Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 14:37:01 +0000 (GMT)
Received: from smtp-102.nerim.net ([IPv6:::ffff:62.4.16.102]:31505 "EHLO
	kraid.nerim.net") by linux-mips.org with ESMTP id <S8225202AbTBJOhB>;
	Mon, 10 Feb 2003 14:37:01 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by kraid.nerim.net (Postfix) with ESMTP
	id A83FE414D4; Mon, 10 Feb 2003 15:36:58 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18iF3d-0000gX-00; Mon, 10 Feb 2003 15:37:17 +0100
Date: Mon, 10 Feb 2003 15:37:16 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: linux-mips@linux-mips.org
Cc: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
Subject: Re: porting arcboot
Message-ID: <Pine.LNX.4.21.0302101533410.1709-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

> P.S.: you didn't cc: linux-mips, feel free to forward this mail there if
> appropriate

It's just I forgot the Reply-all :)
I'll look into what you mention and how to implement it tonight.

Vivien.

---------- Forwarded message ----------
Date: Mon, 10 Feb 2003 14:38:06 +0100
From: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
To: Vivien Chappelier <vivienc@nerim.net>
Subject: Re: porting arcboot

On Mon, Feb 10, 2003 at 01:49:49PM +0100, Vivien Chappelier wrote:
> Yes, that's what we do already. I was speaking of arcboot load address,
> sorry this wasn't very clear :)
That's actually not what we do, at least not consistently. We parse the
load address from the elf header but also assume a reserved space
(reserver_base/reserve_size in loader.c).

> > In case we find a unique place for arcboot in the memory map of the
> > different subarches.
> 
> On the O2 physical memory starts from KSEG0 (0x80000000), the kernel is
> loaded there for 32-bit version or in XKPHYS (0x9800000000000000) for the
> 64-bit version. I don't really know where the PROM code and data is
> located precisely, but loading something (arcboot or a kernel) at
> 0x88000000 as with ip22 is not an option; the PROM says something like
I don't have the Indy's documentation around but I think the space between
0x80000000 and 0x88000000 is reserved for EISA (which only the I2
actually has). Anyways, I'd be nice to get rid of reserve_{base,size}
first, we could then build a unique loader and maybe simply adjust the
loader's load address using objcopy upon installation in the vh, so we
get away with a single binary for 32bit.

> 'loading there would overwrite an existing program'. Why is kernel/arcboot
> loaded at 0x88000000 on ip22? Is KSEG0 an option for ip22?
> BTW, what's the status of mips64/ip22? I guess the PROM doesn't support
Don't know, wanted to look at this together with getting 2.5 a bit further but
my Indys hard disk went up in flames a week a ago (hard disks are
currently failing around me like crazy).
> 64-bit as on the ip32, so arcboot with 64-bit support would be needed as
> well, right?
Thiemo told me that his R10k I2s PROM only loads 64bit executables.
Don't know if the rest of IP22 can laod 64bit executables at all.
 - Guido
