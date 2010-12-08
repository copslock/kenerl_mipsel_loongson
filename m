Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2010 23:46:48 +0100 (CET)
Received: from gate.crashing.org ([63.228.1.57]:59735 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492096Ab0LHWqo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Dec 2010 23:46:44 +0100
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id oB8MjkZ3006547;
        Wed, 8 Dec 2010 16:45:47 -0600
Subject: Re: [PATCH] Introduce mips_late_time_init
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Anoop P A <anoop.pa@gmail.com>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1012082217230.2653@localhost6.localdomain6>
References: <1291623812.31822.6.camel@paanoop1-desktop>
         <4CFD2095.9040404@caviumnetworks.com>
         <20101208203704.GB30923@linux-mips.org>
         <alpine.LFD.2.00.1012082217230.2653@localhost6.localdomain6>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 09 Dec 2010 09:45:46 +1100
Message-ID: <1291848346.16694.205.camel@pasglop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Wed, 2010-12-08 at 22:21 +0100, Thomas Gleixner wrote:
> On Wed, 8 Dec 2010, Ralf Baechle wrote:
> > Running everything from late_time_init() instead allows the use of kmalloc.
> > X86 has the same issue with requiring kmalloc in time_init which is why
> > they had moved everything to late_time_init.
> 
> It's more ioremap, but yeah.
>  
> > So the real question is, why can't we just move the call of time_init()
> > in setup_kernel() to where late_time_init() is getting called from for
> > all architectures, does anything rely on it getting called early?
> 
> That's a good question and I asked it myself already. I can't see a
> real reason why something would need it early. Definitely worth to
> try.

Well, I can see some reasons at least...

On ppc at least, we calibrate the timebase/decrementer in time_init, so
things like udelay etc... are going to be unreliable until we've done
that, which could be a problem if done too late due to sensitive HW
accessors that might rely on these.

So we'd probably need to move that to a different (early) arch callback
if time_init is moved.

Also, still on server PPC, you can't really disable the decrementer
(only delay it). So if interrupts are enabled, we will eventually get
timer ones.

So we'd have to be careful about keeping some state, knowing that the
stuff isn't initialized yet and just set the decrementer to fire again
as late as possible, until it's properly configured.

Besides, we can use kmalloc that early nowadays, can't we ? That's what
the gfp_allowed_mask is all about ...

Cheers,
Ben.
