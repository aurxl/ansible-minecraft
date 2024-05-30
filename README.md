# Ansible-Minecraft

#### Installing Minecraft vanilla or Fabric Server on Linux.

This will create a minecraft user that will handle the minecraft server. This role will not configure or harden your linux server in any way. Take care of it yourself!

#### Supported linux distros are:
- RHEL based (Fedora, EL, Rocky, ...)
- Debian based (Debian, Ubuntu, ...)

#### Installation:
```bash
ansible-galaxy role install aurxl.minecraft
```

## Usage
- Set some [options](#options) in your playbook or host_var
  - Take a look at [example-host_var](#example-host_var)
- If you want a new world, run your playbook with `-e "remove_world=true"`
  - Usefull when you previously added a `custom_world`, but now want to generate a new one
- Connect to tmux session when `interactive` is enabled:
    ```bash
    sudo -u minecraft tmux a
    ```

#### Fabric server
It is also possible to install a [fabric](https://fabricmc.net/) server in order to play with mods enabled.
See example [Fabric](#fabric) config below.


## Options
#### General Server Options:
- `path`  (string): Remote root path of the minecraft server
  - Default: "/opt/minecraft-server"
- `version` (string): Minecraft version
  - Default: "latest"
  - available versions:
    -  1.20.6
    -  1.20.2
    -  1.19.4
    -  1.18.2
    -  1.17.1
- `eula` (bool): Agree the EULA (https://aka.ms/MinecraftEULA)
  - Default: `false`
- `custom_world` (string): Path to a local saved `world` directory
  - Default: None
  - When your `world` name is not "world", remember to set the `world` name in the `server_properties.level_name` option
- `interactive` (bool): Run server in tmux session
  - Default: true
  - Turning this off is **not** recommended
- `min_mem` (int): Minimum memory option passed to jvm
  - Default: 1
- `max_mem` (int): Maximum memory option passed to jvm
  - Default: 2
- `whitelist` (list): List of usernames to be added to whitelist
  - Default: []
- `server_properties` (dict): Set the usual options from `server.properties` file
  - Default: Default `server.properties`
  - Note, that `-` and `.` **must** be replaced by `_`

#### Fabric server options
- `fabric` (dict): Install Fabric server
  - `enable` (bool): wether to enable fabric or not
    - Default: false
  - `mods` (list): A list of mods to install from modrinth
    - Takes a dict with keys `name` and `version`
      - Default: []
      - Modrinth support
      - `name`: Modrinth project name
      - `version`: Version id -> [find my mod version id on modrinth](#find-my-mod-version-id-on-modrinth)
  - `local_mods` (string): Path to local mods dir you want to install
    - Default: ""
    - Will be merged with mods installed by `mods` option
  - `config`: (list): list of mod configs that will be placed in `config`
    - `name`: file name
    - `content`: content of the config file
    - `path`: local path of a config file


### Find my mod version id on modrinth

1. Go to the Modrinth project page and click at the mod tab your desired version
2. Navigate to `Metadata`
3. Copy `Version ID`

## Example host_var
#### Vanilla
```yaml
minecraft:
  path: "/opt/minecraft-server"
  version: "1.20.6"
  eula: true

  # Upload your local save
  custom_world: "~/your_world"

  # Running the server inside tmux
  # so you can interact with the server
  interactive: true

  min_mem: 2
  max_mem: 4

  whitelist:
    - username

  server_properties:
    enable_jmx_monitoring: false
    level_seed:
    rcon_port: 25575
    gamemode: survival
    enable_command_block: false
    enable_query: false
    generator_settings: {}
    enforce_secure_profile: true
    level_name: world
    motd: "Minecraft Server"
    query_port: 25565
    pvp: true
    generate_structures: true
    max_chained_neighbor_updates: 1000000
    difficulty: easy
    network_compression_threshold: 256
    max_tick_time: 60000
    require_resource_pack: false
    use_native_transport: true
    max_players: 20
    online_mode: true
    enable_status: true
    allow_flight: false
    broadcast_rcon_to_ops: true
    view_distance: 10
    server_ip:
    resource_pack_prompt: 
    allow_nether: true
    server_port: 25565
    enable_rcon: false
    sync_chunk_writes: true
    op_permission_level: 4
    prevent_proxy_connections: false
    hide_online_players: false
    resource_pack: 
    entity_broadcast_range_percentage: 100
    simulation_distance: 10
    rcon_password: 
    player_idle_timeout: 0
    force_gamemode: false
    rate_limit: 0
    hardcore: false
    white_list: false
    broadcast_console_to_ops: true
    spawn_npcs: true
    previews_chat: false
    spawn_animals: true
    function_permission_level: 2
    level_type: bclib\:normal
    text_filtering_config: 
    spawn_monsters: true
    enforce_whitelist: false
    spawn_protection: 16
    resource_pack_sha1: 
    max_world_size: 29999984
```

#### Fabric
```yaml
minecraft:
  path: "/opt/minecraft-server"
  version: "latest"
  eula: true

  fabric:
    enabled: true
    local_mods: "~/your/mod/folder"
    mods:
      - name: lithium
        version: bAbb09VF
      - name: fabric-api
        version: sswM8UzU
    config:
      - name: fighters.properties
        path: ~/foo/fighters.properties
      - name: hitchhiker.guide
        content: |
            answer=42;

  min_mem: 2
  max_mem: 4
```
