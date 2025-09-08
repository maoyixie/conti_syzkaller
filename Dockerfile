FROM gcr.io/syzkaller/env:latest

# syzkaller
RUN git clone --depth=1 https://github.com/google/syzkaller.git /syzkaller/gopath/src/github.com/google/syzkaller && \
    cd /syzkaller/gopath/src/github.com/google/syzkaller && \
    make -j"$(nproc)" && \
    mkdir workdir

# kernel
RUN git clone --branch v6.2 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git && \
    cd linux && \
    make defconfig && \
    make kvm_guest.config && \

COPY .config /linux/.config

RUN cd linux && \
    make olddefconfig && \
    make -j`nproc` && \
    ls vmlinux && \
    ls /linux/arch/x86/boot/bzImage

# # image(move to docker run)
# RUN mkdir image && \
#     cd image && \
#     wget https://raw.githubusercontent.com/google/syzkaller/master/tools/create-image.sh -O create-image.sh && \
#     chmod +x create-image.sh && \
#     ./create-image.sh

RUN apt install -y qemu-system-x86

COPY my.cfg /my.cfg
