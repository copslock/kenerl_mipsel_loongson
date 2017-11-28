Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 17:06:37 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:39886 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990596AbdK1QG3EEUGY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 17:06:29 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 28 Nov 2017 16:05:37 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 28 Nov
 2017 08:01:40 -0800
Date:   Tue, 28 Nov 2017 16:01:38 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/13] MIPS: mscc: Add initial support for Microsemi MIPS
 SoCs
Message-ID: <20171128160137.GF27409@jhogan-linux.mipstec.com>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-10-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <20171128152643.20463-10-alexandre.belloni@free-electrons.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1511885134-321457-14198-265-3
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187380
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Tue, Nov 28, 2017 at 04:26:39PM +0100, Alexandre Belloni wrote:
> Introduce support for the MIPS based Microsemi Ocelot SoCs.
> As the plan is to have all SoCs supported only using device tree, the
> mach directory is simply called mscc.

Nice. Have you considered adding this to the existing multiplatform
"generic" platform? See for example commit b35565bb16a5 ("MIPS: generic:
Add support for MIPSfpga") for the latest platform to be converted.

Cheers
James

>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/mips/Kbuild.platforms |   1 +
>  arch/mips/Kconfig          |  24 ++++++++++
>  arch/mips/mscc/Makefile    |  11 +++++
>  arch/mips/mscc/Platform    |  12 +++++
>  arch/mips/mscc/setup.c     | 106 +++++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 154 insertions(+)
>  create mode 100644 arch/mips/mscc/Makefile
>  create mode 100644 arch/mips/mscc/Platform
>  create mode 100644 arch/mips/mscc/setup.c
>=20
> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> index ac7ad54f984f..b3b2f8dc91db 100644
> --- a/arch/mips/Kbuild.platforms
> +++ b/arch/mips/Kbuild.platforms
> @@ -18,6 +18,7 @@ platforms +=3D lantiq
>  platforms +=3D lasat
>  platforms +=3D loongson32
>  platforms +=3D loongson64
> +platforms +=3D mscc
>  platforms +=3D mti-malta
>  platforms +=3D netlogic
>  platforms +=3D paravirt
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 350a990fc719..a9db028a0338 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -527,6 +527,30 @@ config MIPS_MALTA
>  	  This enables support for the MIPS Technologies Malta evaluation
>  	  board.
> =20
> +config MSCC_OCELOT
> +	bool "Microsemi Ocelot architecture"
> +	select BOOT_RAW
> +	select CEVT_R4K
> +	select CSRC_R4K
> +	select IRQ_MIPS_CPU
> +	select DMA_NONCOHERENT
> +	select SYS_HAS_CPU_MIPS32_R2
> +	select SYS_SUPPORTS_32BIT_KERNEL
> +	select SYS_SUPPORTS_BIG_ENDIAN
> +	select SYS_SUPPORTS_LITTLE_ENDIAN
> +	select SYS_HAS_EARLY_PRINTK
> +	select USE_GENERIC_EARLY_PRINTK_8250
> +	select MSCC_OCELOT_IRQ
> +	select PINCTRL
> +	select GPIOLIB
> +	select COMMON_CLK
> +	select USE_OF
> +	select BUILTIN_DTB
> +	select LIBFDT
> +	help
> +	  This enables support for the Microsemi Ocelot architecture.
> +	  It builds a generic DT-based kernel image.
> +
>  config MACH_PIC32
>  	bool "Microchip PIC32 Family"
>  	help
> diff --git a/arch/mips/mscc/Makefile b/arch/mips/mscc/Makefile
> new file mode 100644
> index 000000000000..c96b13546730
> --- /dev/null
> +++ b/arch/mips/mscc/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +#
> +# Microsemi MIPS SoC support
> +#
> +# License: Dual MIT/GPL
> +# Copyright (c) 2017 Microsemi Corporation
> +
> +#
> +# Makefile for the Microsemi MIPS SoCs
> +#
> +obj-y :=3D setup.o
> diff --git a/arch/mips/mscc/Platform b/arch/mips/mscc/Platform
> new file mode 100644
> index 000000000000..9ae874c8f136
> --- /dev/null
> +++ b/arch/mips/mscc/Platform
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +#
> +# Microsemi MIPS SoC support
> +#
> +# License: Dual MIT/GPL
> +# Copyright (c) 2017 Microsemi Corporation
> +
> +#
> +# Microsemi Ocelot board(s)
> +#
> +platform-$(CONFIG_MSCC_OCELOT) +=3D mscc/
> +load-$(CONFIG_MSCC_OCELOT)	 +=3D 0x80100000
> diff --git a/arch/mips/mscc/setup.c b/arch/mips/mscc/setup.c
> new file mode 100644
> index 000000000000..77803edd7bfd
> --- /dev/null
> +++ b/arch/mips/mscc/setup.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Microsemi MIPS SoC support
> + *
> + * License: Dual MIT/GPL
> + * Copyright (c) 2017 Microsemi Corporation
> + */
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/libfdt.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_platform.h>
> +#include <linux/reboot.h>
> +
> +#include <asm/time.h>
> +#include <asm/idle.h>
> +#include <asm/prom.h>
> +#include <asm/reboot.h>
> +
> +static void __init ocelot_earlyprintk_init(void)
> +{
> +	void __iomem *uart_base;
> +
> +	uart_base =3D ioremap_nocache(0x70100000, 0x0f);
> +	setup_8250_early_printk_port((unsigned long)uart_base, 2, 50000);
> +}
> +
> +void __init prom_init(void)
> +{
> +	/* Sanity check for defunct bootloader */
> +	if (fw_arg0 < 10 && (fw_arg1 & 0xFFF00000) =3D=3D 0x80000000) {
> +		unsigned int prom_argc =3D fw_arg0;
> +		const char **prom_argv =3D (const char **)fw_arg1;
> +
> +		if (prom_argc > 1 && strlen(prom_argv[1]) > 0)
> +			/* ignore all built-in args if any f/w args given */
> +			strcpy(arcs_cmdline, prom_argv[1]);
> +	}
> +}
> +
> +void __init prom_free_prom_memory(void)
> +{
> +}
> +
> +unsigned int get_c0_compare_int(void)
> +{
> +	return CP0_LEGACY_COMPARE_IRQ;
> +}
> +
> +void __init plat_time_init(void)
> +{
> +	struct device_node *np;
> +	u32 freq;
> +
> +	np =3D of_find_node_by_name(NULL, "cpus");
> +	if (!np)
> +		panic("missing 'cpus' DT node");
> +	if (of_property_read_u32(np, "mips-hpt-frequency", &freq) < 0)
> +		panic("missing 'mips-hpt-frequency' property");
> +	of_node_put(np);
> +
> +	mips_hpt_frequency =3D freq;
> +}
> +
> +void __init arch_init_irq(void)
> +{
> +	irqchip_init();
> +}
> +
> +const char *get_system_type(void)
> +{
> +	return "Microsemi Ocelot";
> +}
> +
> +static void __init ocelot_late_init(void)
> +{
> +	ocelot_earlyprintk_init();
> +}
> +
> +extern void (*late_time_init)(void);
> +
> +void __init plat_mem_setup(void)
> +{
> +	/* This has to be done so late because ioremap needs to work */
> +	late_time_init =3D ocelot_late_init;
> +
> +	__dt_setup_arch(__dtb_start);
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
> +static int __init populate_machine(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	return 0;
> +}
> +arch_initcall(populate_machine);
> --=20
> 2.15.0
>=20
>=20

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlodiFoACgkQbAtpk944
dnp1vA//UWccWO4xTdRoesmj+jyfb1iYFzIm6T4xMtXWg+ogmKYmdOJMXeSUzemO
wCVfq9k0bwcNj/xnftCDRtokj72yJyuE2QeLs6+5XhHLYNGFbX9R8voFhjqaZ0ZR
b65SnrBDWcItAGMVYrt4XOn4LEnx2Gvp00md8jKkoF+v5eRBiQkb3UUgFsiLSihY
7GfHBjr92W4djp5JHz1CJLAmgOz7FdF4gYCJ5sy4qK2rk4+4fWfcWK/7siOVssG2
qZrCYvc5wbGYmeEICglSB08VuRAX0Wk2XSg9KxiNE54uMpwGj7LUmJ3ZKAF8PC0j
4x7MlWoqnWcD0WX+VZm4T3QVjchrxWQWuhcHCpETMSgPdfgPJD2cdw49nlBmBslO
0IH2VEuopuKh7KSQqlcIlJKmsRZcJ7AdcRPsryyW/oU+OnCNBVa0DSuJNm6yKiEa
IpTvXunoLFz+C75O3zGX8pEDT931W2p0X5115RdGCjON1136Lb/17Y0JafMnEhJv
JVqKsnzvttlLN1E6b7AM+nDeMiaIFy4JNG9KkC+u5jfqd77NSsCVf//O4fjVHUYl
a5YKXk+8M3VPk1Rl6u5zroCNQWi0c6uu2ZPF5CNQIhALa7a3X7kzMiPrcWYD8XGT
UE/fG2MZAFgHZzvXweKMdZpR9BdnldYHtjQdTHUFPJLm6+VqkL8=
=goyn
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
