FROM dart:stable

RUN apt-get update && apt-get install -y \
    nano \
    git \
    curl \
    unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# RUN ...any other commands you want to run in the container

# Set the working directory (do not copy as mounted code will be used)
WORKDIR /workspace

# Default execution command (use tail to prevent the container from exiting)
CMD [ "tail", "-f", "/dev/null" ]
