Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Dec 2007 00:02:56 +0000 (GMT)
Received: from pentafluge.infradead.org ([213.146.154.40]:59333 "EHLO
	pentafluge.infradead.org") by ftp.linux-mips.org with ESMTP
	id S20030551AbXLDACq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Dec 2007 00:02:46 +0000
Received: from [192.102.209.1] (helo=laptopd505.fenrus.org)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1IzLCD-0002Sy-Ot; Mon, 03 Dec 2007 23:59:30 +0000
Date:	Mon, 3 Dec 2007 15:57:46 -0800
From:	Arjan van de Ven <arjan@infradead.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Andy Whitcroft <apw@shadowen.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] SC26XX: New serial driver for SC2681 uarts
Message-ID: <20071203155746.2dc4506d@laptopd505.fenrus.org>
In-Reply-To: <20071203155317.772231f9.akpm@linux-foundation.org>
References: <20071202194346.36E3FDE4C4@solo.franken.de>
	<20071203155317.772231f9.akpm@linux-foundation.org>
Organization: Intel
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.12.1; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Return-Path: <SRS0+dd00f2f123ee515c5e23+1562+infradead.org+arjan@pentafluge.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arjan@infradead.org
Precedence: bulk
X-list: linux-mips

On Mon, 3 Dec 2007 15:53:17 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun,  2 Dec 2007 20:43:46 +0100 (CET)
> Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> 
> > New serial driver for SC2681/SC2691 uarts. Older SNI RM400 machines
> > are using these chips for onboard serial ports.
> > 
> 
> Little things...
> 
> > --- /dev/null
> > +++ b/drivers/serial/sc26xx.c
> > @@ -0,0 +1,757 @@
> > +/*
> > + * SC268xx.c: Serial driver for Philiphs SC2681/SC2692 devices.
> > + *
> > + * Copyright (C) 2006,2007 Thomas Bogend__rfer
> > (tsbogend@alpha.franken.de)
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/tty.h>
> > +#include <linux/tty_flip.h>
> > +#include <linux/major.h>
> > +#include <linux/circ_buf.h>
> > +#include <linux/serial.h>
> > +#include <linux/sysrq.h>
> > +#include <linux/console.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> > +#include <linux/init.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/irq.h>
> > +
> > +#if defined(CONFIG_MAGIC_SYSRQ)
> > +#define SUPPORT_SYSRQ
> > +#endif
> > +
> > +#include <linux/serial_core.h>
> > +
> > +#define SC26XX_MAJOR         204
> > +#define SC26XX_MINOR_START   205
> > +#define SC26XX_NR            2

did lanana assign these numbers officially?
