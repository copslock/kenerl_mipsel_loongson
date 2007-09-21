Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 12:21:18 +0100 (BST)
Received: from smtp3.infineon.com ([203.126.106.229]:6773 "EHLO
	smtp3.infineon.com") by ftp.linux-mips.org with ESMTP
	id S20024966AbXIULVK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 12:21:10 +0100
X-SBRS:	None
Received: from unknown (HELO sinse301.ap.infineon.com) ([172.20.70.22])
  by smtp3.infineon.com with ESMTP; 21 Sep 2007 19:20:01 +0800
Received: from sinse303.ap.infineon.com ([172.20.70.24]) by sinse301.ap.infineon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Sep 2007 19:20:02 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: YAMON booting Linux kernels from malta board harddisk....
Date:	Fri, 21 Sep 2007 19:20:01 +0800
Message-ID: <31E09F73562D7A4D82119D7F6C1729860254C742@sinse303.ap.infineon.com>
In-Reply-To: <46F3A432.4060903@mips.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: YAMON booting Linux kernels from malta board harddisk....
Thread-Index: Acf8PpcEx0b8aURnSRyoDPTzyQ660gAAqOqA
References: <31E09F73562D7A4D82119D7F6C1729860254C469@sinse303.ap.infineon.com> <46F390C5.402@mips.com> <31E09F73562D7A4D82119D7F6C1729860254C65D@sinse303.ap.infineon.com> <46F39A1D.8090101@mips.com> <31E09F73562D7A4D82119D7F6C1729860254C6D6@sinse303.ap.infineon.com> <46F3A432.4060903@mips.com>
From:	<KokHow.Teh@infineon.com>
To:	<beth@mips.com>
Cc:	<linux-mips@linux-mips.org>,
	<Friedrich-Nachtmann.External@infineon.com>, <kurt@mips.com>
X-OriginalArrivalTime: 21 Sep 2007 11:20:02.0617 (UTC) FILETIME=[5A958290:01C7FC41]
Return-Path: <KokHow.Teh@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KokHow.Teh@infineon.com
Precedence: bulk
X-list: linux-mips

Hi Beth
	My question was which partition to put the md.conf? Does it go
with the mb.bin or it can be put at any other partition?

Thanks & Regards,
KH 

-----Original Message-----
From: Elizabeth Oldham [mailto:beth@mips.com] 
Sent: Friday, September 21, 2007 7:00 PM
To: Teh Kok How (IFAP DC COM WL SD)
Cc: linux-mips@linux-mips.org; Nachtmann Friedrich (IFAP DC COM WL SD
External); kurt@mips.com
Subject: Re: YAMON booting Linux kernels from malta board harddisk....

KokHow.Teh@infineon.com wrote:

> /dev/hdd6          8323     10403   1048578+  83  Linux
> 	So I `dd if=mb-0.3.bin of=/dev/hdd6 bs=1024 count=150` and hope
it 
> works. Now there are 2 questions:

It will be easier if you change fdisk's units to sectors, so it prints
the start of the partition for you. I get this from my set up:

Command (m for help): u
Changing display/entry units to sectors

Command (m for help): p

Disk /dev/hda: 80.0 GB, 80026361856 bytes
16 heads, 63 sectors/track, 155061 cylinders, total 156301488 sectors
Units = sectors of 1 * 512 = 512 bytes

    Device Boot      Start         End      Blocks   Id  System
/dev/hda1              63       20159       10048+  83  Linux
/dev/hda2           20160    15646175     7813008   83  Linux
/dev/hda3        15646176    31272191     7813008   83  Linux
/dev/hda4        31272192    72481247    20604528    5  Extended
/dev/hda5        31272255    32249951      488848+  82  Linux swap
/dev/hda6        32250015    47875967     7812976+  83  Linux

So (I think, if there are no gotchas - it's a while since I played with
this stuff) the YAMON command would be:

YAMON> disk read hda 1ec18a0 ff 800d0000; go 800d0000

where 1ec18a0 is (32250015 + 1) in hex.

> (1)	where to put mb.conf?

As it stands the bootloader will look in /dev/hda2 if you are running BE
and /dev/hda3 if LE. For now just try getting MIPSboot to start :)

Beth
