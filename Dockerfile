FROM debian

RUN apt-get update && \
        apt-get install -y \
        gcc             \
        gdb             \
        git             \
        vim             \
        binutils        \
        strace          \
        ltrace          \
        bsdmainutils    \
        make            \
        liblzo2-dev     \
        libncurses5-dev \
        g++             \
        socat           \
        netcat          \
        unzip           \
        curl            \
        valgrind        \
        python          \
        python3         \
        wget

# Setting up Vim
RUN cd /root && \
        git clone https://github.com/tsalvia/.vim && \
        mkdir -p .vim/bundle && \
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > .vim/bundle/installer.sh && \
        sh .vim/bundle/installer.sh .vim/bundle && \
        ln -s .vim/.vimrc .vimrc && \
        /bin/bash -c 'vim -c ":silent! call dein#install() | :q"'

# Install checksec.sh
RUN cd /usr/local/bin && \
        wget http://www.trapkit.de/tools/checksec.sh && \
        sed -i 's/\r//g' checksec.sh && \
        chmod +x /usr/local/bin/checksec.sh

# Install rodata2od
RUN cd /usr/local/bin && \
        wget https://raw.githubusercontent.com/akiym/akitools/master/rodata2od && \
        chmod +x /usr/local/bin/*

# Install peda
RUN cd /usr/local/bin && \
        git clone https://github.com/longld/peda.git && \
        echo "source /usr/local/bin/peda/peda.py" > /root/.gdbinit

# Install ht
RUN cd /usr/local/bin && \
        wget http://sourceforge.net/projects/hte/files/ht-source/ht-2.1.0.tar.bz2 && \
        tar xvf ht-2.1.0.tar.bz2 && \
        cd ht-2.1.0 && \
        ./configure && \
        make && \
        make install && \
        rm ../ht-2.1.0.tar.bz2 

# Enable CoreDump and Disabled ASLR
RUN echo "ulimit -c unlimited" >> /root/.bashrc && \
        echo "echo 0 > /proc/sys/kernel/randomize_va_space" >> /root/.bashrc

WORKDIR /root
CMD ["/bin/bash"]
