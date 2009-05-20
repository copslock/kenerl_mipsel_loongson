Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 04:08:18 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:43060 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021559AbZETDIL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 May 2009 04:08:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 25CFE31CA2E;
	Wed, 20 May 2009 11:03:17 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rZkQdnlpO7ea; Wed, 20 May 2009 11:03:12 +0800 (CST)
Received: from [172.16.2.16] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 6FCB131CA2D;
	Wed, 20 May 2009 11:03:11 +0800 (CST)
Subject: Re: [PATCH 26/30] loongson: flush irq write operation
From:	yanh <yanh@lemote.com>
Reply-To: yanh@lemote.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <1242786494.4382.58.camel@localhost.localdomain>
References: <1242426527.10164.174.camel@falcon>
	 <20090518163603.GA22779@linux-mips.org>
	 <1242700637.4382.21.camel@localhost.localdomain>
	 <20090519160117.GA19672@linux-mips.org>
	 <1242786494.4382.58.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date:	Wed, 20 May 2009 11:07:35 +0800
Message-Id: <1242788855.4382.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.1 (2.24.1-2.fc10) 
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

在 2009-05-20三的 10:28 +0800，yanh写道：
> 在 2009-05-19二的 17:01 +0100，Ralf Baechle写道：
> > On Tue, May 19, 2009 at 10:37:17AM +0800, yanh wrote:
> > 
> > > > The semantic of inX() / outX() is defined by the x86 architecture which
> > > > forbids posting I/O port writes.  In short I think this one is papering
> > > > over a bug in the outX() implementation.
> > > Yes, the outX should do a delayed write, however it does not. 
> > > So our solution is making a read to flush the write.
> > 
> > Do you actually need all the inb() you added to get things to work or is
> 
> Thanks for your reply.
> As my test, if there is no the read, there will be many spurious irqs. 
> > 
> > diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
> > index 01c0885..42d75d7 100644
> > --- a/arch/mips/kernel/i8259.c
> > +++ b/arch/mips/kernel/i8259.c
> > @@ -177,10 +177,12 @@ handle_real_irq:
> >  		outb(cached_slave_mask, PIC_SLAVE_IMR);
> >  		outb(0x60+(irq&7), PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
> >  		outb(0x60+PIC_CASCADE_IR, PIC_MASTER_CMD); /* 'Specific EOI' to master-IRQ2 */
> > +		inb(PIC_MASTER_CMD);
> >  	} else {
> >  		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
> >  		outb(cached_master_mask, PIC_MASTER_IMR);
> >  		outb(0x60+irq, PIC_MASTER_CMD);	/* 'Specific EOI to master */
> > +		inb(PIC_MASTER_CMD);
> >  	}
> >  	smtc_im_ack_irq(irq);
> >  	spin_unlock_irqrestore(&i8259A_lock, flags);
> > 
> > sufficient to solve the problem?
> I have test this patch just now. It works well on yeeloong. 
> I have one question what's the difference between the two patch? 
My original patch only flush imr write. Really only one read is suffient. So no question about it now.
> > 
> >   Ralf
> 
> 
