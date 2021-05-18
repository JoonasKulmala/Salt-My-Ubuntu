# Salt My Ubuntu

- [Salt My Ubuntu](#salt-my-ubuntu)
  - [Getting started](#getting-started)
    - [Salt Master](#salt-master)
    - [Salt Minion](#salt-minion)
  - [Manual installation](#manual-installation)
    - [apt repository](#apt-repository)
    - [Installing Salt Master & Minion](#installing-salt-master--minion)
    - [Salt Minion configuration](#salt-minion-configuration)

| Tool        | Version      |
| ----------- | ------------ |
| Linux       | Ubuntu 20.14 |
| Salt Master | 3003         |
| Salt Minion | 3003         |

**Salt My Ubuntu** is an automated process to setup Salt Master & Salt Minion on Linux Ubuntu 20.14. There are 3 steps to perform:
1. Clone this repository (git clone or download ZIP)
2. Modify the `minion` file 
3. Run bash script to install & configure Salt Master and/or Minion

Please see `USER GUIDE` and edit the necessary files before installing.

Learn more about the [Salt Project](https://docs.saltproject.io/en/latest/topics/about_salt_project.html), how to manually perform [Installation](https://docs.saltproject.io/en/latest/topics/installation/index.html) installation on your system and guide to  [Configuring Salt](https://docs.saltproject.io/en/latest/topics/configuration/index.html).

## Getting started

Either use the command **git clone** or download and extract the `.zip` package of the repository.

    $ git clone https://github.com/JoonasKulmala/Salt-My-Ubuntu.git

![download repository](Resources/download_repository.png)

### Salt Master

Salt Master requires firewall traffic to ports 4505 & 4506:

    # Debian
    $ -A INPUT -m state --state new -m tcp -p tcp --dport 4505:4506 -j ACCEPT
    # Ubuntu
    $ ufw allow salt

To install and configure Salt Master run the bash script `install-master` located in `/Salt-My-Ubuntu/install-master`:

    $ bash install-master

The bash script does the following:
1. Copies SaltStack repository key to `/usr/share/keyring/salt-archive-keyring.gpg`
2. Adds SaltStack repository list to `/etc/apt/sources.list.d/salt-list`
3. Installs salt-master package
4. Copies `master` configuration file to `/etc/salt/master`
5. (False by default) removes this downloaded repository

### Salt Minion

Salt Minion requires atleast 1 line modification to `minion` file; IP address of Salt Master must be added:

![salt master IP address](Resources/salt-master_ip.png)

To install and configure Salt Minion run the bash script `install-minion` located in `/Salt-My-Ubuntu/install-minion`:

    $ bash install-minion

The bash script does the following:
1. Copies SaltStack repository key to `/usr/share/keyring/salt-archive-keyring.gpg`
2. Adds SaltStack repository list to `/etc/apt/sources.list.d/salt-list`
3. Installs salt-minion package
4. Copies `minion` configuration file to `/etc/salt/minion`
5. (False by default) removes this downloaded repository

## Manual installation

If you are unable to run the bash script, encounter errors or wish to complete the steps manually the process is below.

Here is SaltStack's [Installation](https://docs.saltproject.io/en/latest/topics/installation/index.html) documentation.

### apt repository

To install salt minion, SaltStack repository key & source list must be added:

    # Download key
    $ sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg
    # Create apt sources list file
    $ echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/
    sources.list.d/salt.list
    # Update apt repository list
    $ sudo-apt get update

### Installing Salt Master & Minion

After adding the repository you can install salt minion using APT:

    master $ sudo apt-get install salt-master
    minion $ sudo-apt get install salt-minion

### Salt Minion configuration

Now the salt minion must be configured by modifying `/etc/salt/minion`. Either: 
* copy this [minion](minion) file or its contents
* add the values:
  * master: your_master_ip
  * id: your_minion_name

![minion config](Resources/minion_config.png)
  
Finally, restart the salt minion service to connect with your salt master:

    $ sudo systemctl restart salt-minion

Your salt minion is now ready, provided its salt master is configured properly. Salt Master must accept the new minion:

    # -A accepts all pending keys
    $ sudo salt-key


