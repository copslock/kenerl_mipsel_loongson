Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QBY5526265
	for linux-mips-outgoing; Fri, 26 Oct 2001 04:34:05 -0700
Received: from mail2.infineon.com (mail2.infineon.com [192.35.17.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QBY0026261
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 04:34:00 -0700
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail2.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail2.infineon.com (8.11.1/8.11.1) with ESMTP id f9QBXw427293
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 13:33:58 +0200 (MET DST)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id V44V813R; Fri, 26 Oct 2001 13:33:42 +0200
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Fri, 26 Oct 2001 13:33:42 +0200 (W. Europe Daylight Time)
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <4YC1M56F>; Fri, 26 Oct 2001 13:36:32 +0200
Message-ID: <86048F07C015D311864100902760F1DD01B5E29B@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: linux-mips@oss.sgi.com
Subject: Kernel 2.4.3 compile problem
Date: Fri, 26 Oct 2001 13:36:25 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

I tried to compile the kernel 2.4.3 but the process stops directly with the
following error:

saeanme@sae139c:/mipseb/usr/src/linux> make vmlinux
mips-linux-gcc -I /mipseb/usr/src/linux-2.4.3/include/asm/gcc -D__KERNEL__ 
-I/mipseb/usr/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -g -G 0 -mno-abicalls -fno-pic
-mcpu=r4600 
-mips2 -Wa,--trap -pipe   -c -o init/main.o init/main.c
In file included from
/usr/lib/gcc-lib/mips-linux/egcs-2.91.66/include/stdarg.h:27,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/kernel.h:10,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/wait.h:13,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/fs.h:12,
                 from
/mipseb/usr/src/linux-2.4.3/include/linux/capability.h:17,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/binfmts.h:5,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/sched.h:9,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/mm.h:4,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/slab.h:14,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/lib/gcc-lib/mips-linux/egcs-2.91.66/include/va-mips.h:278: parse error
at null character
In file included from /mipseb/usr/src/linux-2.4.3/include/linux/wait.h:13,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/fs.h:12,
                 from
/mipseb/usr/src/linux-2.4.3/include/linux/capability.h:17,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/binfmts.h:5,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/sched.h:9,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/mm.h:4,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/slab.h:14,
                 from /mipseb/usr/src/linux-2.4.3/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/mipseb/usr/src/linux-2.4.3/include/linux/kernel.h:62: parse error before
`va_list'
/mipseb/usr/src/linux-2.4.3/include/linux/kernel.h:62: warning: function
declaration isn't a prototype
make: *** [init/main.o] Error 1
saeanme@sae139c:/mipseb/usr/src/linux>

I downloaded the kernel from
ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/src/
and the compiler is the current from ftp://oss.sgi.com/pub/linux/mips/
Is this a combination that cannot work? 
Any help would be appreciated.

best regards
--
Andre Messerschmidt

Application Engineer
Infineon Technologies AG
