
$fileDelCount = 0


# Get directory
$dataDir = "C:\Program Files\WindowsApps\"

# Finds all directories in directory
$numDirs = Get-ChildItem -Path $dataDir -Attributes D | Sort-Object


# Loop numeric subdirectories
foreach($tempDir in $numDirs)
{
    $tDir = Join-Path -Path $dataDir -ChildPath $tempDir

    # Test if subdir contains CLIMBRACING directory
    $diagDir = Join-Path -Path $tDir -ChildPath "CLIMBRACING"
    $hasDiag = Test-Path -Path $diagDir

    # Test if subdir contains Game directory
    $outlookDir = Join-Path -Path $tDir -ChildPath "game"
    $hasOutlook = Test-Path -Path $outlookDir

    # Empty CLIMBRACING directory
    if ($hasDiag)
    {
        $totalSubFiles = ( Get-ChildItem $diagDir | Measure-Object ).Count
        $fileDelCount += $totalSubFiles

        Get-ChildItem -Path $diagDir -Recurse | Remove-Item -force -recurse
    }

    # Empty Game directory
    if($hasOutlook)
    {
        $totalSubFiles = ( Get-ChildItem $outlookDir | Measure-Object ).Count
        $fileDelCount += $totalSubFiles

        Get-ChildItem -Path $outlookDir -Recurse | Remove-Item -force -recurse
    }
}
