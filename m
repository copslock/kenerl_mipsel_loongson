Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 17:02:08 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52565 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024603AbZESQCB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 May 2009 17:02:01 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4JG1Jo8022498;
	Tue, 19 May 2009 17:01:20 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4JG1H5g022497;
	Tue, 19 May 2009 17:01:17 +0100
Date:	Tue, 19 May 2009 17:01:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	yanh <yanh@lemote.com>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Subject: Re: [PATCH 26/30] loongson: flush irq write operation
Message-ID: <20090519160117.GA19672@linux-mips.org>
References: <1242426527.10164.174.camel@falcon> <20090518163603.GA22779@linux-mips.org> <1242700637.4382.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1242700637.4382.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 19, 2009 at 10:37:17AM +0800, yanh wrote:

> > The semantic of inX() / outX() is defined by the x86 architecture which
> > forbids posting I/O port writes.  In short I think this one is papering
> > over a bug in the outX() implementation.
> Yes, the outX should do a delayed write, however it does not. 
> So our solution is making a read to flush the write.

Do you actually need all the inb() you added to get things to work or is

diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index 01c0885..42d75d7 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -177,10 +177,12 @@ handle_real_irq:
 		outb(cached_slave_mask, PIC_SLAVE_IMR);
 		outb(0x60+(irq&7), PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
 		outb(0x60+PIC_CASCADE_IR, PIC_MASTER_CMD); /* 'Specific EOI' to master-IRQ2 */
+		inb(PIC_MASTER_CMD);
 	} else {
 		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
 		outb(cached_master_mask, PIC_MASTER_IMR);
 		outb(0x60+irq, PIC_MASTER_CMD);	/* 'Specific EOI to master */
+		inb(PIC_MASTER_CMD);
 	}
 	smtc_im_ack_irq(irq);
 	spin_unlock_irqrestore(&i8259A_lock, flags);

sufficient to solve the problem?

  Ralf
