Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 00:46:45 +0000 (GMT)
Received: from [66.201.51.66] ([66.201.51.66]:51294 "EHLO ripper.onstor.net")
	by ftp.linux-mips.org with ESMTP id S20038566AbXB0Aqn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Feb 2007 00:46:43 +0000
Received: from andys by ripper.onstor.net with local (Exim 4.63)
	(envelope-from <andy.sharp@onstor.com>)
	id 1HLqRC-0007WI-Tv
	for linux-mips@linux-mips.org; Mon, 26 Feb 2007 16:43:26 -0800
Date:	Mon, 26 Feb 2007 16:43:26 -0800
From:	Andrew Sharp <tigerand@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Message-ID: <20070227004319.GA28882@onstor.com>
References: <200702270012.l1R0Ctq2006513@pasqua.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200702270012.l1R0Ctq2006513@pasqua.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tigerand@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 26 Feb 2007 18:12:55 -0600 Marc St-Jean <stjeanma@pmc-sierra.com> wrote:
> [PATCH 2/5] mips: PMC MSP71xx mips common
> 
> Patch to add mips common support for the PMC-Sierra
> MSP71xx devices.
> 
> These 5 patches along with the previously posted serial patch
> will boot the PMC-Sierra MSP7120 Residential Gateway board.
> 
> Thanks,
> Marc
> 
> Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
> ---
> Re-posting patch with two recommended changes:
> 1. Dropped the PMC_MSP_UNCACHED configuration item as this was
> already available in arch/mips/Kconfig.debug.
> 3. Dropped 'else' case to simplify patch to do_watch() in
> arch/mips/kernel/traps.c
> 
>  arch/mips/Kconfig           |   78 ++++++++++++++++++++
>  arch/mips/Makefile          |    8 ++
>  arch/mips/kernel/head.S     |    8 ++
>  arch/mips/kernel/traps.c    |    6 +
>  include/asm-mips/bootinfo.h |   12 +++
>  include/asm-mips/mipsregs.h |   30 +++++++
>  include/asm-mips/regops.h   |  168
> ++++++++++++++++++++++++++++++++++++++++++++
> include/asm-mips/war.h      |   11 ++ 8 files changed, 321 insertions(+)

My mailer kind of made a mess of things, hope I caught them all.

> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> index 6f57ca4..d7451b1 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -130,10 +130,18 @@
>  	.endm
>  
>  	/*
> +	 * Reserverd space not required for PMC boards, although we need to
> +	 * jump to kernel start.
> +	 */
> +#ifdef CONFIG_PMC_MSP
> +	jal	kernel_entry
> +#else
> +	/*
>  	 * Reserved space for exception handlers.
>  	 * Necessary for machines which link their kernels at KSEG0.
>  	 */
>  	.fill	0x400
> +#endif /* CONFIG_PMC_MSP */

This is getting kind of ugly.  There are a whole lot of config choices
that need to use the 'j kernel_entry'.  Do they all have to have their
own?  I'm not sure what the best way is to handle them all.


> diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
> index c7c945b..ab29fd4 100644
> --- a/include/asm-mips/bootinfo.h
> +++ b/include/asm-mips/bootinfo.h
> @@ -213,6 +213,18 @@
>  #define MACH_GROUP_NEC_EMMA2RH 25	/* NEC EMMA2RH (was 23)		*/
> #define  MACH_NEC_MARKEINS	0	/* NEC EMMA2RH Mark-eins	*/
> +/*
> + * Valid machtype for group PMC-MSP
> + */
> +#define MACH_GROUP_MSP         23	/* PMC-Sierra MSP boards/CPUs    */
> +#define MACH_MSP4200_EVAL       0	/* PMC-Sierra MSP4200 Evaluation board */
> +#define MACH_MSP4200_GW         1	/* PMC-Sierra MSP4200 Gateway demo board */
> +#define MACH_MSP4200_FPGA       2	/* PMC-Sierra MSP4200 Emulation board */
> +#define MACH_MSP7120_EVAL	   3	/* PMC-Sierra MSP7120 Evaluation board *
/
> +#define MACH_MSP7120_GW         4	/* PMC-Sierra MSP7120 Residential Gateway board */
> +#define MACH_MSP7120_FPGA       5	/* PMC-Sierra MSP7120 Emulation board */
> +#define MACH_MSP_OTHER	 255	/* PMC-Sierra unknown board type */
> +#define CL_SIZE			COMMAND_LINE_SIZE


Really I would add MACH_GROUP_MSP after MACH_GROUP_NEC_EMMA2RH,
perhaps 27 or 28, rather than an interior number.  Especially if
you are going to put it after MACH_GROUP_NEC_EMMA2RH in the file. ~:^)


Cheers,

a
