# Essential
FROM ubuntu:20.04
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -yq apt-utils dialog
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -yq build-essential software-properties-common
RUN apt-get update

# # acados dependencies
# RUN apt-get install -yq git cmake make
# RUN apt-get install -yq bc libblas-dev liblapack-dev

# Dependencies
RUN apt install -yq curl chromium-browser
RUN apt-get update && apt-get install -yq libkf5archive5 libqt5xml5
RUN apt install -yq qml-module-qtquick-controls \
                    qml-module-qtquick-dialogs \
                    qml-module-qtquick-controls2 \
                    qml-module-qt-labs-platform \
                    qtquickcontrols2-5-dev \
                    libqt5websockets5 \
                    libqt5concurrent5

# Installation
RUN curl -L https://drive.google.com/uc?id=1x_KhRp0_qufjnOO-pyDM1MAhRjeQeJTK --output reMarkable.deb
RUN dpkg -i reMarkable.deb
ENV QT_QPA_PLATFORMTHEME=gtk3
CMD ["bash"]
