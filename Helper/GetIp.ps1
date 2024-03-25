
$ip=(Invoke-WebRequest -uri http://ifconfig.me/ip).Content
if($null -eq $ip){
    $ip = "163.166.119.113"
}
Write-Output "{ ""ip"" : ""$ip"" }"