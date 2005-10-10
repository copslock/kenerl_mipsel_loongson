Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Oct 2005 12:46:55 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:20445 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133681AbVJJLqj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Oct 2005 12:46:39 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j9ABkava028769;
	Mon, 10 Oct 2005 13:46:36 +0200 (MEST)
Date:	Mon, 10 Oct 2005 13:46:25 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
cc:	Ralf Baechle <ralf@linux-mips.org>, Carlo Perassi <carlo@linux.it>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: rfc about an uncommented string
In-Reply-To: <434A53D3.1080106@ict.ac.cn>
Message-ID: <Pine.LNX.4.62.0510101344450.5402@numbat.sonytel.be>
References: <20051009134106.GB9091@voyager> <20051010111149.GC2661@linux-mips.org>
 <434A4F27.6010301@ict.ac.cn> <Pine.LNX.4.62.0510101327500.5402@numbat.sonytel.be>
 <434A53D3.1080106@ict.ac.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 10 Oct 2005, Fuxin Zhang wrote:
> Geert Uytterhoeven wrote:
> > On Mon, 10 Oct 2005, Fuxin Zhang wrote:
> >>We are using 8172 for 2.4 kernels presently,although may drop it
> >>sometime later.
> >>
> >>I don't read the 2.6 code,but it seems it remains the same as the copy
> >>in 2.4(except that #ifdef changes).I can't see why the code is broken?
> >>In case you mean the ioport address,mips_io_port_base for that board is
> >>0xa0000000, inb(0x14000060) is reading from 0xb4000060, which is correct
> >>for it.
> > 
> > Shouldn't mips_io_port_base be 0xb4000000 for your board, so inb(0x60) looks
> > more like a PC-style keyboard controller access?
> It is not my code. But anyway the board has more than one discontinuous
> io ranges(0xb4000000 is in fact for it8712 superio and legacy ios,

So 0xb4000000 is the base for ISA and PCI I/O port accesses, right? Hence if
mips_io_port_base is 0xb4000000, all drivers for PCI (and ISA) expansion cards
that use inb() and friends will work.

> it8172's system registers are located around 0xb8000000, while others
> begins at 0xb4010000).

So these can use ITE8172-specific access macros.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
