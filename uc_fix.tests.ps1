$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$Module = '.\uc_fix.psm1'

Import-Module $Module
   
# describes the function Get-LRO
Describe 'Get-LRO' {

    It "Has a manifest file" {
        "$here\.\$Module" | should Exist 
    }

}

