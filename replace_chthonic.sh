# Replace the dummy package name with the desired package name.
if [ ! -z "$1" ]
then
    mv chthonic $1
    sed -i s/chthonic/$1/g Vagrantfile setup.py
else
    echo 'Usage: sh replace_chthonic.sh <your-package-name>'
fi
