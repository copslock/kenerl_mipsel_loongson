Received:  by oss.sgi.com id <S42228AbQHZUHu>;
	Sat, 26 Aug 2000 13:07:50 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:2833 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42225AbQHZUHR>;
	Sat, 26 Aug 2000 13:07:17 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 14833822; Sat, 26 Aug 2000 22:10:27 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 802E38FF5; Sat, 26 Aug 2000 22:06:08 +0200 (CEST)
Date:   Sat, 26 Aug 2000 22:06:08 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: decstation boot loader
Message-ID: <20000826220608.J3009@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
i sat down a couple of hours and had a look at current possibilities
of booting the decstations from HD. I am not much further than
i was was before - And now i got a couple of questions probably one
of the more specialised mips hackers might answer.

- The bootblock of the decstation might contain up to 51 extents
  to load from the disks.

  1. Do these extents refer to the start of the disk or the start
     of the probably first partition.

  2. Do i have to set a checksum in the bootblock or does the checksom
     only apply to the disklabel

  3. What binarys is the bootloader able to load. From the BSD sources
     i guess its only raw instructions.

  4. Does the MS-DOS disklabel and the DEC bootblock interfer in any
     kind that its impossible to have a diskloader with MS-DOS Disklabels 

I rewrote the bootprep.c today to play around with loading different binarys.
I added the honor of partition information meaning - The new (i call
it writeboot) looks at the start of the partition and calculates
the extents relativ to the start of the disk. But still i dont get any
results. When trying to boot those partitions with any kind of combination
the prompt only returns to the prom command line.

I thought of a bootloader much like the silo - Capable of reading
an ext2 filesystem via libext2 etc.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
