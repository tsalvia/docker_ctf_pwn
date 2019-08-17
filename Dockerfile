FROM ubuntu:14.04

RUN apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y \
        software-properties-common \
        gcc             \
        gdb             \
        git             \
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
        python3-pip     \
        lib32z1         \
        libc6-dev-i386  \
        screen          \
        unzip           \
        bzip2           \
        python-dev      \
        libffi-dev      \
        pandoc          \
        libssl-dev      \
        wget            \
        libreadline-dev

# Setting up Vim
RUN add-apt-repository ppa:jonathonf/vim -y && \
        apt-get update && \
        apt-get install vim -y && \
        cd /root && \
        git clone https://github.com/tsalvia/.vim && \
        mkdir -p .vim/bundle && \
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > .vim/bundle/installer.sh && \
        sh .vim/bundle/installer.sh .vim/bundle && \
        ln -s .vim/.vimrc .vimrc && \
        /bin/bash -c 'vim -c ":silent! call dein#install() | :q"'

# Setting up GNU Screen
RUN cd /root && \
        wget https://raw.githubusercontent.com/tsalvia/screenrc/master/.screenrc

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

# Install radare2
RUN cd /usr/local/bin && \
        git clone https://github.com/radare/radare2.git && \
        cd radare2/sys/ && \ 
        ./install.sh

# Install pip2
RUN wget https://bootstrap.pypa.io/get-pip.py -P /tmp && \
        python2 /tmp/get-pip.py

# Install pwntools
RUN pip install pwntools

# Install angr
RUN pip install angr

# Install ruby
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv && \
        git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build && \
        /root/.rbenv/bin/rbenv install 2.6.3 && \
        /root/.rbenv/bin/rbenv global 2.6.3

# Install david942j/one_gadget
RUN /root/.rbenv/versions/2.6.3/bin/gem install one_gadget

# Enable CoreDump and Disabled ASLR
# Default Shell => /bin/bash
# ls color
# ruby
RUN echo "ulimit -c unlimited" > /root/.bashrc && \
        echo "echo 0 > /proc/sys/kernel/randomize_va_space" >> /root/.bashrc && \
        echo "export LS_OPTIONS='--color=auto'" >> /root/.bashrc && \
        echo "export LS_COLORS=':'" >> /root/.bashrc && \
        echo "alias ls='ls --color'" >> /root/.bashrc && \
        echo "export SHELL=/bin/bash" >> /root/.bashrc && \
        echo 'export PATH="/root/.rbenv/bin:$PATH"' >> /root/.bashrc && \
        echo 'eval "$(rbenv init -)"' >> /root/.bashrc

WORKDIR /root
CMD ["/bin/bash"]
