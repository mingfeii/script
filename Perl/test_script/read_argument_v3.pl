use strict;
use warnings;

my %rule_of_opt = (
    '-s' => {
        'perl_type' => 'scalar',
    },
    '-a' => {
        'perl_type' => 'array',
    }
);

my ($opt,%value_of_opt);
for my $arg (@ARGV) {
    if ($arg =~ /^-/) {
        $opt = $arg;
        if (exists $value_of_opt{$opt}) {
            print "Repeated option : $arg\n";
            exit 1;
        }
        else {
            @{$value_of_opt{$opt}} = ();
        }
    }
    elsif (defined $opt) {
        push @{$value_of_opt{$opt}},$arg;
    }
}

for my $opt (keys %value_of_opt) {
    if (exists $rule_of_opt{$opt}) {
        if (${$rule_of_opt{$opt}}{'perl_type'} eq 'scalar') {
            if (@{$value_of_opt{$opt}} != 1) {
                print "Error: only one parameter is expected to '$opt'\n";
                exit 1;
            }
        }
        elsif (${$rule_of_opt{$opt}}{'perl_type'} eq 'array') {
                if (@{$value_of_opt{$opt}} < 1) {
                print "Error: one or more  parameter is expected to '$opt'\n";
                exit 1;
            }
        }
        else {
            print "Error : unkonwn 'perl_type' of '$opt'\n";
            exit 1;

        }
    }
    else {
        print "Un-support option: '$opt'\n";
        # exit 1;
    }
}

for my $opt (keys %value_of_opt) {
    print "$opt =>";
    for my $pv (@{$value_of_opt{$opt}}) {
        print "$pv";
    }
    print "\n";
}

exit 0;