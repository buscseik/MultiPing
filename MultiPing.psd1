﻿@{
RootModule="MultiPing.psm1"
GUID="488127aa-8772-4319-9a62-31c726c09d1a"
Author="Krisztian Buscsei"
ModuleVersion="1.3"
Description="MultiPing will generate a html based report to help troubleshoot network problems."
RequiredModules = @({ModuleName=”UseFulTools”},{ModuleName=”Log2Chart”})

# Private data to pass to the module specified in RootModule/ModuleToProcess
PrivateData = @{
    # PSData is module packaging and gallery metadata embedded in PrivateData
    # It's for rebuilding PowerShellGet (and PoshCode) NuGet-style packages
    # We had to do this because it's the only place we're allowed to extend the manifest
    # https://connect.microsoft.com/PowerShell/feedback/details/421837
    PSData = @{
        # The primary categorization of this module (from the TechNet Gallery tech tree).
        #Category = ""

        # Keyword tags to help users find this module via navigations and search.
        Tags = @("Ping","Log","PowerShell","Chart", "Latency")

        # The web address of an icon which can be used in galleries to represent this module
        #IconUri = "http://pesterbdd.com/images/Pester.png"

        # The web address of this module's project or support homepage.
        ProjectUri = "https://github.com/buscseik/MultiPing/"

        # The web address of this module's license. Points to a page that's embeddable and linkable.
        LicenseUri = "https://github.com/buscseik/MultiPing/blob/master/LICENSE"

        # Release notes for this particular version of the module
        #ReleaseNotes = $True

        # If true, the LicenseUrl points to an end-user license (not just a source license) which requires the user agreement before use.
        # RequireLicenseAcceptance = ""

        # Indicates this is a pre-release/testing version of the module.
        IsPrerelease = 'False'
    }
}

}