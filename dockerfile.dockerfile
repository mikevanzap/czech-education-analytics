FROM eclipse-temurin:24-jre

# Install Python and system dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    wget \
    git \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install dbt + Trino adapter
RUN python3 -m venv /opt/test-venv
ENV PATH="/opt/test-venv/bin:$PATH"

RUN apt-get update && apt-get install -y gettext && rm -rf /var/lib/apt/lists/*

RUN pip install dbt-core==1.10.13 dbt-trino==1.9.3


RUN cd /opt && \
    wget https://repo1.maven.org/maven2/io/trino/trino-server/476/trino-server-476.tar.gz && \
    tar -xzf trino-server-476.tar.gz && \
    mv trino-server-476 trino && \
    rm trino-server-476.tar.gz

# Download and install Nessie
RUN cd /opt && \
    wget https://github.com/projectnessie/nessie/releases/download/nessie-0.105.7/nessie-quarkus-0.105.7-runner.jar && \
    mv nessie-quarkus-0.105.7-runner.jar nessie.jar

# Create app directory
 

 

RUN mkdir -p /opt/trino-data /opt/nessie-data /root/.dbt scripts

COPY scripts/ /scripts/

RUN chmod +x /scripts/start-all.sh

WORKDIR /app
# Copy your files
COPY dbt_project/ ./dbt-project/
COPY dbt_profile/profiles.yml /root/.dbt/
COPY trino/etc/ /opt/trino/etc/
 


# Make scripts executable
 

# Expose ports
EXPOSE 8080 19120

WORKDIR /app

# Start all services
ENTRYPOINT ["/scripts/start-all.sh"]