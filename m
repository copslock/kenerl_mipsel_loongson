Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K2p2v01367
	for linux-mips-outgoing; Tue, 19 Feb 2002 18:51:02 -0800
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K2os901361
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 18:50:54 -0800
Received: from delllaptop (whnat1.weiderpub.com [65.115.104.67])
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g1K1orZ03517
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 17:50:53 -0800
From: "Robert Rusek" <robru@teknuts.com>
To: <linux-mips@oss.sgi.com>
Subject: Error Compiling 2.4.3 kernel on SGI IP22...
Date: Tue, 19 Feb 2002 17:45:46 -0800
Message-ID: <000901c1b9b0$51cdd0b0$0f1610ac@delllaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Initially I got errors telling me that mips-linux-gcc, mips-linux-ld,
and mips-linux-ar did not exists.  I simply made a link for:

mips-linux-gcc	-> gcc 
mips-linux-ld	-> ld
mips-linux-ar	-> ar

Once doing so I got make to complete except for the last part when it
goes to make the vmlinux file.  I included the last few lines before it
errors out.  Any help would be greatly appreciated.

---
make[1]: Entering directory `/usr/src/linux-2.4.3/arch/mips/kernel'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/usr/src/linux-2.4.3/arch/mips/kernel'
make CFLAGS="-I /usr/src/linux-2.4.3/include/asm/gcc -D__KERNEL__
-I/usr/src/lin
ux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-
aliasing -G 0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2 -Wa,--trap -pipe
" -C  a
rch/mips/mm
make[1]: Entering directory `/usr/src/linux-2.4.3/arch/mips/mm'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.4.3/arch/mips/mm'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux-2.4.3/arch/mips/mm'
make[1]: Leaving directory `/usr/src/linux-2.4.3/arch/mips/mm'
make CFLAGS="-I /usr/src/linux-2.4.3/include/asm/gcc -D__KERNEL__
-I/usr/src/lin
ux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-
aliasing -G 0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2 -Wa,--trap -pipe
" -C  a
rch/mips/lib
make[1]: Entering directory `/usr/src/linux-2.4.3/arch/mips/lib'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.4.3/arch/mips/lib'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux-2.4.3/arch/mips/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.3/arch/mips/lib'
mips-linux-ld -static -G 0 -T arch/mips/ld.script
arch/mips/kernel/head.o arch/m
ips/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o
mm/mm.o fs/f
s.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o
arch/mips/sgi/kernel/ip22-kern.o
 \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/ne
t/net.o drivers/media/media.o  drivers/scsi/scsidrv.o
drivers/cdrom/driver.o dri
vers/sgi/sgi.a drivers/video/video.o \
        net/network.o \
        arch/mips/lib/lib.a /usr/src/linux-2.4.3/lib/lib.a
arch/mips/arc/arclib.
a \
        --end-group \
        -o vmlinux
mips-linux-ld: target elf32-bigmips not found
make: *** [vmlinux] Error 1
---

--
Robert Rusek
