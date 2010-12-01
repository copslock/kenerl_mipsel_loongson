Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 12:24:27 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37600 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492952Ab0LALYZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Dec 2010 12:24:25 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oB1BOCgN031109;
        Wed, 1 Dec 2010 11:24:13 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oB1BOBsg031101;
        Wed, 1 Dec 2010 11:24:11 GMT
Date:   Wed, 1 Dec 2010 11:24:10 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Anoop P <anoop.pa@gmail.com>
Cc:     linux-mips@linux-mips.org, dvomlehn@cisco.com,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Allow setup_irq call for VPE1 timer.
Message-ID: <20101201112410.GL2916@linux-mips.org>
References: <1290697632-6139-1-git-send-email-anoop.pa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1290697632-6139-1-git-send-email-anoop.pa@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 25, 2010 at 08:37:12PM +0530, Anoop P wrote:

> From: Anoop P A <anoop.pa@gmail.com>
> 
> VSMP configuration can have seperate timer interrupts for each VPE.Need to setup IRQ for VPE1 timer.

> +#ifndef CONFIG_MIPS_MT_SMP
>  	if (cp0_timer_irq_installed)
>  		return 0;
> -
> +#endif
>  	cp0_timer_irq_installed = 1;
>  
>  	setup_irq(irq, &c0_compare_irqaction);

On the stylistic side adding an #ifdef gives me wrinkles.

With CONFIG_MIPS_MT_SMP this patch results in sharing c0_compare_irqaction
between multiple interrupts which is broken.  Struct irqaction contains
the interrupt number, all registered irqaction structs are part of a chained
list via its ->next member and also there is a per interrupt proc directory.

To fix this properly you'll have to introduce do a bit of bookkeeping - you
want to register each interrupt only once - and allocate a struct irqaction
per registered timer interrupt.

The allocation is made a little trickier by kmalloc not being available
yet by the time this code is getting invoked via time_init() so you'll
have to move it to run via the late_time_init hook like x86:

static __init void x86_late_time_init(void)
{
	... do the real work ...
}

/* ... */

void __init time_init(void)
{
        late_time_init = x86_late_time_init;
}

Which makes me wonder if there is a reason why we need to have both
time_init() and late_time_init() - can't we just move the time_init()?

  Ralf
