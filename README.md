```
docker build --network=host -t conti_syzkaller:latest .
```

```
docker run -dit --name conti_syzkaller \
  --privileged --device /dev/kvm \
  --cap-add SYS_ADMIN --security-opt seccomp=unconfined \
  -p 56730:56730 \
  conti_syzkaller:latest
```

```
docker exec -it conti_syzkaller bash -lc '
  set -e
  mkdir -p /image && cd /image
  wget -q https://raw.githubusercontent.com/google/syzkaller/master/tools/create-image.sh -O create-image.sh
  chmod +x create-image.sh
  ./create-image.sh
  chmod 600 /image/bullseye.id_rsa
  echo "[OK] image ready at /image"
'
```

```
docker exec -it conti_syzkaller bash
```

```
/syzkaller/gopath/src/github.com/google/syzkaller/bin/syz-manager -config=/my.cfg
```