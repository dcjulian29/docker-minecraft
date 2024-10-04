if (-not (Test-Path "$PSScriptRoot\.docker")) {
  New-Item -ItemType Directory -Path "$PSScriptRoot\.docker" -Verbose
}

Invoke-TouchFile -Path ".\.docker\banned-ips.json"
Invoke-TouchFile -Path ".\.docker\banned-players.json"
Invoke-TouchFile -Path ".\.docker\bukkit.yml"
Invoke-TouchFile -Path ".\.docker\ops.json"
Invoke-TouchFile -Path ".\.docker\server.properties"
Invoke-TouchFile -Path ".\.docker\spigot.yml"
Invoke-TouchFile -Path ".\.docker\whitelist.json"

if (-not (Test-Path "$PSScriptRoot\.docker\plugins")) {
  New-Item -ItemType Directory -Path "$PSScriptRoot\.docker\plugins" -Verbose
}

$urls = @(
  "https://mediafilez.forgecdn.net/files/5613/179/worldedit-bukkit-7.3.6.jar"
  "https://mediafilez.forgecdn.net/files/5719/698/worldguard-bukkit-7.0.12-dist.jar"
  "https://mediafilez.forgecdn.net/files/5706/886/multiverse-core-4.3.13.jar"
  "https://mediafilez.forgecdn.net/files/4721/154/multiverse-portals-4.2.3.jar"
  "https://mediafilez.forgecdn.net/files/4721/150/multiverse-netherportals-4.2.3.jar"
  "https://mediafilez.forgecdn.net/files/5668/259/multiverse-signportals-4.3.0.jar"
  "https://cdn.modrinth.com/data/fRQREgAc/versions/AdtrWcU2/Dynmap-3.7-beta-7-spigot.jar"
  "https://mediafilez.forgecdn.net/files/4684/81/EssentialsX-2.20.1.jar"
  "https://mediafilez.forgecdn.net/files/3007/470/Vault.jar"
  "https://ci.lucko.me/job/spark/456/artifact/spark-bukkit/build/libs/spark-1.10.110-bukkit.jar"
  "https://cdn.modrinth.com/data/MubyTbnA/versions/x6xcBZtb/FreedomChat-Paper-1.7.0.jar"
  "https://download.luckperms.net/1556/bukkit/loader/LuckPerms-Bukkit-5.4.141.jar"
  "https://mediafilez.forgecdn.net/files/3599/622/NoMobGriefing-3.0.3.jar"
  "https://ci.viaversion.com/job/ViaVersion/921/artifact/build/libs/ViaVersion-5.0.3.jar"
  "https://hangarcdn.papermc.io/plugins/ViaVersion/ViaBackwards/versions/5.0.3/PAPER/ViaBackwards-5.0.3.jar"
)

foreach ($url in $urls) {
  $file = "$PSScriptRoot\.docker\plugins\" + $url.Substring($url.LastIndexOf('/') + 1)

  if (Test-Path $file) {
    Remove-Item -Path $file -Force
  }

  Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $file -Verbose
}
