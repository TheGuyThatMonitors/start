
# Look users
$fileDelCount = 0


# Get user's local Temp directory
$dataDir = "C:\Program Files\WindowsApps\"

# Finds all directories in Temp with exclusively numeric names
$numDirs = Get-ChildItem -Path $dataDir -Attributes D | 
            Where-Object { $_.Name -match '^\d+$' } | 
            Sort-Object

# Loop numeric subdirectories
foreach($tempDir in $numDirs)
{
    $tDir = Join-Path -Path $dataDir -ChildPath $tempDir

    # Test if subdir contains Diagnostics directory
    $diagDir = Join-Path -Path $tDir -ChildPath "CLIMBRACING"
    $hasDiag = Test-Path -Path $diagDir

    # Test if subdir contains Outlook Logging directory
    $outlookDir = Join-Path -Path $tDir -ChildPath "game"
    $hasOutlook = Test-Path -Path $outlookDir

    # Empty Diagnostics directory
    if ($hasDiag)
    {
        $totalSubFiles = ( Get-ChildItem $diagDir | Measure-Object ).Count
        $fileDelCount += $totalSubFiles

        Get-ChildItem -Path $diagDir -Recurse | Remove-Item -force -recurse
    }

    # Empty Outlook directory
    if($hasOutlook)
    {
        $totalSubFiles = ( Get-ChildItem $outlookDir | Measure-Object ).Count
        $fileDelCount += $totalSubFiles

        Get-ChildItem -Path $outlookDir -Recurse | Remove-Item -force -recurse
    }
}