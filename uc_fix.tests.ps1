$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$Module = '.\uc_fix'

Import-Module $Module
   
# describes the function Get-LRO
Describe 'uc_fix Module' {

    Context 'Test Modules' {
    
        It 'Has a manifest file' {
            "$here\.\$Module.psd1" | should Exist 
        }
    
        It 'Has a module file' {
            "$here\.\$Module.psm1" | should Exist 
        }
    }
    
    Context 'Test AppVeyor' {
    
        It 'Has an AppVeyor yml file' {
            "$here\.\appveyor.yml" | should Exist 
        }
    
    }
    
    $files = ('README.md')
    foreach ($file in $files) {
    
        Context 'Test files exist' {
        
            It "$file should exist" {
            "$here\.\$file" | Should Exist
            }
        }
    }



        It "$Module is valid PowerShell code" {
            $psFile = Get-Content -Path "$here\$module.psm1" -ErrorAction Stop
            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
            $errors.Count | Should Be 0
        }
    
}

