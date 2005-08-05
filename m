Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Aug 2005 15:17:17 +0100 (BST)
Received: from mail.spb.artcoms.ru ([IPv6:::ffff:82.114.120.253]:31372 "EHLO
	mrelay.spb.artcoms.ru") by linux-mips.org with ESMTP
	id <S8225750AbVHEORC>; Fri, 5 Aug 2005 15:17:02 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mrelay.spb.artcoms.ru (Postfix) with ESMTP
	id A3F0B132F3; Fri,  5 Aug 2005 18:20:34 +0400 (MSD)
Received: from mrelay.spb.artcoms.ru ([127.0.0.1])
 by localhost (megera.artcoms.ru [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09127-08; Fri,  5 Aug 2005 18:20:34 +0400 (MSD)
Received: from ALEC (unknown [192.168.249.108])
	by mrelay.spb.artcoms.ru (Postfix) with SMTP
	id 8609B132EF; Fri,  5 Aug 2005 18:20:34 +0400 (MSD)
Message-ID: <013601c599c9$1fe2ca40$6cf9a8c0@ALEC>
Reply-To: "Alexander Voropay" <alec@artcoms.ru>
From:	"Alexander Voropay" <alec@artcoms.ru>
To:	"inpreet" <singh.inpreet@netsity.com>, <linux-mips@linux-mips.org>
References: <01a901c599a4$2f855280$3c67a8c0@netsity.com>
Subject: Re: Ramdisk issue please help!!!
Date:	Fri, 5 Aug 2005 18:22:31 +0400
Organization: Art Communications
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Virus-Scanned: by amavisd-new at spb.artcoms.ru
Return-Path: <alec@artcoms.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alec@artcoms.ru
Precedence: bulk
X-list: linux-mips

"inpreet" <singh.inpreet@netsity.com> wrote:

>I am trying to build ramdisk image and launch bootsplash image at boot time. 
>Steps I followed:
>1. get splash image initrd.splash using splash binary.
...
>8. results in initrd.gz
>
>Now while compiling kernel image I am embedding initrd.gz into it. Here is what I am doing

 You don't need nothing special for *embedded *, not external "MIPS initrd" on a 2.4 kernels.
It works just fine from the CVS.

1) Prepare your "ramdisk.img" with EXT2FS/other FS
2) gzip it.
3) Put this "ramdisk.gz" into the  arch/mips/ramdisk/
4) Enable in the configfile :

CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y

CONFIG_EMBEDDED_RAMDISK=y
CONFIG_EMBEDDED_RAMDISK_IMAGE="ramdisk.gz"

5) make . Kernel build system will find this image automagically.

6) Run this kernel (vmlinux) without a "root=" parameter.

There is example of my kernel bootlog:

...
Determined physical RAM map:
 memory: 01800000 @ 00000000 (usable)
Initial ramdisk at: 0x801b1000 (593920 bytes)
...
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
...
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 580k freed
VFS: Mounted root (ext2 filesystem) readonly.
...

root FS is mouned now as /dev/ram0

--
-=AV=-
