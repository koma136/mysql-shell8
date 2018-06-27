FROM oraclelinux:7-slim

ARG MYSQL_SERVER_PACKAGE_URL=$REPO/yum/mysql-8.0-community/docker/x86_64/mysql-community-server-minimal-8.0.11-1.el7.x86_64.rpm
ARG PACKAGE_URL_SHELL=https://repo.mysql.com/yum/mysql-tools-community/el/7/x86_64/mysql-shell-8.0.11-1.el7.x86_64.rpm

# Install server
RUN rpmkeys --import https://repo.mysql.com/RPM-GPG-KEY-mysql \
  && yum install -y $MYSQL_SERVER_PACKAGE_URL $PACKAGE_URL_SHELL libpwquality \
  && yum clean all \
  && mkdir /docker-entrypoint-initdb.d

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqlsh"]