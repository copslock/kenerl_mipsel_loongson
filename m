Received:  by oss.sgi.com id <S42281AbQH0RU2>;
	Sun, 27 Aug 2000 10:20:28 -0700
Received: from mail.ivm.net ([62.204.1.4]:3954 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S42253AbQH0RT6>;
	Sun, 27 Aug 2000 10:19:58 -0700
Received: from franz.no.dom (port89.duesseldorf.ivm.de [195.247.65.89])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id TAA07373;
	Sun, 27 Aug 2000 19:19:06 +0200
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.000827191949.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20000826220608.J3009@paradigm.rfc822.org>
Date:   Sun, 27 Aug 2000 19:19:49 +0200 (CEST)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Florian Lohoff <flo@rfc822.org>
Subject: RE: decstation boot loader
Cc:     linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Flo,

On 26-Aug-00 Florian Lohoff wrote:
> i sat down a couple of hours and had a look at current possibilities
> of booting the decstations from HD. I am not much further than
> i was was before - And now i got a couple of questions probably one
> of the more specialised mips hackers might answer.
> 
> - The bootblock of the decstation might contain up to 51 extents
>   to load from the disks.
>
>   1. Do these extents refer to the start of the disk or the start
>      of the probably first partition.

The PROM knows nothing about partitions or such so these extends refer obviously
to the start of the disk.
 
>   2. Do i have to set a checksum in the bootblock or does the checksom
>      only apply to the disklabel

The PROM doesn't even know anything about a checksum.
 
>   3. What binarys is the bootloader able to load. From the BSD sources
>      i guess its only raw instructions.

Yes. "mipsel-linux-objcopy --output-target=binary" is your friend.
 
>   4. Does the MS-DOS disklabel and the DEC bootblock interfer in any
>      kind that its impossible to have a diskloader with MS-DOS Disklabels 

No, that should work as long as the the the boot map is short enough not to
overwrite the partition information.
 
> I rewrote the bootprep.c today to play around with loading different binarys.
> I added the honor of partition information meaning - The new (i call
> it writeboot) looks at the start of the partition and calculates
> the extents relativ to the start of the disk. But still i dont get any
> results. When trying to boot those partitions with any kind of combination
> the prompt only returns to the prom command line.

I have successfully booted Linux kernels with bootprep. Depending on the code you
want to load, for example a second stage bootloader, you may need to adjust
"boot_block->loadAddr" and "boot_block->execAddr".
 
> I thought of a bootloader much like the silo - Capable of reading
> an ext2 filesystem via libext2 etc.

That's what I always wanted to do but I never found the time...

-- 
Regards,
Harald
