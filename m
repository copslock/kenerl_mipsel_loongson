Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2003 12:03:56 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:47517 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225211AbTAUKtt>;
	Tue, 21 Jan 2003 10:49:49 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA01279;
	Tue, 21 Jan 2003 11:45:16 +0100 (MET)
Date: Tue, 21 Jan 2003 11:45:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Krishnakumar. R" <krishnakumar@naturesoft.net>
cc: santosh kumar gowda <ipv6_san@rediffmail.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Linux kernel for MIPS architecture
In-Reply-To: <200301211228.47766.krishnakumar@naturesoft.net>
Message-ID: <Pine.GSO.4.21.0301211143430.24563-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1196
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 21 Jan 2003, Krishnakumar. R wrote:
> Change the following in the top level makefile
> 
> CROSS_COMPILE=mipsel-linux-
> ARCH=mips

Or always say `make CROSS_COMPILE=mipsel-linux- ARCH=mips' instead of `make'.

> And change the link 
> include/asm
> of the top directory to point to
> the asm-mips there.

Changing the link is not necessay. `make config' will do that for you.

> Then try configuring and compiling the kernel
> as usual.

> On Tuesday 21 January 2003 10:00 am, you wrote:
> > I want to compile the entire Linux Kernel 2.4.20
> > for MIPS architecture.

And most probably you'll want to use the kernel source tree from Linux/MIPS
CVS, not the one on ftp.kernel.org.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
