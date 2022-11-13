#!/usr/bin/perl -w
use strict;
# --------------------------------------------
# Filename   : gen_sim_logs.pl                     
#   
# Description:                                
#     The script used to generate the simulation 
#     log files by random
#                                             
# Author:                                     
#     Peter.Shi <peter_soc_vrf@163.com>       
# --------------------------------------------
# gen_sim_logs.pl 

# ---------------------------------------------------------------------
# Note
#    You need have a reference simulation log file to generate some
#    real log files used for parsing
# ---------------------------------------------------------------------
my $ref_log_file = "ref_simv.log";
my $ref_log = "";
my $out_dir = "./out";
my $log_num = 50;
my $tab = " "x4;
my $verbose = 0;
my $debug   = 0;

print "\n";

&obtain_ref_log($ref_log_file);

&gen_real_log_files($ref_log, $log_num, $out_dir);

sub obtain_ref_log {
    my $file = shift;
    open (LOG, "<", $file) or die "Can not open $file for reading!\n";
    while (defined (my $line = <LOG>)) {
        $ref_log .= $line;
    }
    close(LOG);
    print "[DEBUG] -- complete to obtain the reference simulation log\n\n";
}

sub gen_real_log_files {
    my ($log, $num, $dir) = @_;
    my $start_val = 2000;
    my $max_val   = 500;
    my @cases;
    my $count = 0;
    print "[DEBUG] -- Start to generate $num log files...\n\n";
    &adjust_out_dir(\$dir);
    while ($count < ($num + 1)) {
        my $case_id = $start_val + int(rand($max_val));
        if (!(grep {$case_id =~ /^$_$/} @cases)) {
            push (@cases, $case_id);
            $count++;
            &gen_one_log_file($case_id, $log, $dir);
        }
    }
    print "[DEBUG] -- Completed to genrate the $num log files into $dir dir\n\n";
}

sub gen_one_log_file {
    my ($id, $log, $dir) = @_;
    my $sim_file = "${dir}/sim_${id}.log";
    my $result = "$log";
    my $status;
    my $max_val = 4000;
    my $rand_val = int(rand($max_val));
    $status = "OK"   if ($rand_val >  ($max_val / 5));
    $status = "FAIL" if ($rand_val <= ($max_val / 5));
    # if ($rand_val > ($max_val / 2)) {
    #     $status = "OK";
    # } 
    # else {
    #     $status = "FAIL";
    # }
    $result .= &obtain_sim_status($status, $id);
    
    # output the generated simulation log for current test
    open (OUT, ">", $sim_file) or die "Can not open $sim_file for writing!\n";
    print OUT $result;
    close(OUT);   
    print "${tab}[DEBUG] -- the $sim_file has been generated!\n\n" if $verbose;
}

sub obtain_sim_status {
    my ($status, $case_id) = @_;
    my $str = "";
    $str .= "# " . "="x30 . "\n";
    $str .= "# test_id    : $case_id\n";
    $str .= "# test_status: $status\n";
    $str .= "# " . "="x30 . "\n";
    return $str;
}

sub adjust_out_dir {
    my $dir_ref = shift;
    
    $$dir_ref =~ s%\$|/$%%g;
    if ( -e $$dir_ref) {
        unlink glob("$$dir_ref/*");
        # system("rm -rf $$dir_ref/*");
        print "${tab}[DEBUG] -- $$dir_ref dir exist and complete to clean up its content\n\n";
    } else {
        mkdir "$$dir_ref", 0755 or die "Can not create $$dir_ref dir!\n";
        print "${tab}[DEBUG] -- $$dir_ref dir do not exist and complete to create it\n\n";
    }
}



