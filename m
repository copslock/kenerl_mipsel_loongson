Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 17:59:56 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:35324 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225473AbSLSR74>;
	Thu, 19 Dec 2002 17:59:56 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBJHxo915536;
	Thu, 19 Dec 2002 09:59:50 -0800
Date: Thu, 19 Dec 2002 09:59:49 -0800
From: Jun Sun <jsun@mvista.com>
To: Colin.Helliwell@Zarlink.Com
Cc: linux-mips@linux-mips.org, rml@mvista.com, jsun@mvista.com
Subject: Re: Problems with CONFIG_PREEMPT
Message-ID: <20021219095949.N6061@mvista.com>
References: <OF6E5B6266.DFC7C2F8-ON80256C94.002DE2D6@zarlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF6E5B6266.DFC7C2F8-ON80256C94.002DE2D6@zarlink.com>; from Colin.Helliwell@Zarlink.Com on Thu, Dec 19, 2002 at 09:10:40AM +0000
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Dec 19, 2002 at 09:10:40AM +0000, Colin.Helliwell@Zarlink.Com wrote:
> 
> Thanks for the patch, but unfortunately the problem is still the same. 

If the problem happens very soon after you boot up, there is something
*obviously* wrong.  The most common problem is that you have an interupt
handling path not going through standard do_IRQ().  Then you need to
do similar treatment like those in ll_timer_interrupt().

The second thing is to look for any *new* global variables you may
introduce in your kernel.  Most of current global variables are either
safe or taken care of (Although another update patch will come out
today or tomorrow to really close the final hole we have).

> I'm
> not sure whether it occurs as a result of interrupts, or just after a
> certain amount of scheduler 'activity' as it sits there copying the initrd
> into ram disk. A few interrupts are enabled, but its only the MIPS timer
> which should be generating any interrupts at that point (I'll check that,
> in case its relevant).

FYI, I have mips kernel with initrd running just fine with preemptible kernel.
In fact, it has passed some very stressful tests with initrd.

> I presume the change from "sti()" to "__sti()" was a semantic (or SMP)
> thing, since the former is #defined to the latter anyway? Please note also
> the following modification which was required to 2.4.19:
> 

This is true.  Since our kernel had synchronize_irq() added long time ago,
I probably forgot about it when I created the pre-k patch.

Jun
