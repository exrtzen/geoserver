<img src="https://upload.wikimedia.org/wikipedia/commons/9/9e/GeoServer_logo.png" alt="Geoserver.org" width="300"/>

---

# 🌍 GeoServer with ECW 5.4 SDK Support

| Component     | Version    |
| ------------- | ---------- |
| **GeoServer** | 2.20.4     |
| **GDAL**      | 2.3.1      |
| **ECW SDK**   | 5.4        |
| **Java**      | OpenJDK 17 |

### 🔌 Installed Plugins

* WPS
* GDAL
* Vector Tiles
* MBTiles

---

## 🧱 System Layer

**Operating System:** Ubuntu 18.04 LTS (or compatible)

### 📦 Required System Dependencies

Ensure the following packages are installed on your system:

* `libpng-dev`
* `libudunits2-dev`
* `libgdal-dev`
* `libgeos-dev`
* `libproj-dev`
* `libgdal-java`
* `build-essential`
* `openjdk-17-jre-headless`
* `make`
* `wget`
* `curl`
* `unzip`

---

## 🧩 Installing the ERDAS ECW SDK

Follow the steps below to install the ECW/JP2 SDK into the existing `ECW` directory in your project.

### 1. 🔽 Download the Installer

Get the installer from one of the following sources:

* 🌐 [Official Hexagon Website](https://www.hexagongeospatial.com/)
* ☁️ [Google Drive Mirror](https://drive.google.com/file/d/1-lbjlrV4wspphkufGGzZoXiitIC4m_Bc/view?usp=share_link)

> The file should be named something like: `ERDAS_ECWJP2_SDK-5.4.0.bin`

---

### 2. 📁 Move the Installer into the `ECW` Directory

```bash
mv ERDAS_ECWJP2_SDK-5.4.0.bin ECW/
```

---

### 3. 🔽 Navigate into the `ECW` Directory

```bash
cd ECW
```

---

### 4. ✅ Make the Installer Executable

```bash
chmod +x ERDAS_ECWJP2_SDK-5.4.0.bin
```

---

### 5. ▶ Run the Installer

```bash
./ERDAS_ECWJP2_SDK-5.4.0.bin
```

During installation:

* Select the **Desktop Read-Only License** (usually **option 1**)
* Accept the license agreement by typing `yes`

---

### 📁 Installation Result

After the installer completes, the `ECW` directory will contain all necessary binaries, headers, and libraries required to build and run ECW/JP2-enabled applications.

---

## 🐳 Running GeoServer via Docker

### 📥 Pull the Image

```bash
docker pull ghcr.io/exrtzen/geoserver:2.20.4-ecw5.4
```

---

### 🚀 Run the Container

#### Basic Run:

```bash
docker run -d -p <host_port>:8080 ghcr.io/exrtzen/geoserver:2.20.4-ecw5.4
```

#### With Mounted Data Directory:

```bash
docker run -d -p <host_port>:8080 \
  -v <host/path/to/dir>:/opt/geoserver/data_dir \
  ghcr.io/exrtzen/geoserver:2.20.4-ecw5.4
```

Once the container is up, GeoServer will be accessible at:
📍 `http://localhost:<host_port>/geoserver`

