FROM ubuntu:bionic
COPY script.sh /
COPY sources.list /etc/apt/sources.list
RUN apt update
RUN apt-get install mailutils -y
RUN apt-get install telnet -y
ENTRYPOINT [ "bash","script.sh" ]
CMD ["successfully exit"]