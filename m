Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 12:50:15 +0000 (GMT)
Received: from smtp-102.noc.nerim.net ([IPv6:::ffff:62.4.17.102]:5129 "EHLO
	mallaury.noc.nerim.net") by linux-mips.org with ESMTP
	id <S8225193AbTBJMuO>; Mon, 10 Feb 2003 12:50:14 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by mallaury.noc.nerim.net (Postfix) with ESMTP id 4847562E43
	for <linux-mips@linux-mips.org>; Mon, 10 Feb 2003 13:50:12 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18iDOI-0000RT-00
	for <linux-mips@linux-mips.org>; Mon, 10 Feb 2003 13:50:30 +0100
Date: Mon, 10 Feb 2003 13:50:30 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: linux-mips@linux-mips.org
Subject: Re: porting arcboot
Message-ID: <Pine.LNX.4.21.0302101350050.1117-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

---------- Forwarded message ----------
Date: Mon, 10 Feb 2003 13:49:49 +0100 (CET)
From: Vivien Chappelier <glaurung@vivienc.net1.nerim.net>
To: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
Subject: Re: porting arcboot

On Mon, 10 Feb 2003, Guido Guenther wrote:
> > Can't we read the load address (and needed space) from the elf header
> s/load address/kernel's load address/

Yes, that's what we do already. I was speaking of arcboot load address,
sorry this wasn't very clear :)

> In case we find a unique place for arcboot in the memory map of the
> different subarches.

On the O2 physical memory starts from KSEG0 (0x80000000), the kernel is
loaded there for 32-bit version or in XKPHYS (0x9800000000000000) for the
64-bit version. I don't really know where the PROM code and data is
located precisely, but loading something (arcboot or a kernel) at
0x88000000 as with ip22 is not an option; the PROM says something like
'loading there would overwrite an existing program'. Why is kernel/arcboot
loaded at 0x88000000 on ip22? Is KSEG0 an option for ip22?
BTW, what's the status of mips64/ip22? I guess the PROM doesn't support
64-bit as on the ip32, so arcboot with 64-bit support would be needed as
well, right?

Vivien.
