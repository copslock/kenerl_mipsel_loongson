Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 21:57:45 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:25575 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022827AbXC0U5k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 21:57:40 +0100
Received: (qmail 24430 invoked by uid 101); 27 Mar 2007 20:56:23 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 27 Mar 2007 20:56:23 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l2RKuIxC001359;
	Tue, 27 Mar 2007 12:56:19 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCQCJMT>; Tue, 27 Mar 2007 13:56:16 -0800
Message-ID: <460984EB.8040306@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/12] drivers: PMC MSP71xx serial driver
Date:	Tue, 27 Mar 2007 12:56:11 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 27 Mar 2007 21:56:05.0734 (UTC) FILETIME=[B80B8860:01C770BA]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Sergei Shtylyov wrote:
> Hello.
> 
> Marc St-Jean wrote:
> 
>  >> > diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c
>  >>b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
>  >> > new file mode 100644
>  >> > index 0000000..3b956e9
>  >> > --- /dev/null
>  >> > +++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
>  >> > @@ -0,0 +1,185 @@
>  >>[...]
>  >> > +#ifdef CONFIG_KGDB
>  >> > +/*
>  >> > + * kgdb uses serial port 1 so the console can remain on port 0.
>  >> > + * To use port 0 change the definition to read as follows:
>  >> > + * #define DEBUG_PORT_BASE KSEG1ADDR(MSP_UART0_BASE)
>  >> > + */
>  >> > +#define DEBUG_PORT_BASE KSEG1ADDR(MSP_UART1_BASE)
>  >> > +
>  >> > +int putDebugChar(char c)
>  >> > +{
>  >> > +     volatile uint32_t *uart = (volatile uint32_t *)DEBUG_PORT_BASE;
>  >> > +     uint32_t val = (uint32_t)c;
>  >> > +
>  >> > +     local_irq_disable();
>  >> > +     while (!(uart[5] & 0x20)); /* Wait for TXRDY */
>  >> > +     uart[0] = val;
>  >> > +     while (!(uart[5] & 0x20)); /* Wait for TXRDY */
>  >> > +     local_irq_enable();
> 
>  >>    Gah, why you decided to put local_irq_enable() there?!  KGDB expects
>  >>interrupts to be *disabled* while it has control, else some subtle state
>  >>corruptions will ensue, and it will eventually lock up. Please remove
>  >>these 2 calls completely.
> 
>  > Hmmm, this has been working for several months. I'll remove, retest and
>  > resubmit.
> 
>     I should probably have said "may".  From my experience with KGDBoE 
> though
> (well, it's somewhat different KGDB implementation :-) it locks up pretty
> quickly because of local_irq_enable() or spin_unlock_irq().  Nevertheless,
> enabling interrupts while KGDB has control is undesirable.  And look at the
> other KGDB serial code inarch/mips/ -- nobody else does this.

A search showed that some other architectures do use local_irq_disable()/enable()
and our code may have been derived from it. None of the MIPS platforms do and
the kgdb implementation seams to be arch specific so I'll drop them.

>  > Are you aware if this is the case for the "putchar" used by early_printk
>  > as well?
> 
>     No idea, ask Ralf. ;-)

I searched putchar implementations and there only seems to be one more for the
cobalt. It also doesn't  twiddle the irg state so I'll drop it there as well.

I tested and seems well without the local_irq_disable()/enable(), I'll resubmit
the path.

Thanks,
Marc
