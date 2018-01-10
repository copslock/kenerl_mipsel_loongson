Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 22:38:35 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:32786 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990604AbeAJVi1H38v5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 22:38:27 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 10 Jan 2018 21:37:58 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 10 Jan
 2018 13:37:15 -0800
Date:   Wed, 10 Jan 2018 21:37:14 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v6 06/15] clk: Add Ingenic jz4770 CGU driver
Message-ID: <20180110213713.GR27409@jhogan-linux.mipstec.com>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
 <20180105182513.16248-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h9WqFG8zn/Mwlkpe"
Content-Disposition: inline
In-Reply-To: <20180105182513.16248-7-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1515620277-637138-32445-834382-3
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188374
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.50 BSF_SC1_TG070          META: Custom Rule TG070 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC1_TG070
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62052
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

--h9WqFG8zn/Mwlkpe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Fri, Jan 05, 2018 at 07:25:04PM +0100, Paul Cercueil wrote:
> Add support for the clocks provided by the CGU in the Ingenic JZ4770
> SoC.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/ingenic/Makefile     |   1 +
>  drivers/clk/ingenic/jz4770-cgu.c | 483 +++++++++++++++++++++++++++++++++=
++++++

Should this file and the jz4770-cgu.h header be added to a new
MAINTAINERS entry for this driver and/or for the platform as a whole?

Cheers
James

