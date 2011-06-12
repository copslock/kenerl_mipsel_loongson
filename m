Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 18:42:16 +0200 (CEST)
Received: from imr3.ericy.com ([198.24.6.13]:60561 "EHLO imr3.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491071Ab1FLQmK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Jun 2011 18:42:10 +0200
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id p5CGftNc009130
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 12 Jun 2011 11:42:02 -0500
Received: from localhost (147.117.20.214) by eusaamw0711.eamcs.ericsson.se
 (147.117.20.179) with Microsoft SMTP Server id 8.3.137.0; Sun, 12 Jun 2011
 12:41:55 -0400
Date:   Sun, 12 Jun 2011 09:41:55 -0700
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Linux 2.6.39 on Cavium CN38xx
Message-ID: <20110612164155.GA30615@ericsson.com>
References: <1307653714.8271.130.camel@groeck-laptop>
 <4DF13E25.2060502@caviumnetworks.com>
 <20110609220614.GA13583@ericsson.com>
 <4DF15068.30906@caviumnetworks.com>
 <1307751642.8271.315.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1307751642.8271.315.camel@groeck-laptop>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 30347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10180

On Fri, Jun 10, 2011 at 08:20:42PM -0400, Guenter Roeck wrote:
[ ... ]

> Hi David,
> 
> Turns out my primary problem is that octeon_irq_setup_secondary_ciu()
> sets C0_STATUS to 0x1000efe0, ie all interrupts except IP4 are enabled.
> This mask is primarily set through octeon_irq_percpu_enable(), which
> sets C0_STATUS to 0x1000e3e0. The value differs from CPU 0, where
> C0_STATUS is set to 0x10008ce0.
> 
> This causes persistent spurious interrupts on our boards (both with
> CN38xx and CN58xx), where C0_CAUSE persistently reads as zero in the
> interrupt handling code but interrupts are triggered anyway. The
> spurious interrupt problem goes away if I mask out IP0, IP1, IP5, and
> IP6 at the end of octeon_irq_setup_secondary_ciu().
> 
Answering part of my own question: The interrupt enable bits for secondary CPUs
are all set through octeon_irq_core_eoi(), which is called from the per-CPU
initialization code and enables each interrupt even if "desired_en" is false
for a given bit. I modified octeon_irq_core_eoi() to

	if (cd->desired_en)
                set_c0_status(0x100 << cd->bit); 

which takes care of the problem. No idea if that is correct, though.

The actual interrupt causing trouble and spurious interrupts in my case is,
oddly enough, STATUSF_IP0. So far I have been unable to track down how that
is triggered; I don't see the bit being set set in C0_CAUSE anywhere.

Are there any means to trigger an IP0 interrupt other than by writing STATUSF_IP0 
into the C0_CAUSE register ?

Thanks,
Guenter
