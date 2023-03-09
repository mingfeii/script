my $src = "dst.txt";
my $dst = "dst_enter.txt";

open my $in,  '<',  $src  or die  "Can't read  $src file: $!";
open my $out, '>',  $dst  or die  "Can't write $dst file: $!";

my @data;

while(<$in>){

    chomp;
    my @array = split(" ",$_);
    foreach my $key (@array) {
	    print $out $key."\n";
    }

}

close $in;
close $out;
