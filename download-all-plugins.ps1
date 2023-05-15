if (-not (Test-Path "$PSScriptRoot\.docker")) {
  New-Folder -Folder "$PSScriptRoot\.docker"
}

Invoke-TouchFile -Path ".\.docker\banned-ips.json"
Invoke-TouchFile -Path ".\.docker\banned-ips.json"
Invoke-TouchFile -Path ".\.docker\bukkit.yml"
Invoke-TouchFile -Path ".\.docker\ops.json"
Invoke-TouchFile -Path ".\.docker\server.properties"
Invoke-TouchFile -Path ".\.docker\spigot.yml"
Invoke-TouchFile -Path ".\.docker\whitelist.json"

if (-not (Test-Path "$PSScriptRoot\.docker\plugins")) {
  New-Folder -Folder "$PSScriptRoot\.docker\plugins"
}

$urls = @(
  "https://mediafilez.forgecdn.net/files/4445/117/worldedit-bukkit-7.2.14.jar"
  "https://mediafilez.forgecdn.net/files/3677/516/worldguard-bukkit-7.0.7-dist.jar"
  "https://mediafilez.forgecdn.net/files/3462/546/Multiverse-Core-4.3.1.jar"
  "https://mediafilez.forgecdn.net/files/3113/114/Multiverse-Portals-4.2.1.jar"
  "https://mediafilez.forgecdn.net/files/3687/506/Multiverse-NetherPortals-4.2.2.jar"
  "https://mediafilez.forgecdn.net/files/4414/231/multiverse-signportals-4.2.1.jar"
  "https://mediafilez.forgecdn.net/files/4512/871/Dynmap-3.5-spigot.jar"
  "https://mediafilez.forgecdn.net/files/3680/816/DriveBackupV2.jar"
  "https://mediafilez.forgecdn.net/files/3948/289/EssentialsX-2.19.7.jar"
  "https://mediafilez.forgecdn.net/files/3007/470/Vault.jar"
  "https://ci.lucko.me/job/spark/376/artifact/spark-bukkit/build/libs/spark-1.10.38-bukkit.jar"
)

foreach ($url in $urls) {
  $file = "$PSScriptRoot\.docker\plugins\" + $url.Substring($url.LastIndexOf('/') + 1)

  if (Test-Path $file) {
    Remove-Item -Path $file -Force
  }

  Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $file
}
