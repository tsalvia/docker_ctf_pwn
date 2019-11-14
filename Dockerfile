FROM ubuntu:14.04
MAINTAINER tsalvia <tsaliva.ctf@gmail.com>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  \
        software-properties-common \
        vim             \
        curl            \
        wget            \
        netcat          \
        socat           \
        unzip           \
        bzip2           \
        strace          \
        ltrace          \
        binutils        \
        bsdmainutils    \
        valgrind        \
        qemu-user-static\
        git             \
        make            \
        gcc             \
        g++             \
        bison           \
        flex            \
        pkg-config      \
        liblzo2-dev     \
        lib32z1         \
        libc6-dev-i386  \
        libffi-dev      \
        libssl-dev      \
        libreadline-dev \
        zlib1g-dev      \
        libncurses5-dev

# gcc-9, g++-9
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gcc-9-multilib g++-9-multilib && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 30 && \
    update-alternatives --install /usr/bin/cc cc /usr/bin/gcc-9 30 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 30 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-9 30

# CMake
RUN wget -O - https://github.com/Kitware/CMake/releases/download/v3.15.3/cmake-3.15.3.tar.gz | tar xvzf - -C /opt && \
    cd /opt/cmake-3.15.3 && \
    ./configure && \
    make && \
    make install && \
    make clean

# gdb, gdb-peda
RUN apt-get install -y gdb && \
    git clone https://github.com/longld/peda.git /opt/peda && \
    echo "source /opt/peda/peda.py" > /root/.gdbinit

# Python3.5, pip, pwntools, angr
RUN apt-get install -y python3.5 python3.5-dev && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.5 30 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 30 && \
    curl -kL https://bootstrap.pypa.io/get-pip.py | python && \
    pip3 install --upgrade git+https://github.com/arthaud/python3-pwntools.git && \
    pip3 install --upgrade angr

# Ruby2.6.3, one_gadget
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv && \
    git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build && \
    /root/.rbenv/bin/rbenv install 2.6.3 && \
    /root/.rbenv/bin/rbenv global 2.6.3 && \
    echo 'export PATH="/root/.rbenv/bin:$PATH"' >> /root/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> /root/.bashrc && \
    /root/.rbenv/versions/2.6.3/bin/gem install one_gadget

# radare2
RUN git clone https://github.com/radare/radare2.git /opt/radare2 && \
    /opt/radare2/sys/install.sh && \
    r2pm init && \
    r2pm -i r2ghidra-dec

# akitools
RUN git clone https://github.com/akiym/akitools /opt/akitools && \
    echo 'export PATH="/opt/akitools:$PATH"' >> /root/.bashrc

# HT Editor
RUN apt-get install -y g++ && \
    wget -O - http://sourceforge.net/projects/hte/files/ht-source/ht-2.1.0.tar.bz2 | tar xvfj - -C /opt && \
    cd /opt/ht-2.1.0/ && \
    ./configure CXX=g++-4.8 && \
    make && \
    make install && \
    make clean

# libc-database
RUN git clone https://github.com/niklasb/libc-database.git /opt/libc-database

# Enable coredump, Disabled ASLR
RUN echo "ulimit -c unlimited" >> /root/.bashrc && \
    echo "echo 0 > /proc/sys/kernel/randomize_va_space" >> /root/.bashrc

WORKDIR /root/workdir
CMD ["/bin/bash"]
