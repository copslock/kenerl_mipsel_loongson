Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2003 00:31:17 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63736 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225310AbTKZAbF>;
	Wed, 26 Nov 2003 00:31:05 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id hAQ0V4501881;
	Tue, 25 Nov 2003 16:31:04 -0800
Date: Tue, 25 Nov 2003 16:31:04 -0800
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Kapoor, Pankaj" <pkapoor@telogy.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: MIPS Interrupts.
Message-ID: <20031125163104.I28822@mvista.com>
References: <37A3C2F21006D611995100B0D0F9B73C02C8FCAE@tnint11.telogy.design.ti.com> <20031125230946.GA12422@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031125230946.GA12422@linux-mips.org>; from ralf@linux-mips.org on Wed, Nov 26, 2003 at 12:09:46AM +0100
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Nov 26, 2003 at 12:09:46AM +0100, Ralf Baechle wrote:
> On Tue, Nov 25, 2003 at 04:52:20PM -0500, Kapoor, Pankaj wrote:
> 
> > Now there are 2 cases that can happen 
> > 
> > 1. Since we have not exited the ISR and the exception level has still not 
> >    been restored there can be no more interrupts that are generated in the 
> >    system. In such a case does that mean that the all bottom half handlers 
> >    pending execution will run with interrupts disabled. 
> >    NOTE: This does not seem likely because the local_irq_enable routine
> >    calls _sti which clears the exception level in the status register and
> >    also sets the IE bit. 
> > 
> > 2. If we have large number of tasklets or if the bottom half handlers take
> >    time to execute, then we could get another timer interrupt or other
> >    device interrupts causing context saves which would cause the stack to
> >    grow and CRASH the system. 
> 
> Interrupts are disabled while the respective interrupt handler is running.
>

They are re-enabled for "bottom halves", i.e., in do_softirq().  I think
that is what the sender is worrying about.

Jun
