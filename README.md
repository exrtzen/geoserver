![Geoserver.org](https://upload.wikimedia.org/wikipedia/commons/9/9e/GeoServer_logo.png)


| Name       | Version    |
|-----------|------------|
| Geoserver | 2.20.4     |
| GDAL      | 2.3.1      |
| ECW Lib   | 5.4 SDK    |
| Java      | OpenJDK 17 |


### Plugins

- WPS Extencion
- GDAL Extencion
- Vector tiles Extencion
- MBTiles Extencion

### ERDAS ECW lib

To unpack and extract the contents of the `ERDAS_ECWJP2_SDK-5.4.0.bin` file, which is likely a self-extracting binary installer (often used for proprietary libraries like ERDAS ECW SDK), you typically need to do the following:

---

### Steps to Extract `ERDAS_ECWJP2_SDK-5.4.0.bin`

1. **Make the file executable (if it isn't already):**

   ```bash
   chmod +x ERDAS_ECWJP2_SDK-5.4.0.bin
   ```

2. **Run the installer:**

   ```bash
   ./ERDAS_ECWJP2_SDK-5.4.0.bin
   ```

3. **Follow the on-screen instructions** to choose an installation directory or accept the license agreement (if prompted).

Here's an English description you can add to your repository's README or documentation:

---

### `ECW` Directory

The `ECW` directory contains the extracted contents of the `ERDAS_ECWJP2_SDK-5.4.0.bin` installer. This includes the binaries, libraries, and resources required to work with the **ERDAS ECW/JP2 SDK**.

> ⚠️ This version includes a **Desktop Read-Only Redistributable**, which allows decoding (reading) of ECW and JPEG2000 images, but **does not permit encoding (writing)**.

No modifications were made to the original files — they were unpacked as-is from the official installer.

---

## System layer

### Linux Ubuntu 18.04 LTS

### Dependencies install 
```shell
sudo apt update && sudo apt install -y \
libpng-dev \
libudunits2-dev \
libgdal-dev \
libgeos-dev \
libproj-dev \
libgdal-java \
build-essential \
openjdk-17-jre-headless \
make \
wget \
curl \
unzip
```


## Container usage

In system with installed Docker use command to download the image

`` docker pull registry.urban-its.ru/services/geoserver/geoserver:<geoserver_version> ``

To run without parameters:

`` docker run -d -p <host_port>:8080 registry.urban-its.ru/services/geoserver/geoserver:<geoserver_version> ``

If you want to use Geoserver with your local files you should use *-v* option to connect volume

``  docker run -d -p <host_port>:8080 -v <host/path/to/dir>:/opt/geoserver/data_dir registry.urban-its.ru/services/geoserver/geoserver:<geoserver_version>  ``

After running container will be available on *http://localhost:<host_port>/geoserver*


