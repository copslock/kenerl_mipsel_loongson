Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2015 11:11:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23462 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010496AbbDVJLWXIFMt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2015 11:11:22 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9D99E41F8E0B;
        Wed, 22 Apr 2015 10:11:18 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 22 Apr 2015 10:11:18 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 22 Apr 2015 10:11:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 08B7E49E40A54;
        Wed, 22 Apr 2015 10:11:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 22 Apr 2015 10:11:18 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 22 Apr
 2015 10:11:17 +0100
Date:   Wed, 22 Apr 2015 10:11:17 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Mike Turquette" <mturquette@linaro.org>
Subject: Re: [PATCH v3 26/37] MIPS,clk: migrate JZ4740 to common clock
 framework
Message-ID: <20150422091117.GF10157@jhogan-linux.le.imgtec.org>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
 <1429627624-30525-27-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Content-Disposition: inline
In-Reply-To: <1429627624-30525-27-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47007
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

--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Apr 21, 2015 at 03:46:53PM +0100, Paul Burton wrote:
> Migrate the JZ4740 & the qi_lb60 board to use common clock framework
> via the new Ingenic SoC CGU driver.

Maybe worth mentioning that debugfs interface removed because common
clock framework already provides something similar.

> +static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
> +
> +	/* External clocks */
> +
> +	[JZ4740_CLK_EXT] = { "ext", CGU_CLK_EXT },
> +	[JZ4740_CLK_RTC] = { "rtc", CGU_CLK_EXT },
> +
> +	[JZ4740_CLK_PLL] = {
> +		"pll", CGU_CLK_PLL,
> +		.parents = { JZ4740_CLK_EXT, -1 },

I thought parents had 4 elements. Do the other two need initialising to -1 (and
below).

> +		.pll = {
> +			.reg = CGU_REG_CPPCR,
> +			.m_shift = 23,
> +			.m_bits = 9,
> +			.m_offset = 2,
> +			.n_shift = 18,
> +			.n_bits = 5,
> +			.n_offset = 2,
> +			.od_shift = 16,
> +			.od_bits = 2,
> +			.od_max = 4,
> +			.od_encoding = pll_od_encoding,
> +			.stable_bit = 10,
> +			.bypass_bit = 9,
> +			.enable_bit = 8,
> +		},
> +	},
> +
> +	/* Muxes & dividers */
> +
> +	[JZ4740_CLK_PLL_HALF] = {
> +		"pll half", CGU_CLK_DIV,
> +		.parents = { JZ4740_CLK_PLL, -1 },
> +		.div = { CGU_REG_CPCCR, 21, 1, -1, -1, -1 },
> +	},
> +
> +	[JZ4740_CLK_CCLK] = {
> +		"cclk", CGU_CLK_DIV,
> +		.parents = { JZ4740_CLK_PLL, -1 },
> +		.div = { CGU_REG_CPCCR, 0, 4, 22, -1, -1 },
> +	},
> +
> +	[JZ4740_CLK_HCLK] = {
> +		"hclk", CGU_CLK_DIV,
> +		.parents = { JZ4740_CLK_PLL, -1 },
> +		.div = { CGU_REG_CPCCR, 4, 4, 22, -1, -1 },
> +	},
> +
> +	[JZ4740_CLK_PCLK] = {
> +		"pclk", CGU_CLK_DIV,
> +		.parents = { JZ4740_CLK_PLL, -1 },
> +		.div = { CGU_REG_CPCCR, 8, 4, 22, -1, -1 },
> +	},
> +
> +	[JZ4740_CLK_MCLK] = {
> +		"mclk", CGU_CLK_DIV,
> +		.parents = { JZ4740_CLK_PLL, -1 },
> +		.div = { CGU_REG_CPCCR, 12, 4, 22, -1, -1 },
> +	},
> +
> +	[JZ4740_CLK_LCD] = {
> +		"lcd", CGU_CLK_DIV | CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_PLL_HALF, -1 },
> +		.div = { CGU_REG_CPCCR, 16, 5, 22, -1, -1 },
> +		.gate = { CGU_REG_CLKGR, 10 },
> +	},
> +
> +	[JZ4740_CLK_LCD_PCLK] = {
> +		"lcd_pclk", CGU_CLK_DIV,
> +		.parents = { JZ4740_CLK_PLL_HALF, -1 },
> +		.div = { CGU_REG_LPCDR, 0, 11, -1, -1, -1 },
> +	},
> +
> +	[JZ4740_CLK_I2S] = {
> +		"i2s", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF, -1 },
> +		.mux = { CGU_REG_CPCCR, 31, 1 },
> +		.div = { CGU_REG_I2SCDR, 0, 8, -1, -1, -1 },
> +		.gate = { CGU_REG_CLKGR, 6 },
> +	},
> +
> +	[JZ4740_CLK_SPI] = {
> +		"spi", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL, -1 },
> +		.mux = { CGU_REG_SSICDR, 31, 1 },
> +		.div = { CGU_REG_SSICDR, 0, 4, -1, -1, -1 },
> +		.gate = { CGU_REG_CLKGR, 4 },
> +	},
> +
> +	[JZ4740_CLK_MMC] = {
> +		"mmc", CGU_CLK_DIV | CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_PLL_HALF, -1 },
> +		.div = { CGU_REG_MSCCDR, 0, 5, -1, -1, -1 },
> +		.gate = { CGU_REG_CLKGR, 7 },
> +	},
> +
> +	[JZ4740_CLK_UHC] = {
> +		"uhc", CGU_CLK_DIV | CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_PLL_HALF, -1 },
> +		.div = { CGU_REG_UHCCDR, 0, 4, -1, -1, -1 },
> +		.gate = { CGU_REG_CLKGR, 14 },
> +	},
> +
> +	[JZ4740_CLK_UDC] = {
> +		"udc", CGU_CLK_MUX | CGU_CLK_DIV,
> +		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF, -1 },
> +		.mux = { CGU_REG_CPCCR, 29, 1 },
> +		.div = { CGU_REG_CPCCR, 23, 6, -1, -1, -1 },
> +		.gate = { CGU_REG_SCR, 6 },
> +	},
> +
> +	/* Gate-only clocks */
> +
> +	[JZ4740_CLK_UART0] = {
> +		"uart0", CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_EXT, -1 },
> +		.gate = { CGU_REG_CLKGR, 0 },
> +	},
> +
> +	[JZ4740_CLK_UART1] = {
> +		"uart1", CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_EXT, -1 },
> +		.gate = { CGU_REG_CLKGR, 15 },
> +	},
> +
> +	[JZ4740_CLK_DMA] = {
> +		"dma", CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_PCLK, -1 },
> +		.gate = { CGU_REG_CLKGR, 12 },
> +	},
> +
> +	[JZ4740_CLK_IPU] = {
> +		"ipu", CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_PCLK, -1 },
> +		.gate = { CGU_REG_CLKGR, 13 },
> +	},
> +
> +	[JZ4740_CLK_ADC] = {
> +		"adc", CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_EXT, -1 },
> +		.gate = { CGU_REG_CLKGR, 8 },
> +	},
> +
> +	[JZ4740_CLK_I2C] = {
> +		"i2c", CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_EXT, -1 },
> +		.gate = { CGU_REG_CLKGR, 3 },
> +	},
> +
> +	[JZ4740_CLK_AIC] = {
> +		"aic", CGU_CLK_GATE,
> +		.parents = { JZ4740_CLK_EXT, -1 },
> +		.gate = { CGU_REG_CLKGR, 5 },
> +	},
> +};
> +
> +static void __init jz4740_cgu_init(struct device_node *np)
> +{
> +	int retval;
> +
> +	cgu = ingenic_cgu_new(jz4740_cgu_clocks,
> +			      ARRAY_SIZE(jz4740_cgu_clocks), np);
> +	if (!cgu)
> +		pr_err("%s: failed to initialise CGU\n", __func__);

return, to avoid passing NULL to ingenic_cgu_register_clocks?

> +
> +	retval = ingenic_cgu_register_clocks(cgu);
> +	if (retval)
> +		pr_err("%s: failed to register CGU Clocks\n", __func__);
> +}
> +CLK_OF_DECLARE(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);

