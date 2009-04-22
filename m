Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 02:38:25 +0100 (BST)
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:51860 "EHLO
	stout.engsoc.carleton.ca") by ftp.linux-mips.org with ESMTP
	id S20037216AbZDVQQr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 17:16:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id DC5805840B3;
	Wed, 22 Apr 2009 12:16:38 -0400 (EDT)
Received: from stout.engsoc.carleton.ca ([127.0.0.1])
	by localhost (stout.engsoc.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KOxahkMgfZZf; Wed, 22 Apr 2009 12:16:38 -0400 (EDT)
Received: from mobius.cowpig.ca (cowpig.ca [134.117.69.79])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id B5ED3584099;
	Wed, 22 Apr 2009 12:16:38 -0400 (EDT)
Received: by mobius.cowpig.ca (Postfix, from userid 1000)
	id BFBEE16018B; Wed, 22 Apr 2009 12:16:31 -0400 (EDT)
Date:	Wed, 22 Apr 2009 12:16:31 -0400
From:	Philippe Vachon <philippe@cowpig.ca>
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Clean up Lemote Loongson 2E Support
Message-ID: <20090422161631.GA2317@cowpig.ca>
References: <20090422063747.GA2009@cowpig.ca> <m363gxgic8.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m363gxgic8.fsf@anduin.mandriva.com>
User-Agent: Mutt/1.5.9i
Return-Path: <philippe@cowpig.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippe@cowpig.ca
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, Apr 22, 2009 at 11:15:19AM +0200, Arnaud Patard wrote:
> 
> Theses are neither Lemote nor 2E specifics. 2E and 2F controllers are
> very similar (and they're similar to the bonito stuff). Why do you need
> a specific header instead of using the Bonito64.h header for theses
> constants ? And if you really want to create it, please rename all to
> loongson and remove lemote references as it'll work on 2F and on boards
> from ST.
> 

What might be worthwhile eventually is to move all the loongson code into
arch/mips/loongson. I know there is some duplication of code between 2F
and 2E as it stands, but since 2F isn't upstream yet (and probably won't
be for a while), I would cross that bridge when we get there.

Given how Loongson actually differs a lot from Bonito64 beyond a few of
the control registers' addresses, perhaps it is worthwhile to start
moving away from using bonito64.h anyways; it's a bit odd that ICT chose
to base some of the SoC on the Bonito64 design, IMO, but that's a
different conversation.

> > +/* UART address (16550 -- on the Fulong) */
> > +#define LS2E_UART_BASE		0x1fd003f8
> 
> It happens to be 0x1fd003f8 but it could have been at a different
> address base. For instance, on 2f, depending on the board, there's
> 0x1ff003f8 and 0x1fd003f8 (I think there's also some board with a
> different address than theses but I'm not sure).
> 

One option I was thinking of was moving that into a device-specific
header. However, of the two Loongson 2E devices I have, both have the
UART at the same address -- are there any Loongson 2E devices that have
the UART at a different location? None that I'm aware of (and on the 2F
side, I only know of the Gdium).

...

> > +static inline void ls2e_writeb(uint8_t value, unsigned long addr)
> > +{
> > +	*(volatile uint8_t *)addr = value;
> > +}
> > +
> 
> What about readl/writel and friends ?
> 

I'm ambivalent. Since they're sub-64-bit-wide reads/writes, they're
happening in a single instruction anyways. I can adjust the patch to use
them in the name of reducing code duplication.

> hmm... I may be wrong on that but using ioremap looks here looks not a
> good idea. This code is called by early_printk so you can end up calling
> it very early in the boot process.
> Also, you're calling ioremap everytime this function is called. Why
> don't you do that only the first time ?
> 
> [...]

Quite wrong -- as the address is in kseg1, when compiled this actually
will end up having the same net effect as using the 'deprecated'
CKSEG1ADDR() macro. Have a look at the implementation of
__ioremap_mode() in arch/mips/include/asm/io.h. While it's being
'called' early in the boot process, the physical resource will be 
accessed via its kseg1 address. When I was speaking to Ralf about this, 
he had mentioned this was by design.

In looking at the disassembly of prom_putchar in particular:

; ioremap_nocache()
li      $v0, 0xFFFFFFF9 
dsll32  $v0, 8
ori     $v0, 0x1FD
dsll    $v0, 20
ori     $v0, 0x3FD

; load from the UART's LSR register:
lbu     $v1, 0($v0)
...

> same remark as for the serial stuff. I'm really not sure that calling ioremap
> in such a place is a good idea (say, you've panic'ed and booted with
> panic=3, will this still work ?).
> 

Yes. See above.

I'll probably send an updated patch shortly.

Cheers,
Phil
