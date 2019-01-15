my %runPHP = (
    label       => "PHP - Run Php",
    procedure   => "runPHP",
    description => "Integrates Php Scripting into Electric Commander",
    category    => "Scripting/Shell"
);

$batch->deleteProperty("/server/ec_customEditors/pickerStep/PHP - Run Php");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/EC-PHP - runPHP");

@::createStepPickerSteps = (\%runPHP);
