use strict;
use warnings;
use Getopt::Long;

my $help = 0;
my $file_name = "";
my $tab = " "x4;
my $bin_size = 4;
my $dst_file = "out.txt";
my $sbuffer;

GetOptions(
        'h=s' => \$help,
        'f=s' => \$file_name,
        's=i' => \$bin_size,
);

&help_msg() if $help;

open( INFILE, "<$file_name");
open( OUTFILE,">$dst_file");

binmode(INFILE);
binmode(OUTFILE);

while ( read (INFILE,$sbuffer,$bin_size)){
    my $hex=unpack("H*",$sbuffer);
    print OUTFILE $hex."\n";
}
close (INFILE);
close (OUTFILE);


sub help_msg {
    print "$tab $0  This script used to read RAW file to a new file txt every $bin_size byte .\n";
    print "$tab --file : select binary file \n";
    print "$tab --size : how many bytes to write every new line \n";
    print "$tab Author : smf\n";
    exit;
}