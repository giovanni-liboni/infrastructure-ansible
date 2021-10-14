<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <h3 align="center">Infrastructure @home</h3>
  <p align="center">
    Configuration for the home educational data-center with Ansible
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This repository is a collection of Ansible Playbooks and assets deployed on my servers at home and in the cloud (GCE, Oracle Cloud). It includes home automation projects, movies and TV series management systems, 3D print monitor and timelapses servers, and more. The project is for educational purposes.

<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

Let's first install the required Python dependencies:

* MacOS - [homebrew](https://brew.sh)
    1. Install `python3` with `brew` run: 
        ```sh
        brew install python3
        ```
    2. Update the `PATH` environment variable in `~/.zshrc` if you're using `zsh` or `~/.bash_profile` if you're using `bash`
        ```sh
        export PATH=/usr/local/share/python:$PATH
        ```
        Restart the terminal or run the following commands
        ```sh
        source ~/.zshrc
        ```
        or
        ```sh
        source ~/.bash_profile
        ```
    4.  Install `virtualenv`
        ```sh
        pip3 install virtualenv
        ```

* MacOS - Default Python installation
    ```sh
    pip install virtualenv
    ```
Now it's time to install `ansible` into the virtual environment

1. Create the Python virtual environment
    ```sh
    virtualenv myansible
    ```
2. Activate the virtual environment
    ```sh
    source myansible/bin/activate
    ```
3. Install Ansible and the requirements with `pip`
    ```sh
    pip install -r requirements.txt
    ```

## Playbooks available

### Base Services

- [Authelia](https://github.com/authelia/authelia) - An open-source authentication and authorization server
- [Postgres](https://www.postgresql.org/) - An open source database system
- [Redis](https://redis.io/) - An in-memory database that persists on disk
- [Tecnativa](https://github.com/Tecnativa/) - Proxy over your Docker socket to restrict which requests it accepts
- [Traefik](https://containo.us/traefik/) - The Cloud Native Edge Router
- [Homer](https://github.com/bastienwirtz/homer/) - A very simple static homepage for your server

### Core Services

- [Visual Studio Code](https://code.visualstudio.com/) - Modern integrated development environment
- [OpenVPN Proxy](https://hub.docker.com/r/dceschmidt/openvpn-proxy) - Service containg an OpenVPN Client and a Squid Proxy Server
- [Transmission](https://transmissionbt.com/) - BitTorrent Client with an integrated OpenVPN Client

### Media Services

- [Jackett](https://github.com/Jackett/Jackett/) - API Support for your favorite torrent trackers
- [Bazarr](https://github.com/morpheus65535/bazarr/) - Bazarr is a companion application to Sonarr and Radarr that manages and downloads subtitles
- [Calibre](https://calibre-ebook.com/) - Ebook manager
- [Calibre Web](https://github.com/janeczku/calibre-web) - Web app providing a clean interface for browsing, reading and downloading eBooks using an existing Calibre database
- [Photoprism](https://photoprism.io/) - Personal Photo Management powered by Go and Google TensorFlow
- [Tdarr](https://github.com/HaveAGitGat/Tdarr/) - Audio/Video library analytics + transcode automation using FFmpeg/HandBrake + video health checking
- [Radarr](https://github.com/Radarr/Radarr/) - A fork of Sonarr to work with movies à la Couchpotato
- [Sonarr](https://github.com/Sonarr/Sonarr/) - Smart PVR for newsgroup and bittorrent users
- [Jellyfin](https://github.com/jellyfin/jellyfin/) - The Free Software Media System

### Other playbooks

- [ansible-ssh-hardening](https://github.com/dev-sec/ansible-ssh-hardening) - SSH hardening playbook to run against production servers
- `common` - Common settings for development and production servers
- [cups](http://www.cups.org/) - Print server

## Development guidelines

### Directory layout

Based on [Ansible Best Practices](https://docs.ansible.com/ansible/playbooks_best_practices.html#directory-layout)

<pre>
production                # inventory file for production servers
staging                   # inventory file for staging environment

group_vars/
   group1                 # here we assign variables to particular groups
   group2                 # ""
host_vars/
   hostname1              # if systems need specific variables, put them here
   hostname2              # ""

library/                  # if any custom modules, put them here (optional)
filter_plugins/           # if any custom filter plugins, put them here (optional)

site.yml                  # master playbook
webservers.yml            # playbook for webserver tier
dbservers.yml             # playbook for dbserver tier

roles/
    common/               # this hierarchy represents a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies

    webtier/              # same kind of structure as "common" was above, done for the webtier role
    monitoring/           # ""
    fooapp/               # ""
</pre>

## Ansible Tips

### Generate empty role skeleton
In your roles directory, type ansible-galaxy init <em>role_name</em> in order to generate an empty skeleton for a new role you are working on.

Example:
<pre>
ansible-galaxy init nginx
</pre>

Check out [Ansible Examples](https://github.com/ansible/ansible-examples) for example playbooks.

### Upgrade all servers - Ubuntu only

```sh
ansible ubuntu -m apt -a "upgrade=yes update_cache=yes" -b
```

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License

Distributed under the MIT license. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Giovanni Liboni - giovanni@liboni.me

Project Link: [https://github.com/giovanni-liboni/infrastructure-ansible](https://github.com/giovanni-liboni/infrastructure-ansible)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Best-README-Template](https://github.com/othneildrew/Best-README-Template/blob/master/README.md)
* [Choose an Open Source License](https://choosealicense.com)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/giovanni-liboni/infrastructure-ansible.svg?style=for-the-badge
[contributors-url]: https://github.com/giovanni-liboni/infrastructure-ansible/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/giovanni-liboni/infrastructure-ansible.svg?style=for-the-badge
[forks-url]: https://github.com/giovanni-liboni/infrastructure-ansible/network/members
[stars-shield]: https://img.shields.io/github/stars/giovanni-liboni/infrastructure-ansible.svg?style=for-the-badge
[stars-url]: https://github.com/giovanni-liboni/infrastructure-ansible/stargazers
[issues-shield]: https://img.shields.io/github/issues/giovanni-liboni/infrastructure-ansible.svg?style=for-the-badge
[issues-url]: https://github.com/giovanni-liboni/infrastructure-ansible/issues
[license-shield]: https://img.shields.io/github/license/giovanni-liboni/infrastructure-ansible.svg?style=for-the-badge
[license-url]: https://github.com/giovanni-liboni/infrastructure-ansible/blob/master/LICENSE
