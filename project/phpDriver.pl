use warnings;
use strict; 
$|=1;

################################################################################
# procedure parameter name: [phpCommand]
#
# script variable name:$::phpCommand
#
# purpose: field on wich the php commands can be written.
#
# implemented in this script: yes
################################################################################



use ElectricCommander;
my $ec = ElectricCommander->new();
$ec->abortOnError(0);
$::phpLocation  = ($ec->getProperty( "phpLocation" ))->findvalue('//value')->string_value;
$::phpFile      = ($ec->getProperty( "phpFile" ))->findvalue('//value')->string_value;
$::phpCode      = ($ec->getProperty( "phpCode" ))->findvalue('//value')->string_value;
$::checkArgs    = ($ec->getProperty( "checkArgs" ))->findvalue('//value')->string_value;
$::phpArguments = ($ec->getProperty( "phpArguments" ))->findvalue('//value')->string_value;

sub createphpCommandLine {
    #my $commandLine = "php -f ";
    my $commandLine = "";
    my $code="";
    if($::phpLocation && $::phpLocation ne ""){
        $commandLine .= qq{"$::phpLocation" -f };        
    } else {
        $commandLine = "php -f ";
    }
        
    if($::phpFile && $::phpFile ne ""){
        $commandLine .= qq{"$::phpFile"};        
    }else{        
        $commandLine .= "data.php";
        if($::phpCode  && $::phpCode  ne "") {
            $code = "$::phpCode";
        }
        open (MYFILE, '>>data.php');
        print MYFILE "<?php\n$code\n?>";
        close (MYFILE);
    }

 	# if checkArgs: add to command string
   	if($::checkArgs && $::checkArgs ne "") {
        $commandLine .= " $::phpArguments";
    }
	print $commandLine."\n\n";
    return $commandLine;
}

sub setProperties {

    my ($propHash) = @_;

    # get an EC object
    my $ec = new ElectricCommander();
    $ec->abortOnError(0);

    foreach my $key (keys % $propHash) {
        my $val = $propHash->{$key};
        $ec->setProperty("/myCall/$key", $val);
    }
}

sub main() {
    
    # create args array
    my @args = ();
    my %props;	

   $props{"phpCommandLine"} = createphpCommandLine();
    setProperties(\%props);
}

main();

