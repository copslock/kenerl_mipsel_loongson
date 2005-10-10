Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Oct 2005 12:29:24 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:5082 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133471AbVJJL3B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Oct 2005 12:29:01 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j9ABStva028230;
	Mon, 10 Oct 2005 13:28:55 +0200 (MEST)
Date:	Mon, 10 Oct 2005 13:28:43 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
cc:	Ralf Baechle <ralf@linux-mips.org>, Carlo Perassi <carlo@linux.it>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: rfc about an uncommented string
In-Reply-To: <434A4F27.6010301@ict.ac.cn>
Message-ID: <Pine.LNX.4.62.0510101327500.5402@numbat.sonytel.be>
References: <20051009134106.GB9091@voyager> <20051010111149.GC2661@linux-mips.org>
 <434A4F27.6010301@ict.ac.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 10 Oct 2005, Fuxin Zhang wrote:
> We are using 8172 for 2.4 kernels presently,although may drop it
> sometime later.
> 
> I don't read the 2.6 code,but it seems it remains the same as the copy
> in 2.4(except that #ifdef changes).I can't see why the code is broken?
> In case you mean the ioport address,mips_io_port_base for that board is
> 0xa0000000, inb(0x14000060) is reading from 0xb4000060, which is correct
> for it.

Shouldn't mips_io_port_base be 0xb4000000 for your board, so inb(0x60) looks
more like a PC-style keyboard controller access?

> Ralf Baechle wrote:
> > On Sun, Oct 09, 2005 at 03:41:06PM +0200, Carlo Perassi wrote:
> >>As suggested (*) by Arthur Othieno on the kernel-janitors mailing list,
> >>I bounce here this email for collecting comments.
> >>The old email refers to 2.6.13-rc6 but the code is still the same on
> >>2.6.14-rc3.
> >>Thank you.
> >>
> >>Hi.
> >>
> >>I'd like to collect some comments about the following code
> >>segment I found in
> >>linux-2.6.13-rc6/arch/mips/ite-boards/generic/it8172_setup.c
> >>(the "^^^" sequence is not mine, it's in the code)
> > 
> > 
> > I know, I put it there.  The code was obviously broken, so I place this
> > hard to miss not right into the middle of it.  It's there since ages and
> > nobody did complain.  So unless somebody complains - and that complaint
> > better include some patches - I will delete support for the IT8172 and
> > it's eval board.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
