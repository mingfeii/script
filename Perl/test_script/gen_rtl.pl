use strict;
use warnings;
use Getopt::Long;
use Cwd;
use Cwd 'abs_path';

my $help = 0;
my $tab = " "x4;
my $src_file = "fpga_template.xml";
my $dst_file = "fpga.xml";
my $rtl_dir = "/qsys/sys/synthesis/submodules";
my $label_string = "\<\/efx:design_info\>";
my @rtl_files;
my $abs_path = abs_path($0);
my $location_keyword = "LocationPath";

GetOptions(
            'help' => \$help,
);

# print help message
&help_msg() if $help;
# process filelist 
&process_rtl_file($rtl_dir,$src_file,$dst_file,$label_string,$location_keyword,$abs_path);

sub process_rtl_file{
    my ($rtl_file_dir,$src_file,$dst_file,$label_string,$location_keyword,$abs_path) = @_;
    my $folder = "";
    my @all_dir;
    my $dir = "";
    opendir DH,"./" or die "Can not open current folder .";
    @all_dir = grep {/DVP$/} readdir DH;
    print @all_dir;
    for (my $i = 0; $i < $#all_dir+1; $i++) {
            @rtl_files = ();
            $folder = $all_dir[$i];
            my $qsys_cmd = qq(qsys-generate $folder/qsys/sys.qsys --synthesis=VERILOG --output-directory=$folder/qsys/ --family="Cyclone V" --part=5CSEBA4U23C8);
            system($qsys_cmd); #generate Qsys rtl file 

            my $file_dir = ".\/".$folder.$rtl_file_dir;
            my $abs_path_real = $abs_path.$folder;
            my $src_file_real = $folder."\/".$src_file;
            my $dst_file_real = $folder."\/".$dst_file;
            print  $file_dir."\n";
            print $folder."\n";
            &get_generated_rtl($file_dir,$rtl_file_dir);
            &write_files_to_xml($src_file_real,$dst_file_real,$label_string,$location_keyword,$abs_path_real);
        }
    }

sub get_generated_rtl {
    my ($folder_dir,$rtl_dir) = @_;
    my $format_former = qq(\<efx:design_file name\=);
    my $format_later = qq(version\="default" library\="default"\/\>);
    my $format_name = "";
    print "Start to find Qsys generated file .\n";
    opendir DH,$folder_dir or die "Can not open qsys dir .\n";
    while (my $name = readdir DH) {
        if ($name =~ /\.(v|sv)$/) {
            $format_name = $format_former."\""."\.".$rtl_dir."\/".$name."\""." ".$format_later."\n";
            push (@rtl_files,$format_name);
        }
    }
    print @rtl_files;
    close DH;
}

sub write_files_to_xml {
    my ($src,$dst,$label,$location,$abs_location) = @_;
    open my $in,  '<',  $src  or die  "Can't read  $src file: $!";
    open my $out, '>',  $dst  or die  "Can't write $dst file: $!";
    while(<$in>){
        if  ($_ =~ /$label/) {
            # print $out $_;
            foreach my $rtl_file (@rtl_files) {
                print $out $tab.$rtl_file;
            }
        }
        s/$location/$abs_location/g;
        print $out $_;
    }
    close $out;
}

sub help_msg {
    print "$0 is used to generate necessary Qsys rtl file \n";
    print "qsys-generate must add to PATH \n";
    print "Author : smf\n";
    exit;
}