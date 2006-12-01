Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:14:18 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:9477 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038324AbWLAPON (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 15:14:13 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 23E5EE1CAE;
	Fri,  1 Dec 2006 16:14:01 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U0fJsd1e4NwV; Fri,  1 Dec 2006 16:14:00 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C0A62E1CAC;
	Fri,  1 Dec 2006 16:14:00 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id kB1FEB1L013274;
	Fri, 1 Dec 2006 16:14:11 +0100
Date:	Fri, 1 Dec 2006 15:14:07 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Compile __do_IRQ() when really needed
In-Reply-To: <457042FF.2060908@innova-card.com>
Message-ID: <Pine.LNX.4.64N.0612011511330.5923@blysk.ds.pg.gda.pl>
References: <457042FF.2060908@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.6/2267/Fri Dec  1 05:29:21 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Dec 2006, Franck Bui-Huu wrote:

> diff --git a/arch/mips/dec/ioasic-irq.c b/arch/mips/dec/ioasic-irq.c
> index 269b22b..c5248a1 100644
> --- a/arch/mips/dec/ioasic-irq.c
> +++ b/arch/mips/dec/ioasic-irq.c
> @@ -55,19 +55,12 @@ static inline void ack_ioasic_irq(unsign
>  	fast_iob();
>  }
>  
> -static inline void end_ioasic_irq(unsigned int irq)
> -{
> -	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
> -		unmask_ioasic_irq(irq);
> -}
> -
>  static struct irq_chip ioasic_irq_type = {
>  	.typename = "IO-ASIC",
>  	.ack = ack_ioasic_irq,
>  	.mask = mask_ioasic_irq,
>  	.mask_ack = ack_ioasic_irq,
>  	.unmask = unmask_ioasic_irq,
> -	.end = end_ioasic_irq,
>  };
>  
>  
> @@ -77,20 +70,12 @@ static struct irq_chip ioasic_irq_type =
>  
>  #define ack_ioasic_dma_irq ack_ioasic_irq
>  
> -static inline void end_ioasic_dma_irq(unsigned int irq)
> -{
> -	clear_ioasic_irq(irq);
> -	fast_iob();
> -	end_ioasic_irq(irq);
> -}
> -
>  static struct irq_chip ioasic_dma_irq_type = {
>  	.typename = "IO-ASIC-DMA",
>  	.ack = ack_ioasic_dma_irq,
>  	.mask = mask_ioasic_dma_irq,
>  	.mask_ack = ack_ioasic_dma_irq,
>  	.unmask = unmask_ioasic_dma_irq,
> -	.end = end_ioasic_dma_irq,
>  };
>  
>  

 You have removed a call to clear_ioasic_irq() -- I/O ASIC DMA engines 
will cease to work as a result.

  Maciej
