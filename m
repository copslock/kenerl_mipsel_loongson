Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 20:00:49 +0000 (GMT)
Received: from mailout09.sul.t-online.com ([IPv6:::ffff:194.25.134.84]:29836
	"EHLO mailout09.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225289AbSLQUAs> convert rfc822-to-8bit; Tue, 17 Dec 2002 20:00:48 +0000
Received: from fwd00.sul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 18ONtV-0006Ol-01; Tue, 17 Dec 2002 21:00:45 +0100
Received: from juli.scheel-home.de (320039238345-0001@[217.227.24.202]) by fmrl00.sul.t-online.com
	with esmtp id 18ONtE-0GAaJcC; Tue, 17 Dec 2002 21:00:28 +0100
From: Julian Scheel <jscheel@activevb.de>
To: linux-mips@linux-mips.org
Subject: MIPS64 kernel cross-compiling
Date: Tue, 17 Dec 2002 21:00:27 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200212172100.27296.jscheel@activevb.de>
X-Sender: 320039238345-0001@t-dialin.net
Return-Path: <jscheel@activevb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscheel@activevb.de
Precedence: bulk
X-list: linux-mips

Hi,

we're trying to compile a kernel for an embedded system with a 
MIPS64-processor on it.
We tried first with your CVS-sources, but there we get this error:

-----
  Generating include/linux/version.h (unchanged)
make[1]: Nothing to be done for `__build'.
  SPLIT  include/linux/autoconf.h -> include/config/*
make -f scripts/Makefile.build obj=arch/mips64/kernel 
arch/mips64/kernel/offset.s
make[1]: `arch/mips64/kernel/offset.s' is up to date.
/bin/sh: arch/mips64/kernel/offset.s: Datei oder Verzeichnis nicht gefunden
-----

Afterwards we changed to the 2.4.20 stock kernel, there we have managed to get 
the kernel compiling the first steps. We're using the algor SDE-Toolchain and 
on make vmlinux, we get masses of parse-errors.
Our point of view is, that the compiler tries to link to include/asm instead 
of include/asm-mips64, but doing a dirty simlink from asm to asm-mips64 
didn't really improve our situation.
Here are some of the errors we get:

----
sde-gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-mips64    -I /usr/src/linux-2.4.20/include/asm-mips64/gcc -mabi=64 -G 0 
-mno-abicalls -fno-pic -Wa,--trap -pipe   -DKBUILD_BASENAME=main -c -o 
init/main.o init/main.c
In file included from /usr/src/linux-2.4.20/include/asm/system.h:14,
                 from /usr/src/linux-2.4.20/include/asm/processor.h:36,
                 from /usr/src/linux-2.4.20/include/linux/prefetch.h:13,
                 from /usr/src/linux-2.4.20/include/linux/list.h:6,
                 from /usr/src/linux-2.4.20/include/linux/wait.h:14,
                 from /usr/src/linux-2.4.20/include/linux/fs.h:12,
                 from /usr/src/linux-2.4.20/include/linux/capability.h:17,
                 from /usr/src/linux-2.4.20/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.20/include/linux/sched.h:9,
                 from /usr/src/linux-2.4.20/include/linux/mm.h:4,
                 from /usr/src/linux-2.4.20/include/linux/slab.h:14,
                 from /usr/src/linux-2.4.20/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux-2.4.20/include/asm/sgidefs.h:18:39: #error Use a Linux compiler 
or give up.
[...]
In file included from /usr/src/linux-2.4.20/include/linux/pagemap.h:16,
                 from /usr/src/linux-2.4.20/include/linux/locks.h:8,
                 from /usr/src/linux-2.4.20/include/linux/blk.h:5,
                 from init/main.c:25:
/usr/src/linux-2.4.20/include/linux/highmem.h: In function `kmap':
/usr/src/linux-2.4.20/include/linux/highmem.h:68: `PAGE_OFFSET' undeclared 
(first use in this function)
/usr/src/linux-2.4.20/include/linux/highmem.h:68: warning: control reaches end 
of non-void function
init/main.c: In function `start_kernel':
init/main.c:383: `PAGE_OFFSET' undeclared (first use in this function)
make: *** [init/main.o] Error 1
----

hoping for a bit of help (c:

-- 
Grüße,
Julian, Paco
