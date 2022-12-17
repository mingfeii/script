
open my $fh_input, '<',$0, or die " read file fail :  $!";
while (my $line = <$fh_input>) {
    print $line;
}

close $fh_input or die " close file fail : $!";

exit 0;
