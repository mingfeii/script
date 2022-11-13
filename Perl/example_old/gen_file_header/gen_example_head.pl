#!/usr/bin/perl -w
use strict;
use POSIX;
my $cur_time=strftime("%m/%d/%Y",localtime());
my $file_name;
my $tab = " "x4;
if (@ARGV == 1) {
    $file_name = $ARGV[0];
}
else {
    &help_message();
}
open (LOG, ">", $file_name) or die "Can not open $file_name for writing!\n";
my $str = "";
$str .= "#!/usr/bin/perl -w\n";
$str .= "use strict;\n";
$str .= "# --------------------------------------------\n";
$str .= "# Filename   : $file_name                     \n";
$str .= "#   \n";
$str .= "# Description:                                \n";
$str .= "#     \n";
$str .= "#     \n";
$str .= "#                                             \n";
$str .= "# Author:                                     \n";
$str .= "#     Peter.Shi <peter_soc_vrf\@163.com>       \n";
# $str .= "#     $cur_time \n";
$str .= "# --------------------------------------------\n";
$str .= "# $file_name \n";
print LOG $str;
close (LOG);
print "\nThe header for specified file $file_name has been generated!\n\n";

sub help_message {
    print "\nThe $0 script used to generate the head of a perl example file header for training\n\n";
    print "Usage: perl $0 file_name\n\n";

    print "Example:\n";
    print "${tab}" . "-"x40 . "\n";
    print "${tab}perl $0 ext4.6.pl\n";
    print $tab . "  --> generate the header for the specified perl file called ext4.6.pl \n\n";
    exit;
}
