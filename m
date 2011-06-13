Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2011 23:51:52 +0200 (CEST)
Received: from imr4.ericy.com ([198.24.6.8]:44595 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491119Ab1FMVva (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jun 2011 23:51:30 +0200
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id p5DLpHFj003939;
        Mon, 13 Jun 2011 16:51:23 -0500
Received: from localhost (147.117.20.214) by eusaamw0707.eamcs.ericsson.se
 (147.117.20.92) with Microsoft SMTP Server id 8.3.137.0; Mon, 13 Jun 2011
 17:51:11 -0400
Date:   Mon, 13 Jun 2011 14:51:11 -0700
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Linux 2.6.39 on Cavium CN38xx
Message-ID: <20110613215111.GA3484@ericsson.com>
References: <1307653714.8271.130.camel@groeck-laptop>
 <4DF13E25.2060502@caviumnetworks.com>
 <20110609220614.GA13583@ericsson.com>
 <4DF15068.30906@caviumnetworks.com>
 <1307751642.8271.315.camel@groeck-laptop>
 <20110612164155.GA30615@ericsson.com>
 <4DF67CAE.1040804@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4DF67CAE.1040804@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 30372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10964

On Mon, Jun 13, 2011 at 05:10:06PM -0400, David Daney wrote:
> On 06/12/2011 09:41 AM, Guenter Roeck wrote:
> > On Fri, Jun 10, 2011 at 08:20:42PM -0400, Guenter Roeck wrote:
> > [ ... ]
> >
> >> Hi David,
> >>
> >> Turns out my primary problem is that octeon_irq_setup_secondary_ciu()
> >> sets C0_STATUS to 0x1000efe0, ie all interrupts except IP4 are enabled.
> >> This mask is primarily set through octeon_irq_percpu_enable(), which
> >> sets C0_STATUS to 0x1000e3e0. The value differs from CPU 0, where
> >> C0_STATUS is set to 0x10008ce0.
> >>
> >> This causes persistent spurious interrupts on our boards (both with
> >> CN38xx and CN58xx), where C0_CAUSE persistently reads as zero in the
> >> interrupt handling code but interrupts are triggered anyway. The
> >> spurious interrupt problem goes away if I mask out IP0, IP1, IP5, and
> >> IP6 at the end of octeon_irq_setup_secondary_ciu().
> >>
> > Answering part of my own question: The interrupt enable bits for secondary CPUs
> > are all set through octeon_irq_core_eoi(), which is called from the per-CPU
> > initialization code and enables each interrupt even if "desired_en" is false
> > for a given bit. I modified octeon_irq_core_eoi() to
> >
> > 	if (cd->desired_en)
> >                  set_c0_status(0x100<<  cd->bit);
> >
> 
> That shouldn't be needed.  The logic in irq_cpu_online() should only 
> call chip->irq_cpu_online() if the irq is enabled.
> 
Doesn't look like it. Here is some log output:

SMP: Booting CPU01 (CoreId  1)...
Core 1 ALIVE
CPU revision is: 000d0003 (Cavium Octeon)
PU 1: Calling irq_cpu_online() for irq_chip Core, flags=0x8, disabled=0
CPU 1: irq_core_eoi(enable=0, bit=0)
CPU 1: Calling irq_cpu_online() for irq_chip Core, flags=0x8, disabled=0
CPU 1: irq_core_eoi(enable=0, bit=1)
CPU 1: Calling irq_cpu_online() for irq_chip Core, flags=0x8, disabled=0
CPU 1: irq_core_eoi(enable=0, bit=5)
CPU 1: Calling irq_cpu_online() for irq_chip Core, flags=0x8, disabled=0
CPU 1: irq_core_eoi(enable=0, bit=6)
CPU 1: Calling irq_cpu_online() for irq_chip Core, flags=0x8, disabled=0
CPU 1: irq_core_eoi(enable=1, bit=7)

irqd_irq_disabled(&desc->irq_data) returns false, meaning IRQD_IRQ_DISABLED
is not set in the state_use_accessors field of irq_data for the interrupt bits
in question. If I understand the code correctly, this happens for unused 
interrupts if CONFIG_IRQ_SPARSE is not set (desc_set_defaults(), which sets the bit,
is only called if CONFIG_IRQ_SPARSE is defined).

As a result, irq_core_eoi() is called from irq_cpu_online(), even though
IRQCHIP_ONOFFLINE_ENABLED is set in irq_chip.

> 
> > which takes care of the problem. No idea if that is correct, though.
> >
> > The actual interrupt causing trouble and spurious interrupts in my case is,
> > oddly enough, STATUSF_IP0. So far I have been unable to track down how that
> > is triggered; I don't see the bit being set set in C0_CAUSE anywhere.
> >
> > Are there any means to trigger an IP0 interrupt other than by writing STATUSF_IP0
> > into the C0_CAUSE register ?
> >
> 
> No.  Nothing that I know of ever uses IP0 and IP1, so they should always 
> be cleared.
> 
Exactly what I figured, yet I still get those spurious interrupts if IP0 is enabled.
Something odd is definitely going on in my system.

Besides the above, my hopefully final problem is that timer interrupts are only
received by CPU 0. Any idea what to look for to fix this problem ?

Thanks,
Guenter
