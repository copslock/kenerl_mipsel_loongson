Received:  by oss.sgi.com id <S305171AbPLGU3p>;
	Tue, 7 Dec 1999 12:29:45 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:45899 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305167AbPLGU3V>;
	Tue, 7 Dec 1999 12:29:21 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06966; Tue, 7 Dec 1999 12:36:31 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA74465
	for linux-list;
	Tue, 7 Dec 1999 12:06:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA92251
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 7 Dec 1999 12:06:01 -0800 (PST)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id MAA04112
	for <linux@cthulhu.engr.sgi.com>; Tue, 7 Dec 1999 12:05:58 -0800 (PST)
	mail_from (mikehill@hgeng.com)
Received: (qmail 12300 invoked from network); 7 Dec 1999 20:05:38 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 7 Dec 1999 20:05:38 -0000
Received: by BART with Internet Mail Service (5.5.2232.9)
	id <YMMWSHZK>; Tue, 7 Dec 1999 15:05:44 -0500
Message-ID: <E138DB347D10D3119C630008C79F5DEC11F79F@BART>
From:   Mike Hill <mikehill@hgeng.com>
To:     "'Ralf Baechle'" <ralf@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: RE: Snapshot
Date:   Tue, 7 Dec 1999 15:05:43 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2232.9)
Content-Type: text/plain
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi Ralf,

This compiles very well (i386 cross-compiled) unless I add serial console
support, in which case it finishes like this:

mips-linux-ld -static -G 0 -T arch/mips/ld.script.big -Ttext 0x88002000
arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o
init/version.o \
   --start-group \
   arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
   fs/filesystems.a \
   net/network.a \
   drivers/block/block.a drivers/char/char.o drivers/misc/misc.o
drivers/parport/parport.a drivers/net/net.a drivers/scsi/scsi.a
drivers/cdrom/cdrom.a drivers/sound/sounddrivers.o drivers/sgi/sgi.a
drivers/video/video.a \
   arch/mips/lib/lib.a /usr/src/mips/linux-19991206/lib/lib.a
arch/mips/sgi/kernel/sgikern.a arch/mips/arc/arclib.a \
   --end-group \
   -o vmlinux
arch/mips/sgi/kernel/sgikern.a(setup.o): In function `sgi_write_output':
setup.c(.text.init+0x84): undefined reference to `console_setup'
setup.c(.text.init+0x84): relocation truncated to fit: R_MIPS_26
console_setup
make: *** [vmlinux] Error 1

The CVS 2.2 source still compiles.

Regards,

Mike
