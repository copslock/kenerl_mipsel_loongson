Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id KAA26526
	for <pstadt@stud.fh-heilbronn.de>; Fri, 3 Sep 1999 10:22:51 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id BAA06475; Fri, 3 Sep 1999 01:20:39 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA63364
	for linux-list;
	Fri, 3 Sep 1999 01:12:12 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA92159
	for <linux@engr.sgi.com>;
	Fri, 3 Sep 1999 01:12:09 -0700 (PDT)
	mail_from (zeno@holmes.nl)
Received: from holmes.holmes.nl (holmes.holmes.nl [194.229.145.97]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA08157
	for <linux@engr.sgi.com>; Fri, 3 Sep 1999 01:12:07 -0700 (PDT)
	mail_from (zeno@holmes.nl)
From: zeno@holmes.nl
Received: from theta.holmes.nl (theta.holmes.nl [10.5.0.12])
	by holmes.holmes.nl (Postfix) with ESMTP id EE1D13878
	for <linux@engr.sgi.com>; Fri,  3 Sep 1999 10:22:58 +0200 (CEST)
Received: by theta.holmes.nl with Internet Mail Service (5.5.2448.0)
	id <RTFL8LJH>; Fri, 3 Sep 1999 09:56:52 +0200
Message-ID: <A7C09CFCAF83D2119C5000104B416CCF091C11@theta.holmes.nl>
To: linux@cthulhu.engr.sgi.com
Subject: Problem Red Hat 6.0 / SGI 540
Date: Fri, 3 Sep 1999 09:56:51 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I tried to install the Red Hat 6.0 by the rules that are given on
http://www.linux.sgi.com/intel, however it did not work out. The first
floppy did not boot properly. After this I followed the suggestion of
booting with larc.exe, however the boot was not succesful.

WIth larc.exe the next messages are displayed :
OSLoadPartition : multi(0)disk(0)fdisk(0)partition(1)
OSLoadFileName : /la2210.vw
OSLOadScript : root=/dev/fd0 load_ramdisk=1

ARC opening multi(0)disk(0)fdisk(0)partition(1)la2210.vw
ARC reading 52 bytes at offset 0

then it read the floppy forever.

My Hardware Inventory :
SGI_ARCx86_mp
dual processor 500 Mhz x86 Family 6, Model 7, STepring 2 (1024 L2 Cache)
Firmware 1.006
Memory 2048 MB
Display Cobalt Graphics
Network Intel 82257
USB Keyboard / Mouse
with Raid QL 4 QL 1080 SCSI 2 - disks

Thanks in advance for any suggestions to install Linux on this system.

Best regards,


Zeno
