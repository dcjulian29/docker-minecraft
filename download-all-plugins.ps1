if (-not (Test-Path "$PSScriptRoot\.docker")) {
  New-Item -ItemType Directory -Path "$PSScriptRoot\.docker" -Verbose
}

if (-not (Test-Path "$PSScriptRoot\.docker\plugins")) {
  New-Item -ItemType Directory -Path "$PSScriptRoot\.docker\plugins" -Verbose
}

$urls = @(
  "https://mediafilez.forgecdn.net/files/6786/280/worldedit-bukkit-7.3.16.jar"
  "https://mediafilez.forgecdn.net/files/6643/567/worldguard-bukkit-7.0.14-dist.jar"
  "https://mediafilez.forgecdn.net/files/7045/706/multiverse-core-5.3.0.jar"
  "https://mediafilez.forgecdn.net/files/6771/890/multiverse-portals-5.1.0.jar"
  "https://mediafilez.forgecdn.net/files/6774/131/multiverse-netherportals-5.0.3.jar"
  "https://mediafilez.forgecdn.net/files/6771/891/multiverse-signportals-5.0.1.jar"
  "https://mediafilez.forgecdn.net/files/6769/644/Dynmap-3.7-beta-10-spigot.jar"
  "https://mediafilez.forgecdn.net/files/6844/22/EssentialsX-2.21.2.jar"
  "https://mediafilez.forgecdn.net/files/3007/470/Vault.jar"
  "https://ci.lucko.me/job/spark/494/artifact/spark-bukkit/build/libs/spark-1.10.144-bukkit.jar"
  "https://cdn.modrinth.com/data/MubyTbnA/versions/37l08D01/FreedomChat-Paper-1.7.5.jar"
  "https://download.luckperms.net/1600/bukkit/loader/LuckPerms-Bukkit-5.5.14.jar"
  "https://mediafilez.forgecdn.net/files/3599/622/NoMobGriefing-3.0.3.jar"
  "https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/5.4.2/PAPER/ViaVersion-5.4.2.jar"
  "https://hangarcdn.papermc.io/plugins/ViaVersion/ViaBackwards/versions/5.4.2/PAPER/ViaBackwards-5.4.2.jar"
)

foreach ($url in $urls) {
  $file = "$PSScriptRoot\.docker\plugins\" + $url.Substring($url.LastIndexOf('/') + 1)

  if (Test-Path $file) {
    Remove-Item -Path $file -Force
  }

  Invoke-WebRequest -Uri $url -UseBasicParsing -OutFile $file -Verbose
}
