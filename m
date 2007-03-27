Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 19:36:52 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:8424 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022669AbXC0Sgu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 19:36:50 +0100
Received: (qmail 26196 invoked by uid 101); 27 Mar 2007 18:35:42 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by mother.pmc-sierra.com with SMTP; 27 Mar 2007 18:35:42 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l2RIZgpk022896;
	Tue, 27 Mar 2007 10:35:42 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCQCD6K>; Tue, 27 Mar 2007 11:35:39 -0800
Message-ID: <460963FB.9090101@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/12] drivers: PMC MSP71xx serial driver
Date:	Tue, 27 Mar 2007 10:35:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 27 Mar 2007 19:35:33.0250 (UTC) FILETIME=[15E49620:01C770A7]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14738
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
>  > Patch to add serial driver support for the PMC-Sierra
>  > MSP71xx devices.
> 
>  > Reposting patches as a single set at the request of akpm.
>  > Only 9 of 12 will be posted at this time, 3 more to follow
>  > when cleanups are complete.
> 
>  > Thanks,
>  > Marc
> 
>  > Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
>  > ---
>  > Re-posting patch with recommended changes:
>  > -Implemented support for putchar() in msp_serial.c
> 
>  > diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c 
> b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
>  > new file mode 100644
>  > index 0000000..3b956e9
>  > --- /dev/null
>  > +++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
>  > @@ -0,0 +1,185 @@
> [...]
>  > +#ifdef CONFIG_KGDB
>  > +/*
>  > + * kgdb uses serial port 1 so the console can remain on port 0.
>  > + * To use port 0 change the definition to read as follows:
>  > + * #define DEBUG_PORT_BASE KSEG1ADDR(MSP_UART0_BASE)
>  > + */
>  > +#define DEBUG_PORT_BASE KSEG1ADDR(MSP_UART1_BASE)
>  > +
>  > +int putDebugChar(char c)
>  > +{
>  > +     volatile uint32_t *uart = (volatile uint32_t *)DEBUG_PORT_BASE;
>  > +     uint32_t val = (uint32_t)c;
>  > +
>  > +     local_irq_disable();
>  > +     while (!(uart[5] & 0x20)); /* Wait for TXRDY */
>  > +     uart[0] = val;
>  > +     while (!(uart[5] & 0x20)); /* Wait for TXRDY */
>  > +     local_irq_enable();
> 
>     Gah, why you decided to put local_irq_enable() there?!  KGDB expects
> interrupts to be *disabled* while it has control, else some subtle state
> corruptions will ensue, and it will eventually lock up. Please remove 
> these 2 calls completely.

Hmmm, this has been working for several months. I'll remove, retest and
resubmit.

Are you aware if this is the case for the "putchar" used by early_printk
as well?

Thanks,
Marc
