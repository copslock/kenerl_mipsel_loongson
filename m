Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 13:49:42 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:25530 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28578970AbYFLMtk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 13:49:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5CCnLBK005601;
	Thu, 12 Jun 2008 13:49:21 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5CCnK5i005594;
	Thu, 12 Jun 2008 13:49:20 +0100
Date:	Thu, 12 Jun 2008 13:49:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	Daniel Laird <daniel.j.laird@nxp.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] : Add support for =?utf-8?Q?NX?=
	=?utf-8?Q?P_PNX833x_=28STB222=2F5=29_into_linux_kernel=E2=80=8F?=
	(UPDATE)
Message-ID: <20080612124920.GA24343@linux-mips.org>
References: <64660ef00806120529l5c5979a0j6eb81c0dfc36fabb@mail.gmail.com> <200806121441.01705.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200806121441.01705.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2008 at 02:41:00PM +0200, Florian Fainelli wrote:

> Le Thursday 12 June 2008 14:29:47 Daniel Laird, vous avez écrit :
> > linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/gpio.h
> > linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/gpio.h
> > +
> > +/* Initialize GPIO to a known state */
> > +static inline void pnx833x_gpio_init(void)
> > +{
> > +	PNX833X_PIO_DIR = 0;
> > +	PNX833X_PIO_DIR2 = 0;
> > +	PNX833X_PIO_SEL = 0;
> > +	PNX833X_PIO_SEL2 = 0;
> > +	PNX833X_PIO_INT_EDGE = 0;
> > +	PNX833X_PIO_INT_HI = 0;
> > +	PNX833X_PIO_INT_LO = 0;
> 
> It would be better if you for instance map a structure to your PIO registers, 
> like this :
> 
> struct pnx833x_pio_reg {
> 	u32	in;
> 	u32	out;
> 	[..]
> };
> 
> Then the gpio code would ioremap this registers like this in 
> pnx833x_gpio_init :
> 
> 	struct pnx833x_pio_reg *gpio_reg = ioremap_nocache(0xF00, sizeof(struct 
> pnx833x_gpio_reg));
> 	[..]
> 
> So that you could use writel/readl like this :
> 
> 	writel(0, &gpio_reg->in);
> 
> which looks nicer.

Actually for portable drivers the practice of using structs is discouraged.
The alignment rules are not the same on every architecture, so:

struct example {
	u16	var1;
	u32	var2;
};

Would have var2 at offset 2 on m68k but on offset 4 on MIPS.  So hardcoding
the offsets by some other means is preferable for portable code.  As for
this code which is meant to be MIPS only I'd not be religous but it's good
practice to try to always write portable code.

  Ralf
