if (-not (Test-Path "$PSScriptRoot\.docker")) {
  New-Item -ItemType Directory -Path "$PSScriptRoot\.docker" -Verbose
}

Invoke-TouchFile -Path ".\.docker\banned-ips.json"
Invoke-TouchFile -Path ".\.docker\banned-ips.json"
Invoke-TouchFile -Path ".\.docker\bukkit.yml"
Invoke-TouchFile -Path ".\.docker\ops.json"
Invoke-TouchFile -Path ".\.docker\server.properties"
Invoke-TouchFile -Path ".\.docker\spigot.yml"
Invoke-TouchFile -Path ".\.docker\whitelist.json"

if (-not (Test-Path "$PSScriptRoot\.docker\plugins")) {
  New-Item -ItemType Directory -Path "$PSScriptRoot\.docker\plugins" -Verbose
}

$urls = @(
  "https://mediafilez.forgecdn.net/files/5168/643/worldedit-bukkit-7.3.0.jar"
  "https://mediafilez.forgecdn.net/files/4675/318/worldguard-bukkit-7.0.9-dist.jar"
  "https://mediafilez.forgecdn.net/files/4744/18/multiverse-core-4.3.12.jar"
  "https://mediafilez.forgecdn.net/files/4721/154/multiverse-portals-4.2.3.jar"
  "https://mediafilez.forgecdn.net/files/4721/150/multiverse-netherportals-4.2.3.jar"
  "https://mediafilez.forgecdn.net/files/4721/189/multiverse-signportals-4.2.2.jar"
  "https://mediafilez.forgecdn.net/files/5299/546/Dynmap-3.7-beta-5-spigot.jar"
  "https://mediafilez.forgecdn.net/files/4554/611/DriveBackupV2.jar"
  "https://mediafilez.forgecdn.net/files/4684/81/EssentialsX-2.20.1.jar"
  "https://mediafilez.forgecdn.net/files/3007/470/Vault.jar"
  "https://ci.lucko.me/job/spark/410/artifact/spark-bukkit/build/libs/spark-1.10.65-bukkit.jar"
  "https://cdn.modrinth.com/data/UmLGoGij/versions/mr2CijyC/DiscordSRV-Build-1.27.0.jar"
  "https://cdn.modrinth.com/data/MubyTbnA/versions/Y9N0QwjG/FreedomChat-1.5.2.jar"
  "https://download.luckperms.net/1539/bukkit/loader/LuckPerms-Bukkit-5.4.126.jar"
  "https://mediafilez.forgecdn.net/files/3599/622/NoMobGriefing-3.0.3.jar"
  "https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/4.10.1/PAPER/ViaVersion-4.10.1.jar"
  "https://hangarcdn.papermc.io/plugins/ViaVersion/ViaBackwards/versions/4.10.1/PAPER/ViaBackwards-4.10.1.jar"
)

foreach ($url in $urls) {
  $file = "$PSScriptRoot\.docker\plugins\" + $url.Substring($url.LastIndexOf('/') + 1)

  if (Test-Path $file) {
    Remove-Item -Path $file -Force
  }

  Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $file -Verbose
}
