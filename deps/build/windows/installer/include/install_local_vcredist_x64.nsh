!include LogicLib.nsh

!macro InstallVCredist

  ReadRegDWORD $0 HKLM "SOFTWARE\Wow6432Node\Microsoft\VisualStudio\14.0\VC\Runtimes\x64" Bld
  ${If} $0 >= 27024
    DetailPrint "Removing VC++ installer."
    Delete "$INSTDIR\vc_redist.x64.exe"

    DetailPrint "VC++ installer removed."
    goto VCInstalled
  ${Else}
    DetailPrint "Pausing installation while downloaded VC++ installer runs."
    DetailPrint "Installation could take several minutes to complete."
    ExecWait '$INSTDIR\vc_redist.x64.exe /passive /norestart'
	DetailPrint "Removing VC++ installer."
	
	Delete "$INSTDIR\vc_redist.x64.exe"
	goto VCInstalled
  ${EndIf}

VCCanceled:
  Abort "Installation cancelled by user."

VCInstalled:
  Pop $0
!macroend
