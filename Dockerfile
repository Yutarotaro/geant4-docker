FROM ubuntu:20.04

RUN apt-get update && apt-get install -y tzdata

ARG HOME="/root"
# timezone setting
ENV TZ=Asia/Tokyo 

RUN apt-get update && apt-get install -y vim wget git dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev gfortran libssl-dev libpcre3-dev \
 		 xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
         libmysqlclient-dev libfftw3-dev libcfitsio-dev \
         graphviz-dev libavahi-compat-libdnssd-dev \
         libldap2-dev python-dev libxml2-dev libkrb5-dev libgsl0-dev

RUN wget http://cern.ch/geant4-data/releases/geant4.10.03.p01.tar.gz -O $HOME/geant4.10.03.p01.tar.gz

WORKDIR $HOME
RUN tar xvf geant4.10.03.p01.tar.gz

RUN  apt-get install -y qt4*
RUN  apt-get install -y qt5-default
RUN  apt-get install -y libxss-dev libxxf86vm-dev libxkbfile-dev libxv-dev libxmu-dev

RUN mkdir geant4-build
WORKDIR $HOME/geant4-build
RUN cmake -DGEANT4_INSTALL_DATA=ON -DCMAKE_INSTALL_PREFIX=$HOME/geant4-install/  -DGEANT4_USE_OPENGL_X11=ON -DGEANT4_USE_RAYTRACER_X11=ON -DGEANT4_USE_QT=ON GEANT4_BUILD_MULTITHREADED=ON $HOME/geant4.10.03.p01
RUN make -j8 
RUN make install -j8

WORKDIR $HOME/geant4-install/share/Geant4-10.3.1
