Received:  by oss.sgi.com id <S553722AbQKAWnX>;
	Wed, 1 Nov 2000 14:43:23 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:44810 "HELO convert rfc822-to-8bit
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553714AbQKAWnG>;
	Wed, 1 Nov 2000 14:43:06 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 5785A7CD4; Wed,  1 Nov 2000 22:43:04 +0000 (GMT)
Date:   Wed, 1 Nov 2000 22:43:04 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Re: GCC Compile Failed
Message-ID: <20001101224303.A28369@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.9i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

After this problem with GCC, I have compiled the kernel, binutils, batch etc...but now have had problems with glibc.

It has been compiling glibc for about 2 hours (I2, 200Mhz, 96Mb) so must have been nearly finished, and I get:

gcc -nostdlib -nostartfiles -o /mnt/hd2/lfstmp/glibc-001027/glibc-build/iconv/iconv_prog  -Wl,-dynamic-linker=/lib/ld.so.1   /mnt/hd2/lfstmp/glibc-001027/glibc-build/csu/crt1.o /mnt/hd2/lfstmp/glibc-001027/glibc-build/csu/crti.o `gcc --print-file-name=crtbegin.o` /mnt/hd2/lfstmp/glibc-001027/glibc-build/iconv/iconv_prog.o  -Wl,-rpath-link=/mnt/hd2/lfstmp/glibc-001027/glibc-build:/mnt/hd2/lfstmp/glibc-001027/glibc-build/math:/mnt/hd2/lfstmp/glibc-001027/glibc-build/elf:/mnt/hd2/lfstmp/glibc-001027/glibc-build/dlfcn:/mnt/hd2/lfstmp/glibc-001027/glibc-build/nss:/mnt/hd2/lfstmp/glibc-001027/glibc-build/nis:/mnt/hd2/lfstmp/glibc-001027/glibc-build/rt:/mnt/hd2/lfstmp/glibc-001027/glibc-build/resolv:/mnt/hd2/lfstmp/glibc-001027/glibc-build/crypt:/mnt/hd2/lfstmp/glibc-001027/glibc-build/linuxthreads /mnt/hd2/lfstmp/glibc-001027/glibc-build/libc.so.6 /mnt/hd2/lfstmp/glibc-001027/glibc-build/libc_nonshared.a -lgcc `gcc --print-file-name=crtend.o` /mnt/hd2/lfstmp/glibc-001027/glibc-build/csu/crtn.o
/mnt/hd2/lfstmp/glibc-001027/glibc-build/libc.so.6: undefined reference to `__pthread_initialize_minimal'
collect2: ld returned 1 exit status
make[2]: *** [/mnt/hd2/lfstmp/glibc-001027/glibc-build/iconv/iconv_prog] Error 1
make[2]: Leaving directory `/mnt/hd2/lfstmp/glibc-001027/iconv'
make[1]: *** [iconv/others] Error 2
make[1]: Leaving directory `/mnt/hd2/lfstmp/glibc-001027'
make: *** [all] Error 2


Any ideas?
 

Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
