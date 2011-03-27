Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Mar 2011 23:30:02 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:36982 "EHLO linutronix.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491047Ab1C0V37 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Mar 2011 23:29:59 +0200
Received: from localhost ([127.0.0.1])
        by linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q3xWx-0005pJ-Du; Sun, 27 Mar 2011 23:29:51 +0200
Date:   Sun, 27 Mar 2011 23:29:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Daney <david.s.daney@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [patch 3/5] MIPS: Octeon: Simplify irq_cpu_on/offline irq chip
 functions
In-Reply-To: <4D8FA840.2080108@gmail.com>
Message-ID: <alpine.LFD.2.00.1103272326270.31464@localhost6.localdomain6>
References: <20110327155637.623706071@linutronix.de> <20110327161118.737588559@linutronix.de> <4D8FA840.2080108@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Sun, 27 Mar 2011, David Daney wrote:

> On 03/27/2011 09:22 AM, Thomas Gleixner wrote:
> > Make use of the IRQCHIP_ONOFFLINE_ENABLED flag and remove the
> > wrappers. Use irqd_irq_disabled() instead of desc->status, which will
> > go away.
> > 
> 
> I rewrote my patch set and was testing it.  Interesting that I came up with a
> function with almost the same name and purpose.
> 
> However my function told us if the irq was masked *or* disabled.  The idea
> being a function that returns true if the irq could fire.  We cannot be
> enabling the interrupt in the controller if it is masked.
> 
> For example I need to test this when adjusting affinity, and taking CPUs on
> and off line.
> 
> I don't think your genirq changes can tell the me information I really need in
> their current state.  I think we need to consider how the masked state
> interacts with IRQCHIP_ONOFFLINE_ENABLED and irqd_irq_disabled().
> 
> Since I have totally rewritten my interrupt code, I am a bit ambivalent about
> applying these patches.  It might make more sense that I adjust my patch for
> your genirq changes and test it before committing it.

The modifications I made are 100% equivalent to the code you provided
in the first place.

The IRQCHIP_ONOFFLINE_ENABLED flag is only used for the on/offline
callbacks. The disabled checked based on irq_data is in the affinity
setting code.

Unless I'm missing something we should be all set.

Thanks,

	tglx
