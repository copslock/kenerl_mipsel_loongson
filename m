Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 05:25:54 +0100 (BST)
Received: from crack.them.org ([IPv6:::ffff:146.82.138.56]:23530 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225278AbTEJEZw>;
	Sat, 10 May 2003 05:25:52 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 19ELvu-0005Ev-00; Fri, 09 May 2003 23:26:02 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 19ELvT-0000bz-00; Sat, 10 May 2003 00:25:35 -0400
Date: Sat, 10 May 2003 00:25:35 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: menkuec@auto-intern.com
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: compiling glibc
Message-ID: <20030510042535.GA2336@nevyn.them.org>
References: <200305092145.43690.benmen@gmx.de> <20030509214501.GA18697@rembrandt.csv.ica.uni-stuttgart.de> <200305100303.48870.benmen@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200305100303.48870.benmen@gmx.de>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sat, May 10, 2003 at 03:03:48AM +0200, Benjamin Menküc wrote:
> When I add the include stuff I still get this error:
> 
> [benmen@linuxpc1 mipsel-glibc] LD_LIBRARY_PATH="" CFLAGS="-O2 -g 
> -finline-limit=10000" ../glibc-2.3.2/configure --build=i686-linux 
> --host=mipsel-linux --enable-add-ons --prefix=/home/benmen/mipsel 
> --with-headers=/home/benmen/mips/kernel/mips-2.4.20/include

You didn't set CC and AS.  It's using the native compiler, not the
cross.

> 
> ....
> 
> [benmen@linuxpc1 mipsel-glibc] make
> 
> ...
> 
> make[2]: Leaving directory `/home/benmen/mips/glibc-2.3.2/csu'
> make[2]: Entering directory `/home/benmen/mips/glibc-2.3.2/csu'
> gcc ../sysdeps/unix/sysv/linux/init-first.c -c -std=gnu99 -O2 -Wall -Winline 
> -Wstrict-prototypes -Wwrite-strings -finline-limit=10000 -g      -I../include 
> -I. -I/home/benmen/mips/mipsel-glibc/csu -I.. -I../libio  
> -I/home/benmen/mips/mipsel-glibc -I../sysdeps/mips/elf 
> -I../linuxthreads/sysdeps/unix/sysv/linux/mips 
> -I../linuxthreads/sysdeps/unix/sysv/linux -I../linuxthreads/sysdeps/pthread 
> -I../sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv 
> -I../linuxthreads/sysdeps/unix -I../linuxthreads/sysdeps/mips 
> -I../sysdeps/unix/sysv/linux/mips -I../sysdeps/unix/sysv/linux 
> -I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman 
> -I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix/mips 
> -I../sysdeps/unix -I../sysdeps/posix -I../sysdeps/mips/mipsel 
> -I../sysdeps/mips/fpu -I../sysdeps/mips -I../sysdeps/wordsize-32 
> -I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64 -I../sysdeps/ieee754 
> -I../sysdeps/generic/elf -I../sysdeps/generic  -nostdinc -isystem 
> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/include -isystem 
> /home/benmen/mips/kernel/mips-2.4.20/include -D_LIBC_REENTRANT -include 
> ../include/libc-symbols.h       -DHAVE_INITFINI -o 
> /home/benmen/mips/mipsel-glibc/csu/init-first.o
> In file included from ../linuxthreads/descr.h:42,
>                  from ../linuxthreads/internals.h:29,
>                  from ../linuxthreads/sysdeps/pthread/bits/libc-lock.h:27,
>                  from ../sysdeps/generic/ldsodefs.h:38,
>                  from ../sysdeps/unix/sysv/linux/ldsodefs.h:25,
>                  from ../sysdeps/mips/elf/ldsodefs.h:25,
>                  from ../sysdeps/unix/sysv/linux/init-first.c:30:
> ../linuxthreads/sysdeps/mips/pt-machine.h:48: invalid register name for 
> `stack_pointer'
> make[2]: *** [/home/benmen/mips/mipsel-glibc/csu/init-first.o] Fehler 1
> make[2]: Leaving directory `/home/benmen/mips/glibc-2.3.2/csu'
> make[1]: *** [csu/subdir_lib] Fehler 2
> make[1]: Leaving directory `/home/benmen/mips/glibc-2.3.2'
> make: *** [all] Fehler 2
> 
> regards,
> 
> Ben
> 
> 
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
