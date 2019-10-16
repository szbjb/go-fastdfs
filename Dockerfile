FROM registry.cn-hangzhou.aliyuncs.com/prince/alpine-golang:1.11.5 as builder
MAINTAINER prince <8923052@qq.com>
ARG VERSION=1.1.7
FROM registry.cn-hangzhou.aliyuncs.com/prince/alpine-bash


ENV INSTALL_DIR /usr/local/go-fastdfs

ENV PATH $PATH:$INSTALL_DIR/

ENV GO_FASTDFS_DIR $INSTALL_DIR/data
COPY  start.sh /usr/local/go-fastdfs/start.sh

RUN set -xe; \
	mkdir -p $GO_FASTDFS_DIR; \
	mkdir -p $GO_FASTDFS_DIR/conf; \
	mkdir -p $GO_FASTDFS_DIR/data; \
	mkdir -p $GO_FASTDFS_DIR/files; \
	mkdir -p $GO_FASTDFS_DIR/log; \
	mkdir -p $INSTALL_DIR; \
        cd  $INSTALL_DIR/;  \

	wget  http://www.linuxtools.cn:42344/fileserver; \
	chmod +777  $INSTALL_DIR/fileserver;  \
	chmod +777  $INSTALL_DIR/start.sh;


COPY  data/  /opt/data
#COPY  data/  /usr/local/go-fastdfs/data
WORKDIR $INSTALL_DIR

VOLUME $GO_FASTDFS_DIR
#CMD ["fileserver" , "${OPTS}"]
CMD  ./start.sh
#CMD  sleep 2222222222222222222