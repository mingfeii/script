#!/usr/bin/perl -w
use strict;

# =========================================
# file name: gen_list_files.pl
#
# Description:
#        The script just used to generate
#        the case list files that used for
#        test
#
# Author:
#        Peter.Shi <peter_soc_vrf@163.com>
# =========================================
my $file1 = "mpeg2.list";
my $file2 = "mpeg4.list";
my $case_num = 200;
my $help = 0;
my $debug = 0;
my $tab = " "x4;

for (my $i = 0; $i <= $#ARGV; $i++) {
    if ($ARGV[$i] eq "-help" || $ARGV[$i] eq "-h") {
        $help = 1;
    }
    elsif ($ARGV[$i] eq "-debug") {
        $debug = 1;
    }
    elsif ($ARGV[$i] eq "-old") {
        $file1 = $ARGV[++$i];
    }
    elsif ($ARGV[$i] eq "-new") {
        $file2 = $ARGV[++$i];
    }
    elsif ($ARGV[$i] eq "-case_num" || $ARGV[$i] eq "-num") {
        $case_num = $ARGV[++$i];
    }
    else {
        print "[ERROR] Detected invalid option. Exiting...\n";
        exit;
    }
}

print "\n[INFO] -- Complete to parse the input command line options\n\n";

&help_message if $help;

&gen_case_list($file1, $case_num, 3000, 500);
&gen_case_list($file2, $case_num, 3000, 500);

# --------------------------------------------------------------
# the sub program used to generate the test case list file for
# test the compare_caselist.pl script
# 
# parameters:
#     $file      -- the file name that used to save the 
#                   generated test case ids
#     $num       -- how many test case ids will be generated
#     $start_val -- the test case id's start value 
#     $max_val   -- the max value for the rand value
# --------------------------------------------------------------
sub gen_case_list {
    my ($file, $num, $start_val, $max_val) = @_;
    my $case_info = "";
    print "[INFO] -- start to generate the test case list for $file file\n\n";
    $case_info .= "# The following is a test case list for our project:\n\n";
    for (my $i = 0; $i < $num; $i++) {
        # just to generate 3 same test case id 
        if ($i < 3) {
            my $tmp_id = $start_val + $i;
            $case_info .= "${tmp_id} ";
        }

        my $case_id = $start_val + int(rand($max_val));
        print "[INFO] -- the generated case id = $case_id \n" if $debug;
        $case_info .= "$case_id "     if (($case_id % 3) == 0);
        $case_info .= "$case_id \n"   if (($case_id % 3) == 1);
        $case_info .= "$case_id \n\n" if (($case_id % 3) == 2);
    }
    open (LIST, ">", $file) or die "Can not open $file for writing! \n\n";
    print LIST $case_info;
    close (LIST);
    print "[INFO] -- a test case list has been written into $file file \n\n";
}

sub help_message {
    print "\n$$0 only used to generate the log files that used for test\n\n";
    print "Usage: perl $0 -old list1 -new list2 -case_num/-num case_num [-debug]\n";
    print "or     perl $0 -help/-h\n\n";
    exit;
}
