Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 12:40:30 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:19380 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225196AbTDVLk3>;
	Tue, 22 Apr 2003 12:40:29 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0p/8.8.6) with ESMTP id NAA27285;
	Tue, 22 Apr 2003 13:40:20 +0200 (MET DST)
Date: Tue, 22 Apr 2003 13:40:19 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Juan Quintela <quintela@mandrakesoft.com>,
	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] TANBAC TB0226(NEC VR4131) for v2.5
In-Reply-To: <20030422133642.A15285@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0304221338360.16017-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 22 Apr 2003, Ralf Baechle wrote:
> On Tue, Apr 22, 2003 at 01:17:21PM +0200, Juan Quintela wrote:
> > yoichi> +static struct resource vr41xx_pci_mem_resource = {
> > yoichi> +	"PCI memory space",
> > yoichi> +	VR41XX_PCI_MEM_START,
> > yoichi> +	VR41XX_PCI_MEM_END,
> > yoichi> +	IORESOURCE_MEM
> > yoichi> +};
> > 
> > Please, use C99 named initializers in the whole file.
> 
> I don't think there's much point in using ISO style initializers everywhere.
> So far the convention is only to replace the GNU-style inializer.
> We unfortunately have a few places where the code got inflated by at least
> the factor of 3 because now some code uses the ISO initializers for
> everything - for no good reason.

What if someone will change struct resource in the future?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
