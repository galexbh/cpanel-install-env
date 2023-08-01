#!/bin/bash
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

GO_LATEST=$(curl https://go.dev/VERSION?m=text)

rm -rf ~/go 

cd ~
echo "Descargando versión $GO_LATEST..."
wget "https://go.dev/dl/$GO_LATEST.linux-amd64.tar.gz" -O $GO_LATEST.linux-amd64.tar.gz

tar xvfz $GO_LATEST.linux-amd64.tar.gz
rm -f $GO_LATEST.linux-amd64.tar.gz

echo "Creando entorno..."
mkdir -p ~/bin 2>/dev/null 
cd ~/bin

rm -f go
ln -s ~/go/bin/go go

echo "Escribiendo variables..."
sed -i '/:~\/bin:~\/go\/bin/d' ~/.bashrc
echo 'PATH=$PATH:~/bin:~/go/bin' >> ~/.bashrc
source ~/.bashrc 

sed -i '/^alias go=/d' ~/.bashrc
echo 'alias go="export TMPDIR=~/tmp/; export GOMAXPROCS=1; go"' >> ~/.bashrc
source ~/.bashrc

echo -n "go version: "
go version

rm -f $CWD/install_golang.sh

echo "Listo!"