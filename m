Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id UAA21832
	for <pstadt@stud.fh-heilbronn.de>; Wed, 4 Aug 1999 20:12:15 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA10505; Wed, 4 Aug 1999 11:06:40 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA01492
	for linux-list;
	Wed, 4 Aug 1999 11:02:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA90958
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 4 Aug 1999 11:02:28 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id LAA00848
	for <linux@cthulhu.engr.sgi.com>; Wed, 4 Aug 1999 11:02:25 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: (qmail 20741 invoked from network); 4 Aug 1999 18:02:23 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 4 Aug 1999 18:02:23 -0000
Received: by BART with Internet Mail Service (5.5.2232.9)
	id <QBB1A031>; Wed, 4 Aug 1999 14:03:21 -0400
Message-ID: <E138DB347D10D3119C630008C79F5DEC07EB75@BART>
From: Mike Hill <mikehill@hgeng.com>
To: linux@cthulhu.engr.sgi.com
Subject: Floptical Drive
Date: Wed, 4 Aug 1999 14:03:18 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2232.9)
Content-Type: text/plain
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've connected my Indy floptical drive under Linux for the first time, and
the kernel accurately detects and sizes it (when a diskette is in).  Since
I've never had the opportunity to actually purchase a 21 M floptical
diskette, the default media are IBM format dikettes.  When I try to add
msdos or vfat filesystem support to the kernel (latest CVS) I get the
following failure:

make -C  arch/mips/tools
make[1]: Entering directory `/usr/src/mips/linux/arch/mips/tools'
mips-linux-gcc -D__KERNEL__ -I/usr/src/mips/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
-mcpu=r4600 -mips2 -pipe   -S offset.c -o offset.s
sed -n '/^@@@/s///p' offset.s >offset.h
cmp -s offset.h /usr/src/mips/linux/include/asm-mips/offset.h || (cp
offset.h /usr/src/mips/linux/include/asm-mips/offset.h.new && mv
/usr/src/mips/linux/include/asm-mips/offset.h.new
/usr/src/mips/linux/include/asm-mips/offset.h)
make[1]: Leaving directory `/usr/src/mips/linux/arch/mips/tools'
mips-linux-ld -static -N -G 0 -T arch/mips/ld.script.big -Ttext 0x88002000
arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.a drivers/misc/misc.a
drivers/net/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a
drivers/sgi/sgi.a drivers/video/video.a \
        arch/mips/lib/lib.a /usr/src/mips/linux/lib/lib.a
arch/mips/sgi/kernel/sgikern.a arch/mips/arc/arclib.a \
        --end-group \
        -o vmlinux
fs/filesystems.a(fat.o): In function `fat_file_write':
file.c(.text+0x3214): undefined reference to `update_vm_cache'
file.c(.text+0x3214): relocation truncated to fit: R_MIPS_26 update_vm_cache
make: *** [vmlinux] Error 1


Suggestions?

Thanks,

Mike