>  2 files changed, 484 insertions(+)
>  create mode 100644 drivers/clk/ingenic/jz4770-cgu.c
>=20
>  v2: Make structures static const
>  v3: <dt-bindings/clock/jz4770-cgu.h> is now added in a separate patch
>  v4: No change
>  v5: Use SPDX license identifier
>  v6: No change
>=20
> diff --git a/drivers/clk/ingenic/Makefile b/drivers/clk/ingenic/Makefile
> index cd47b0664c2b..1456e4cdb562 100644
> --- a/drivers/clk/ingenic/Makefile
> +++ b/drivers/clk/ingenic/Makefile
> @@ -1,3 +1,4 @@
>  obj-y				+=3D cgu.o
>  obj-$(CONFIG_MACH_JZ4740)	+=3D jz4740-cgu.o
> +obj-$(CONFIG_MACH_JZ4770)	+=3D jz4770-cgu.o
>  obj-$(CONFIG_MACH_JZ4780)	+=3D jz4780-cgu.o
> diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz477=
0-cgu.c
> new file mode 100644
> index 000000000000..c78d369b9403
> --- /dev/null
> +++ b/drivers/clk/ingenic/jz4770-cgu.c
> @@ -0,0 +1,483 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * JZ4770 SoC CGU driver
> + * Copyright 2018, Paul Cercueil <paul@crapouillou.net>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/syscore_ops.h>
> +#include <dt-bindings/clock/jz4770-cgu.h>
> +#include "cgu.h"
> +
> +/*
> + * CPM registers offset address definition
> + */
> +#define CGU_REG_CPCCR		0x00
> +#define CGU_REG_LCR		0x04
> +#define CGU_REG_CPPCR0		0x10
> +#define CGU_REG_CLKGR0		0x20
> +#define CGU_REG_OPCR		0x24
> +#define CGU_REG_CLKGR1		0x28
> +#define CGU_REG_CPPCR1		0x30
> +#define CGU_REG_USBPCR1		0x48
> +#define CGU_REG_USBCDR		0x50
> +#define CGU_REG_I2SCDR		0x60
> +#define CGU_REG_LPCDR		0x64
> +#define CGU_REG_MSC0CDR		0x68
> +#define CGU_REG_UHCCDR		0x6c
> +#define CGU_REG_SSICDR		0x74
> +#define CGU_REG_CIMCDR		0x7c
> +#define CGU_REG_GPSCDR		0x80
> +#define CGU_REG_PCMCDR		0x84
> +#define CGU_REG_GPUCDR		0x88
> +#define CGU_REG_MSC1CDR		0xA4
> +#define CGU_REG_MSC2CDR		0xA8
> +#define CGU_REG_BCHCDR		0xAC
> +
> +/* bits within the LCR register */
> +#define LCR_LPM			BIT(0)		/* Low Power Mode */
> +
> +/* bits within the OPCR register */
> +#define OPCR_SPENDH		BIT(5)		/* UHC PHY suspend */
> +#define OPCR_SPENDN		BIT(7)		/* OTG PHY suspend */
> +
> +/* bits within the USBPCR1 register */
> +#define USBPCR1_UHC_POWER	BIT(5)		/* UHC PHY power down */
> +
> +static struct ingenic_cgu *cgu;
> +
> +static int jz4770_uhc_phy_enable(struct clk_hw *hw)
> +{
> +	void __iomem *reg_opcr		=3D cgu->base + CGU_REG_OPCR;
> +	void __iomem *reg_usbpcr1	=3D cgu->base + CGU_REG_USBPCR1;
> +
> +	writel(readl(reg_opcr) & ~OPCR_SPENDH, reg_opcr);
> +	writel(readl(reg_usbpcr1) | USBPCR1_UHC_POWER, reg_usbpcr1);
> +	return 0;
> +}
> +
> +static void jz4770_uhc_phy_disable(struct clk_hw *hw)
> +{
> +	void __iomem *reg_opcr		=3D cgu->base + CGU_REG_OPCR;
> +	void __iomem *reg_usbpcr1	=3D cgu->base + CGU_REG_USBPCR1;
> +
> +	writel(readl(reg_usbpcr1) & ~USBPCR1_UHC_POWER, reg_usbpcr1);
> +	writel(readl(reg_opcr) | OPCR_SPENDH, reg_opcr);
> +}
> +
> +static int jz4770_uhc_phy_is_enabled(struct clk_hw *hw)
> +{
> +	void __iomem *reg_opcr		=3D cgu->base + CGU_REG_OPCR;
> +	void __iomem *reg_usbpcr1	=3D cgu->base + CGU_REG_USBPCR1;
> +
> +	return !(readl(reg_opcr) & OPCR_SPENDH) &&
> +		(readl(reg_usbpcr1) & USBPCR1_UHC_POWER);
> +}
> +
> +static const struct clk_ops jz4770_uhc_phy_ops =3D {
> +	.enable =3D jz4770_uhc_phy_enable,
> +	.disable =3D jz4770_uhc_phy_disable,
> +	.is_enabled =3D jz4770_uhc_phy_is_enabled,
> +};
> +
> +static int jz4770_otg_phy_enable(struct clk_hw *hw)
> +{
> +	void __iomem *reg_opcr		=3D cgu->base + CGU_REG_OPCR;
> +
> +	writel(readl(reg_opcr) | OPCR_SPENDN, reg_opcr);
> +
> +	/* Wait for the clock to be stable */
> +	udelay(50);
> +	return 0;
> +}
> +
> +static void jz4770_otg_phy_disable(struct clk_hw *hw)
> +{
> +	void __iomem *reg_opcr		=3D cgu->base + CGU_REG_OPCR;
> +
> +	writel(readl(reg_opcr) & ~OPCR_SPENDN, reg_opcr);
> +}
> +
> +static int jz4770_otg_phy_is_enabled(struct clk_hw *hw)
> +{
> +	void __iomem *reg_opcr		=3D cgu->base + CGU_REG_OPCR;
> +
> +	return !!(readl(reg_opcr) & OPCR_SPENDN);
> +}
> +
> +static const struct clk_ops jz4770_otg_phy_ops =3D {
> +	.enable =3D jz4770_otg_phy_enable,
> +	.disable =3D jz4770_otg_phy_disable,
> +	.is_enabled =3D jz4770_otg_phy_is_enabled,
> +};
> +
> +static const s8 pll_od_encoding[8] =3D {
> +	0x0, 0x1, -1, 0x2, -1, -1, -1, 0x3,
> +};
> +
> +static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] =3D {
> +
> +	/* External clocks */
> +
> +	[JZ4770_CLK_EXT] =3D { "ext", CGU_CLK_EXT },
> +	[JZ4770_CLK_OSC32K] =3D { "osc32k", CGU_CLK_EXT },
> +
> +	/* PLLs */
> +
> +	[JZ4770_CLK_PLL0] =3D {
> +		"pll0", CGU_CLK_PLL,
> +		.parents =3D { JZ4770_CLK_EXT },
> +		.pll =3D {
> +			.reg =3D CGU_REG_CPPCR0,
> +			.m_shift =3D 24,
> +			.m_bits =3D 7,
> +			.m_offset =3D 1,
> +			.n_shift =3D 18,
> +			.n_bits =3D 5,
> +			.n_offset =3D 1,
> +			.od_shift =3D 16,
> +			.od_bits =3D 2,
> +			.od_max =3D 8,
> +			.od_encoding =3D pll_od_encoding,
> +			.bypass_bit =3D 9,
> +			.enable_bit =3D 8,
> +			.stable_bit =3D 10,
> +		},
> +	},
> +
> +	[JZ4770_CLK_PLL1] =3D {
> +		/* TODO: PLL1 can depend on PLL0 */
> +		"pll1", CGU_CLK_PLL,
> +		.parents =3D { JZ4770_CLK_EXT },
> +		.pll =3D {
> +			.reg =3D CGU_REG_CPPCR1,
> +			.m_shift =3D 24,
> +			.m_bits =3D 7,
> +			.m_offset =3D 1,
> +			.n_shift =3D 18,
> +			.n_bits =3D 5,
> +			.n_offset =3D 1,
> +			.od_shift =3D 16,
> +			.od_bits =3D 2,
> +			.od_max =3D 8,
> +			.od_encoding =3D pll_od_encoding,
> +			.enable_bit =3D 7,
> +			.stable_bit =3D 6,
> +			.no_bypass_bit =3D true,
> +		},
> +	},
> +
> +	/* Main clocks */
> +
> +	[JZ4770_CLK_CCLK] =3D {
> +		"cclk", CGU_CLK_DIV,
> +		.parents =3D { JZ4770_CLK_PLL0, },
> +		.div =3D { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
> +	},
> +	[JZ4770_CLK_H0CLK] =3D {
> +		"h0clk", CGU_CLK_DIV,
> +		.parents =3D { JZ4770_CLK_PLL0, },
> +		.div =3D { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
> +	},
> +	[JZ4770_CLK_H1CLK] =3D {
> +		"h1clk", CGU_CLK_DIV | CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_PLL0, },
> +		.div =3D { CGU_REG_CPCCR, 24, 1, 4, 22, -1, -1 },
> +		.gate =3D { CGU_REG_LCR, 30 },
> +	},
> +	[JZ4770_CLK_H2CLK] =3D {
> +		"h2clk", CGU_CLK_DIV,
> +		.parents =3D { JZ4770_CLK_PLL0, },
> +		.div =3D { CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1 },
> +	},
> +	[JZ4770_CLK_C1CLK] =3D {
> +		"c1clk", CGU_CLK_DIV,
> +		.parents =3D { JZ4770_CLK_PLL0, },
> +		.div =3D { CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1 },
> +	},
> +	[JZ4770_CLK_PCLK] =3D {
> +		"pclk", CGU_CLK_DIV,
> +		.parents =3D { JZ4770_CLK_PLL0, },
> +		.div =3D { CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1 },
> +	},
> +
> +	/* Those divided clocks can connect to PLL0 or PLL1 */
> +
> +	[JZ4770_CLK_MMC0_MUX] =3D {
> +		"mmc0_mux", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.mux =3D { CGU_REG_MSC0CDR, 30, 1 },
> +		.div =3D { CGU_REG_MSC0CDR, 0, 1, 7, -1, -1, 31 },
> +		.gate =3D { CGU_REG_MSC0CDR, 31 },
> +	},
> +	[JZ4770_CLK_MMC1_MUX] =3D {
> +		"mmc1_mux", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.mux =3D { CGU_REG_MSC1CDR, 30, 1 },
> +		.div =3D { CGU_REG_MSC1CDR, 0, 1, 7, -1, -1, 31 },
> +		.gate =3D { CGU_REG_MSC1CDR, 31 },
> +	},
> +	[JZ4770_CLK_MMC2_MUX] =3D {
> +		"mmc2_mux", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.mux =3D { CGU_REG_MSC2CDR, 30, 1 },
> +		.div =3D { CGU_REG_MSC2CDR, 0, 1, 7, -1, -1, 31 },
> +		.gate =3D { CGU_REG_MSC2CDR, 31 },
> +	},
> +	[JZ4770_CLK_CIM] =3D {
> +		"cim", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.mux =3D { CGU_REG_CIMCDR, 31, 1 },
> +		.div =3D { CGU_REG_CIMCDR, 0, 1, 8, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR0, 26 },
> +	},
> +	[JZ4770_CLK_UHC] =3D {
> +		"uhc", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.mux =3D { CGU_REG_UHCCDR, 29, 1 },
> +		.div =3D { CGU_REG_UHCCDR, 0, 1, 4, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR0, 24 },
> +	},
> +	[JZ4770_CLK_GPU] =3D {
> +		"gpu", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, -1 },
> +		.mux =3D { CGU_REG_GPUCDR, 31, 1 },
> +		.div =3D { CGU_REG_GPUCDR, 0, 1, 3, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR1, 9 },
> +	},
> +	[JZ4770_CLK_BCH] =3D {
> +		"bch", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.mux =3D { CGU_REG_BCHCDR, 31, 1 },
> +		.div =3D { CGU_REG_BCHCDR, 0, 1, 3, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR0, 1 },
> +	},
> +	[JZ4770_CLK_LPCLK_MUX] =3D {
> +		"lpclk", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.mux =3D { CGU_REG_LPCDR, 29, 1 },
> +		.div =3D { CGU_REG_LPCDR, 0, 1, 11, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR0, 28 },
> +	},
> +	[JZ4770_CLK_GPS] =3D {
> +		"gps", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.mux =3D { CGU_REG_GPSCDR, 31, 1 },
> +		.div =3D { CGU_REG_GPSCDR, 0, 1, 4, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR0, 22 },
> +	},
> +
> +	/* Those divided clocks can connect to EXT, PLL0 or PLL1 */
> +
> +	[JZ4770_CLK_SSI_MUX] =3D {
> +		"ssi_mux", CGU_CLK_DIV | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_EXT, -1,
> +			JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
> +		.mux =3D { CGU_REG_SSICDR, 30, 2 },
> +		.div =3D { CGU_REG_SSICDR, 0, 1, 6, -1, -1, -1 },
> +	},
> +	[JZ4770_CLK_PCM_MUX] =3D {
> +		"pcm_mux", CGU_CLK_DIV | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_EXT, -1,
> +			JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
> +		.mux =3D { CGU_REG_PCMCDR, 30, 2 },
> +		.div =3D { CGU_REG_PCMCDR, 0, 1, 9, -1, -1, -1 },
> +	},
> +	[JZ4770_CLK_I2S] =3D {
> +		"i2s", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_EXT, -1,
> +			JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
> +		.mux =3D { CGU_REG_I2SCDR, 30, 2 },
> +		.div =3D { CGU_REG_I2SCDR, 0, 1, 9, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR1, 13 },
> +	},
> +	[JZ4770_CLK_OTG] =3D {
> +		"usb", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_EXT, -1,
> +			JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
> +		.mux =3D { CGU_REG_USBCDR, 30, 2 },
> +		.div =3D { CGU_REG_USBCDR, 0, 1, 8, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR0, 2 },
> +	},
> +
> +	/* Gate-only clocks */
> +
> +	[JZ4770_CLK_SSI0] =3D {
> +		"ssi0", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_SSI_MUX, },
> +		.gate =3D { CGU_REG_CLKGR0, 4 },
> +	},
> +	[JZ4770_CLK_SSI1] =3D {
> +		"ssi1", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_SSI_MUX, },
> +		.gate =3D { CGU_REG_CLKGR0, 19 },
> +	},
> +	[JZ4770_CLK_SSI2] =3D {
> +		"ssi2", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_SSI_MUX, },
> +		.gate =3D { CGU_REG_CLKGR0, 20 },
> +	},
> +	[JZ4770_CLK_PCM0] =3D {
> +		"pcm0", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_PCM_MUX, },
> +		.gate =3D { CGU_REG_CLKGR1, 8 },
> +	},
> +	[JZ4770_CLK_PCM1] =3D {
> +		"pcm1", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_PCM_MUX, },
> +		.gate =3D { CGU_REG_CLKGR1, 10 },
> +	},
> +	[JZ4770_CLK_DMA] =3D {
> +		"dma", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_H2CLK, },
> +		.gate =3D { CGU_REG_CLKGR0, 21 },
> +	},
> +	[JZ4770_CLK_I2C0] =3D {
> +		"i2c0", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_EXT, },
> +		.gate =3D { CGU_REG_CLKGR0, 5 },
> +	},
> +	[JZ4770_CLK_I2C1] =3D {
> +		"i2c1", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_EXT, },
> +		.gate =3D { CGU_REG_CLKGR0, 6 },
> +	},
> +	[JZ4770_CLK_I2C2] =3D {
> +		"i2c2", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_EXT, },
> +		.gate =3D { CGU_REG_CLKGR1, 15 },
> +	},
> +	[JZ4770_CLK_UART0] =3D {
> +		"uart0", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_EXT, },
> +		.gate =3D { CGU_REG_CLKGR0, 15 },
> +	},
> +	[JZ4770_CLK_UART1] =3D {
> +		"uart1", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_EXT, },
> +		.gate =3D { CGU_REG_CLKGR0, 16 },
> +	},
> +	[JZ4770_CLK_UART2] =3D {
> +		"uart2", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_EXT, },
> +		.gate =3D { CGU_REG_CLKGR0, 17 },
> +	},
> +	[JZ4770_CLK_UART3] =3D {
> +		"uart3", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_EXT, },
> +		.gate =3D { CGU_REG_CLKGR0, 18 },
> +	},
> +	[JZ4770_CLK_IPU] =3D {
> +		"ipu", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_H0CLK, },
> +		.gate =3D { CGU_REG_CLKGR0, 29 },
> +	},
> +	[JZ4770_CLK_ADC] =3D {
> +		"adc", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_EXT, },
> +		.gate =3D { CGU_REG_CLKGR0, 14 },
> +	},
> +	[JZ4770_CLK_AIC] =3D {
> +		"aic", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_EXT, },
> +		.gate =3D { CGU_REG_CLKGR0, 8 },
> +	},
> +	[JZ4770_CLK_AUX] =3D {
> +		"aux", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_C1CLK, },
> +		.gate =3D { CGU_REG_CLKGR1, 14 },
> +	},
> +	[JZ4770_CLK_VPU] =3D {
> +		"vpu", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_H1CLK, },
> +		.gate =3D { CGU_REG_CLKGR1, 7 },
> +	},
> +	[JZ4770_CLK_MMC0] =3D {
> +		"mmc0", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_MMC0_MUX, },
> +		.gate =3D { CGU_REG_CLKGR0, 3 },
> +	},
> +	[JZ4770_CLK_MMC1] =3D {
> +		"mmc1", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_MMC1_MUX, },
> +		.gate =3D { CGU_REG_CLKGR0, 11 },
> +	},
> +	[JZ4770_CLK_MMC2] =3D {
> +		"mmc2", CGU_CLK_GATE,
> +		.parents =3D { JZ4770_CLK_MMC2_MUX, },
> +		.gate =3D { CGU_REG_CLKGR0, 12 },
> +	},
> +
> +	/* Custom clocks */
> +
> +	[JZ4770_CLK_UHC_PHY] =3D {
> +		"uhc_phy", CGU_CLK_CUSTOM,
> +		.parents =3D { JZ4770_CLK_UHC, -1, -1, -1 },
> +		.custom =3D { &jz4770_uhc_phy_ops },
> +	},
> +	[JZ4770_CLK_OTG_PHY] =3D {
> +		"usb_phy", CGU_CLK_CUSTOM,
> +		.parents =3D { JZ4770_CLK_OTG, -1, -1, -1 },
> +		.custom =3D { &jz4770_otg_phy_ops },
> +	},
> +
> +	[JZ4770_CLK_EXT512] =3D {
> +		"ext/512", CGU_CLK_FIXDIV,
> +		.parents =3D { JZ4770_CLK_EXT },
> +		.fixdiv =3D { 512 },
> +	},
> +
> +	[JZ4770_CLK_RTC] =3D {
> +		"rtc", CGU_CLK_MUX,
> +		.parents =3D { JZ4770_CLK_EXT512, JZ4770_CLK_OSC32K, },
> +		.mux =3D { CGU_REG_OPCR, 2, 1},
> +	},
> +};
> +
> +#if IS_ENABLED(CONFIG_PM_SLEEP)
> +static int jz4770_cgu_pm_suspend(void)
> +{
> +	u32 val;
> +
> +	val =3D readl(cgu->base + CGU_REG_LCR);
> +	writel(val | LCR_LPM, cgu->base + CGU_REG_LCR);
> +	return 0;
> +}
> +
> +static void jz4770_cgu_pm_resume(void)
> +{
> +	u32 val;
> +
> +	val =3D readl(cgu->base + CGU_REG_LCR);
> +	writel(val & ~LCR_LPM, cgu->base + CGU_REG_LCR);
> +}
> +
> +static struct syscore_ops jz4770_cgu_pm_ops =3D {
> +	.suspend =3D jz4770_cgu_pm_suspend,
> +	.resume =3D jz4770_cgu_pm_resume,
> +};
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static void __init jz4770_cgu_init(struct device_node *np)
> +{
> +	int retval;
> +
> +	cgu =3D ingenic_cgu_new(jz4770_cgu_clocks,
> +			      ARRAY_SIZE(jz4770_cgu_clocks), np);
> +	if (!cgu)
> +		pr_err("%s: failed to initialise CGU\n", __func__);
> +
> +	retval =3D ingenic_cgu_register_clocks(cgu);
> +	if (retval)
> +		pr_err("%s: failed to register CGU Clocks\n", __func__);
> +
> +#if IS_ENABLED(CONFIG_PM_SLEEP)
> +	register_syscore_ops(&jz4770_cgu_pm_ops);
> +#endif
> +}
> +
> +/* We only probe via devicetree, no need for a platform driver */
> +CLK_OF_DECLARE(jz4770_cgu, "ingenic,jz4770-cgu", jz4770_cgu_init);
> --=20
> 2.11.0
>=20
>=20

