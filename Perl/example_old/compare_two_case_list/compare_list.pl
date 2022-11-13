#!/usr/bin/perl -w
use strict;
use Getopt::Long;
# ================================================================
# file name: compare_list.pl
# 
# Description:
#      The script used to compare two specified case list files
#      and print out the compared result
# 
# Author:
#      Peter.Shi <peter_soc_vrf@163.com>
# ================================================================
my @old_list;
my @new_list;
my @in_old_not_in_new;
my @in_new_not_in_old;
my @both_in_old_and_new;
my $old_list_file_name = '';
my $new_list_file_name = '';
my $debug = 0;
my $help = 0;
my $tab = " "x4;

if (@ARGV > 0) {
    GetOptions(
               'new=s'           => \$new_list_file_name,
               'old=s'           => \$old_list_file_name,
               'help!'           => \$help,
               'debug!'          => \$debug,
              );
} else {
    &help_msg();
}

&help_msg() if $help;

## check whether the obtained caselist file name is valid or not
if (!defined $old_list_file_name || (defined $old_list_file_name && $old_list_file_name=~/^\s*$/)) {
    print "The obtained assigned caselist file name is empty! \n";
    exit;
}

if (!defined $new_list_file_name || (defined $new_list_file_name && $new_list_file_name=~/^\s*$/)) {
    print "The obtained all caselist file name is empty! \n";
    exit;
}

# obtain the assigned case list
&obtain_caselist($old_list_file_name, \@old_list);

# obtain the all case list
&obtain_caselist($new_list_file_name, \@new_list);

## compare the difference
&exist_A_but_not_B(\@old_list, \@new_list, \@in_old_not_in_new);
&exist_A_but_not_B(\@new_list, \@old_list, \@in_new_not_in_old);
&both_in_A_and_B(\@old_list, \@new_list, \@both_in_old_and_new);

&display_info();                #if ($debug);

sub exist_A_but_not_B {
    my ($A_list_ref, $B_list_ref, $result_list_ref) = @_;
    foreach my $item_A (@$A_list_ref) {
        if (defined $item_A && $item_A !~ /^\s*$/) { #   if (!(grep {$cur_module =~ /^$_$/} @module_arr)) {
            if (!(grep {$item_A =~ /^$_$/} @$B_list_ref)) {
                push (@$result_list_ref, $item_A);
            }
        }
    }
}

sub both_in_A_and_B {
    my ($A_list_ref, $B_list_ref, $result_list_ref) = @_;
    foreach my $item_A (@$A_list_ref) {
        if (defined $item_A && $item_A !~ /^\s*$/) { 
            if ((grep {$item_A =~ /^$_$/} @$B_list_ref)) {
                push (@$result_list_ref, $item_A);
            }
        }
    }
}

sub obtain_caselist {
    my ($case_file_name, $case_list_ref) = @_;
    open(CASE_LIST, "<", $case_file_name) or die "Can not open $case_file_name for reading!\n";
    foreach my $cur_caselist (<CASE_LIST>) {
        next if($cur_caselist=~/^\s*$/ || $cur_caselist=~/^\#/);
        if ($cur_caselist =~ /^\s*(\d+\s+)+/) {
            my @cur_list = split(/\s+/, $cur_caselist);
            if (defined $cur_list[0]) {
                foreach my $case (@cur_list) {
                    if (defined $case && $case=~/^\s*(\d+)\s*$/) {
                        # do not push the current case to array if the case already exist in array
                        if (defined $$case_list_ref[0] && $$case_list_ref[0] !~ /^\s*$/) {
                            next if ((grep {$case =~ /^${_}$/} @$case_list_ref));
                        }
                        push (@$case_list_ref, $1);
                    }
                }
            }
        }
    }
    close (CASE_LIST);
}

sub display_info {
    my $case_num;
    $case_num=$#old_list+1;
    # print "$case_num cases in assigned case list = @old_list \n\n";
    print "There are $case_num cases in $old_list_file_name list:\n";
    print "-"x80 . "\n";
    print "@old_list \n\n\n";

    $case_num=$#new_list+1;
    # print "$case_num cases in all case list      = @new_list \n\n";
    print "There are $case_num cases in $new_list_file_name:\n";
    print "-"x80 . "\n";
    print "@new_list \n\n\n";

    if (defined $in_new_not_in_old[0] && $in_new_not_in_old[0]=~/^\d+$/) {
        $case_num=$#in_new_not_in_old+1;
        # print "$case_num cases in all caselist but not in assigned caselist = @in_new_not_in_old \n\n";
        print "The following $case_num cases in $new_list_file_name but not in $old_list_file_name:\n";
        print "-"x80 . "\n";
        print "@in_new_not_in_old \n\n\n";
    }

    if (defined $in_old_not_in_new[0] && $in_old_not_in_new[0]=~/^\d+$/) {
        $case_num = $#in_old_not_in_new+1;
        # print "$case_num cases in assigned caselist but not in all caselist = @in_old_not_in_new \n\n";
        print "The following $case_num cases in $old_list_file_name but not in $new_list_file_name:\n";
        print "-"x80 . "\n";
        print "@in_old_not_in_new \n\n\n";
    }

    if (@in_old_not_in_new == 0 && @in_new_not_in_old == 0) {
        print "The cases in $new_list_file_name and $old_list_file_name are the same!\n\n";
    } elsif (defined $both_in_old_and_new[0] && $both_in_old_and_new[0]=~/^\d+$/) {
        $case_num = $#both_in_old_and_new+1;
        print "The following $case_num cases both in $old_list_file_name and ${new_list_file_name}:\n";
        print "-"x80 . "\n";
        print "@both_in_old_and_new \n\n\n";
    }
}

sub help_msg {
    print "$0 is used to compare between two case list file \n\n";
    print "Usage:    perl $0 -old old_list -new new_list \n";
    print "       or perl $0 -h/-help \n\n";

    print "${tab}${tab}Author:\n";
    print "$tab"x2 . "-"x40 . "\n";
    print "${tab}${tab}${tab}Peter.Shi <peter_soc_vrf\@163.com>, 01/16/2014\n\n";
    exit;
}
