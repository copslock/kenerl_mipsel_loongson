Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2007 08:00:11 +0100 (BST)
Received: from hoboe2bl1.telenet-ops.be ([195.130.137.73]:44227 "EHLO
	hoboe2bl1.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022571AbXHVHAJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Aug 2007 08:00:09 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hoboe2bl1.telenet-ops.be (Postfix) with SMTP id A3DFC124035;
	Wed, 22 Aug 2007 08:59:58 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by hoboe2bl1.telenet-ops.be (Postfix) with ESMTP id 722F312402D;
	Wed, 22 Aug 2007 08:59:57 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-8) with ESMTP id l7M6xvHL011797
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Aug 2007 08:59:57 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l7M6xtOA011794;
	Wed, 22 Aug 2007 08:59:56 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 22 Aug 2007 08:59:55 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	brm <brm@murphy.dk>, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add back support for LASAT platforms
In-Reply-To: <20070822101425.430da249.yoichi_yuasa@tripeaks.co.jp>
Message-ID: <Pine.LNX.4.64.0708220858290.9716@anakin>
References: <200708212034.l7LKYGiD011023@potty.localnet>
 <20070822101425.430da249.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 22 Aug 2007, Yoichi Yuasa wrote:
> On Tue, 21 Aug 2007 22:34:16 +0200
> brm <brm@murphy.dk> wrote:
> 
> > Add back support for LASAT platforms.
> > 
> > Signed-off-by: Brian Murphy <brian@murphy.dk>
> 
> <snip>
> 
> > diff --git a/arch/mips/lasat/Kconfig b/arch/mips/lasat/Kconfig
> > new file mode 100644
> > index 0000000..1d2ee8a
> > --- /dev/null
> > +++ b/arch/mips/lasat/Kconfig
> > @@ -0,0 +1,15 @@
> > +config PICVUE
> > +	tristate "PICVUE LCD display driver"
> > +	depends on LASAT
> > +
> > +config PICVUE_PROC
> > +	tristate "PICVUE LCD display driver /proc interface"
> > +	depends on PICVUE
> > +
> > +config DS1603
> > +	bool "DS1603 RTC driver"
> > +	depends on LASAT
> 
> If you add new RTC driver, it should go to drivers/rtc.

Nice! So the way to review existing code, is to remove it (accidentally? ;-)
and add it back later? ;-)

> > diff --git a/include/asm-mips/nile4.h b/include/asm-mips/nile4.h
> > new file mode 100644
> > index 0000000..c3ca959
> > --- /dev/null
> > +++ b/include/asm-mips/nile4.h
> > @@ -0,0 +1,310 @@
> > +/*
> > + *  asm-mips/nile4.h -- NEC Vrc-5074 Nile 4 definitions
> 
> <snip>
> 
> > +    /*
> > +     *  Interrupt Programming
> > +     */
> > +
> > +#define NUM_I8259_INTERRUPTS	16
> > +#define NUM_NILE4_INTERRUPTS	16
> > +
> > +#define IRQ_I8259_CASCADE	NILE4_INT_INTE
> > +#define is_i8259_irq(irq)	((irq) < NUM_I8259_INTERRUPTS)
> > +#define nile4_to_irq(n)		((n)+NUM_I8259_INTERRUPTS)
> > +#define irq_to_nile4(n)		((n)-NUM_I8259_INTERRUPTS)
> > +
> > +extern void nile4_map_irq(int nile4_irq, int cpu_irq);
> > +extern void nile4_map_irq_all(int cpu_irq);
> > +extern void nile4_enable_irq(unsigned int nile4_irq);
> > +extern void nile4_disable_irq(unsigned int nile4_irq);
> > +extern void nile4_disable_irq_all(void);
> > +extern u16 nile4_get_irq_stat(int cpu_irq);
> > +extern void nile4_enable_irq_output(int cpu_irq);
> > +extern void nile4_disable_irq_output(int cpu_irq);
> > +extern void nile4_set_pci_irq_polarity(int pci_irq, int high);
> > +extern void nile4_set_pci_irq_level_or_edge(int pci_irq, int level);
> > +extern void nile4_clear_irq(int nile4_irq);
> > +extern void nile4_clear_irq_mask(u32 mask);
> > +extern u8 nile4_i8259_iack(void);
> > +extern void nile4_dump_irq_status(void);	/* Debug */
> 
> nile4 IRQ functions don't exist.

Yep, those are for the NEC DDB Vrc-5074 (still to be resurrected, one day ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
