FROM steamcmd/steamcmd AS steambuild
# SETUP: Add maintainers

# SETUP: Get the appid of the dedicated server from steamdb or similar
ARG APPID=<YOUR APPID HERE>
ARG UID=999
ARG GID=999

ENV CONFIG_LOC="/config"
ENV INSTALL_LOC="/GAME_NAME"

# Upgrade the system
USER root
RUN apt-get update && \
    apt-get upgrade --assume-yes
    # Install the GAME_NAME server
    mkdir -p $INSTALL_LOC && \
    steamcmd \
        +login anonymous \
        +force_install_dir $INSTALL_LOC \
        +app_update $APPID validate \
        +quit && \
    # SETUP: you will probably want to symlink the game's default config directory
    # SETUP: to $CONFIG_LOC here
    # Setup directory structure and permissions
    groupadd -g $GID GAME_NAME && \
    useradd -m -s /bin/false -u $UID -g $GID GAME_NAME && \
    mkdir -p $CONFIG_LOC $INSTALL_LOC && \
    chown -R GAME_NAME:GAME_NAME $INSTALL_LOC $CONFIG_LOC

# I/O
VOLUME $CONFIG_LOC
# SETUP: Add any ports you might need. Don't forget to append with /udp if necessary

# Expose and run
USER GAME_NAME
WORKDIR $INSTALL_LOC
# SETUP: Add an entrypoint for the game
