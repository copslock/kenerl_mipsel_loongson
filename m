Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2006 12:05:58 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:20951 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038539AbWKVMF4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Nov 2006 12:05:56 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAMC5ssn032334;
	Wed, 22 Nov 2006 12:05:55 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAMC5qh0032333;
	Wed, 22 Nov 2006 12:05:52 GMT
Date:	Wed, 22 Nov 2006 12:05:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] use generic_handle_irq, handle_level_irq, handle_percpu_irq
Message-ID: <20061122120552.GA27782@linux-mips.org>
References: <20061114.011318.99611303.anemo@mba.ocn.ne.jp> <45631BD2.4090509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45631BD2.4090509@ru.mvista.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 21, 2006 at 06:31:30PM +0300, Sergei Shtylyov wrote:

> >@@ -104,6 +105,7 @@ static struct irq_chip mips_mt_cpu_irq_c
> > 	.mask		= mask_mips_mt_irq,
> > 	.mask_ack	= mips_mt_cpu_irq_ack,
> > 	.unmask		= unmask_mips_mt_irq,
> >+	.eoi		= unmask_mips_mt_irq,
> > 	.end		= mips_mt_cpu_irq_end,
> > };
> > 
> >@@ -124,7 +126,8 @@ void __init mips_cpu_irq_init(int irq_ba
> > 			set_irq_chip(i, &mips_mt_cpu_irq_controller);
> > 
> > 	for (i = irq_base + 2; i < irq_base + 8; i++)
> >-		set_irq_chip(i, &mips_cpu_irq_controller);
> >+		set_irq_chip_and_handler(i, &mips_cpu_irq_controller,
> >+					 handle_level_irq);
> 
>    BTW, isn't IRQ7 per-CPU?

Yes and no.  On many CPUs IRQ 7 can be configured at reset time as either
the count / compare interrupt or a CPU interrupt just like the others.
It always used to be a normal CPU interrupt for R2000 class CPUs.

  Ralf
