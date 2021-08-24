# README for base-kamailio

This README will help you understand the objective of this Dockerfile

## Table of Contents

- [Description](#description)
- [Usage](#usage)
- [Support](#support)
- [Contributing](#contributing)

## Description

The idea is for this Dockefile to create an image conatining all the base software for:
 - Kamailio
 - awscli

## Usage

You should first build this image like:

```docker build -t kamailio:5.3 .```

Once you've done this, then you can use it as a base image on another Dockerfile and add your config stuff so you don't have to create a whole new docker image and install all the kamailio, etc.
