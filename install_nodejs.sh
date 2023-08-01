#!/bin/bash

NODE_VERSION="v20.3.1"
NODE_DIST="https://nodejs.org/dist/latest-${NODE_VERSION%%.*}.x/node-${NODE_VERSION}-linux-x64.tar.gz"

cd ~

echo "Realizando limpieza de una posible instalación anterior..."
rm -rf ~/nodejs
rm -rf ~/.npm
rm -f ~/bin/node
rm -f ~/bin/npm

echo "Descargando Node.js versión $NODE_VERSION..."
wget $NODE_DIST

tar xvfz "node-${NODE_VERSION}-linux-x64.tar.gz"

mv "node-${NODE_VERSION}-linux-x64" nodejs

mkdir -p ~/bin

cp nodejs/bin/node ~/bin

cd ~/bin
ln -s ../nodejs/lib/node_modules/npm/bin/npm-cli.js npm

sed -i '/PATH=\$PATH:\$HOME\/bin/d' ~/.bashrc
sed -i '/export PATH/d' ~/.bashrc
echo 'PATH=$PATH:$HOME/bin' >> ~/.bashrc
echo 'export PATH' >> ~/.bashrc

PATH=$PATH:$HOME/bin
export PATH

echo "Node.js versión $NODE_VERSION instalado con éxito!"
node -v
npm -v

echo "Listo!"