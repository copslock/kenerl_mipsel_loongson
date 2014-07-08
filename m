Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 18:04:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52293 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861343AbaGHQECtgYLP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Jul 2014 18:04:02 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 54EFDBF12968;
        Tue,  8 Jul 2014 17:03:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 8 Jul 2014 17:03:55 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 8 Jul
 2014 17:03:54 +0100
Message-ID: <53BC15DA.7050602@imgtec.com>
Date:   Tue, 8 Jul 2014 17:01:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>, <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH RFC] MIPS: add support for vmlinux appended DTB
References: <1404832446-31028-1-git-send-email-jogo@openwrt.org>
In-Reply-To: <1404832446-31028-1-git-send-email-jogo@openwrt.org>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Jonas,

On 08/07/14 16:14, Jonas Gorski wrote:
> Add support for populating initial_device_params through a dtb

initial_boot_params here and above?

> blob appended to vmlinux.

should that be vmlinux.bin? Presumably it isn't appended to the ELF file?

> 
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
> Mostly adapted from how ARM is doing it.
> 
> Sent as an RFC PATCH because I am not sure if this is the right way to
> it, and whether storing the pointer in initial_device_params is a good
> idea, or a new variable should be introduced.
> 
> The reasoning for initial_device_params is that there is no common
> MIPS interface yet, so the next best thing was using that. This also
> has the advantage of keeping the original fw_args intact.

Does it matter that this will be ignored if the bootloader does provide
a DT (initial_boot_params overwritten by early_init_dt_scan() call), and
that if no DT is provided by the bootloader the of_scan_flat_dt() calls
at the bottom of early_init_dt_scan will never happen?

> 
> This patch works for me on bcm63xx, where the bootloade expects

s/bootloade/bootloader/

> an lzma compressed kernel, so I wanted to not double compress using
> the in-kernel compressed kernel support.
> 
> Completely untested on anything except MIPS32 / big endian.
> 
>  arch/mips/Kconfig              | 18 ++++++++++++++++++
>  arch/mips/kernel/head.S        | 19 +++++++++++++++++++
>  arch/mips/kernel/vmlinux.lds.S |  6 ++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3f05b56..58527cd 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2476,6 +2476,24 @@ config USE_OF
>  	select OF_EARLY_FLATTREE
>  	select IRQ_DOMAIN
>  
> +config MIPS_APPENDED_DTB
> +	bool "Use appended device tree blob to vmlinux (EXPERIMENTAL)"
> +	depends on OF
> +	help
> +	  With this option, the boot code will look for a device tree binary
> +	  DTB) appended to vmlinux

s/DTB)/(DTB)/

vmlinux.bin again?

> +	  (e.g. cat vmlinux <filename>.dtb > vmlinux_w_dtb).

here too I think.

> +
> +	  This is meant as a backward compatibility convenience for those
> +	  systems with a bootloader that can't be upgraded to accommodate
> +	  the documented boot protocol using a device tree.
> +
> +	  Beware that there is very little in terms of protection against
> +	  this option being confused by leftover garbage in memory that might
> +	  look like a DTB header after a reboot if no actual DTB is appended
> +	  to vmlinux.  Do not leave this option active in a production kernel

maybe same here too.

Can't fault the rest though.

Cheers
James

> +	  if you don't intend to always append a DTB.
> +
>  endmenu
>  
>  config LOCKDEP_SUPPORT
> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> index 95afd66..72c1049 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -93,7 +93,22 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
>  	PTR_LA	t0, 0f
>  	jr	t0
>  0:
> +#ifdef CONFIG_MIPS_APPENDED_DTB
> +	PTR_LA		t0, __appended_dtb
> +	PTR_LI		t3, 0
>  
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +	PTR_LI		t1, 0xd00dfeed
> +#else
> +	PTR_LI		t1, 0xedfe0dd0
> +#endif
> +	LONG_L		t2, (t0)
> +	bne		t1, t2, not_found
> +
> +	PTR_LA		t3, __appended_dtb
> +
> +not_found:
> +#endif
>  	PTR_LA		t0, __bss_start		# clear .bss
>  	LONG_S		zero, (t0)
>  	PTR_LA		t1, __bss_stop - LONGSIZE
> @@ -107,6 +122,10 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
>  	LONG_S		a2, fw_arg2
>  	LONG_S		a3, fw_arg3
>  
> +#ifdef CONFIG_MIPS_APPENDED_DTB
> +	LONG_S		t3, initial_boot_params
> +#endif
> +
>  	MTC0		zero, CP0_CONTEXT	# clear context register
>  	PTR_LA		$28, init_thread_union
>  	/* Set the SP after an empty pt_regs.  */
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> index 3b46f7c..8009530 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -127,6 +127,12 @@ SECTIONS
>  	}
>  
>  	PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
> +
> +#ifdef CONFIG_MIPS_APPENDED_DTB
> +	__appended_dtb = .;
> +	/* leave space for appended DTB */
> +	. = . + 0x100000;
> +#endif
>  	/*
>  	 * Align to 64K in attempt to eliminate holes before the
>  	 * .bss..swapper_pg_dir section at the start of .bss.  This
> 
