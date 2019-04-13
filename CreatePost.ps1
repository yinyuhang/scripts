# 用于创建GitHub.IO post 模板文件的脚本

# Extract Parameter
if ($args.Count -lt 1) {
  echo 'wrong args'
  echo '-n file name(not null)' '-t title' '-st subtitle' '-T tags'
  exit
}
$Name = $Title = $SubTitle = ''
[System.Collections.ArrayList]$Tags = @()
if ($args.Count -gt 1) {
  foreach ($arg in $args) {
    if ($arg.StartsWith('-n')) {
      $Name = $arg.Substring(2)
    } elseif ($arg.StartsWith('-t')) {
      $Title = $arg.Substring(2)
    } elseif ($arg.StartsWith('-T')) {
      $Tags.Add($arg.Substring(2))
    } elseif ($arg.StartsWith('-st')) {
      $SubTitle = $arg.Substring(3)
    }
  }
} else {
  $Name = $args[0]
}
$log = 'Name:' +  $Name + ' , Title: '+ $Title + ', SubTitle: '+ $SubTitle+ ', Tags: ' + $Tags
echo $log

# CreateFile
$CurDate = Get-Date -Format 'yyyy-MM-dd'
$CurTime = Get-Date -Format 'HH:mm:ss'
$FileName = $CurDate + '-' + $Name + '.md'
New-Item -Path './' -Name $FileName -ItemType file

# Write File Template
$TimeStamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
'---' | Out-File -Append $FileName
'layout: post' | Out-File -Append $FileName
'title: ' + $Title | Out-File -Append $FileName
'subtitle: ' + $SubTitle | Out-File -Append $FileName
'date: ' + $TimeStamp | Out-File -Append $FileName
'catalog: true' | Out-File -Append $FileName
'tag: ' | Out-File -Append $FileName
foreach ($Tag in $Tags) {
  '    - ' + $Tag | Out-File -Append $FileName
}
'---' | Out-File -Append $FileName
