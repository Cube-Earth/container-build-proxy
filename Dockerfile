FROM alpine:latest

RUN apk add --update curl ca-certificates sudo supervisor && \
	addgroup sudo && \
	echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
	
RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache
    
# RUN cd /usr/bin \
#   && ln -sf easy_install-3.4 easy_install \
#   && ln -sf idle3.4 idle \
#   && ln -sf pydoc3.4 pydoc \
#   && ln -sf python3.4 python \
#   && ln -sf python-config3.4 python-config \
#   && ln -sf pip3.4 pip
  
	
RUN mkdir /opt /cache && \
	apk add --no-cache git && \
	git clone https://github.com/mkorenkov/http-replicator /opt/http-replicator && \
	adduser -D -g '' -G sudo -s /sbin/nologin replicator

COPY supervisord.conf /etc/

VOLUME ["/cache"]

EXPOSE 8889

ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]
