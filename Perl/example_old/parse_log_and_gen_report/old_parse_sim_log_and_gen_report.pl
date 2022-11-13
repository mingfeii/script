#!/usr/bin/perl -w
use strict;
# --------------------------------------------
# Filename   : parse_sim_log_and_gen_report.pl
#
# Description:
#       The script used to parse the generated
#       simulation log files and generate a
#       summary report
#
# Author:
#     Peter.Shi <peter_soc_vrf@163.com>
# --------------------------------------------
# parse_sim_log_and_gen_report.pl
use Getopt::Long;

my $log_dir = "./out";
my $report_file = "simulation_report.log";
my $verbose = 0;
my $debug = 0;
my $help = 0;
my $tab = " "x4;
my $info  = "[INFO]  --";
my $error = "[ERROR] --";
my @pass_cases;
my @fail_cases;
my @unknown_cases;

# parse the input options
GetOptions(
           'log_dir=s'       => \$log_dir,
           'verbose!'        => \$verbose,
           'debug!'          => \$debug,
           'help!'           => \$help,
          );

&help_message if $help;

&parse_sim_logs($log_dir);

&gen_report($report_file);

sub parse_sim_logs {
    my $sim_dir = shift;
    print "\n${info} Start to parse the simulation log files in $sim_dir dir\n\n";
    my @sim_files;
    # @sim_files = glob("$sim_dir/*.log");
    opendir DH, $sim_dir or die "Cannot open $sim_dir dir for reading!\n";
    while (my $name = readdir DH) {
        $name = "${sim_dir}/${name}";
        push (@sim_files, $name) if $name =~ /\.log$/;
    }
    closedir DH;

    if (!defined $sim_files[0] || $sim_files[0] =~ /^\s*$/) {
        print "${error} Do not obtain valid simulation log files. Exiting...\n\n";
        exit;
    }
    foreach my $sim_file (@sim_files) {
        my $case_id;
        my $status;
        open (SIM, "<", $sim_file) or die "Can not open $sim_file for reading!\n";
        while (defined (my $line = <SIM>)) {
            chomp $line;
            next if $line =~ /^\s*$/;
            $line =~ s/^\s*|\s*$//g;
            if ($line =~ /^#\s*test_id\s*:\s*(\d+)/) {
                $case_id = $1;
            } elsif ($line =~ /^#\s*test_status\s*:\s*(\w+)/) {
                $status = $1;
                $status =~ s/^\s*|\s*$//g;
                last;
            }
        }
        if (defined $case_id && defined $status) {
            if ($status =~ /^ok$/i) {
                push (@pass_cases, $case_id);
            } elsif ($status =~ /^fail$/i) {
                push (@fail_cases, $case_id);
            } else {
                push (@unknown_cases, $case_id);
            }
        }
        close(SIM);
    }
    print "${info} Complete to parse the simulation log files \n\n";
}

sub gen_report {
    my $out_file = shift;
    my $result = "";
    my $pass_rate;
    my $fail_rate;
    my $pass_num = 0;
    my $fail_num = 0;
    my $unknow_num = 0;
    my $case_num = 0;

    print "${info} Start to generate the summary report\n\n";
    $pass_num = @pass_cases if defined $pass_cases[0];
    $fail_num = @fail_cases if defined $fail_cases[0];
    $unknow_num = @unknown_cases if defined $unknown_cases[0];
    $case_num = $pass_num + $fail_num + $unknow_num;
    my $len = length($case_num);
    if ($case_num == 0) {
        print "${error} Do not obtain any test cases' simulation result. Exiting...\n\n";
        exit;
    }
    $pass_rate = $pass_num / $case_num;
    $fail_rate = $fail_num / $case_num;

    $result .= "\n";
    $result .= "#"x80 . "\n";
    $result .= "# The following is the simulation result summary report for project PrjA\n";
    $result .= "#"x80 . "\n";
    $result .= "${tab}Launched $case_num cases totally\n";
    $result .= "${tab}$pass_num cases passed\n";
    $result .= "${tab}$fail_num cases failed\n";
    # $result .= "${tab}pass rate = $pass_num / $case_num = " . sprintf("%4.2f\%", $pass_rate * 100) . "\n";
    # $result .= "${tab}fail rate = $fail_num / $case_num = " . sprintf("%4.2f\%", $fail_rate * 100) . "\n";
    $result .= "${tab}pass rate = " . sprintf("%${len}d", $pass_num) . " / $case_num = ";
    $result .= sprintf("%4.2f\%", ($pass_rate * 100)) . "\n";

    $result .= "${tab}fail rate = " . sprintf("%${len}d", $fail_num) . " / $case_num = ";
    $result .= sprintf("%4.2f\%", ($fail_rate * 100)) . "\n";

    $result .= "\n";
    $result .= $tab . "-"x50 . "\n";

    if ($pass_num > 0) {
        $result .= "${tab}The following $pass_num test cases passed:\n";
        $result .= &print_array_by_len(\@pass_cases, 15);
        $result .= "\n";
    }

    if ($fail_num > 0) {
        $result .= "${tab}The following $fail_num test cases failed:\n";
        $result .= &print_array_by_len(\@fail_cases, 15);
        $result .= "\n";
    }

    if ($unknow_num > 0) {
        $result .= "${tab}The following $unknow_num test cases' status is ";
        $result .= "unknown and need to be checked:\n";
        $result .= &print_array_by_len(\@unknown_cases, 15);
        $result .= "\n";
    }

    # output the summary report to the specified file
    open (OUT, ">", $out_file) or die "Can not open $out_file for writing!\n";
    print OUT $result;
    close(OUT);

    print $result;
    print "You also can refer to the summary report from $out_file file\n\n";
}

sub print_array_by_len {
    my ($ref, $len) = @_;
    my $str = "${tab}${tab}";
    my $num = 0;
    foreach my $item (@$ref) {
        if ($num > 0 && $num % $len == 0) {
            # $str .= "${tab}${tab}";
            $str .= "\n${tab}${tab}";
            $num = 0;
        }

        $str .= "${item} ";
        $num += 1;
    }
    $str .= "\n\n";
    return $str;
}


sub help_message {
    print "\nUsage: perl $0 OPTIONS\n\n";
    print "OPTIONS:\n";
    print "-"x50 . "\n";
    print "${tab}-log_dir dir_name -- specify the the log dir that save the simulation log files. Default is ./out\n";
    print "${tab}-help             -- print out the help message\n";
    print "${tab}-debug/-verbose   -- control to output some debug information\n\n";
    print "Author:\n";
    print "-"x50 . "\n";
    print "${tab}peter.shi <peter_soc_vrf\@163.com>\n\n";
    exit;
}
