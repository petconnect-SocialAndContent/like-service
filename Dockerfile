FROM ruby:3.2-slim

# Variables de entorno
ENV BUNDLE_DEPLOYMENT=true \
    BUNDLE_PATH=/gems \
    APP_HOME=/app

# Instala dependencias del sistema
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    pkg-config \
    git \
    curl && \
    rm -rf /var/lib/apt/lists/*

# Define el directorio de trabajo
WORKDIR $APP_HOME

# Copia sólo los archivos necesarios para instalar gemas
COPY Gemfile Gemfile.lock ./

# Agrega plataforma Linux para que bundle no falle
RUN gem install bundler -v 2.6.7 && \
    bundle lock --add-platform x86_64-linux && \
    bundle config set without 'development test' && \
    bundle install --jobs 4 --retry 3 && \
    rm -rf /root/.bundle/cache

# Copia el resto de la aplicación
COPY . .

# Expone el puerto que uses
EXPOSE 3020

# Comando final (usa rackup si tienes config.ru o ejecuta Sinatra directamente)
CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "3020"]

