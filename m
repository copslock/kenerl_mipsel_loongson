Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 03:37:58 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:56908 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024551AbZESChv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 May 2009 03:37:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 991453404A;
	Tue, 19 May 2009 10:33:00 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B28txt4Goztb; Tue, 19 May 2009 10:32:55 +0800 (CST)
Received: from [172.16.2.16] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 6DD6731C979;
	Tue, 19 May 2009 10:32:55 +0800 (CST)
Subject: Re: [PATCH 26/30] loongson: flush irq write operation
From:	yanh <yanh@lemote.com>
Reply-To: yanh@lemote.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <20090518163603.GA22779@linux-mips.org>
References: <1242426527.10164.174.camel@falcon>
	 <20090518163603.GA22779@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:	Tue, 19 May 2009 10:37:17 +0800
Message-Id: <1242700637.4382.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.1 (2.24.1-2.fc10) 
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

在 2009-05-18一的 17:36 +0100，Ralf Baechle写道：
> On Sat, May 16, 2009 at 06:28:47AM +0800, Wu Zhangjin wrote:
> 
> > read back after write, otherwise, there will be many spurious irqs from
> > it
> > ---
> >  arch/mips/kernel/i8259.c               |    5 +++++
> >  arch/mips/loongson/common/bonito-irq.c |    4 ++++
> >  2 files changed, 9 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
> > index 413bd1d..f7c3a2b 100644
> > --- a/arch/mips/kernel/i8259.c
> > +++ b/arch/mips/kernel/i8259.c
> > @@ -175,12 +175,17 @@ handle_real_irq:
> >  	if (irq & 8) {
> >  		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */
> >  		outb(cached_slave_mask, PIC_SLAVE_IMR);
> > +		inb(PIC_SLAVE_IMR);
> >  		outb(0x60+(irq&7), PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
> > +		inb(PIC_SLAVE_CMD);
> >  		outb(0x60+PIC_CASCADE_IR, PIC_MASTER_CMD); /* 'Specific EOI' to
> > master-IRQ2 */
> > +		inb(PIC_MASTER_CMD);
> >  	} else {
> >  		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
> >  		outb(cached_master_mask, PIC_MASTER_IMR);
> > +		inb(PIC_SLAVE_IMR);
> >  		outb(0x60+irq, PIC_MASTER_CMD);	/* 'Specific EOI to master */
> > +		inb(PIC_MASTER_CMD);
> >  	}
> >  	smtc_im_ack_irq(irq);
> >  	spin_unlock_irqrestore(&i8259A_lock, flags);
> 
> The semantic of inX() / outX() is defined by the x86 architecture which
> forbids posting I/O port writes.  In short I think this one is papering
> over a bug in the outX() implementation.
Yes, the outX should do a delayed write, however it does not. 
So our solution is making a read to flush the write.
> 
> I'm ok with the bonito part of this patch.
> 
>   Ralf
