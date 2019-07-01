#!/bin/bash

mkdir ~/.config/mpd

cd ~/.config/mpd/

mkdir playlists
touch mpd.db mpd.log mpdstate sticker.sql

# TODO: copy config
# wget https://taingram.org/ -o mpd.conf

systemctl --user enable --now mpd
