Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2012 18:02:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58640 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1901168Ab2ALRCz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jan 2012 18:02:55 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id q0CH2rcx024077;
        Thu, 12 Jan 2012 18:02:54 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id q0CH2pSL024076;
        Thu, 12 Jan 2012 18:02:51 +0100
Date:   Thu, 12 Jan 2012 18:02:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        Felix Fietkau <nbd@openwrt.org>
Subject: Re: [PATCH RESEND 16/17] MIPS: make oprofile use cp0_perfcount_irq
 if it is set
Message-ID: <20120112170251.GA21781@linux-mips.org>
References: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
 <1326314674-9899-16-git-send-email-blogic@openwrt.org>
 <4F0EFE6E.3080503@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F0EFE6E.3080503@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Jan 12, 2012 at 06:38:22PM +0300, Sergei Shtylyov wrote:

> >@@ -374,6 +379,10 @@ static int __init mipsxx_init(void)
> >  	save_perf_irq = perf_irq;
> >  	perf_irq = mipsxx_perfcount_handler;
> >
> >+	if (cp0_perfcount_irq>= 0)
> 
>    BTW, I just noticed. IRQ0 is not a valid IRQ in Linux,
> request_irq() should fail when passed 0, so this and following check
> should be '> 0'.

In a normal configuration that is in a discrete processor or in a MIPS
core where the performance IRQ is just routed back into the core the
lowest sensible value for cp0_perfcount_irq is 2, so there is no
immediate problem there.

IRQ 0 is ok for static use; dynamic use is problematic.  This case is
even more problematic because the interrupt might be shared with the
timer and the timer interrupt is allocated statically (see cevt-r4k.c)
but the performance counter interrupt later allocated dynamically with
IRQF_SHARED.

  Ralf
