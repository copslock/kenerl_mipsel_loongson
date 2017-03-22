Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2017 09:18:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26443 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993457AbdCVISkEJW4A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Mar 2017 09:18:40 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 171D6B8A9F95
        for <linux-mips@linux-mips.org>; Wed, 22 Mar 2017 08:18:29 +0000 (GMT)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 22 Mar
 2017 08:18:31 +0000
Subject: Re: [PATCH] Add initial SX3000b platform code to MIPS arch
To:     <linux-mips@linux-mips.org>
References: <AM4PR0201MB2179B0EE9D0C00461C999697E43C0@AM4PR0201MB2179.eurprd02.prod.outlook.com>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <0de3d9ac-057b-1d7e-9c20-87943fa62aae@imgtec.com>
Date:   Wed, 22 Mar 2017 09:18:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <AM4PR0201MB2179B0EE9D0C00461C999697E43C0@AM4PR0201MB2179.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Amit,

On 22.03.2017 06:38, Amit Kama IL wrote:
> Add initial support for boards based on Satixfy's SX3000b (Catniss) SoC.
> The SoC includes a MIPS interAptiv dual core 4 VPE processor and boots
> using device-tree.
>
> Signed-off-by: Amit Kama <amit.kama@staixfy.com>
>
> The irqchip file (irq-sx3000b.c) is pertinent to the platform.
> IRQCHIP maintainers - is it possible to merge this through MIPS tree?
>

Thank you for your patches. Is there any documentation available for the 
chip you're adding support for?
I've found your company website with a link to the SoC at 
http://satixfy.com/dev/?page_id=145 - but that page doesn't work properly.

We generally would expect modern MIPS platforms to use a generic 
platform rather than adding a lot of custom code. Would it be possible 
to update your code to make use of it? You can find some details of it here:
https://paulburton.eu/kernel-docs/mips/generic-platform.html
and an example of a new platform being added here:
https://patchwork.linux-mips.org/patch/15545/
(if you search the linux-mips archive you can see earlier revisions of 
the NI board patches which initially also started as a custom platform 
but have later been updated to generic).

Please see also a few comments below.

>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> old mode 100666
> new mode 100666
> index a008a9f..1bcb300
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -551,6 +551,31 @@ config MACH_PIC32
> 	  Microchip PIC32 is a family of general-purpose 32 bit MIPS core
> 	  microcontrollers.
>
> +config MACH_SX3000
> +	bool "Satixfy SX3000 based boards"
> +	select SYS_SUPPORTS_32BIT_KERNEL
> +	select SYS_SUPPORTS_LITTLE_ENDIAN
> +	select SYS_SUPPORTS_MIPS_CPS
> +	select SYS_SUPPORTS_MULTITHREADING
> +	select SYS_HAS_CPU_MIPS32_R2
> +	select SYS_HAS_CPU_MIPS32_R3_5
> +	select SYS_HAS_EARLY_PRINTK
> +	select USE_GENERIC_EARLY_PRINTK_8250
> +	select DMA_MAYBE_COHERENT
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select LIBFDT
> +	select USE_OF
> +	select BUILTIN_DTB
> +	select IRQ_MIPS_CPU
> +	select MIPS_GIC
> +	select SX3000_ICU
> +	select MIPS_CPU_SCACHE
> +	select CLKSRC_MIPS_GIC
> +	select COMMON_CLK
> +	select BOOT_RAW
> +	help
> +	  This enables support for the Satixfy SX3000 SoC.
> +
>  config NEC_MARKEINS
> 	bool "NEC EMMA2RH Mark-eins board"
> 	select SOC_EMMA2RH
> @@ -1022,6 +1047,7 @@ source "arch/mips/pmcs-msp71xx/Kconfig"
>  source "arch/mips/ralink/Kconfig"
>  source "arch/mips/sgi-ip27/Kconfig"
>  source "arch/mips/sibyte/Kconfig"
> +source "arch/mips/sx3000/Kconfig"
>  source "arch/mips/txx9/Kconfig"
>  source "arch/mips/vr41xx/Kconfig"
>  source "arch/mips/cavium-octeon/Kconfig"
> diff --git a/arch/mips/boot/dts/sx3000/Makefile b/arch/mips/boot/dts/sx3000/Makefile
> new file mode 100666
> index 0000000..8b73c39
> --- /dev/null
> +++ b/arch/mips/boot/dts/sx3000/Makefile
> @@ -0,0 +1,13 @@
> +dtb-$(CONFIG_SX3000_DEVBOARD)	+= sx3000_devboard.dtb
> +dtb-$(CONFIG_SX3000_BBB)	+= sx3000_bbb.dtb
> +dtb-$(SX3000_IDU3)		+= sx3000_idu3.dtb
> +dtb-$(SX3000_IDU4)		+= sx3000_idu4.dtb
> +
> +
> +obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-				+= dummy.o
> +
> +always				:= $(dtb-y)
> +clean-files	:= *.dtb *.dtb.S

