# Ampache Docker Image

This repository contains a `dockerfile` to build as small an Ampache image as possible, as well as a simple `docker-compose.yml` to start the Ampache container, as well as a mariadb container.

```bash
kuzi:~$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ampache             latest              e642415f8940        26 minutes ago      717MB
```

## About

The dockerfile grabs the Ampache source and installs dependencies within a Composer container, then copies the finished result to a new image to minimize the end image size as much as possible.

The docker-compose file exposes an Apache server on port 80 with PHP 7.4. Database information is stored in a named volume **db-vol**, the directory for music in the Ampache image is located at `/media`, which is also mapped to `/media` on the host. You will likely want to change that to where your media is stored on your host. The Ampache configuration is stored in the named volume `ampache-vol` if you would like to edit the config file after installation. Lastly if you want Ampache logs, you will need to enable logging in the configuration, and then logs will be stored in `./data/log` relative to the docker-compose.yml file.

This image has not been fully tested, but does allow you to add catalogs, and play music from the web interface.

## Usage

Feel free to change the passwords in the .env file, but make sure to follow these instructions with the changed passwords!

1. Run `build.sh` or if on Windows just run `Docker build -t ampache .`
2. Run `docker-compose up -d` to start the Ampache image and database.
3. Navigate to `http://localhost/`
4. Complete Installation
    1. Choose Installation Language
        * click **Start Configuration**
    2. Requirements
        * click **Continue**
    3. Insert Ampache Database
        1. Set "MySQL Hostname" to **ampache-db**
        2. Set "MySQL Administrative Password" to **ampacheroot**
        3. Check the box for "Overwrite if Database Already Exists"
        4. Click **Insert Database**
    4. Generate Configuration File
        1. Set "MySQL Password" to **ampache**
        2. Click **Create Config**
    5. Create Admin Account
        1. Fill in the **Password** and **Confirm Password** fields
        2. Click **Create Account**
    6. Ampache Update
        1. Click **Update Now!**
        2. Click **Return to main page** to go to the Login Page to start using Ampache.
