# Use the latest Debian image as the base
FROM debian:latest

# Install essential tools and GoTTY
RUN apt-get update && \
    apt-get install -y \
    curl \
    sudo \
    bash \
    nano \
    vim \
    build-essential \
    wget \
    git \
    python3 \
    python3-pip \
    net-tools \
    iputils-ping \
    && apt-get clean

# Download and install GoTTY
RUN wget https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz && \
    tar -xvzf gotty_linux_amd64.tar.gz && \
    mv gotty /usr/local/bin/ && \
    rm gotty_linux_amd64.tar.gz

# Add a new user with sudo privileges
RUN useradd -ms /bin/bash debianuser && \
    echo "debianuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the new user
USER debianuser
WORKDIR /home/debianuser

# Expose the port for the web terminal
EXPOSE 8080

# Start GoTTY in the container to provide a web-based terminal interface
CMD ["gotty", "--permit-write", "--reconnect", "/bin/bash"]
