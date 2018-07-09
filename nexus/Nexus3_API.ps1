function Get-POMVars () {

    [xml]$pom = Get-Content -Path pom.xml

    $ext = "jar"

    if ($isZip) { $ext = "zip" }
    else { $ext = $pom.project.packaging }

    $variable_map = @{
        "groupid"        = $pom.project.groupId;
        "artifactid"     = $pom.project.artifactId;
        "projectversion" = $pom.project.version;
        "packageformat"  = $ext;
    }

    return $variable_map
}

function Find-JavaBinary([Hashtable]$variable_map) {
    $FQgid = "maven.groupId=$(      $variable_map.groupid)"
    $FQaid = "maven.artifactId=$(   $variable_map.artifactid)"
    $FQver = "maven.baseVersion=$(  $variable_map.projectversion)"
    $FQext = "maven.extension=$(    $variable_map.packageformat)"
    return ($baseURL + "search/assets?$FQgid&$FQaid&$FQver&$FQext")
}

function Invoke-NexusCall ([String]$URL) {
    $a = Invoke-RestMethod $URL -Headers $headers
    # Get the last returned item from the returned json list.
    # Necessary because there may be multiple items available for the provided
    # groupid, artifactid, and version. (Namely snapshots)
    # This returns the download url of the most recent snapshot
    $target_download_url = "$($a.items[$($a.items.Length - 1)].downloadUrl)"

    return $target_download_url
}

function Get-Binary([String]$URL, [String]$Location, [Hashtable]$credentials) {
    Invoke-RestMethod $URL -Headers $credentials -OutFile $Location
}


$baseURL = "https://nexus.instance:1234/service/rest/beta/"

$credentials = [System.Convert]::ToBase64String(
    [System.Text.Encoding]::ASCII.GetBytes($Stored_Credentials)
)

$headers = @{ Authorization = "Basic $credentials" }
