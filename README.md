# bridgectl
A script that facilitates the use of bridges with torctl.

## Description

A script you can hook into [`torctl`](https://github.com/BlackArch/torctl) and force it to make use of provided bridges (currently only `obfs4`).

## Installation

1. Dounload the repository to your `home` directory.
2. Make the installation script which comes with the repo (`handle.sh`) executable by running:
```bash
chmod +x handle.sh
```
then (as `root`)
```bash
./handle.sh install
```
3. Run the `handle.sh` script as `root`.

After the above steps you should have `torctl` subdirectory in `/usr/etc/` with two files `bridgectl` and `bridges.txt`.

Or alternatively, create a `torctl` folder in `/usr/etc/` and copy the `bridgectl` and `bridges.txt` files in there. 

## Usage

- You should have `torctl` and `obfs4proxy` installed.
- Edit the [`torctl`](https://github.com/BlackArch/torctl/blob/master/torctl) file to use this script.
- Insert your bridges into the `bridges.txt` file (`/usr/etc/torctl/bridges.txt`) one per line, starting each line with `obfs4`.

`handle.sh`
```bash
install
uninstall
enable
disable
add    - opens file, where you can add/remove bridges
```

### Tweaked torctl

[`torctl`](https://github.com/Nespelem-3000/torctl/blob/bridge-hook/torctl)

