Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2004 00:03:56 +0100 (BST)
Received: from pimout3-ext.prodigy.net ([IPv6:::ffff:207.115.63.102]:43424
	"EHLO pimout3-ext.prodigy.net") by linux-mips.org with ESMTP
	id <S8226038AbUENXDw> convert rfc822-to-8bit; Sat, 15 May 2004 00:03:52 +0100
Received: from adsl-69-106-45-43.dsl.pltn13.pacbell.net (adsl-69-106-45-43.dsl.pltn13.pacbell.net [69.106.45.43])
	by pimout3-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id i4EN3mTT216806;
	Fri, 14 May 2004 19:03:48 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: timr <timr@valuepointnet.com>
Reply-To: timr@valuepointnet.com
Organization: ValuePoint Net
To: linux-mips@linux-mips.org
Subject: gdb gives Don't know how to run ,  gdbserver says Killing inferior
Date: Fri, 14 May 2004 16:02:09 -0700
User-Agent: KMail/1.4.3
Cc: timr <timr@valuepointnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200405141602.09876.timr@valuepointnet.com>
Return-Path: <timr@valuepointnet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: timr@valuepointnet.com
Precedence: bulk
X-list: linux-mips

Hi,

I am attempting to do my first remote debug.
 Every time I attempt to run from gdb, gdb says target is already running. 
