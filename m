Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2005 16:18:36 +0100 (BST)
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:33720 "EHLO
	jg555.com") by ftp.linux-mips.org with ESMTP id S8133514AbVIZPSR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Sep 2005 16:18:17 +0100
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 26 Sep 2005 08:18:14 -0700
  id 00008476.43381136.00004C1D
Message-ID: <4338111C.6040401@jg555.com>
Date:	Mon, 26 Sep 2005 08:17:48 -0700
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS64 NPTL Status
References: <43323D35.9030905@jg555.com> <20050922213020.GA15905@nevyn.them.org> <43333001.3080703@jg555.com>
In-Reply-To: <43333001.3080703@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Daniel,
    Got passed the first issue, but the second one came around when 
trying to get NPTL to compile with N32. Here's what I got. The code does 
compile under pure 64 bit no problems.

mips64el-unknown-linux-gnu-gcc -mel -march=r5000 -mtune=r5000 -mabi=n32 ../sysdeps/unix/sysv/linux/ptrace.c -c -std=gnu99 -O2 -Wall -Winline -Wstrict-prototypes -Wwrite-strings -g      -I../include -I. -I/mnt/lfs-mips64/build/glibc-cross-n32/misc -I.. -I../libio -I../nptl -I/mnt/lfs-mips64/build/glibc-cross-n32 -I../sysdeps/mips/elf -I../libidn/sysdeps/unix -I../nptl/sysdeps/unix/sysv/linux/mips/mips64 -I../nptl/sysdeps/unix/sysv/linux/mips -I../nptl/sysdeps/unix/sysv/linux -I../nptl/sysdeps/pthread -I../sysdeps/pthread -I../nptl/sysdeps/unix/sysv -I../nptl/sysdeps/unix -I../nptl/sysdeps/mips -I../nptl/sysdeps/generic -I../sysdeps/unix/sysv/linux/mips/mips64/n32 -I../sysdeps/unix/sysv/linux/mips/mips64 -I../sysdeps/unix/sysv/linux/mips -I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix/mips/mips64/n32 -I../sysdeps/unix/mips/mips64 -I../sysdeps/unix/mips -I../sysdeps/unix -I../sysdeps/posix -I../sysdeps/mips/mips64/n32 -I../sysdeps/ieee754/ldbl-128 -I../sysdeps/mips/mips64 -I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64 -I../sysdeps/mips -I../sysdeps/wordsize-32 -I../sysdeps/mips/fpu -I../sysdeps/ieee754 -I../sysdeps/generic/elf -I../sysdeps/generic -nostdinc -isystem /home/lfs-mips64/cross-tools/bin/../lib/gcc/mips64el-unknown-linux-gnu/4.0.1/include -isystem /tools/include -D_LIBC_REENTRANT -D_LIBC_REENTRANT -include ../include/libc-symbols.h  -DPIC     -o /mnt/lfs-mips64/build/glibc-cross-n32/misc/ptrace.o -MD -MP -MF /mnt/lfs-mips64/build/glibc-cross-n32/misc/ptrace.o.dt -MT /mnt/lfs-mips64/build/glibc-cross-n32/misc/ptrace.o
../sysdeps/unix/sysv/linux/ptrace.c:31: error: conflicting types for 'ptrace'
../sysdeps/unix/sysv/linux/mips/sys/ptrace.h:129: error: previous declaration of 'ptrace' was here
../sysdeps/unix/sysv/linux/ptrace.c: In function 'ptrace':
../sysdeps/unix/sysv/linux/ptrace.c:104: warning: cast from pointer to integer of different size
../sysdeps/unix/sysv/linux/ptrace.c:104: warning: cast from pointer to integer of different size
make[2]: *** [/mnt/lfs-mips64/build/glibc-cross-n32/misc/ptrace.o] Error 1
make[2]: Leaving directory `/mnt/lfs-mips64/build/glibc-20050919/misc'
make[1]: *** [misc/subdir_lib] Error 2
make[1]: Leaving directory `/mnt/lfs-mips64/build/glibc-20050919'
make: *** [all] Error 2


Line 127 - ptrace.h
#if _MIPS_SIM == _ABIN32
__extension__ extern long long int ptrace
  (enum __ptrace_request __request, ...) __THROW;
#else
extern long int ptrace (enum __ptrace_request __request, ...) __THROW;
#endif

Line 31 - ptrace.c

long int
ptrace (enum __ptrace_request request, ...)
{
  long int res, ret;




-- 
----
Jim Gifford
maillist@jg555.com
