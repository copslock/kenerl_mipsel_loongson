Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 17:04:08 +0000 (GMT)
Received: from gateway-1237.mvista.com ([12.44.186.158]:48626 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225241AbSLKREH>;
	Wed, 11 Dec 2002 17:04:07 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBBH45l06881;
	Wed, 11 Dec 2002 09:04:05 -0800
Date: Wed, 11 Dec 2002 09:04:05 -0800
From: Jun Sun <jsun@mvista.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: Malta board patch
Message-ID: <20021211090405.B6755@mvista.com>
References: <3DF6F54C.64858797@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DF6F54C.64858797@mips.com>; from carstenl@mips.com on Wed, Dec 11, 2002 at 09:20:28AM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


A couple of nit-picking points ...

On Wed, Dec 11, 2002 at 09:20:28AM +0100, Carsten Langgaard wrote:
> Index: arch/mips/mips-boards/generic/pci.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mips-boards/generic/pci.c,v
> retrieving revision 1.5.2.4
> diff -u -r1.5.2.4 pci.c
> --- arch/mips/mips-boards/generic/pci.c	28 Sep 2002 18:28:44 -0000	1.5.2.4
> +++ arch/mips/mips-boards/generic/pci.c	11 Dec 2002 08:11:56 -0000
> @@ -405,6 +405,12 @@
>  			".set\treorder");
>  
>  		irq = *(volatile u32 *)(KSEG1ADDR(BONITO_PCICFG_BASE));
> +		__asm__ __volatile__(
> +			".set\tnoreorder\n\t"
> +			".set\tnoat\n\t"
> +			"sync\n\t"
> +			".set\tat\n\t"
> +			".set\treorder");
>  		irq &= 0xff;
>  		BONITO_PCIMAP_CFG = 0;
>  		break;

Would a higher level macro such as __sync or fast_mb be better here?

> Index: arch/mips/mips-boards/malta/malta_int.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mips-boards/malta/malta_int.c,v
> retrieving revision 1.8.2.6
> diff -u -r1.8.2.6 malta_int.c
> --- arch/mips/mips-boards/malta/malta_int.c	5 Aug 2002 23:53:34 -0000	1.8.2.6
> +++ arch/mips/mips-boards/malta/malta_int.c	11 Dec 2002 08:11:57 -0000
> @@ -91,6 +91,9 @@
>  {
>          unsigned int data,datahi;
>  
> +	/* Mask out corehi interrupt. */
> +	clear_c0_status(IE_IRQ3);
> +
>          printk("CoreHI interrupt, shouldn't happen, so we die here!!!\n");
>          printk("epc   : %08lx\nStatus: %08lx\nCause : %08lx\nbadVaddr : %08lx\n"
>  , regs->cp0_epc, regs->cp0_status, regs->cp0_cause, regs->cp0_badvaddr);
> @@ -125,7 +128,6 @@
>  
>          /* We die here*/
>          die("CoreHi interrupt", regs);
> -        while (1) ;
>  }
>  
>  void __init init_IRQ(void)

I think corehi interrupt should be blocked from the beginning.  I seem to 
remember a board errata itme that recommands not using it.

Jun
