Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2004 17:45:56 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:13828
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8225203AbUJPQpt>;
	Sat, 16 Oct 2004 17:45:49 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9GGjbA17957;
	Sat, 16 Oct 2004 09:45:37 -0700
Message-ID: <4171501D.5040506@embeddedalley.com>
Date: Sat, 16 Oct 2004 09:45:17 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ??? <Mickey@turtle.ee.ncku.edu.tw>
CC: linux-mips@linux-mips.org
Subject: Re: Is there any means to use Cramfs and JFFS2 images as root disks?
References: <20041015174542.20487.qmail@web81008.mail.yahoo.com> <004201c4b331$f9f6b180$7101a8c0@dinosaur>
In-Reply-To: <004201c4b331$f9f6b180$7101a8c0@dinosaur>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

??? wrote:
> Hi Pete,
> How do I compile JFFS2 image and Kernel image together and by that way
> Kernel can know where /dev/mtdblock3 is?

I'm not sure a brief answer will help you, but here it is.

You don't compile "jffs2 image and kernel image" together. You select 
jffs2 support in the kernel when you run something like "make 
menuconfig". You rebuild the kernel and now your kernel will have jffs2 
support. You also need your kernel to have mtd support, since that's how 
you'll access /dev/mtdblockxxxx. You then build a jffs2 image, put it in 
flash in whatever partition you want or have space for, and then boot 
the kernel with "root=/dev/mtdblockxxx".

> And if I want to just write JFFS2 image to Flash, how do I do on YAMON?

Yes, you can, but I don't remember the commands off the top of my head. 
On the Au1x boards, you can use yamon to erase the flash and load srec 
files directly to flash. You may also be able to load a binary file and 
store it in flash which would make it easier. Finally, you can build a 
kernel with NFS root file system, or a ramdisk, etc, -- something other 
than jffs2. Then, you can use the linux kernel to erase the mtd 
partition where you want a jffs2 image, and then copy the image to that 
partition.

> Can also I use Cramfs as root when boot up, like JFFS2?

Yes, you can. The same steps above apply.

Pete
