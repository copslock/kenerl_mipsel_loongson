Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2006 08:19:34 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:64195 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133423AbWFSHTY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Jun 2006 08:19:24 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 4524FBFE3;
	Mon, 19 Jun 2006 09:19:14 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 6584F1BC08D;
	Mon, 19 Jun 2006 09:19:14 +0200 (CEST)
Received: from picohp (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id E53991A18AF;
	Mon, 19 Jun 2006 09:19:13 +0200 (CEST)
Subject: Re: gcc-4.1.0 cross-compile for MIPS
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	kernel coder <lhrkernelcoder@gmail.com>
Cc:	James E Wilson <wilson@specifix.com>, linux-mips@linux-mips.org
In-Reply-To: <f69849430606182340t72ed5a68l95a724ea933faf12@mail.gmail.com>
References: <f69849430606160522i12050d00n9a4a39810f13b8a0@mail.gmail.com>
	 <1150497195.17820.4.camel@aretha.corp.specifix.com>
	 <f69849430606182340t72ed5a68l95a724ea933faf12@mail.gmail.com>
Content-Type: text/plain
Date:	Mon, 19 Jun 2006 09:19:13 +0200
Message-Id: <1150701553.7203.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi,

See this thread:
http://sourceware.org/ml/crossgcc/2005-07/msg00030.html

BR,,
Matej


> yes you were right.When i did
> make all-gcc
> 
> It just compiled smoothly.
> 
> Now to compile glibc-2.3.6 ,I issued following sequence of commands
> 
> ../glibc-2.3.6/configure --host=mipsel-linux --prefix="/usr"
> --enable-add-ons --with-headers=/home/shahzad/install/mipsel/include
> 
>  make cross-compiling=yes
> install_root=/home/shahzad/install/mipsel/include  prefix=""
> install-headers
> 
> But following error was generated
> 
> make[1]: Entering directory `/home/shahzad/glibc-2.3.6' { echo
> '#include "posix/bits/posix1_lim.h"';            \   echo '#define
> _LIBC 1';                                       \   echo '#include
> "misc/sys/uio.h"'; } |                 \ gcc -mabi=32 -E -dM -MD -MP
> -MF /home/shahzad/build-glibc-headers/bits/stdio_lim.dT -MT
> '/home/shahzad/build-glibc-headers/bits/stdio_lim.h
> /home/shahzad/build-glibc-headers/bits/stdio_lim.d'      \
>       -Iinclude -I. -I/home/shahzad/build-glibc-headers  -Ilibio
> -Inptl -I/home/shahzad/build-glibc-headers -Isysdeps/mips/elf
> -Inptl/sysdeps/unix/sysv/linux -Inptl/sysdeps/pthread
> -Isysdeps/pthread -Inptl/sysdeps/unix/sysv -Inptl/sysdeps/unix
> -Isysdeps/unix/sysv/linux/mips/mips32 -Isysdeps/unix/sysv/linux/mips
> -Isysdeps/unix/sysv/linux -Isysdeps/gnu -Isysdeps/unix/common
> -Isysdeps/unix/mman -Isysdeps/unix/inet -Isysdeps/unix/sysv
> -Isysdeps/unix/mips/mips32 -Isysdeps/unix/mips -Isysdeps/unix
> -Isysdeps/posix -Isysdeps/mips/mips32 -Isysdeps/mips
> -Isysdeps/ieee754/flt-32 -Isysdeps/ieee754/dbl-64
> -Isysdeps/wordsize-32 -Isysdeps/mips/fpu -Isysdeps/ieee754
> -Isysdeps/generic/elf -Isysdeps/generic -nostdinc -isystem
> /usr/lib/gcc/i386-redhat-linux/4.1.0/include -isystem
> /home/shahzad/install/mipsel/include -xc - -o
> /home/shahzad/build-glibc-headers/bits/stdio_lim.hT
> cc1: error: unrecognized command line option "-mabi=32"
> 
> 
> 
> I did some search on google,but on most of links "-mabi=32" option was
> being used with cross-compiler for mips.
> Would you please tell me what is causing the problem.
> 
> 
> 
> 
> On 6/17/06, James E Wilson <wilson@specifix.com> wrote:
> > On Fri, 2006-06-16 at 05:22, kernel coder wrote:
> > > /home/shahzad/install//mipsel/sys-include -DHAVE_CONFIG_H -I.
> > > -I../../../gcc-4.1.0/libssp -I. -Wall -O2 -g -O2 -MT ssp.lo -MD -MP
> > > -MF .deps/ssp.Tpo -c ../../../gcc-4.1.0/libssp/ssp.c -o ssp.o
> > > ../../../gcc-4.1.0/libssp/ssp.c:46:20: error: fcntl.h: No such file or directory
> >
> > You can't build target libraries like libssp in a --without-headers
> > build.  It was luck that this happened to work with earlier gcc
> > releases, because previously we didn't have C language target libraries
> > in gcc.  The solution is to do
> >   make all-gcc
> >   make install-gcc
> > instead of just
> >   make all
> >   make install
> >
> > Please see Dan Kegel's crosstools package, which already knows how to do
> > this.
> > --
> > Jim Wilson, GNU Tools Support, http://www.specifix.com
> >
> >
> 
