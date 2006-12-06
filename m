Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 17:04:02 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:1488 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038416AbWLFRD5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2006 17:03:57 +0000
Received: from localhost (p6066-ipad209funabasi.chiba.ocn.ne.jp [58.88.117.66])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CD718B9A8; Thu,  7 Dec 2006 02:03:48 +0900 (JST)
Date:	Thu, 07 Dec 2006 02:03:48 +0900 (JST)
Message-Id: <20061207.020348.25910403.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4576C2E9.4060900@ru.mvista.com>
References: <20061206.115602.63741871.nemoto@toshiba-tops.co.jp>
	<20061206.133836.89067271.nemoto@toshiba-tops.co.jp>
	<4576C2E9.4060900@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 06 Dec 2006 16:17:29 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +static struct irq_chip i8259A_chip = {
> > +	.name		= "XT-PIC",
> > +	.mask		= disable_8259A_irq,
> > +	.unmask		= enable_8259A_irq,
> > +	.mask_ack	= mask_and_ack_8259A,
> >  };
> 
>     I wonder whose idea was to call this device XT-PIC. XT never had dual 
> 8259A PICs and so was capable of handling only 8 IRQs. Dual 8259A was first 
> used in the AT class machines...

It has been called "XT-PIC" anyway so I'd like to keep unchanged.

> >  {
> > -	unsigned int mask = 1 << irq;
> > +	unsigned int mask = 1<<irq;
> 
>     Unnecassary, to say the least.
> 
> > @@ -109,7 +99,8 @@ int i8259A_irq_pending(unsigned int irq)
> >  void make_8259A_irq(unsigned int irq)
> >  {
> >  	disable_irq_nosync(irq);
> > -	set_irq_chip(irq, &i8259A_irq_type);
> > +	set_irq_chip_and_handler_name(irq, &i8259A_chip, handle_level_irq,
> > +				      "XT");
> 
>     No! Do not evoke the memory of XT anymore, let it rest in peace at last!
> Call it 8259A, please.
> 
> > @@ -122,17 +113,17 @@ void make_8259A_irq(unsigned int irq)
> >  static inline int i8259A_irq_real(unsigned int irq)
> >  {
> >  	int value;
> > -	int irqmask = 1 << irq;
> > +	int irqmask = 1<<irq;
> 
>     Unnecessary too.

Well, these changes are due to synchronization with i386's code.  I'll
drop them.

> > @@ -214,15 +207,52 @@ spurious_8259A_irq:
> >  	}
> >  }
> >  
> > +static char irq_trigger[2];
> > +/**
> > + * ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ
> > + */
> > +static void restore_ELCR(char *trigger)
> > +{
> > +	outb(trigger[0], 0x4d0);
> > +	outb(trigger[1], 0x4d1);
> > +}
> > +
> > +static void save_ELCR(char *trigger)
> > +{
> > +	/* IRQ 0,1,2,8,13 are marked as reserved */
> > +	trigger[0] = inb(0x4d0) & 0xF8;
> > +	trigger[1] = inb(0x4d1) & 0xDE;
> 
>     Erm, the bits should be zero, why mask them out I wonder...

These codes are also come from i386 ... while they seems not used on
MIPS now anyway I'll drop them.

Thank you for review.  I'll post updated patch soon.
---
Atsushi Nemoto
