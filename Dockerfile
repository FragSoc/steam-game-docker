FROM steamcmd/steamcmd AS steambuild
# SETUP: Add maintainers

# SETUP: Get the appid of the dedicated server from steamdb or similar
ARG APPID=<YOUR APPID HERE>
ARG UID=999

# SETUP: Replace all occurences of GAME_NAME with the name of the game you're installing
# SETUP: or an abbreviation of it (suggest a regex)
ENV CONFIG_LOC="/config"
ENV INSTALL_LOC="/GAME_NAMEserver"

# Upgrade the system
USER root
RUN apt-get update
RUN apt-get upgrade --assume-yes

# Install the GAME_NAME server
RUN mkdir -p $INSTALL_LOC
RUN steamcmd \
    +login anonymous \
    +force_install_dir $INSTALL_LOC \
    +app_update $APPID validate \
    +quit

# Setup directory structure and permissions
RUN useradd -m -s /bin/false -u $UID GAME_NAME
RUN mkdir -p $CONFIG_LOC $INSTALL_LOC
RUN chown -R GAME_NAME:GAME_NAME $INSTALL_LOC $CONFIG_LOC

# I/O
VOLUME $CONFIG_LOC
# SETUP: Add more ports as you need them
EXPOSE 7777/udp

# Expose and run
USER GAME_NAME
WORKDIR $INSTALL_LOC
# SETUP: Add an entrypoint for the game
