FROM oraclelinux:7-slim

ARG PACKAGE_URL_SHELL=https://repo.mysql.com/yum/mysql-tools-community/el/7/x86_64/mysql-shell-8.0.11-1.el7.x86_64.rpm

# Install server
RUN rpmkeys --import https://repo.mysql.com/RPM-GPG-KEY-mysql \
  && yum install -y $PACKAGE_URL_SHELL libpwquality \
  && yum clean all \
  && mkdir /docker-entrypoint-initdb.d

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqlsh"]