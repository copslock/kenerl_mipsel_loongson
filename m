Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 17:54:13 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:42303 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991743AbdK1QyGSLyC3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 17:54:06 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id E020720396; Tue, 28 Nov 2017 17:53:58 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id B3BE020380;
        Tue, 28 Nov 2017 17:53:58 +0100 (CET)
Date:   Tue, 28 Nov 2017 17:53:59 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] MIPS: mscc: Add initial support for Microsemi MIPS
 SoCs
Message-ID: <20171128165359.GJ21126@piout.net>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-10-alexandre.belloni@free-electrons.com>
 <20171128160137.GF27409@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128160137.GF27409@jhogan-linux.mipstec.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

On 28/11/2017 at 16:01:38 +0000, James Hogan wrote:
> Hi Alexandre,
> 
> On Tue, Nov 28, 2017 at 04:26:39PM +0100, Alexandre Belloni wrote:
> > Introduce support for the MIPS based Microsemi Ocelot SoCs.
> > As the plan is to have all SoCs supported only using device tree, the
> > mach directory is simply called mscc.
> 
> Nice. Have you considered adding this to the existing multiplatform
> "generic" platform? See for example commit b35565bb16a5 ("MIPS: generic:
> Add support for MIPSfpga") for the latest platform to be converted.
> 

I didn't because we are currently booting using an old redboot with its
own boot protocol and at boot, the register read by the sead3 code is
completely random (it actually matched once).

Do you consider that mandatory to get the platform upstream?

the plan is to switch to u-boot but we will definitively need to keep
supporting redboot.

> Cheers
> James
> 
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  arch/mips/Kbuild.platforms |   1 +
> >  arch/mips/Kconfig          |  24 ++++++++++
> >  arch/mips/mscc/Makefile    |  11 +++++
> >  arch/mips/mscc/Platform    |  12 +++++
> >  arch/mips/mscc/setup.c     | 106 +++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 154 insertions(+)
> >  create mode 100644 arch/mips/mscc/Makefile
> >  create mode 100644 arch/mips/mscc/Platform
> >  create mode 100644 arch/mips/mscc/setup.c
> > 
> > diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> > index ac7ad54f984f..b3b2f8dc91db 100644
> > --- a/arch/mips/Kbuild.platforms
> > +++ b/arch/mips/Kbuild.platforms
> > @@ -18,6 +18,7 @@ platforms += lantiq
> >  platforms += lasat
> >  platforms += loongson32
> >  platforms += loongson64
> > +platforms += mscc
> >  platforms += mti-malta
> >  platforms += netlogic
> >  platforms += paravirt
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 350a990fc719..a9db028a0338 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -527,6 +527,30 @@ config MIPS_MALTA
> >  	  This enables support for the MIPS Technologies Malta evaluation
> >  	  board.
> >  
> > +config MSCC_OCELOT
> > +	bool "Microsemi Ocelot architecture"
> > +	select BOOT_RAW
> > +	select CEVT_R4K
> > +	select CSRC_R4K
> > +	select IRQ_MIPS_CPU
> > +	select DMA_NONCOHERENT
> > +	select SYS_HAS_CPU_MIPS32_R2
> > +	select SYS_SUPPORTS_32BIT_KERNEL
> > +	select SYS_SUPPORTS_BIG_ENDIAN
> > +	select SYS_SUPPORTS_LITTLE_ENDIAN
> > +	select SYS_HAS_EARLY_PRINTK
> > +	select USE_GENERIC_EARLY_PRINTK_8250
> > +	select MSCC_OCELOT_IRQ
> > +	select PINCTRL
> > +	select GPIOLIB
> > +	select COMMON_CLK
> > +	select USE_OF
> > +	select BUILTIN_DTB
> > +	select LIBFDT
> > +	help
> > +	  This enables support for the Microsemi Ocelot architecture.
> > +	  It builds a generic DT-based kernel image.
> > +
> >  config MACH_PIC32
> >  	bool "Microchip PIC32 Family"
> >  	help
> > diff --git a/arch/mips/mscc/Makefile b/arch/mips/mscc/Makefile
> > new file mode 100644
> > index 000000000000..c96b13546730
> > --- /dev/null
> > +++ b/arch/mips/mscc/Makefile
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +#
> > +# Microsemi MIPS SoC support
> > +#
> > +# License: Dual MIT/GPL
> > +# Copyright (c) 2017 Microsemi Corporation
> > +
> > +#
> > +# Makefile for the Microsemi MIPS SoCs
> > +#
> > +obj-y := setup.o
> > diff --git a/arch/mips/mscc/Platform b/arch/mips/mscc/Platform
> > new file mode 100644
> > index 000000000000..9ae874c8f136
> > --- /dev/null
> > +++ b/arch/mips/mscc/Platform
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +#
> > +# Microsemi MIPS SoC support
> > +#
> > +# License: Dual MIT/GPL
> > +# Copyright (c) 2017 Microsemi Corporation
> > +
> > +#
> > +# Microsemi Ocelot board(s)
> > +#
> > +platform-$(CONFIG_MSCC_OCELOT) += mscc/
> > +load-$(CONFIG_MSCC_OCELOT)	 += 0x80100000
> > diff --git a/arch/mips/mscc/setup.c b/arch/mips/mscc/setup.c
> > new file mode 100644
> > index 000000000000..77803edd7bfd
> > --- /dev/null
> > +++ b/arch/mips/mscc/setup.c
> > @@ -0,0 +1,106 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Microsemi MIPS SoC support
> > + *
> > + * License: Dual MIT/GPL
> > + * Copyright (c) 2017 Microsemi Corporation
> > + */
> > +#include <linux/delay.h>
> > +#include <linux/export.h>
> > +#include <linux/init.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/libfdt.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/reboot.h>
> > +
> > +#include <asm/time.h>
> > +#include <asm/idle.h>
> > +#include <asm/prom.h>
> > +#include <asm/reboot.h>
> > +
> > +static void __init ocelot_earlyprintk_init(void)
> > +{
> > +	void __iomem *uart_base;
> > +
> > +	uart_base = ioremap_nocache(0x70100000, 0x0f);
> > +	setup_8250_early_printk_port((unsigned long)uart_base, 2, 50000);
> > +}
> > +
> > +void __init prom_init(void)
> > +{
> > +	/* Sanity check for defunct bootloader */
> > +	if (fw_arg0 < 10 && (fw_arg1 & 0xFFF00000) == 0x80000000) {
> > +		unsigned int prom_argc = fw_arg0;
> > +		const char **prom_argv = (const char **)fw_arg1;
> > +
> > +		if (prom_argc > 1 && strlen(prom_argv[1]) > 0)
> > +			/* ignore all built-in args if any f/w args given */
> > +			strcpy(arcs_cmdline, prom_argv[1]);
> > +	}
> > +}
> > +
> > +void __init prom_free_prom_memory(void)
> > +{
> > +}
> > +
> > +unsigned int get_c0_compare_int(void)
> > +{
> > +	return CP0_LEGACY_COMPARE_IRQ;
> > +}
> > +
> > +void __init plat_time_init(void)
> > +{
> > +	struct device_node *np;
> > +	u32 freq;
> > +
> > +	np = of_find_node_by_name(NULL, "cpus");
> > +	if (!np)
> > +		panic("missing 'cpus' DT node");
> > +	if (of_property_read_u32(np, "mips-hpt-frequency", &freq) < 0)
> > +		panic("missing 'mips-hpt-frequency' property");
> > +	of_node_put(np);
> > +
> > +	mips_hpt_frequency = freq;
> > +}
> > +
> > +void __init arch_init_irq(void)
> > +{
> > +	irqchip_init();
> > +}
> > +
> > +const char *get_system_type(void)
> > +{
> > +	return "Microsemi Ocelot";
> > +}
> > +
> > +static void __init ocelot_late_init(void)
> > +{
> > +	ocelot_earlyprintk_init();
> > +}
> > +
> > +extern void (*late_time_init)(void);
> > +
> > +void __init plat_mem_setup(void)
> > +{
> > +	/* This has to be done so late because ioremap needs to work */
> > +	late_time_init = ocelot_late_init;
> > +
> > +	__dt_setup_arch(__dtb_start);
> > +}
> > +
> > +void __init device_tree_init(void)
> > +{
> > +	if (!initial_boot_params)
> > +		return;
> > +
> > +	unflatten_and_copy_device_tree();
> > +}
> > +
> > +static int __init populate_machine(void)
> > +{
> > +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +	return 0;
> > +}
> > +arch_initcall(populate_machine);
> > -- 
> > 2.15.0
> > 
> > 



-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
