﻿BeforeAll { 
    $CurrentFolder = Split-Path -Parent $PSScriptRoot;
    $ModulePath = Resolve-Path "$CurrentFolder\DeployCube\DeployCube.psd1";
    import-Module -Name $ModulePath;
}

Describe "Select-AnalysisServicesDeploymentExeVersion"  -Tag "Round1" {

    Context "Testing Inputs" {
        It "Should have PreferredVersion as a mandatory parameter" {
            (Get-Command Select-AnalysisServicesDeploymentExeVersion).Parameters['PreferredVersion'].Attributes.mandatory | Should -Be $true
        }
    }

    Context "Finding Versions" {
        It "Finds latest version" {
            Select-AnalysisServicesDeploymentExeVersion -PreferredVersion latest | Should -Be '15'
        }
        
        It "Finds version 15" {
            Select-AnalysisServicesDeploymentExeVersion -PreferredVersion 15 | Should -Be '15'
        }
        
        It "Does not find version 14" {
            Select-AnalysisServicesDeploymentExeVersion -PreferredVersion 14 | Should -Not -Be '14'
        }

        It "Does not find version 13" {
            Select-AnalysisServicesDeploymentExeVersion -PreferredVersion 13 | Should -Not -Be '13'
        }

        It "Does not find version 12" {
            Select-AnalysisServicesDeploymentExeVersion -PreferredVersion 12 | Should -Not -Be '12'
        }

        It "Does not find version 11" {
            Select-AnalysisServicesDeploymentExeVersion -PreferredVersion 11 | Should -Not -Be 11;
        }

        It "Unsupported AnalysisServicesDeploymentExe version 100 so should Throw" {
            { Select-AnalysisServicesDeploymentExeVersion -PreferredVersion 10 } | Should -Throw;
        }

        It "Invalid version XXX so should throw" {
            { Select-AnalysisServicesDeploymentExeVersion -PreferredVersion XX } | Should -Throw;
        }
    }
}

AfterAll {
    Remove-Module -Name DeployCube
}