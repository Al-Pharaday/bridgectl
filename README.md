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

Or alternatively, manually create a `torctl` folder in `/usr/etc/` and copy the `bridgectl` and `bridges.txt` files there.
4. `./handle.sh add` opens the `bridges.txt` file using Nano. Add your bridges lines there one per line and save.

## Usage

You should have `torctl` and `obfs4proxy` installed. `torctl` requires some modifications to use bridges automatically, and so:
- Edit the [`torctl`](https://github.com/BlackArch/torctl/blob/master/torctl) file manually (it is located at `/usr/bin/torctl`) or using the provided scripts (see below).
- Insert your bridges into the `bridges.txt` file (`/usr/etc/torctl/bridges.txt`) one per line, starting each line with `obfs4`.

#### using preinstalled scripts to edit the `torctl` file
(This will work as long as the present `torctl` file remains unmodified as the `torctl_tweaker.sh` script uses the strings order in the present `torctl` file. The same effect can be achieved in a much easier way by simply moving an already modified `torctl` to its folder, but this repo sticks to a fancier approach.)

- You should have `torctl` and `obfs4proxy` installed.
- Run `sudo ./handle.sh install` to add the bridge mode for `torctl`.
- Run `sudo ./handle.sh uninstall` to revert everything.
Then just
```
torctl start
```
```
torctl stop
```

`handle.sh` flags:
```bash
install
uninstall
enable
disable
add    - opens file, where you can add/remove bridges
```

### Modified torctl

[`torctl`](https://github.com/Nespelem-3000/torctl/blob/bridge-hook/torctl)

