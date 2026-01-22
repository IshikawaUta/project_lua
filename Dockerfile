FROM debian:bookworm-slim

# Install dependency sistem
RUN apt-get update && apt-get install -y \
    lua5.4 \
    luarocks \
    build-essential \
    zlib1g-dev \
    liblua5.4-dev \
    && rm -rf /var/lib/apt/lists/*

# Konfigurasi Luarocks agar menggunakan Lua 5.4 secara default
RUN luarocks config lua_version 5.4

# Install Pegasus Engine via Luarocks
RUN luarocks install pegasus

# Set direktori kerja
WORKDIR /app

# Copy file project ke dalam container
COPY app.lua .

# Ekspos port yang digunakan aplikasi (9090 sesuai app.lua)
EXPOSE 9090

# Jalankan aplikasi
CMD ["lua5.4", "app.lua"]