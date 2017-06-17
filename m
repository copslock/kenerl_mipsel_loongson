Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jun 2017 22:56:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53938 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994918AbdFQU4GRlVgF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jun 2017 22:56:06 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 365DE41F8DC5;
        Sat, 17 Jun 2017 23:05:34 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sat, 17 Jun 2017 23:05:34 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sat, 17 Jun 2017 23:05:34 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E4005A9D4B39E;
        Sat, 17 Jun 2017 21:55:55 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 17 Jun
 2017 21:56:00 +0100
Received: from np-p-burton.localnet (10.20.78.225) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Sat, 17 Jun
 2017 13:55:58 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Stephen Boyd <sboyd@codeaurora.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] clk: boston: Add a driver for MIPS Boston board clocks
Date:   Sat, 17 Jun 2017 13:55:53 -0700
Message-ID: <3561131.ErLRrgaNh5@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <20170614160106.GY20170@codeaurora.org>
References: <20170602182003.16269-1-paul.burton@imgtec.com> <20170602182003.16269-3-paul.burton@imgtec.com> <20170614160106.GY20170@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1610435.VxNgIZDhlI";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.78.225]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart1610435.VxNgIZDhlI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Stephen,

On Wednesday, 14 June 2017 09:01:06 PDT Stephen Boyd wrote:
> On 06/02, Paul Burton wrote:
> > diff --git a/drivers/clk/imgtec/Kconfig b/drivers/clk/imgtec/Kconfig
> > new file mode 100644
> > index 000000000000..c2ea745928e4
> > --- /dev/null
> > +++ b/drivers/clk/imgtec/Kconfig
> > @@ -0,0 +1,10 @@
> > +config COMMON_CLK_BOSTON
> > +	bool "Clock driver for MIPS Boston boards"
> > +	depends on MIPS || COMPILE_TEST
> > +	depends on OF
> 
> What's the OF build dependency?

Dropped for v5, though the driver won't actually be used on systems without 
CONFIG_OF.