Cheers
James

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVN2W1AAoJEGwLaZPeOHZ6OUQP/17L8tK9gMymPMXtr6BCGWIq
3oS2qOBUTgmPt5lwufevynu4Sl+IvVwfLMPhH3GC4D2vSY7y7EO4JH6KhLuq+p1O
HobJuGU/Z+91TOHxIyAHA2kI6dL0C32Luen9zK27982Gwvtb8P0h5EFCbRE4J3ov
GnizypXvcbXmWl0D3mulMSPZ87rMYr+N7Gn3LgpaQDusyyq5NCjJAWrxhaEC09Ya
FbG+xlgZSPa5scJn7FVT28zKbjtCRxOh6QnaQhOo0neqqdVVh+5/FdGbKHfFeVHp
vv8R5b8S982Dc9wS8q8F2gpPzFOpQTmjTwkDpfgIJoCGk9TGIgpXQIZqT34E+6zd
EFtJYLw+eo6irBd5OHXUEFckyalGYYdcH3G8IG4CEqzDJX/a43hL3/1MWvo4ru/b
abLXBwrBidobbqY94GCRsHcOWX2zUj08hC+JhnpcbmlCkHxOs33HfRPK06QZBXJS
1oL4vZtmhSAjxOH6VIYbRfr8YrOO53eFCcQZIJxX8xopIskzcoPl8KgM8HQbA+xh
sEyDhAFqrFZYt//6OP/aWMUGtGvEpZEg3mpWOh/oZ6Tn/qkZrcVGbjYzjJhtgE6Z
O707VtirOEQ9MR3aBfIEqokSP+Igq8o3pqsGSy4wiQBYeNAcGFZSBfs1DUbMRp9d
oMzBvbtZo0tRoUSPUgbJ
=GS2H
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--
