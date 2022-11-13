#!/usr/bin/perl -w

#######################################################
#
# File Name: prepare_tests_for_ip_deliver.pl
#
# Description:
#     The script used to prepare the test patterns 
#     for ip release
#
# Author:
#     peter.shi <peter_soc_vrf@163.com>
#
#######################################################

use strict;
use Getopt::Long;

my $output_name = "test_pattern"; 
my $tar_format  = "tar";  # .tar.gz or .tar, can be modified by option
my $case_list = "./env_log/case_list";
my $cfg_dir = "./env_log/sim_log";
my $stream_path = "./env_log/test_streams";
my $help = 0; 
my $debug = 0;
my $verbose = 0;
my $tab = " "x4;

my @cases;
my $cur_dir;
my $ERROR = "[ERROR] --";
my $INFO  = "[INFO] --";
my @not_generated_list;
my @generated_list;

# if (@ARGV > 0) {
GetOptions(
           'package_name=s'   => \$output_name,
           'tar_format=s'     => \$tar_format,
           'case_list=s'      => \$case_list,
           'cfg_dir=s'        => \$cfg_dir,
           'stream_path=s'    => \$stream_path,
           'help!'            => \$help,
           'debug!'           => \$debug,
           'verbose!'         => \$verbose,
          );

$cur_dir = `pwd`;
chomp $cur_dir;
$cur_dir =~ s#\$|/$##;

&adjust_one_dir(\$cfg_dir, $cur_dir)     if defined $cfg_dir;
&adjust_one_dir(\$stream_path, $cur_dir) if defined $cur_dir;
$output_name =~ s/^\s*|\s*$//g;
$output_name =~ s#^\.+/|/$##g;

&help_message() if $help;

# ---------------------------------------------------------------------------
# 
# generation flow:
# 1) obtain the case list from case list file
# 2) cp the config file and test stream into a new generated case dir
# 3) output the test pattern package in the specified format
# ---------------------------------------------------------------------------

&obtain_case_list($case_list);

&gen_testdata(\@cases);

# &gen_report();

# the sub program used the obtain the valid test patterns from
# the read back line information
sub obtain_one_line_patterns {
    my ($line, $arr_ref) = @_;
    my @cur_cases = split(/\s+/, $line);
    if (defined $cur_cases[0] && $cur_cases[0] !~ /^\s*$/) {
        foreach my $cur_case (@cur_cases) {
            $cur_case =~ s/^\s*|\s*$//g;
            $cur_case =~ s/^case_//;
            push (@$arr_ref, $cur_case) if ($cur_case =~ /^\d+$/);
        }
    }
}

sub gen_testdata {
    my $case_ref = shift;
    print "${INFO} Start to generate each test pattern's testdata \n\n";
    # prepare the tmp dir for testdata generation
    my $tmp_dir = "./tmp_dir";
    &prepare_out_dir($tmp_dir);    
    my $tmp_pkg_dir = "${tmp_dir}/${output_name}";
    &adjust_one_dir(\$tmp_pkg_dir, $cur_dir);
    system("rm -rf ${tmp_pkg_dir}/*");

    foreach my $cur_case (@$case_ref) {
        my $stream_name;
        $cur_case =~ s/^case_//;
        my $cur_case_dir = "${tmp_pkg_dir}/case_${cur_case}";
        my $cur_cfg_file = "${cfg_dir}/log_case_${cur_case}/test.cfg";
        my $cur_stream_file = "${stream_path}/case_${cur_case}/stream.mpeg2";

        # obtain the config file
        if ( -e "$cur_cfg_file") {
            system("mkdir -p ${cur_case_dir}");
            system("cp ${cur_cfg_file} ${cur_case_dir}");
        } else {
            push (@not_generated_list, $cur_case);
            next;
        }
        
        # obtain the test stream files
        if (-e "${cur_stream_file}") {
            system("cp $cur_stream_file $cur_case_dir");
        } else {
            push (@not_generated_list, $cur_case);
            next;
        }
        push (@generated_list, $cur_case);
    }

    # &adjust_one_dir(\$output_name, $cur_dir);
    my $final_pkg_name = &output_test_patters_package($tmp_pkg_dir, $output_name);
    system("rm -rf $tmp_dir");
    system("rm -rf $output_name");
    print "${INFO} Complete to generate each test pattern's testdata \n\n";
    print "${INFO} The generated test patterns package for ip deliver has been placed to $final_pkg_name \n\n";
}

sub output_test_patters_package {
    my ($tmp_pkg_dir, $package_name) = @_;
    # check the tar format
    $tar_format =~ s/^\.// if defined $tar_format;
    if (!defined $tar_format || (defined $tar_format && $tar_format !~ /^tar$/ && $tar_format !~ /^tar\.gz$/)) {
        print "${ERROR} the tar format should be \"tar\" or \"tar.gz\" but detect a not valid value. Exiting...\n\n";
        exit;
    }

    system("mv $tmp_pkg_dir $package_name");
    chdir $package_name;
    if ($tar_format eq "tar") {
        system("tar cvf ${package_name}.tar * > /dev/null");
        system("mv ${package_name}.tar $cur_dir");
        chdir $cur_dir;
        return "${cur_dir}/${package_name}.tar";
    } elsif ($tar_format eq "tar.gz") {
        system("tar zcvf ${package_name}.tar.gz * > /dev/null");
        system("mv ${package_name}.tar.gz $cur_dir");
        chdir $cur_dir;
        return "${cur_dir}/${package_name}.tar.gz";
    }
}

