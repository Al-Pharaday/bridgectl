# bridgectl
A script to hook with torctl so that the latter can use bridges.

## Description

A script you can hook to [`torctl`](https://github.com/BlackArch/torctl) and force it to make use of provided bridges (currently only `obfs4`).

## Installation

1. Dounload the repository to your `home` directory.
2. Make the installation script which comes with the repo (`installation.sh`) executable by running:
```bash
chmod +x installation.sh
```
3. Run the installation script as `root`.

After the above steps you should have `torctl` subdirectory in `/usr/etc/` with two files `bridgectl` and `bridges.txt`.

Or alternatively, create a `torctl` folder in `/usr/etc/` and copy the `bridgectl` and `bridges.txt` files in there. 

## Usage

- You should have `torctl` and `obfs4proxy` installed.
- Edit the [`torctl`](https://github.com/BlackArch/torctl/blob/master/torctl) file to use this script.
- Insert your bridges into the `bridges.txt` file (`/usr/etc/torctl/bridges.txt`) one per line, starting each line with `obfs4`.

### Tweaking torctl
`/usr/bin/torctl`
Given the current version, add:
1. 
```bash
[[ -f "/usr/etc/torctl/bridgectl" ]] && BRIDGES="/usr/etc/torctl/bridgectl" && source $BRIDGES
```
between `check_backup_dir()` and `start_service()` function defenitions.

2. 
```bash
$BRIDGES_FOR_TORRC
```
inside `gen_torrc()` function defenition after the `EnforceDistinctSubnets 1` line.

3. 
```bash
[[ -f $BRIDGES ]] && conf_bridges || :
```
inside `start()` function defenition right befote the call to `gen_torrc`.


