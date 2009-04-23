Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 01:51:48 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.247]:5445 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20044267AbZDWAs4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Apr 2009 01:48:56 +0100
Received: by rv-out-0708.google.com with SMTP id k29so193344rvb.24
        for <multiple recipients>; Wed, 22 Apr 2009 17:48:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ZzlBw7nT+V8iVp3G+vMcJsiytFDCQpMOLLpOmXkUEMY=;
        b=iTZ7vfegZGfyU4rqXLLbXqqVbLU4xeCzfVKP+fmsp56YuSMNEN7s+01MqFutWw187U
         VnNBp4/O1oD1OerJ1KH1UU5lG8NsjkOxbhWfDH5S4lz4zsd7guq3y3UypwhNlaU6fzsF
         tOhy+PeWLmvvMFfaIIPgkWHkcLsxHcpFGpbE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=nxABjkT2TpqsL3gwSypPQWo59WU7Q3jXBENzE1eQV3o7+jFxkQakXnPrwXV6pENW5e
         aA5ptLiT9SsXJHscfm0mDKbPbpe6CHFaGpC9D9a8cYzIX6JhrWJ37TqPbWLgrsOEqj9r
         Ist/ZBYFT1l58EnjjmPT/bg2hPaPubHcGWNvI=
Received: by 10.114.67.17 with SMTP id p17mr174538waa.49.1240447731967;
        Wed, 22 Apr 2009 17:48:51 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id l37sm893356waf.40.2009.04.22.17.48.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 17:48:51 -0700 (PDT)
Subject: Re: [PATCH] Clean up Lemote Loongson 2E Support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	Philippe Vachon <philippe@cowpig.ca>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <m363gxgic8.fsf@anduin.mandriva.com>
References: <20090422063747.GA2009@cowpig.ca>
	 <m363gxgic8.fsf@anduin.mandriva.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 23 Apr 2009 08:48:28 +0800
