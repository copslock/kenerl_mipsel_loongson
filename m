Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA08861 for <linux-archive@neteng.engr.sgi.com>; Fri, 11 Jun 1999 03:46:12 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA03791
	for linux-list;
	Fri, 11 Jun 1999 03:44:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA38920
	for <linux@engr.sgi.com>;
	Fri, 11 Jun 1999 03:44:15 -0700 (PDT)
	mail_from (andy@derfel99.freeserve.co.uk)
Received: from mail4.svr.pol.co.uk (mail4.svr.pol.co.uk [195.92.193.211]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA02027
	for <linux@engr.sgi.com>; Fri, 11 Jun 1999 03:44:14 -0700 (PDT)
	mail_from (andy@derfel99.freeserve.co.uk)
Received: from modem-60.radon.dialup.pol.co.uk ([62.136.42.188] helo=snafu)
	by mail4.svr.pol.co.uk with smtp (Exim 2.12 #1)
	id 10sOnE-0003Ua-00
	for linux@engr.sgi.com; Fri, 11 Jun 1999 11:44:12 +0100
Message-ID: <000901beb3f7$6be730c0$0a02030a@snafu>
From: "Andrew Linfoot" <andy@derfel99.freeserve.co.uk>
To: "linux" <linux@cthulhu.engr.sgi.com>
Subject: Kernel Build Problem
Date: Fri, 11 Jun 1999 11:44:40 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I'm trying to build the 2.2.1 kernel with sound support enabled and i get
the following warnings:

sound_firmware.c: In function `do_mod_firmware_load':
sound_firmware.c:23: warning: implicit declaration of function `lseek'
sound_firmware.c:38: warning: implicit declaration of function `read'

and then during the final link:

drivers/sound/sound.a(sound_firmware.o): In function `do_mod_firmware_load':
sound_firmware.c(.text+0x84): undefined reference to `lseek'
sound_firmware.c(.text+0x84): relocation truncated to fit: R_MIPS_26 lseek
sound_firmware.c(.text+0xc4): undefined reference to `lseek'
sound_firmware.c(.text+0xc4): relocation truncated to fit: R_MIPS_26 lseek
sound_firmware.c(.text+0xfc): undefined reference to `read'
sound_firmware.c(.text+0xfc): relocation truncated to fit: R_MIPS_26 read
make: *** [vmlinux] Error 1

I can compile OK with/without modules and sound disabled.

Is this fixed in the 2.2.9 kernel and if so will an archive of 2.2.9 be made
available on linus? (I don't have CVS access from my development box at the
moment).

Any help would be appreciated.

Thanks
Andy

Andrew Linfoot
Tel: +44 (0)114 265 0251
Mobile: +44 (0)7974 299 545
