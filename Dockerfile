FROM apache/airflow:2.5.0
RUN pip install cx_oracle
RUN pip install airflow-code-editor
RUN pip install black
RUN pip install --no-cache-dir apache-airflow-providers-oracle
RUN pip install selenium
#RUN apt-get install -y chromium-driver
#RUN chromium-driver
USER root
RUN apt-get update
RUN apt-get install libaio-dev -y \
    libaio1 \
    libaio-dev \
    build-essential \
    unzip \
    curl
RUN mkdir -p opt/oracle
COPY instantclient-basic-linux.x64-19.19.0.0.0dbru.zip /tmp
COPY instantclient-sdk-linux.x64-19.19.0.0.0dbru.zip /tmp
RUN unzip /tmp/instantclient-basic-linux.x64-19.19.0.0.0dbru.zip -d /opt/oracle
RUN unzip /tmp/instantclient-sdk-linux.x64-19.19.0.0.0dbru.zip -d /opt/oracle
RUN mv /opt/oracle/instantclient_19_19 /opt/oracle/instantclient
RUN ln -s /opt/oracle/instantclient/libclntsh.so.11.1 /opt/oracle/instantclient/libclntsh.so || echo "yuppi"
RUN ln -s /opt/oracle/instantclient/libocci.so.11.1 /opt/oracle/instantclient/libocci.so || echo "yuppi"
RUN rm -rf /tmp/instantclient*
USER airflow
ENV ORACLE_HOME="/opt/oracle/instantclient"
ENV OCI_HOME="/opt/oracle/instantclient"
ENV OCI_LIB_DIR="/opt/oracle/instantclient"
ENV OCI_INCLUDE_DIR="/opt/oracle/instantclient/sdk/include"
ENV LD_LIBRARY_PATH="/opt/oracle/instantclient:$ORACLE_HOME"
USER root
RUN echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && ldconfig
#RUN apt-get install -y chromium-driver