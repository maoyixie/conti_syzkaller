docker build -t conti_syzkaller:latest .

docker run -dit --name conti_syzkaller \
  --privileged --device /dev/kvm \
  --cap-add SYS_ADMIN --security-opt seccomp=unconfined \
  -p 56730:56730 \
  conti_syzkaller:latest bash -lc '
    set -e
    mkdir -p /image && cd /image
    wget https://raw.githubusercontent.com/google/syzkaller/master/tools/create-image.sh -O create-image.sh
    chmod +x create-image.sh
    ./create-image.sh
    ls -lh /image/bullseye.img /image/bullseye.id_rsa
    chmod 600 /image/bullseye.id_rsa
  '

