$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$Module = '.\uc_fix'

Import-Module $Module
   
# describes the function Get-LRO
Describe 'Get-LRO' {

    It "Has a manifest file" {
        "$here\.\$Module.psd1" | should Exist 
    }
    
    It "Has a module file" {
        "$here\.\$Module.psm1" | should Exist 
    }

}