But when I try to connect to the target app (mini_http) via my browser,  I see 
its not running. (NOTE: mini_httpd  does run when I'm not using gdbserver)
when I answer gdb "start from the beginning" with y
gdbserver bails with "Killing inferior"!

What am I doing wrong - please help?

Where do I supply the app arguments,
on the target when I start gdbserver or on the host?
how does this effect a "re-start"?

Is it gdbserver that starts the app or is it started from gdb?

I can do (gdb) list   and (gdb) break 1200, not sure if that helps.

See below for detail.

Thanks,
Tim


 target is mipsel   with 2.4.18
host 686, running Redhat 8.0

gdb-5.2.1

I first tried gdb-6.0.tar.gz but I kept getting errors:
warnings because libtread_db wasn't found and
then linux-low would not compile because of __SIGRTMIN
(see output below) Any way I bailed on 6.0 and went to 5.2.1

I had problems on the target with 5.2.1 
I used "file" and found both gdbserver and my app (mini_httpd) were both
dynamicall linked, so I compiled with LDFLAGS=-static

got the new builds loaded on the target and issued:

gdbserver 192.168.0.2:2345 /sbin/whg/mini_httpd -d /www/whg -u root -c 
"/cgi-bin/\*" -i /var/state/mini_httpd.pid
Process /sbin/whg/mini_httpd created; pid = 27373

<<<gdbserver comes up fine>>>

(on the host )
>mipsel-linux-gdb /path-to-binary/mini_httpd
GNU gdb 5.2.1
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i686-pc-linux-gnu --target=mipsel-linux"...
(gdb) target remote 192.168.0.1:2345
Remote debugging using 192.168.0.1:2345
0x004000b0 in _ftext ()
<<< TARGET shows >>>
Remote debugging from host 192.168.0.2

<<< Host >>>

(gdb) dir /path-to-src/src/MINI_HTTPD
Source directories searched: /path-to-src/src/MINI_HTTPD:$cdir:$cwd
(gdb) run
The program being debugged has been started already.
Start it from the beginning? (y or n) y
Starting program: /path-to-app/mini_httpd
Don't know how to run.  Try "help target".

<<< TARGET shows >>>
Killing inferior


<<<  bad build output for gdbserver 6.0 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
export PROJECT=VPT
echo $PROJECT
export PRJROOT=/root
export TARGET=mipsel-linux
export PREFIX=/usr/local
export TARGET_PREFIX=${PREFIX}/${TARGET}
export PATH=${PREFIX}/bin:${PATH}

>CC=mipsel-linux-gcc ../gdb-6.0/gdb/gdbserver/configure --host=$TARGET 
--prefix=${TARGET_PREFIX} 2>&1 | tee gdbserver.6.0.config.out

creating cache ./config.cache
checking for gcc... mipsel-linux-gcc
checking whether the C compiler (mipsel-linux-gcc  ) works... yes
checking whether the C compiler (mipsel-linux-gcc  ) is a cross-compiler... 
yes
checking whether we are using GNU C... yes
checking whether mipsel-linux-gcc accepts -g... yes
checking host system type... mipsel-unknown-linux-gnu
checking target system type... mipsel-unknown-linux-gnu
checking build system type... mipsel-unknown-linux-gnu
checking for a BSD compatible install... /usr/bin/install -c
checking how to run the C preprocessor... mipsel-linux-gcc -E
checking for ANSI C header files... yes
checking for sgtty.h... yes
checking for termio.h... yes
checking for termios.h... yes
checking for sys/reg.h... no
checking for string.h... yes
checking for proc_service.h... no
checking for sys/procfs.h... yes
checking for thread_db.h... no
checking for linux/elf.h... yes
checking for stdlib.h... yes
checking for unistd.h... yes
checking whether strerror must be declared... no
checking for lwpid_t in sys/procfs.h... no
checking for psaddr_t in sys/procfs.h... no
checking for prgregset_t in sys/procfs.h... no
checking for prfpregset_t in sys/procfs.h... no
checking for elf_fpregset_t in sys/procfs.h... yes
checking for libthread_db... no
configure: warning: Could not find libthread_db.
configure: warning: Disabling thread support in gdbserver.
updating cache ./config.cache
creating ./config.status
creating Makefile
creating config.h

>make 2>&1 | tee gdbserver.6.0.make.out

mipsel-linux-gcc -c -Wall -g -O2    -I. -I../gdb-6.0/gdb/gdbserver 
-I../gdb-6.0/gdb/gdbserver/../regformats 
-I../gdb-6.0/gdb/gdbserver/../../include -I../../bfd 
-I../gdb-6.0/gdb/gdbserver/../../bfd ../gdb-6.0/gdb/gdbserver/inferiors.c
mipsel-linux-gcc -c -Wall -g -O2    -I. -I../gdb-6.0/gdb/gdbserver 
-I../gdb-6.0/gdb/gdbserver/../regformats 
-I../gdb-6.0/gdb/gdbserver/../../include -I../../bfd 
-I../gdb-6.0/gdb/gdbserver/../../bfd ../gdb-6.0/gdb/gdbserver/regcache.c
mipsel-linux-gcc -c -Wall -g -O2    -I. -I../gdb-6.0/gdb/gdbserver 
-I../gdb-6.0/gdb/gdbserver/../regformats 
-I../gdb-6.0/gdb/gdbserver/../../include -I../../bfd 
-I../gdb-6.0/gdb/gdbserver/../../bfd ../gdb-6.0/gdb/gdbserver/remote-utils.c
mipsel-linux-gcc -c -Wall -g -O2    -I. -I../gdb-6.0/gdb/gdbserver 
-I../gdb-6.0/gdb/gdbserver/../regformats 
-I../gdb-6.0/gdb/gdbserver/../../include -I../../bfd 
-I../gdb-6.0/gdb/gdbserver/../../bfd ../gdb-6.0/gdb/gdbserver/server.c
mipsel-linux-gcc -c  -Wall -g -O2    -I. -I../gdb-6.0/gdb/gdbserver 
-I../gdb-6.0/gdb/gdbserver/../regformats 
-I../gdb-6.0/gdb/gdbserver/../../include -I../../bfd 
-I../gdb-6.0/gdb/gdbserver/../../bfd 
../gdb-6.0/gdb/gdbserver/../signals/signals.c -DGDBSERVER
../gdb-6.0/gdb/signals/signals.c: In function `do_target_signal_to_host':
../gdb-6.0/gdb/signals/signals.c:521: warning: unused variable `retsig'
mipsel-linux-gcc -c -Wall -g -O2    -I. -I../gdb-6.0/gdb/gdbserver 
-I../gdb-6.0/gdb/gdbserver/../regformats 
-I../gdb-6.0/gdb/gdbserver/../../include -I../../bfd 
-I../gdb-6.0/gdb/gdbserver/../../bfd ../gdb-6.0/gdb/gdbserver/target.c
mipsel-linux-gcc -c -Wall -g -O2    -I. -I../gdb-6.0/gdb/gdbserver 
-I../gdb-6.0/gdb/gdbserver/../regformats 
-I../gdb-6.0/gdb/gdbserver/../../include -I../../bfd 
-I../gdb-6.0/gdb/gdbserver/../../bfd ../gdb-6.0/gdb/gdbserver/utils.c
mipsel-linux-gcc -c -Wall -g -O2    -I. -I../gdb-6.0/gdb/gdbserver 
-I../gdb-6.0/gdb/gdbserver/../regformats 
-I../gdb-6.0/gdb/gdbserver/../../include -I../../bfd 
-I../gdb-6.0/gdb/gdbserver/../../bfd ../gdb-6.0/gdb/gdbserver/mem-break.c
sh ../gdb-6.0/gdb/gdbserver/../regformats/regdat.sh 
../gdb-6.0/gdb/gdbserver/../regformats/reg-mips.dat reg-mips.c
reg-mips.c updated.
mipsel-linux-gcc -c -Wall -g -O2    -I. -I../gdb-6.0/gdb/gdbserver 
-I../gdb-6.0/gdb/gdbserver/../regformats 
-I../gdb-6.0/gdb/gdbserver/../../include -I../../bfd 
-I../gdb-6.0/gdb/gdbserver/../../bfd reg-mips.c
mipsel-linux-gcc -c  -Wall -g -O2    -I. -I../gdb-6.0/gdb/gdbserver 
-I../gdb-6.0/gdb/gdbserver/../regformats 
-I../gdb-6.0/gdb/gdbserver/../../include -I../../bfd 
-I../gdb-6.0/gdb/gdbserver/../../bfd ../gdb-6.0/gdb/gdbserver/linux-low.c 
../gdb-6.0/gdb/gdbserver/linux-low.c: In function `linux_create_inferior':
../gdb-6.0/gdb/gdbserver/linux-low.c:150: `__SIGRTMIN' undeclared (first use 
in this function)
../gdb-6.0/gdb/gdbserver/linux-low.c:150: (Each undeclared identifier is 
reported only once
../gdb-6.0/gdb/gdbserver/linux-low.c:150: for each function it appears in.)
../gdb-6.0/gdb/gdbserver/linux-low.c: In function `linux_wait_for_event':
../gdb-6.0/gdb/gdbserver/linux-low.c:511: `__SIGRTMIN' undeclared (first use 
in this function)
../gdb-6.0/gdb/gdbserver/linux-low.c: In function `linux_init_signals':
../gdb-6.0/gdb/gdbserver/linux-low.c:1283: `__SIGRTMIN' undeclared (first use 
in this function)
