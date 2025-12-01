FROM apache/nifi:1.28.1

COPY jdbc_drivers/postgresql-42.7.8.jar /opt/nifi/nifi-current/lib/
