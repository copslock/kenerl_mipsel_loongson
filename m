Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2004 09:49:05 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:156 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224954AbUAPJtE>;
	Fri, 16 Jan 2004 09:49:04 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i0G9mxoi022181;
	Fri, 16 Jan 2004 10:49:00 +0100 (MET)
Date: Fri, 16 Jan 2004 10:49:00 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Suresh. R" <suresh@mistralsoftware.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: VR4131 - MQ1132 - UPD63335
In-Reply-To: <40079391.7080301@mistralsoftware.com>
Message-ID: <Pine.GSO.4.58.0401161047480.14892@waterleaf.sonytel.be>
References: <40079391.7080301@mistralsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 16 Jan 2004, Suresh. R wrote:
> I am writing a linux device driver for UPD63335 audio codec. Its
> controlled through the MQ1132 co-processor. The VR4131 is the processor.
> The memory of MQ1132 is mapped to the processor memory in Kseg1 (0xA000
> 0000 onwards) which the manual says is TLB Unmapped region. Now my
> question is is it necessary to map this region before using it in Linux.
> Actually I have WinCE code for my reference. In that code the programmer
> is mapping the region using Virtual Cpoy and Virtual Alloc. Is it
> necessary to do that or Can I directly address the memory locatoin.

From the Linux kernel, you can access all memory at 0xa0000000 'till 0xbfffffff
directly.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
