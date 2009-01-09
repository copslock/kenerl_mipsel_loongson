Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2009 12:08:30 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.152]:62530 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S21103375AbZAIMI2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Jan 2009 12:08:28 +0000
Received: by fg-out-1718.google.com with SMTP id d23so3263603fga.32
        for <linux-mips@linux-mips.org>; Fri, 09 Jan 2009 04:08:27 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Jar7yL2qhUXE4QGstr6UCqWlu8vpMWc/mZ1jcZlq7Mw=;
        b=U2CqLesy0VMzRVXqmrUA/+I6ROSE10dM5CPgm9fnHZ9K2RyDVVVvOLsOvMCM3K5Ep4
         h+IOyw26sKagMWAMY8g1MFcRgoTEIuMrCaSINnon7NI9zagHLrd8TAuk9wtwa1edzc+c
         53h1PYf15GElhO1Q2IDGwGHwtrvaxieQUFPtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cJxOam+WtFUzOKI/LYGJrW5HNDY3u+1I0BBi0TomfNJCfJdf/HqsWs0FGfwzlVBNYX
         zGX4XAB2+iJM3ftt2sROpMRIUVHtRvnGFEtdWSZXlfed2HYR6UkcwVvdTlzANh7eBi4o
         KM3MuuVcTOSsuUunV0vLw0kPRNHA9b70nZT1w=
Received: by 10.86.65.9 with SMTP id n9mr14830524fga.61.1231502906822;
        Fri, 09 Jan 2009 04:08:26 -0800 (PST)
Received: by 10.86.72.13 with HTTP; Fri, 9 Jan 2009 04:08:26 -0800 (PST)
Message-ID: <164c42ea0901090408h377e9f4eqb417443ef7a1ad@mail.gmail.com>
Date:	Fri, 9 Jan 2009 13:08:26 +0100
From:	"Per Andreas Gulbrandsen" <theperan@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Problem compiling glibc
In-Reply-To: <164c42ea0901080443sace24b2v176bcc0a4d23836a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <164c42ea0901080443sace24b2v176bcc0a4d23836a@mail.gmail.com>
Return-Path: <theperan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: theperan@gmail.com
Precedence: bulk
X-list: linux-mips

Hi.

I first sent this mail to clfs-support (cross-compile linux from
scratch), but got the advice to try asking for help here.

I'm following the clfs guide for cross compiling a linux system for
mips (alchemy, CLFS_TARGET="mipsel-unknown-linux-gnu"). SVN Version
SVN-20090107-MIPS. My host system is openSuse 11
(CLFS_HOST="x86_64-cross-linux-gnu"). I've checked host requirements
and I have all tools specified there.

I get stuck in 5.11, Constructing Cross-Compile Tools - glibc. When I
try to make glibc I get the following error:
mipsel-unknown-linux-gnu-gcc -mabi=32
../sysdeps/unix/sysv/linux/sa_len.c -c -std=gnu99 -fgnu89-inline -O2
-Wall -Winline -Wwrite-strings -fmerge-all-constants -g
-Wstrict-prototypes      -I../include
-I/mnt/clfs/sources/glibc-build/socket -I/mnt/clfs/sources/glibc-build
-I../ports/sysdeps/mips/elf
-I../ports/sysdeps/unix/sysv/linux/mips/mips32
-I../ports/sysdeps/unix/sysv/linux/mips/nptl
-I../ports/sysdeps/unix/sysv/linux/mips
-I../nptl/sysdeps/unix/sysv/linux -I../nptl/sysdeps/pthread
-I../sysdeps/pthread -I../ports/sysdeps/unix/sysv/linux
-I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common
-I../sysdeps/unix/mman -I../sysdeps/unix/inet
-I../nptl/sysdeps/unix/sysv -I../ports/sysdeps/unix/sysv
-I../sysdeps/unix/sysv -I../ports/sysdeps/unix/mips/mips32
-I../ports/sysdeps/unix/mips -I../nptl/sysdeps/unix
-I../ports/sysdeps/unix -I../sysdeps/unix -I../sysdeps/posix
-I../ports/sysdeps/mips/mips32 -I../ports/sysdeps/mips
-I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64
-I../sysdeps/wordsize-32 -I../ports/sysdeps/mips/fpu
-I../ports/sysdeps/mips/nptl -I../sysdeps/ieee754
-I../sysdeps/generic/elf -I../sysdeps/generic -I../nptl -I../ports
-I.. -I../libio -I. -nostdinc -isystem
/mnt/clfs/cross-tools/bin/../lib/gcc/mipsel-unknown-linux-gnu/4.3.2/include
-isystem /mnt/clfs/cross-tools/bin/../lib/gcc/mipsel-unknown-linux-gnu/4.3.2/include-fixed
-isystem /tools/include -D_LIBC_REENTRANT -include
../include/libc-symbols.h  -DPIC     -o
/mnt/clfs/sources/glibc-build/socket/sa_len.o -MD -MP -MF
/mnt/clfs/sources/glibc-build/socket/sa_len.o.dt
-MT/mnt/clfs/sources/glibc-build/socket/sa_len.o
In file included from /tools/include/asm/byteorder.h:65,
                from /tools/include/linux/atalk.h:4,
                from ../sysdeps/unix/sysv/linux/netatalk/at.h:25,
                from ../sysdeps/unix/sysv/linux/sa_len.c:22:
/tools/include/linux/byteorder.h:8:3: error: #error Fix
asm/byteorder.h to define one endianness
make[2]: *** [/mnt/clfs/sources/glibc-build/socket/sa_len.o] Error 1
make[2]: Leaving directory `/mnt/clfs/sources/glibc-2.8/socket'
make[1]: *** [socket/subdir_lib] Error 2
make[1]: Leaving directory `/mnt/clfs/sources/glibc-2.8'
make: *** [all] Error 2

I've looked at asm/byteorder.h, but I can't figure out what to do. I
can't understand how I'm suppose to "fix" it. I've tried different
stuff, i.e. undefing __MIPSEB__ and/or __BIG_ENDIAN if __MIPSEB__ is
defined. But I still get the same error.
However, If I undef __BIG_ENDIAN in /tools/include/linux/byteorder.h
just before the check that triggers the error it compiles. But this
doesn't seem like a very good solution. Seems like I should get rid of
the initial definition of __BIG_ENDIAN (alt. __MIPSEB). Can anyone
please advice? I'd like to get this right, and not just hack my way
through it.

--
mvh
Per Andreas Gulbrandsen