> > +	select MFD_SYSCON
> > +	---help---
> > +	  Enable this to support the system & CPU clocks on the MIPS Boston
> > +	  development board from Imagination Technologies. These are simple
> > +	  fixed rate clocks whose rate is determined by reading a platform
> > +	  provided register.
> > diff --git a/drivers/clk/imgtec/Makefile b/drivers/clk/imgtec/Makefile
> > new file mode 100644
> > index 000000000000..ac779b8c22f2
> > --- /dev/null
> > +++ b/drivers/clk/imgtec/Makefile
> > @@ -0,0 +1 @@
> > +obj-$(CONFIG_COMMON_CLK_BOSTON)		+= clk-boston.o
> > diff --git a/drivers/clk/imgtec/clk-boston.c
> > b/drivers/clk/imgtec/clk-boston.c new file mode 100644
> > index 000000000000..98bb0b764d15
> > --- /dev/null
> > +++ b/drivers/clk/imgtec/clk-boston.c
> > @@ -0,0 +1,101 @@
> > +/*
> > + * Copyright (C) 2016-2017 Imagination Technologies
> > + * Author: Paul Burton <paul.burton@imgtec.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > it
> > + * under the terms of the GNU General Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at
> > your + * option) any later version.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +#include <linux/mfd/syscon.h>
> > +
> > +#include <dt-bindings/clock/boston-clock.h>
> > +
> > +#define BOSTON_PLAT_MMCMDIV		0x30
> > +# define BOSTON_PLAT_MMCMDIV_CLK0DIV	(0xff << 0)
> > +# define BOSTON_PLAT_MMCMDIV_INPUT	(0xff << 8)
> > +# define BOSTON_PLAT_MMCMDIV_MUL	(0xff << 16)
> > +# define BOSTON_PLAT_MMCMDIV_CLK1DIV	(0xff << 24)
> > +
> > +#define BOSTON_CLK_COUNT 3
> > +
> > +struct clk_boston_state {
> > +	struct clk *clks[BOSTON_CLK_COUNT];
> > +	struct clk_onecell_data onecell_data;
> > +};
> > +
> > +static u32 ext_field(u32 val, u32 mask)
> > +{
> > +	return (val & mask) >> (ffs(mask) - 1);
> > +}
> > +
> > +static void __init clk_boston_setup(struct device_node *np)
> > +{
> > +	unsigned long in_freq, cpu_freq, sys_freq;
> > +	uint mmcmdiv, mul, cpu_div, sys_div;
> > +	struct clk_boston_state *state;
> > +	struct regmap *regmap;
> > +	struct clk *clk;
> > +	int err;
> > +
> > +	regmap = syscon_node_to_regmap(np->parent);
> > +	if (IS_ERR(regmap)) {
> > +		pr_err("failed to find regmap\n");
> > +		return;
> > +	}
> > +
> > +	err = regmap_read(regmap, BOSTON_PLAT_MMCMDIV, &mmcmdiv);
> > +	if (err) {
> > +		pr_err("failed to read mmcm_div register: %d\n", err);
> > +		return;
> > +	}
> > +
> > +	in_freq = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_INPUT) * 1000000;
> > +	mul = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_MUL);
> > +
> > +	sys_div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK0DIV);
> > +	sys_freq = mult_frac(in_freq, mul, sys_div);
> > +
> > +	cpu_div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK1DIV);
> > +	cpu_freq = mult_frac(in_freq, mul, cpu_div);
> > +
> > +	state = kzalloc(sizeof(*state), GFP_KERNEL);
> > +	if (!state)
> > +		return;
> > +
> > +	clk = clk_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
> 
> Please use the clk_hw_register_*() APIs instead so that this
> driver only deals in clk_hw pointers.

OK, done in v5.

> > +	if (IS_ERR(clk)) {
> > +		pr_err("failed to register input clock: %ld\n", PTR_ERR(clk));
> > +		return;
> > +	}
> > +	state->clks[BOSTON_CLK_INPUT] = clk;
> > +
> > +	clk = clk_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
> > +	if (IS_ERR(clk)) {
> > +		pr_err("failed to register sys clock: %ld\n", PTR_ERR(clk));
> > +		return;
> > +	}
> > +	state->clks[BOSTON_CLK_SYS] = clk;
> > +
> > +	clk = clk_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
> > +	if (IS_ERR(clk)) {
> > +		pr_err("failed to register cpu clock: %ld\n", PTR_ERR(clk));
> > +		return;
> > +	}
> > +	state->clks[BOSTON_CLK_CPU] = clk;
> > +
> > +	state->onecell_data.clks = state->clks;
> > +	state->onecell_data.clk_num = BOSTON_CLK_COUNT;
> > +
> > +	err = of_clk_add_provider(np, of_clk_src_onecell_get,
> > +				  &state->onecell_data);
> 
> Same for here, of_clk_add_hw_provider()

Done in v5.

> > +	if (err)
> > +		pr_err("failed to add DT provider: %d\n", err);
> > +}
> > +CLK_OF_DECLARE(clk_boston, "img,boston-clock", clk_boston_setup);
> 
> Can this be a platform driver? The syscon mfd can populate child
> nodes and this could be a driver that binds to the clock child
> node.

Sadly no, it can't. This driver provides the CPU frequency which we need early 
on. I've added a comment to that effect in v5.

Thanks,
    Paul
--nextPart1610435.VxNgIZDhlI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAllFl1kACgkQgiDZ+mk8
HGW9dxAAoBK+xi40YgsJoejABQ76y05D2uzYJ6+9EK2jKnyD0cqD64uYC+CuVWxk
yhnXavwEFiW2nEtqXcQG3QZVpD39OGG/FmjtZnhJXyt8otn6OO0UQ2R2HEd35jNE
kSUf1zIkOhDmD7uUxw+bfKR2z/0mjbxT8N/T+/RpbRzU2BNWfDvNx3j2EdH6XlY0
Qvo+U279nJku+AuYLEOJwoL0aJIVSZmlHNIX34eOpFfMa6ur/P9iF/qX8FNKCCeH
ZxXHTVVjJZECwyWqPXiEINNL4OrCUADBDBeGo0ypY2TYXIOckaB3SrhhmKvcOET9
Q9livLPBT9IWcT04XDa01nahR2wnM6dF+BgYyVncPaBNoKSs+52sp1HitFRx839a
qo9a8bHv9QfdSf9D2HBJ6sezM0+1a6x4P1WqkOboIjapaPzpXiDcBn4CJIRigICp
KhLnTTDfBRZcfv9fKBmp8nIRd+rQO4wnA8jlLmWtR+/RIr8A0jsEgHK2FYs8CDcn
V2wro2W7TFm1uhizyw1Ykuu4t7I6t9RygQMCmpIjPVFuEgOnjFgOODh5l2+5L0cn
qG4Co4C7d/w05R8dsZqVDot3IKdnP/dmJpVWHtByOlgpO76IbkbZ5w3xN1ze/MuR
9EBvqQdMgDrReeqe7Gcy0qD+FiHN+Pfr1nwphjyadv2sAS0MBk4=
=2doe
-----END PGP SIGNATURE-----

--nextPart1610435.VxNgIZDhlI--
