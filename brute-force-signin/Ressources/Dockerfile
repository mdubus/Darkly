FROM	kalilinux/kali-linux-docker

RUN		apt update -y && \
			apt upgrade -y && \
			apt-get install -y wordlists hydra hydra-gtk

RUN		gunzip /usr/share/wordlists/rockyou.txt.gz