> diff --git a/arch/mips/include/asm/mach-sx3000/irq.h b/arch/mips/include/asm/mach-sx3000/irq.h
> new file mode 100755
> index 0000000..2018718
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-sx3000/irq.h
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (C) 2016 Imagination Technologies
> + * Author: Matt Redfearn <matt.redfearn@@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __MIPS_ASM_MACH_SX3000_IRQ_H__
> +#define __MIPS_ASM_MACH_SX3000_IRQ_H__
> +
> +#define NR_IRQS 128
> +
> +#include_next <irq.h>
> +
> +#endif /* __MIPS_ASM_MACH_SX3000_IRQ_H__ */
> diff --git a/arch/mips/include/asm/mach-sx3000/kernel-entry-init.h b/arch/mips/include/asm/mach-sx3000/kernel-entry-init.h
> new file mode 100755
> index 0000000..63e7b04
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-sx3000/kernel-entry-init.h
> @@ -0,0 +1,54 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Matt Redfearn <matt.redfearn@imgtec.com>
> + * Copyright (C) 2016 Imagination Technologies Ltd.
> + */
> +#ifndef __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
> +#define __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
> +
> +#include <asm/regdef.h>
> +#include <asm/mipsregs.h>
> +
> + /*
> + * Prepare segments for EVA boot:
> + */
> + .macro platform_eva_init
> +
> + .endm
> +
> + .macro kernel_entry_setup
> +
> +#ifdef CONFIG_EVA
> + sync
> + ehb
> +
> + mfc0    t1, CP0_CONFIG
> + bgez    t1, 9f
> + mfc0 t0, CP0_CONFIG, 1
> + bgez t0, 9f
> + mfc0 t0, CP0_CONFIG, 2
> + bgez t0, 9f
> + mfc0 t0, CP0_CONFIG, 3
> + sll     t0, t0, 6   /* SC bit */
> + bgez    t0, 9f
> +
> + platform_eva_init
> +#endif /* CONFIG_EVA */
> +9 :
> + .endm


Since you've left platform_eva_init empty and don't perform the segment 
configuration here, the code above doesn't do anything useful and can be 
safely removed (if you move to a generic platform then it is a non-issue 
as those macros are left empty in the generic init anyway).

