#!/bin/bash
# rmpc-like.sh
# Like or unlike the current song in rmpc, preserving folder structure

# Favorites folder
FAV_FOLDER="$HOME/Music/Favorites"
mkdir -p "$FAV_FOLDER"

# MPD music directory
MPD_MUSIC_DIR="$HOME/Music"

# Get currently playing song's relative path
REL_PATH=$(rmpc --format "%file%" current)
if [ -z "$REL_PATH" ]; then
    echo "No song is currently playing."
    exit 1
fi

# Absolute path to the song
SONG_ABS="$MPD_MUSIC_DIR/$REL_PATH"

# Debug
echo "Relative path: $REL_PATH"
echo "Absolute path: $SONG_ABS"

# Check if file exists
if [ ! -f "$SONG_ABS" ]; then
    echo "Song file not found: $SONG_ABS"
    exit 1
fi

# Destination path in Favorites
DEST="$FAV_FOLDER/$REL_PATH"
DEST_DIR=$(dirname "$DEST")
mkdir -p "$DEST_DIR"

# Like/unlike logic
if [ -f "$DEST" ]; then
    rm "$DEST"
    echo "Unliked: $REL_PATH"
else
    cp "$SONG_ABS" "$DEST"
    echo "Liked: $REL_PATH"
fi
