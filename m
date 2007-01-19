Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jan 2007 17:33:36 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:13782 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20049897AbXASRda (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Jan 2007 17:33:30 +0000
Received: (qmail 20350 invoked by uid 101); 19 Jan 2007 17:33:15 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 19 Jan 2007 17:33:15 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l0JHXEg2020923
	for <linux-mips@linux-mips.org>; Fri, 19 Jan 2007 09:33:15 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <DCB587PQ>; Fri, 19 Jan 2007 09:33:14 -0800
Message-ID: <5C1FD43E5F1B824E83985A74F396286E03AD7629@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	er
Date:	Fri, 19 Jan 2007 09:33:06 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

 

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@linux-mips.org] 
> Sent: Friday, January 19, 2007 8:18 AM
> To: Marc St-Jean
> Cc: linux-mips@linux-mips.org; linux-serial@vger.kernel.org
> Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel 
> linux-mips.git master
> 
> On Thu, Jan 18, 2007 at 04:23:01PM -0800, Marc St-Jean wrote:
> 
> > Index: linux_2_6/drivers/serial/8250.c 
> > ===================================================================
> > RCS file: linux_2_6/drivers/serial/8250.c,v retrieving revision 
> > 1.1.1.7 retrieving revision 1.9 diff -u -r1.1.1.7 -r1.9
> > --- linux_2_6/drivers/serial/8250.c	19 Oct 2006 21:00:58 
> -0000	1.1.1.7
> > +++ linux_2_6/drivers/serial/8250.c	19 Oct 2006 22:08:15 
> -0000	1.9
> > @@ -44,6 +44,10 @@
> >   #include <asm/io.h>
> >   #include <asm/irq.h>
> > 
> > +#ifdef CONFIG_PMC_MSP
> > +#include <msp_regs.h>
> > +#endif
> 
> CONFIG_PMC_MSP is not defined anywhere.  msp_regs.h does not exist.
> 
>   Ralf
> 

Hi Ralf,

CONFIG_PMC_MSP is defined in the main platform patch (arch/mips/Kconfig). I doesn't apply against the git HEAD yet. I'm still working on it and will post as soon as it does.

msp_regs.h defines the UART0_STATUS_REG and UART1_STATUS_REG SoC addresses for the DesignWare UART. I thought of putting them in include/linux/serial_reg.h but it contains register offsets only, no platform addresses.

That is one of the main issues, how to add MSP71xx specific register mapping without platform tests/includes?

Marc
