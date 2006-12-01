Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:45:36 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:29905 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037895AbWLAPpb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 15:45:31 +0000
Received: from localhost (p7250-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.250])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8109EBDA5; Sat,  2 Dec 2006 00:45:27 +0900 (JST)
Date:	Sat, 02 Dec 2006 00:45:27 +0900 (JST)
Message-Id: <20061202.004527.52131670.anemo@mba.ocn.ne.jp>
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
X-archive-position: 13308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 01 Dec 2006 15:58:07 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> @@ -216,6 +217,7 @@ config MACH_JAZZ
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
>  	select SYS_SUPPORTS_100HZ
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
>  	help
>  	 This a family of machines based on the MIPS R4030 chipset which was
>  	 used by several vendors to build RISC/os and Windows NT workstations.

JAZZ uses i8259 which is not converted to irq flow handler yet.

> @@ -468,6 +473,7 @@ config DDB5477
>  config MACH_VR41XX
>  	bool "NEC VR41XX-based machines"
>  	select SYS_HAS_CPU_VR41XX
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
>  
>  config PMC_YOSEMITE
>  	bool "PMC-Sierra Yosemite eval board"

Same here.

> @@ -519,6 +525,7 @@ config MARKEINS
>  	select SYS_SUPPORTS_BIG_ENDIAN
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  	select SYS_HAS_CPU_R5000
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
>  	help
>  	  This enables support for the R5432-based NEC Mark-eins
>  	  boards with R5500 CPU.

For now emma2rh_gpio_irq_controller still needs __do_IRQ().

> @@ -539,6 +546,7 @@ config SGI_IP22
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_64BIT_KERNEL
>  	select SYS_SUPPORTS_BIG_ENDIAN
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
>  	help
>  	  This are the SGI Indy, Challenge S and Indigo2, as well as certain
>  	  OEM variants like the Tandem CMN B006S. To compile a Linux kernel

For now ip22_eisa1_irq_type and ip22_eisa2_irq_type need __do_IRQ().

> @@ -739,6 +748,7 @@ config TOSHIBA_RBTX4927
>  	select SYS_SUPPORTS_64BIT_KERNEL
>  	select SYS_SUPPORTS_BIG_ENDIAN
>  	select TOSHIBA_BOARDS
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
>  	help
>  	  This Toshiba board is based on the TX4927 processor. Say Y here to
>  	  support this machine type

For now toshiba_rbtx4927_irq_isa_type still needs __do_IRQ().

> @@ -758,6 +768,7 @@ config TOSHIBA_RBTX4938
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  	select SYS_SUPPORTS_BIG_ENDIAN
>  	select TOSHIBA_BOARDS
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
>  	help
>  	  This Toshiba board is based on the TX4938 processor. Say Y here to
>  	  support this machine type

RBTX4938(rbhma4500) uses i8259 which is not converted to irq flow
handler yet.

> @@ -214,15 +210,6 @@ static void tx4927_irq_cp0_disable(unsig
>  	tx4927_irq_cp0_modify(CCP0_STATUS, tx4927_irq_cp0_mask(irq), 0);
>  }
>  
> -static void tx4927_irq_cp0_end(unsigned int irq)
> -{
> -	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_ENDIRQ, "irq=%d \n", irq);
> -
> -	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
> -		tx4927_irq_cp0_enable(irq);
> -	}
> -}
> -
>  /*
>   * Functions for pic
>   */
> @@ -376,15 +363,6 @@ static void tx4927_irq_pic_disable(unsig
>  			      tx4927_irq_pic_mask(irq), 0);
>  }
>  
> -static void tx4927_irq_pic_end(unsigned int irq)
> -{
> -	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_ENDIRQ, "irq=%d\n", irq);
> -
> -	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
> -		tx4927_irq_pic_enable(irq);
> -	}
> -}
> -
>  /*
>   * Main init functions
>   */

You can remove those lines too:

#define TX4927_IRQ_CP0_ENDIRQ   ( 1 << 16 )
#define TX4927_IRQ_PIC_ENDIRQ   ( 1 << 26 )

> diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
> index 34cdb2a..ce4ef10 100644
> --- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
> +++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
> @@ -388,23 +386,6 @@ static void toshiba_rbtx4927_irq_ioc_dis
>  	TOSHIBA_RBTX4927_WR08(TOSHIBA_RBTX4927_IOC_INTR_ENAB, v);
>  }
>  
> -static void toshiba_rbtx4927_irq_ioc_end(unsigned int irq)
> -{
> -	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_IOC_ENDIRQ,
> -				     "irq=%d\n", irq);
> -
> -	if (irq < TOSHIBA_RBTX4927_IRQ_IOC_BEG
> -	    || irq > TOSHIBA_RBTX4927_IRQ_IOC_END) {
> -		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
> -					     "bad irq=%d\n", irq);
> -		panic("\n");
> -	}
> -
> -	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
> -		toshiba_rbtx4927_irq_ioc_enable(irq);
> -	}
> -}
> -
>  
>  /**********************************************************************************/
>  /* Functions for isa                                                              */

You can remove this line too:

#define TOSHIBA_RBTX4927_IRQ_IOC_ENDIRQ    ( 1 << 16 )
