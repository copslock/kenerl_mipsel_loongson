Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2010 21:37:24 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42819 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491909Ab0LHUhU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Dec 2010 21:37:20 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oB8Kb6OF008718;
        Wed, 8 Dec 2010 20:37:06 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oB8Kb5lR008707;
        Wed, 8 Dec 2010 20:37:05 GMT
Date:   Wed, 8 Dec 2010 20:37:04 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Anoop P A <anoop.pa@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Introduce mips_late_time_init
Message-ID: <20101208203704.GB30923@linux-mips.org>
References: <1291623812.31822.6.camel@paanoop1-desktop>
 <4CFD2095.9040404@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CFD2095.9040404@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 06, 2010 at 09:42:45AM -0800, David Daney wrote:

> On 12/06/2010 12:23 AM, Anoop P A wrote:
> >This patch moves plat_time_init and clocksoure init funtion calls to
> >late_time_init.
> >
> 
> Why would you want to do this?
> 
> The current code works perfectly, so I see no reason to change it.

Well, not really.  By the time time_init is called kmalloc isn't ready yet.
That's why mips_clockevent_device pretty much had to be statically
allocated and is also why interrupts have to use setup_irq instead of
request_irq.

Keeping mips_clockevent_device statically allocated as per-CPU makes sense.
Less for the struct irqaction and he'll have to allocate one for each
VPE (think CPU) he installs a clockevent device on.

Running everything from late_time_init() instead allows the use of kmalloc.
X86 has the same issue with requiring kmalloc in time_init which is why
they had moved everything to late_time_init.

So the real question is, why can't we just move the call of time_init()
in setup_kernel() to where late_time_init() is getting called from for
all architectures, does anything rely on it getting called early?

  Ralf
