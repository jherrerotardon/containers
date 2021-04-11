FROM python:3.9-slim

LABEL mantainer='jherrero.tardon@gmail.com'

ARG user=docker
ARG uid=1000
ARG guid=1000

# Creates user.
RUN groupadd --gid $guid $user && \
	useradd --gid $uid --uid $guid $user && \
	mkdir -p /home/$user/.ssh && \
	chown -R $user:$user /home/$user

# Install dependencies.
RUN apt update && \
    apt install --no-install-recommends -y \
        git \
        g++ \
        ssh

# Install python virtual env module.
RUN pip3 install pipenv

# Clean.
RUN apt autoremove -y && \
	apt clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["python3"]

