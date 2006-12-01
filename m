Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:12:27 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:59118 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037960AbWLAPMW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 15:12:22 +0000
Received: from localhost (p7250-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.250])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CCEA1BFB3; Sat,  2 Dec 2006 00:12:17 +0900 (JST)
Date:	Sat, 02 Dec 2006 00:12:17 +0900 (JST)
Message-Id: <20061202.001217.108120576.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Compile __do_IRQ() when really needed
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <457042FF.2060908@innova-card.com>
References: <457042FF.2060908@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 01 Dec 2006 15:58:07 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> __do_IRQ() is needed only by irq handlers that can't use
> default handler defined in kernel/irq/chip.c.
> 
> For others platforms there's no need to compile this function
> since it won't be used. For those platforms this patch defines
> GENERIC_HARDIRQS_NO__DO_IRQ symbol which is used exactly for
> this purpose.
> 
> Futhermore for platforms which do not use __do_IRQ(), end()
> method which is part of the 'irq_chip' structure is not used.
> This patch simply removes this method in this case.

As I wrote in separate mail, I think I had fault on
ioasic_dma_irq_type.  So please drop some part from your patch.


> @@ -171,6 +171,7 @@ config MACH_DECSTATION
>  	select SYS_SUPPORTS_128HZ
>  	select SYS_SUPPORTS_256HZ
>  	select SYS_SUPPORTS_1024HZ
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
>  	help
>  	  This enables support for DEC's MIPS based workstations.  For details
>  	  see the Linux/MIPS FAQ on <http://www.linux-mips.org/> and the

and

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

Sorry for confusion...
---
Atsushi Nemoto
