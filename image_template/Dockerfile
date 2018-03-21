FROM ubuntu:latest

COPY user-mapping.sh /
RUN  chmod u+x /user-mapping.sh

ENTRYPOINT ["/user-mapping.sh"]

# docker build -t uiduntu . 
# docker run --name uiduntu_myuser --rm -ti -e HOST_USER_ID=myuser -e HOST_USER_ID=22222 -e HOST_USER_GID=22222 uiduntu
