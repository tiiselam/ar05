for /f %%a in ('dir %windir%\Microsoft.Net\Framework\regasm.exe /s /b') do set currentRegasm="%%a"
%currentRegasm% "C:\Program Files (x86)\Microsoft Dynamics\GP2018\AddIns\FEEXP.dll" /tlb:feexp.tlb
%currentRegasm% "C:\Program Files (x86)\Microsoft Dynamics\GP2018\AddIns\ACA_WSFE.dll" /tlb:ACA_WSFE.tlb
