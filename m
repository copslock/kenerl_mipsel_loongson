Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2004 18:42:04 +0100 (BST)
Received: from msr40.hinet.net ([IPv6:::ffff:168.95.4.140]:4068 "EHLO
	msr40.hinet.net") by linux-mips.org with ESMTP id <S8225305AbUJPRl5>;
	Sat, 16 Oct 2004 18:41:57 +0100
Received: from dinosaur (218-168-152-123.dynamic.hinet.net [218.168.152.123])
	by msr40.hinet.net (8.9.3/8.9.3) with SMTP id BAA12324;
	Sun, 17 Oct 2004 01:41:35 +0800 (CST)
Message-ID: <004b01c4b3a7$6193e810$7101a8c0@dinosaur>
From: "???" <Mickey@turtle.ee.ncku.edu.tw>
To: "Pete Popov" <ppopov@embeddedalley.com>
Cc: <linux-mips@linux-mips.org>
References: <20041015174542.20487.qmail@web81008.mail.yahoo.com> <004201c4b331$f9f6b180$7101a8c0@dinosaur> <4171501D.5040506@embeddedalley.com>
Subject: Re: Is there any means to use Cramfs and JFFS2 images as root disks?
Date: Sun, 17 Oct 2004 01:41:33 +0800
Organization: III
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Return-Path: <Mickey@turtle.ee.ncku.edu.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Mickey@turtle.ee.ncku.edu.tw
Precedence: bulk
X-list: linux-mips


----- Original Message ----- 
From: "Pete Popov" <ppopov@embeddedalley.com>
To: "???" <Mickey@turtle.ee.ncku.edu.tw>
Cc: <linux-mips@linux-mips.org>
Sent: Sunday, October 17, 2004 12:45 AM
Subject: Re: Is there any means to use Cramfs and JFFS2 images as root
disks?


> ??? wrote:
> > Hi Pete,
> > How do I compile JFFS2 image and Kernel image together and by that way
> > Kernel can know where /dev/mtdblock3 is?
>
> I'm not sure a brief answer will help you, but here it is.
>
> You don't compile "jffs2 image and kernel image" together. You select
> jffs2 support in the kernel when you run something like "make
> menuconfig". You rebuild the kernel and now your kernel will have jffs2
> support. You also need your kernel to have mtd support, since that's how
> you'll access /dev/mtdblockxxxx. You then build a jffs2 image, put it in
> flash in whatever partition you want or have space for, and then boot
> the kernel with "root=/dev/mtdblockxxx".

My question still exists: YAMON doesn't know where /dev/mtdblock3 is...
How do I put JFFS2 image by YAMON onto the right location in Flash... :-)

>
> > And if I want to just write JFFS2 image to Flash, how do I do on YAMON?
>
> Yes, you can, but I don't remember the commands off the top of my head.
> On the Au1x boards, you can use yamon to erase the flash and load srec
> files directly to flash. You may also be able to load a binary file and
> store it in flash which would make it easier. Finally, you can build a
> kernel with NFS root file system, or a ramdisk, etc, -- something other
> than jffs2. Then, you can use the linux kernel to erase the mtd
> partition where you want a jffs2 image, and then copy the image to that
> partition.
>

Great! This is a good idea.
I can already boot up Linux with NFS root.
I'll give it a try to write JFFS2 root image to /dev/mtdblock on Linux
system, not on YAMON.

> > Can also I use Cramfs as root when boot up, like JFFS2?
>
> Yes, you can. The same steps above apply.
>
> Pete

Thanks and regards,
Colin
