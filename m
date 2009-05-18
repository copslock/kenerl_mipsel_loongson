Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 17:38:38 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47349 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023466AbZERQib (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 May 2009 17:38:31 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4IGa6Nd022881;
	Mon, 18 May 2009 17:36:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4IGa3ia022879;
	Mon, 18 May 2009 17:36:03 +0100
Date:	Mon, 18 May 2009 17:36:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Subject: Re: [PATCH 26/30] loongson: flush irq write operation
Message-ID: <20090518163603.GA22779@linux-mips.org>
References: <1242426527.10164.174.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1242426527.10164.174.camel@falcon>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, May 16, 2009 at 06:28:47AM +0800, Wu Zhangjin wrote:

> read back after write, otherwise, there will be many spurious irqs from
> it
> ---
>  arch/mips/kernel/i8259.c               |    5 +++++
>  arch/mips/loongson/common/bonito-irq.c |    4 ++++
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
> index 413bd1d..f7c3a2b 100644
> --- a/arch/mips/kernel/i8259.c
> +++ b/arch/mips/kernel/i8259.c
> @@ -175,12 +175,17 @@ handle_real_irq:
>  	if (irq & 8) {
>  		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */
>  		outb(cached_slave_mask, PIC_SLAVE_IMR);
> +		inb(PIC_SLAVE_IMR);
>  		outb(0x60+(irq&7), PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
> +		inb(PIC_SLAVE_CMD);
>  		outb(0x60+PIC_CASCADE_IR, PIC_MASTER_CMD); /* 'Specific EOI' to
> master-IRQ2 */
> +		inb(PIC_MASTER_CMD);
>  	} else {
>  		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
>  		outb(cached_master_mask, PIC_MASTER_IMR);
> +		inb(PIC_SLAVE_IMR);
>  		outb(0x60+irq, PIC_MASTER_CMD);	/* 'Specific EOI to master */
> +		inb(PIC_MASTER_CMD);
>  	}
>  	smtc_im_ack_irq(irq);
>  	spin_unlock_irqrestore(&i8259A_lock, flags);

The semantic of inX() / outX() is defined by the x86 architecture which
forbids posting I/O port writes.  In short I think this one is papering
over a bug in the outX() implementation.

I'm ok with the bonito part of this patch.

  Ralf
