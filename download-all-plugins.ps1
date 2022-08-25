if (-not (Test-Path "$PSScriptRoot\.docker\plugins")) {
  New-Folder -Folder "$PSScriptRoot\.docker\plugins"
}

$urls = @(
  "https://mediafiles.forgecdn.net/files/3922/624/worldedit-bukkit-7.2.12.jar"
  "https://mediafiles.forgecdn.net/files/3677/516/worldguard-bukkit-7.0.7-dist.jar"
  "https://mediafiles.forgecdn.net/files/3462/546/Multiverse-Core-4.3.1.jar"
  "https://mediafiles.forgecdn.net/files/3113/114/Multiverse-Portals-4.2.1.jar"
  "https://mediafiles.forgecdn.net/files/3687/506/Multiverse-NetherPortals-4.2.2.jar"
  "https://mediafiles.forgecdn.net/files/3074/605/Multiverse-SignPortals-4.2.0.jar"
  "https://mediafiles.forgecdn.net/files/3934/649/Dynmap-3.4-spigot.jar"
  "https://mediafiles.forgecdn.net/files/2843/593/Dynmap-WorldGuard-1.2.jar"
  "https://mediafiles.forgecdn.net/files/3680/816/DriveBackupV2.jar"
  "https://mediafiles.forgecdn.net/files/3695/832/DiscordSRV-Build-1.25.1.jar"
  "https://mediafiles.forgecdn.net/files/3933/49/PvPManager.jar"
  "https://ci.opencollab.dev//job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar"
)

foreach ($url in $urls) {
  $file = "$PSScriptRoot\.docker\plugins\" + $url.Substring($url.LastIndexOf('/') + 1)

  if (Test-Path $file) {
    Remove-Item -Path $file -Force
  }

  Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $file
}
