FROM ubuntu:18.04
MAINTAINER Maxim Romanenko<shirshakovm@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
#Install system packages
RUN apt-get -qq update \
        && apt-get -qq -y install \
        libpng-dev \
        libudunits2-dev \
        libgdal-dev \
        libgeos-dev \
        libproj-dev \
        libgdal-java \
        build-essential \
        openjdk-11-jre-headless \
        make \
        wget \
        curl \
        unzip
#Install ERDAS ECW Libs
WORKDIR /hexagon
COPY ECW .
WORKDIR /usr/local/hexagon
RUN cp -r /hexagon/* /usr/local/hexagon
RUN rm -r /usr/local/hexagon/lib/x64
RUN mv /usr/local/hexagon/lib/newabi/x64 /usr/local/hexagon/lib/x64
RUN cp /usr/local/hexagon/lib/x64/release/libNCSEcw* /usr/local/lib
RUN ldconfig /usr/local/hexagon

#Install GDAL 2.3.1 from binary
ENV GDAL_VERSION=2.3.1
WORKDIR /tmp
RUN wget http://download.osgeo.org/gdal/$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz  
RUN tar -xvzf gdal-$GDAL_VERSION.tar.gz
WORKDIR /tmp/gdal-$GDAL_VERSION
RUN ./configure --with-ecw=/usr/local/hexagon
RUN make clean
RUN make -j$(nproc) --silent
RUN make install
RUN ldconfig /usr/local/hexagon
RUN rm -rf /hexagon 

#Clean
WORKDIR /tmp/gdal-$GDAL_VERSION
RUN make clean

WORKDIR /opt/geoserver

# Geoserver Environmet variables
ENV GEOSERVER_HOME /opt/geoserver
ENV GDAL_DATA /usr/local/share/gdal/
ENV LD_LIBRARY_PATH /usr/local/share/gdal

##
## PLUGINS INSTALLATION if need
##
ENV GEOSERVER_VERSION=2.20.4 
ENV GEOSERVER_URL http://sourceforge.net/projects/geoserver/files/GeoServer/$GEOSERVER_VERSION
#
# Get GeoServer from source
RUN wget -c $GEOSERVER_URL/geoserver-$GEOSERVER_VERSION-bin.zip -O ~/geoserver.zip && \
    unzip ~/geoserver.zip -d /opt/geoserver && \
    rm ~/geoserver.zip

ENV PLUGIN=gdal
RUN wget -c https://build.geoserver.org/geoserver/2.20.x/ext-latest/geoserver-2.20-SNAPSHOT-gdal-plugin.zip -O ~/geoserver-$PLUGIN-plugin.zip && \
    unzip -o ~/geoserver-$PLUGIN-plugin.zip -d /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm ~/geoserver-$PLUGIN-plugin.zip

ENV PLUGIN=vectortiles
RUN wget -c $GEOSERVER_URL/extensions/geoserver-$GEOSERVER_VERSION-$PLUGIN-plugin.zip -O ~/geoserver-$PLUGIN-plugin.zip && \
    unzip -o ~/geoserver-$PLUGIN-plugin.zip -d /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm ~/geoserver-$PLUGIN-plugin.zip

ENV PLUGIN=mbtiles-store
RUN wget -c https://build.geoserver.org/geoserver/2.20.x/community-latest/geoserver-2.20-SNAPSHOT-mbtiles-store-plugin.zip -O ~/geoserver-$PLUGIN-plugin.zip && \
    unzip -o ~/geoserver-$PLUGIN-plugin.zip -d /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm ~/geoserver-$PLUGIN-plugin.zip


ENV PLUGIN=mbtiles
RUN wget -c https://build.geoserver.org/geoserver/2.20.x/community-latest/geoserver-2.20-SNAPSHOT-mbtiles-plugin.zip -O ~/geoserver-$PLUGIN-plugin.zip && \
    unzip -o ~/geoserver-$PLUGIN-plugin.zip -d /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm ~/geoserver-$PLUGIN-plugin.zip

ENV PLUGIN=wps
RUN wget -c $GEOSERVER_URL/extensions/geoserver-$GEOSERVER_VERSION-$PLUGIN-plugin.zip -O ~/geoserver-$PLUGIN-plugin.zip && \
    unzip -o ~/geoserver-$PLUGIN-plugin.zip -d /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm ~/geoserver-$PLUGIN-plugin.zip
    
# Expose GeoServer's default port
EXPOSE 8080
WORKDIR /opt/geoserver/data_dir
CMD ["/opt/geoserver/bin/startup.sh"]
