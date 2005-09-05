Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2005 12:35:10 +0100 (BST)
Received: from smtp010.tiscali.dk ([IPv6:::ffff:212.54.64.103]:51646 "EHLO
	smtp010.tiscali.dk") by linux-mips.org with ESMTP
	id <S8224982AbVIELeu> convert rfc822-to-8bit; Mon, 5 Sep 2005 12:34:50 +0100
Received: from jorg ([62.79.30.245])
	by smtp010.tiscali.dk (8.12.10/8.12.10) with ESMTP id j85BfYnW009084
	for <linux-mips@linux-mips.org>; Mon, 5 Sep 2005 13:41:34 +0200 (MEST)
From:	=?iso-8859-1?Q?J=F8rg_Ulrich_Hansen?= <jh@hansen-telecom.dk>
To:	<linux-mips@linux-mips.org>
Subject: Re: Howto Boot from Flash with the Alchemy AU1100
Date:	Mon, 5 Sep 2005 13:41:34 +0200
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAb4ajDk58bkCNi0V1ZTQFHIKAAAAQAAAAS0TGHpU5zUWTXqf0fsiG9AEAAAAA@hansen-telecom.dk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Thread-Index: AcWyDsR7yEipV1BPSZWRu+EDn8ApGw==
Return-Path: <jh@hansen-telecom.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jh@hansen-telecom.dk
Precedence: bulk
X-list: linux-mips


Start linux from flash at startup
The boot loader can be set up to automatically start Linux at power up.

Do the following:
To load kernel image into RAM on mb1100 type:
load

Then the image has to be copied to FLASH.
Erase block in FLASH:
erase bfd00000 2c0000

Copy image from RAM to FLASH:
copy a0100000 bfd00000 2c0000

When YAMON starts up it will process the start command, so that has to be
set up.
The kernel_entry address is not fixed so the start address has to be set up
for each new kernel
image. The start address can be read from the srec image file or it is
printed on the screen after
the load image command.

To set the start command:
set start 'copy bfd00000 a0100000 2c0000; go a032b018 \
root=/dev/mtdblock0 rootfstype=jffs2'


Start Linux with root file system mounted as jffs2
In a real world the root file system will normally be located in the FLASH
memory as a jffs2
partition. 
We will now copy a jffs2 image with the root file system to the FLASH.

From YAMON prompt do following:
Fill 16 MB of RAM with FF:
fill a1000000 1000000 ff
Load image into RAM:
load tftp://192.168.21.33/rootfs.srec
Erase 16MB in FLASH:
erase be000000 1000000
Copy 4MB from RAM to FLASH
copy a1000000 be000000 400000
If the image is bigger than 4MB please copy the appropriate size.

Now it should be ready to press reset.

If it prints a lot of text Linux starts correctly
If it prints ‘kernel panic’ in the end then it failed to mount the root file
system

This is based on a CPU module mb1100 that is similar to db1100.
More information about au1100 running Linux can be found at
http://www.mechatronicbrick.dk

Kind regards Jorg
