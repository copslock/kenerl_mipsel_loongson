Received:  by oss.sgi.com id <S553795AbRCLPkK>;
	Mon, 12 Mar 2001 07:40:10 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:57095 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553733AbRCLPj6>;
	Mon, 12 Mar 2001 07:39:58 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 249C07F6; Mon, 12 Mar 2001 16:39:47 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 317C2EFD0; Mon, 12 Mar 2001 16:39:38 +0100 (CET)
Date:   Mon, 12 Mar 2001 16:39:38 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Cc:     Andreas Jaeger <aj@suse.de>
Subject: glibc 2.2.2 on linux mips kernel 2.2 NOGO
Message-ID: <20010312163938.E7715@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I tried building glibc 2.2.2 on Linux-mips (Kernel 2.2.16) with no success.
I was using Keiths cross stuff to determin the way it worked for him.

I am getting the following output.

./configure --prefix=/usr --with-headers=/usr/src/linux/include/
   --enable-kernel=2.2.15 --enable-add-ons --with-elf --disable-profile

Results in:

../elf/ld.so.1 --library-path ..:../math:../elf:../dlfcn:../nss:../nis:../rt:../resolv:../crypt:../linuxthreads ./rpcgen -Y `gcc -print-file-name=cpp | sed 's|/cpp$||'` -c rpcsvc/bootparam_prot.x -o xbootparam_prot.T
make[1]: *** [xbootparam_prot.stmp] Segmentation fault

The same happens when i remove the "--enable-kernel=2.2.15" completely. In
case i am using an "--enable-kernel=2.3.99" i am getting

TOO OLD KERNEL

I was using

flo@repeat:~/glibc-2.2.2$ gcc -v
Reading specs from /home/flo/gcc-3.0/lib/gcc-lib/mipsel-unknown-linux-gnu/3.0/specs
Configured with: ./configure --prefix=/home/flo/gcc-3.0 --with-newlib --disable-shared --enable-languages=c
gcc version 3.0 20010303 (prerelease)
flo@repeat:~/glibc-2.2.2$ ld -v
GNU ld version 2.11.90 (with BFD 2.11.90)
flo@repeat:~/glibc-2.2.2$ head /usr/src/linux/include/linux/version.h 
#define UTS_RELEASE "2.4.2"
#define LINUX_VERSION_CODE 132098
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
flo@repeat:~/glibc-2.2.2$ uname -a
Linux repeat.rfc822.org 2.2.16 #42 Fri Dec 29 11:46:41 CET 2000 mips unknown

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