sub prepare_out_dir {
    my $dir_name = shift;
    if (-e $dir_name) {
        system("rm -rf $dir_name/*");
    } else {
        system("mkdir $dir_name");
    }    
}

sub adjust_one_dir {
    my ($dir_ref, $cur_path) = @_;
    my $dir = $$dir_ref;
    $dir =~ s/^\s*|\s*$//g;
    $dir =~ s#\$|/$##; 
    if ($dir =~ /^\.\/(\w+.*)$/) {
        $dir = "${cur_path}/${dir}";
    } elsif ($dir =~ /^\.\.\/\w+/) {
        $dir = "${cur_path}/${dir}";
    } elsif ($dir =~ /^\w+$/) {
        $dir = "${cur_path}/${dir}";
    }
    $$dir_ref = $dir;
}

sub obtain_case_list {
    my $file = shift;
    print "${INFO} Start to obtain the test case list from $file\n\n";
    if (defined $file && $file !~ /^\s*$/ && (-e $file)) {
        open(LOG, "<", $file) or die "Can not open $file for reading!\n";
        while (<LOG>) {
            my $line = $_;
            next if &is_not_valid($line);
            next if $line =~ /^\s*#/; # comment in the test case list file
            chomp $line;
            &obtain_one_line_patterns($line, \@cases);
        }
        close(LOG);
    } else {
        print "${ERROR} Can not obtain the test case list. You must specify it use \"-case_list\" option. Exiting...\n";
        exit;
    }
    print "${tab}The obtained test case list from $file is cases = @cases \n\n" if $verbose;
    print "${INFO} Complete to obtain the test case list from $file\n\n";
}

sub display_array_for_len {
    my ($len, $ref) = @_;
    my $cur_len = 0;
    my $str = "";
    foreach my $case (@$ref) {
        if ($cur_len == 0) {
            my $item = "${tab}${tab}${case} ";
            $cur_len += length($case);
            $str .= $item;
        } elsif ($cur_len < $len) {
            my $item = "$case ";
            $cur_len += length($item);
            $str .= $item;
        } else {
            my $item = "$case \n";
            $cur_len = 0;
            $str .= $item;
        }
    }
    return $str;
}

sub is_not_valid {
    my $val = shift;
    if (!defined $val || (defined $val && $val =~ /^\s*$/)) {
        return 1;
    }
    return 0;
}

sub help_message {
    my $len = length($0);
    print "${tab}Usage: perl $0 OPTIONS\n\n";

    ################# descriptions for options
    print "${tab}Descriptions for OPTIONS:\n";
    print "${tab}" . "-"x50 . "\n";
    print "${tab}${tab}-package_name package_name -- specify the prepared test pattern package name\n";
    print "${tab}${tab}-case_list list_file       -- specify the test cases list that will be generate testdata. \n";
    print "${tab}${tab}-tar_format format         -- specify the output file's format: .tar.gz, tar.gz, .tar or tar\n";
    print "${tab}${tab}                              limitaion by default \n";
    print "${tab}${tab}-cfG_dir                   -- specify the dir that the config files locate in\n";
    print "${tab}${tab}-stream_path stream_dir    -- specify the dir that the test streams locate in\n";
    print "${tab}${tab}-help                      -- print out the current help information\n";
    print "${tab}${tab}-debug                     -- debug mode and will print out some debug information\n";
    print "${tab}${tab}-verbose                   -- the same as \"-debug\", but have more detailed inforamtion\n\n";

    ################# Examples
    print "${tab}Some examples: \n";
    print "${tab}" . "-"x50 . "\n";
    print "${tab}${tab}1) perl $0 -case_list list_file -package_name test_data -tar_format .tar.gz \n";
    print "${tab}${tab}        " . " "x$len . " -cfg_dir ./env_log/sim_log \n\n";
    print "${tab}${tab}${tab}--> generate test data for the test cases specified in the list_file file in the format of .tar.gz,\n";    
    print "${tab}${tab}${tab}    each test pattern's config file can be found in ./env_log/sim_log/log_case_xxx dir. Obtain the \n";
    print "${tab}${tab}${tab}    test streams from the ./env_log/test_streams/case_xxx/stream.mpeg2 \n\n";

    print "${tab}${tab}2) perl $0 -case_list list_file -package_name test_data -tar_format .tar.gz \n";
    print "${tab}${tab}        " . " "x$len . " -cfg_dir ./env_log/sim_log -stream_path ./test_stream \n\n";
    print "${tab}${tab}${tab}--> the same as above example, but obtain the test streams from the specified ./test_stream dir \n\n";

    print "${tab}${tab}3) a example for list_file\n";
    print "${tab}" . "-"x50 . "\n";
    print "${tab}${tab}${tab}############################     \n"; 
    print "${tab}${tab}${tab}case_14003                       \n"; 
    print "${tab}${tab}${tab}case_14187                       \n"; 
    print "${tab}${tab}${tab}                                 \n"; 
    print "${tab}${tab}${tab}# 15911 15918                    \n"; 
    print "${tab}${tab}${tab}                                 \n"; 
    print "${tab}${tab}${tab}12101 12097                      \n"; 
    print "${tab}${tab}${tab}                                 \n"; 
    print "\n";


    print "${tab}Author:\n";
    print $tab . "-"x50 . "\n";
    print "${tab}${tab}peter.shi <peter_soc_vrf\@163.com>\n\n";

    exit;
}