--h9WqFG8zn/Mwlkpe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpWh3wACgkQbAtpk944
dnojhQ//cWCfN9dE6H5mAbWh+3o+9B0GCGZPXQVlelNL9bSAYMu45N87/16+LWse
zUYGeo1kIka8K8u7fx896gwVHCuvnnDFW9eJmXZrjtmtx0ke2aKTXUUjPxeU3GAD
dJCeyU4g/V+7iqt8PLHdVAq01SJcy5wgJNIvkP0SsmHEfukT4UwOiDLCQQtM0LaJ
24uPdoWOf5RYEobzPNwfmrvDjgOugcHu/l17h6xJxB26AJGVAylaf9q7qgHxh2Ya
3B98yt4PnQYOW18ycHib50AMA8/Cgyr/jYW22su1pAzISkMGWcSudWO6BiILPqcE
UK0Zs1nfXGo3w+LzLCWlVJmjyiByXKEhPdpk8jMCexfAi5PxYNTiA6rzHHka28ez
fghQG80TvjJOsSfl42vxxqgWhBnk0fFtFiA2xqa8l0MSLMDYFyagLlrDOHlNOHJU
0EIIXSWOEZG1r+1q7WF0nBU7ZdERhyqEv75KWrlMAokhrEyRRu/kSJJOKj1Kbwao
FyuzmtqbajrHak6SW2vxyRT/Pq5aw/spmOdRA+zPnMC7tU08TM37NyXBZ81wAaUb
Rv7IOWIBFtbj/sjjC6YoQotDINZoMaoZJJNyxvEmkhpW1Fb82yruPosw1pxpF9Ql
4/ese6oZjYtkSgY3RpilF7EkZYumlm1hpQsD6Lb0ugZ9baMHm4s=
=WwPD
-----END PGP SIGNATURE-----

--h9WqFG8zn/Mwlkpe--