> +/*
> + * Do SMP slave processor setup necessary before we can safely execute C code.
> + */
> + .macro smp_slave_setup
> +#ifdef CONFIG_EVA
> + sync
> + ehb
> + platform_eva_init
> +#endif
> + .endm
> +
> +#endif /* __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H */
> diff --git a/arch/mips/sx3000/Kconfig b/arch/mips/sx3000/Kconfig
> new file mode 100755
> index 0000000..f20d88a
> --- /dev/null
> +++ b/arch/mips/sx3000/Kconfig
> @@ -0,0 +1,18 @@
> +choice
> +	prompt "Machine type"
> +	depends on MACH_SX3000
> +	default SX3000_DEVBOARD
> +
> +config SX3000_DEVBOARD
> +	bool "SX3000 Development board"
> +
> +config SX3000_BBB
> +	bool "SX3000 BBB board"
> +
> +config SX3000_IDU3
> +	bool "SX3000 IDU rev 3 board"
> +
> +config SX3000_IDU4
> +	bool "SX3000 IDU rev 4 board"
> +
> +endchoice
> diff --git a/arch/mips/sx3000/Makefile b/arch/mips/sx3000/Makefile
> new file mode 100755
> index 0000000..ac3c5d2
> --- /dev/null
> +++ b/arch/mips/sx3000/Makefile
> @@ -0,0 +1 @@
> +obj-y += init.o irq.o time.o sx3000-reset.o
> diff --git a/arch/mips/sx3000/Platform b/arch/mips/sx3000/Platform
> new file mode 100755
> index 0000000..d6a55d5
> --- /dev/null
> +++ b/arch/mips/sx3000/Platform
> @@ -0,0 +1,3 @@
> +platform-$(CONFIG_MACH_SX3000) += sx3000/
> +cflags-$(CONFIG_MACH_SX3000) += -I$(srctree)/arch/mips/include/asm/mach-sx3000
> +load-$(CONFIG_MACH_SX3000) += 0xffffffff80400000
> diff --git a/arch/mips/sx3000/init.c b/arch/mips/sx3000/init.c
> new file mode 100755
> index 0000000..5245d06
> --- /dev/null
> +++ b/arch/mips/sx3000/init.c
> @@ -0,0 +1,123 @@
> +/*
> + * SX3000 platform setup
> + *
> + * Copyright (C) 2016 Imagination Technologies
> + * Author: Matt Redfearn <matt.redfearn@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/dma-coherence.h>
> +#include <asm/fw/fw.h>
> +#include <asm/mips-boards/generic.h>
> +#include <asm/mips-cm.h>
> +#include <asm/mips-cpc.h>
> +#include <asm/prom.h>
> +#include <asm/traps.h>
> +
> +/* Uncached (KSEG1) virtual address of console UART */
> +#define SX3000_UART0_BASE	0xBD4D09C0 // (0xA000_0000 for kseg1 + 0x1D4D09C0)
> +
> +/* Physical addresses where the CPC and CDMM regions can be mapped to */
> +#define DEFAULT_CPC_BASE_ADDR	0x1DA00000
> +#define DEFAULT_CDMM_BASE_ADDR	0x1DA20000
> +
> +const char *get_system_type(void)
> +{
> +	/*
> +	 * If your SoC has a revision register, you should
> +	 * read it here and return the appropriate name.
> +	 */
> +	return "SX3000";
> +}
> +
> +phys_addr_t mips_cpc_default_phys_base(void)
> +{
> +	return DEFAULT_CPC_BASE_ADDR;
> +}
> +
> +phys_addr_t mips_cdmm_phys_base(void)
> +{
> +	return DEFAULT_CDMM_BASE_ADDR;
> +}
> +
> +static void __init plat_setup_iocoherency(void)
> +{
> +	/*
> +	 * Kernel has been configured with software coherency
> +	 * but we might choose to turn it off and use hardware
> +	 * coherency instead.
> +	 */
> +	if (mips_cm_numiocu() != 0) {
> +		/* Nothing special needs to be done to enable coherency */
> +		pr_info("CMP IOCU detected\n");
> +
> +		hw_coherentio = 0;
> +		coherentio = 0;
> +		if (coherentio == 0)
> +			pr_info("Hardware DMA cache coherency disabled\n");
> +		else
> +			pr_info("Hardware DMA cache coherency enabled\n");
> +	} else {
> +		if (coherentio == 1)
> +			pr_info("Hardware DMA cache coherency unsupported, but enabled from command line!\n");
> +		else
> +			pr_info("Software DMA cache coherency enabled\n");
> +	}
> +}
> +
> +void __init plat_mem_setup(void)
> +{
> +	__dt_setup_arch(__dtb_start);
> +	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> +	// Change segctl 0,2 to confer with legacy mode
> +	write_c0_segctl0(0x00230013);
> +
> +	write_c0_segctl2(0x00330033);

This looks like really the only thing that would require any extra 
support in the generic code - ie. to configure EVA segments. I think you 
could do it via board-specific prom_init handler (in a similar fashion 
to what mach->fixup_fdt does currently).
Could you also use the exising macros to descibe the EVA layout rather 
than using a magic number directly? You can use 
mach-malta/kernel-entry-init as an example.

> +	plat_setup_iocoherency();
> +}
> +
> +void __init prom_init(void)
> +{
> +	/* Set up early printk (byte access, 50000 timeout */
> +	setup_8250_early_printk_port(SX3000_UART0_BASE, 2, 50000);
> +
> +	mips_cm_probe();
> +	mips_cpc_probe();
> +#ifdef CONFIG_MIPS_CPS
> +	register_cps_smp_ops();
> +#endif
> +}
> +
> +void __init prom_free_prom_memory(void)
> +{
> +}
> +
> +void __init device_tree_init(void)
> +{
> +	if (!initial_boot_params)
> +		return;
> +
> +	unflatten_and_copy_device_tree();
> +}
> +
> +static int __init plat_of_setup(void)
> +{
> +	if (!of_have_populated_dt())
> +		panic("Device tree not present");
> +
> +	if (of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL))
> +		panic("Failed to populate DT");
> +
> +	return 0;
> +}
> +arch_initcall(plat_of_setup);
> diff --git a/arch/mips/sx3000/irq.c b/arch/mips/sx3000/irq.c
> new file mode 100755
> index 0000000..76c4301
> --- /dev/null
> +++ b/arch/mips/sx3000/irq.c
> @@ -0,0 +1,35 @@
> +/*
> + * SX3000 IRQ setup
> + *
> + * Copyright (C) 2016 Imagination Technologies
> + * Author: Matt Redfearn <matt.redfearn@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/mips-gic.h>
> +#include <linux/kernel.h>
> +
> +#include <asm/cpu-features.h>
> +#include <asm/irq.h>
> +#include <asm/irq_cpu.h>
> +
> +void __init arch_init_irq(void)
> +{
> +	pr_info("EIC is %s\n", cpu_has_veic ? "on" : "off");
> +	pr_info("VINT is %s\n", cpu_has_vint ? "on" : "off");
> +
> +	pr_info("IRQ base, CPU: %d GIC: %d\n", MIPS_CPU_IRQ_BASE, MIPS_GIC_IRQ_BASE);
> +
> +	// Clear the IPL field in the status register to have minimum int level 0
> +	clear_c0_status(ST0_IM);
> +
> +	if (!cpu_has_veic)
> +		mips_cpu_irq_init();
> +
> +	irqchip_init();
> +}
> diff --git a/arch/mips/sx3000/sx3000-reset.c b/arch/mips/sx3000/sx3000-reset.c
> new file mode 100755
> index 0000000..82c5bb3
> --- /dev/null
> +++ b/arch/mips/sx3000/sx3000-reset.c


This looks like just using a gpio to perform the reset? In that case you 
could use an already existing "gpio-restart" driver.





Best regards,
Marcin