Message-Id: <1240447708.24610.13.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-04-22 at 11:15 +0200, Arnaud Patard wrote:
> Philippe Vachon <philippe@cowpig.ca> writes:
> 
> Hi,
> 
> > This patch eliminates magic numbers and adds accessors for memory-mapped
> > registers. As well, it removes some inline assembly and restructures how
> > the early printk code behaves.
> >
> > Signed-off-by: Philippe Vachon <philippe@cowpig.ca>
> > ---
> >  arch/mips/include/asm/mach-lemote/loongson2e.h |   60 +++++++++++
> >  arch/mips/lemote/lm2e/dbg_io.c                 |  125 ++---------------------
> >  arch/mips/lemote/lm2e/prom.c                   |   10 +--
> >  arch/mips/lemote/lm2e/reset.c                  |   18 ++--
> >  4 files changed, 82 insertions(+), 131 deletions(-)
> >  create mode 100644 arch/mips/include/asm/mach-lemote/loongson2e.h
> >
> > diff --git a/arch/mips/include/asm/mach-lemote/loongson2e.h b/arch/mips/include/asm/mach-lemote/loongson2e.h
> > new file mode 100644
> > index 0000000..82c1a95
> > --- /dev/null
> > +++ b/arch/mips/include/asm/mach-lemote/loongson2e.h
> > @@ -0,0 +1,60 @@
> > +/* Accessor functions for the Loongson 2E MMIO registers
> > + *
> > + * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
> > + *
> > + * This program is free software; you can redistribute  it and/or modify it
> > + * under  the terms of  the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + *
> > + */
> > +#ifndef __ASM_MACH_LEMOTE_LOONGSON2E
> > +#define __ASM_MACH_LEMOTE_LOONGSON2E
> > +
> > +#include <linux/types.h>
> > +
> > +/* Loongson 2E Control Registers */
> > +#define LS2E_REG_BASE		0x1fe00100 /* start of config registers */
> > +#define LS2E_GENCFG_REG		(LS2E_REG_BASE + 0x04)
> > +
> > +#define LS2E_RESET_VECTOR	0x1fc00000 /* this should be obvious! */
> > +
> 
> Theses are neither Lemote nor 2E specifics. 2E and 2F controllers are
> very similar (and they're similar to the bonito stuff). Why do you need
> a specific header instead of using the Bonito64.h header for theses
> constants ? And if you really want to create it, please rename all to
> loongson and remove lemote references as it'll work on 2F and on boards
> from ST.
> 

I am working on merging the source code of fuloong+yeeloong(2f based)
and 2e, currently, the source code of fuloong & yeeloong have been
merged, and now, I am trying to merge 2e & 2f, lots of duplications have
been removed with the import of some new header files, and some MACROs,
Variables have been tuned. a first release may be out to dev.lemote.com
before this weekend. 

> > +/* UART address (16550 -- on the Fulong) */
> > +#define LS2E_UART_BASE		0x1fd003f8
> 
> It happens to be 0x1fd003f8 but it could have been at a different
> address base. For instance, on 2f, depending on the board, there's
> 0x1ff003f8 and 0x1fd003f8 (I think there's also some board with a
> different address than theses but I'm not sure).
> 

in fuloong(2f) & yeeloong(2f), the serial address is 0xbfd002f8, in
fuloong(2e), the serial address is 0xbfd003f8.

> > +/* Various system parameters passed from PMON */
> > +extern unsigned long bus_clock;
> > +extern unsigned long cpu_clock_freq;
> > +extern unsigned int memsize, highmemsize;
> > +
> > +static inline void ls2e_writeb(uint8_t value, unsigned long addr)
> > +{
> > +	*(volatile uint8_t *)addr = value;
> > +}
> > +
> 
> What about readl/writel and friends ?
> [...]
> 
> > -void debugInit(u32 baud, u8 data, u8 parity, u8 stop)
> > +void prom_putchar(char c)
> >  {
> > -	u32 divisor;
> > -
> > -	/* disable interrupts */
> > -	UART16550_WRITE(OFS_INTR_ENABLE, 0);
> > +	int timeout;
> > +	phys_addr_t uart_base = (phys_addr_t)ioremap_nocache(LS2E_UART_BASE, 8);
> > +	char reg = ls2e_readb(uart_base + UART_LSR) & UART_LSR_THRE;
> 
> hmm... I may be wrong on that but using ioremap looks here looks not a
> good idea. This code is called by early_printk so you can end up calling
> it very early in the boot process.
> Also, you're calling ioremap everytime this function is called. Why
> don't you do that only the first time ?
> 
> [...]
> 
> > diff --git a/arch/mips/lemote/lm2e/reset.c b/arch/mips/lemote/lm2e/reset.c
> > index 099387a..0989d28 100644
> > --- a/arch/mips/lemote/lm2e/reset.c
> > +++ b/arch/mips/lemote/lm2e/reset.c
> > @@ -7,20 +7,22 @@
> >   * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
> >   * Author: Fuxin Zhang, zhangfx@lemote.com
> >   */
> > +
> >  #include <linux/pm.h>
> > +#include <linux/io.h>
> > +#include <loongson2e.h>
> >  
> >  #include <asm/reboot.h>
> >  
> >  static void loongson2e_restart(char *command)
> >  {
> > -#ifdef CONFIG_32BIT
> > -	*(unsigned long *)0xbfe00104 &= ~(1 << 2);
> > -	*(unsigned long *)0xbfe00104 |= (1 << 2);
> > -#else
> > -	*(unsigned long *)0xffffffffbfe00104 &= ~(1 << 2);
> > -	*(unsigned long *)0xffffffffbfe00104 |= (1 << 2);
> > -#endif
> > -	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
> > +	uint32_t ctl =
> > +		(ls2e_readl((phys_addr_t)ioremap_nocache(LS2E_GENCFG_REG, 4))
> > +		& ~(1 << 2)) | 1 << 2;
> > +
> > +	ls2e_writel(ctl, (phys_addr_t)ioremap_nocache(LS2E_GENCFG_REG, 4));
> > +
> > +	((void (*)(void))ioremap_nocache(LS2E_RESET_VECTOR, 4))();
> 
> same remark as for the serial stuff. I'm really not sure that calling ioremap
> in such a place is a good idea (say, you've panic'ed and booted with
> panic=3, will this still work ?).
> 
> 
> Arnaud
> 
