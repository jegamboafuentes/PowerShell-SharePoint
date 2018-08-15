cls
$dateLimitTemp = (get-date).AddDays(-14) 
$dateLimit = Get-Date $dateLimitTemp -Format g #-UFormat "%M/%d/%Y %h:%m %t"
$dateC = "8/14/18 6:58 AM"
if((get-date $dateC) -gt (get-date $dateLimit)){
    echo Yes
}else{
    echo No
}
echo $dateLimit
echo $dateC