Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 20:36:15 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:58535 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039032AbXBWUgL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Feb 2007 20:36:11 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 228193EC9; Fri, 23 Feb 2007 12:35:38 -0800 (PST)
Message-ID: <45DF5014.8020503@ru.mvista.com>
Date:	Fri, 23 Feb 2007 23:35:32 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
References: <200702231956.l1NJu4Zd032458@pasqua.pmc-sierra.bc.ca>
In-Reply-To: <200702231956.l1NJu4Zd032458@pasqua.pmc-sierra.bc.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marc St-Jean wrote:

> [PATCH 2/5] mips: PMC MSP71xx mips common

> Patch to add mips common support for the PMC-Sierra
> MSP71xx devices.

> These 5 patches along with the previously posted serial patch
> will boot the PMC-Sierra MSP7120 Residential Gateway board.

> Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5da6b0d..d512389 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
[...]

> +menu "Options for PMC-Sierra MSP chipsets"
> +	depends on PMC_MSP
> +
> +config PMC_MSP_EMBEDDED_ROOTFS
> +	bool "Root filesystem embedded in kernel image"
> +	select MTD
> +	select MTD_BLOCK
> +	select MTD_PMC_MSP_RAMROOT
> +	select MTD_RAM
> +

    Hm, why not just use initramfs?

> +config PMC_MSP_UNCACHED
> +	bool "Run uncached"
> +	select MIPS_UNCACHED
> +	
> +endmenu
> +

    Erm, was there really a need for separate option?

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 18f56a9..610e169 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -70,6 +70,7 @@ extern asmlinkage void handle_reserved(void);
>  extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
>  	struct mips_fpu_struct *ctx, int has_fpu);
>  
> +void (*board_watchpoint_handler)(struct pt_regs *regs);
>  void (*board_be_init)(void);
>  int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
>  void (*board_nmi_handler_setup)(void);
> @@ -860,13 +861,17 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
>  
>  asmlinkage void do_watch(struct pt_regs *regs)
>  {
> -	/*
> -	 * We use the watch exception where available to detect stack
> -	 * overflows.
> -	 */
> -	dump_tlb_all();
> -	show_regs(regs);
> -	panic("Caught WATCH exception - probably caused by stack overflow.");
> +	if (board_watchpoint_handler) {
> +		(*board_watchpoint_handler)(regs);
> +	} else {
> +		/*
> +		 * We use the watch exception where available to detect stack
> +		 * overflows.
> +		 */
> +		dump_tlb_all();
> +		show_regs(regs);
> +		panic("Caught WATCH exception - probably caused by stack overflow.");
> +	}
>  }

    There was no real need for else and massive change, just add return right 
after calling the handler...

WBR, Sergei
