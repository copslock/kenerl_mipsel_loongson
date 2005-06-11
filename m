Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Jun 2005 19:55:13 +0100 (BST)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:1731
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8225206AbVFKSy5>;
	Sat, 11 Jun 2005 19:54:57 +0100
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Sat, 11 Jun 2005 11:54:53 -0700
  id 001CCECD.42AB337D.00003CD5
Message-ID: <42AB3366.8030206@jg555.com>
Date:	Sat, 11 Jun 2005 11:54:30 -0700
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Building o32 glibc on mips64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Anyone got any ideas on how to fix this. I'm using binutils 2.16, gcc 
3.4.4, and glibc-2.3.5 with the syscall patch. Looks like socket.S is 
not being generated.

mips64el-unknown-linux-gnu-gcc  -mabi=32 
../sysdeps/unix/sysv/linux/recv.S -c  -
I../include -I. -I/usr/src/glibc-build/socket -I.. -I../libio  
-I/usr/src/glibc-
build -I../sysdeps/mips/elf -I../libidn/sysdeps/unix 
-I../linuxthreads/sysdeps/u
nix/sysv/linux/mips -I../linuxthreads/sysdeps/unix/sysv/linux 
-I../linuxthreads/
sysdeps/pthread -I../sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv 
-I../li
nuxthreads/sysdeps/unix -I../linuxthreads/sysdeps/mips 
-I../sysdeps/unix/sysv/li
nux/mips/mips32 -I../sysdeps/unix/sysv/linux/mips 
-I../sysdeps/unix/sysv/linux -
I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman 
-I../sysdeps/uni
x/inet -I../sysdeps/unix/sysv -I../sysdeps/unix/mips/mips32 
-I../sysdeps/unix/mi
ps -I../sysdeps/unix -I../sysdeps/posix -I../sysdeps/mips/mips32 
-I../sysdeps/mi
ps -I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64 
-I../sysdeps/wordsize
-32 -I../sysdeps/mips/fpu -I../sysdeps/ieee754 -I../sysdeps/generic/elf 
-I../sys
deps/generic  -D_LIBC_REENTRANT -include ../include/libc-symbols.h  
-DPIC     -D
ASSEMBLER  -g   -o /usr/src/glibc-build/socket/recv.o -MD -MP -MF 
/usr/src/glibc
-build/socket/recv.o.dt -MT /usr/src/glibc-build/socket/recv.o
../sysdeps/unix/sysv/linux/recv.S:5:20: socket.S: No such file or directory
make[2]: *** [/usr/src/glibc-build/socket/recv.o] Error 1
make[2]: Leaving directory `/usr/src/glibc-2.3.5/socket'
make[1]: *** [socket/subdir_lib] Error 2
make[1]: Leaving directory `/usr/src/glibc-2.3.5'
make: *** [all] Error 2
root:/usr/src/glibc-build#

-- 
----
Jim Gifford
maillist@jg555.com
