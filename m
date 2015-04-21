Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2015 01:25:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7786 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007307AbbDUXZhqP7LR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2015 01:25:37 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BC7F441F8D58;
        Wed, 22 Apr 2015 00:25:33 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 22 Apr 2015 00:25:33 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 22 Apr 2015 00:25:33 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B2D2452D6913D;
        Wed, 22 Apr 2015 00:25:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 22 Apr 2015 00:25:33 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 22 Apr
 2015 00:25:32 +0100
Date:   Wed, 22 Apr 2015 00:25:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Mike Turquette" <mturquette@linaro.org>
Subject: Re: [PATCH v3 25/37] clk: ingenic: add driver for Ingenic SoC CGU
 clocks
Message-ID: <20150421232532.GC10157@jhogan-linux.le.imgtec.org>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
 <1429627624-30525-26-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <1429627624-30525-26-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47001
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

--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Apr 21, 2015 at 03:46:52PM +0100, Paul Burton wrote:
> This driver supports the CGU clocks for Ingenic SoCs. It is generic
> enough to be usable across at least the JZ4740 to the JZ4780, and will
> be made use of on such devices in subsequent commits. This patch by
> itself only adds the SoC-agnostic infrastructure that forms the bulk of
> the CGU driver for the aforementioned further commits to make use of.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Co-authored-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Mike Turquette <mturquette@linaro.org>
> ---
> Changes in v3:
>   - s/jz47xx/ingenic/ since Ingenic have changed their naming scheme to
>     "Mxxx" for newer SoCs.
>=20
>   - Allow clock gating with registers other than CLKGR* (pcercuei).
>=20
>   - Fixup dividers to never exceed the requested rate (pcercuei).
>=20
>   - Fixup PLL calculations to work better with more restricted
>     coefficient bit widths (pcercuei).
>=20
> Changes in v2:
>   - Fix spinlock handling in jz47xx_clk_set_rate error path (ZubairLK).
> ---
>  drivers/clk/Makefile         |   1 +
>  drivers/clk/ingenic/Makefile |   1 +
>  drivers/clk/ingenic/cgu.c    | 711 +++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/clk/ingenic/cgu.h    | 223 ++++++++++++++
>  4 files changed, 936 insertions(+)
>  create mode 100644 drivers/clk/ingenic/Makefile
>  create mode 100644 drivers/clk/ingenic/cgu.c
>  create mode 100644 drivers/clk/ingenic/cgu.h
>=20
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 3d00c25..cc77327 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_ARCH_BERLIN)		+=3D berlin/
>  obj-$(CONFIG_ARCH_HI3xxx)		+=3D hisilicon/
>  obj-$(CONFIG_ARCH_HIP04)		+=3D hisilicon/
>  obj-$(CONFIG_ARCH_HIX5HD2)		+=3D hisilicon/
> +obj-$(CONFIG_MACH_INGENIC)		+=3D ingenic/
>  obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+=3D keystone/
>  ifeq ($(CONFIG_COMMON_CLK), y)
>  obj-$(CONFIG_ARCH_MMP)			+=3D mmp/
> diff --git a/drivers/clk/ingenic/Makefile b/drivers/clk/ingenic/Makefile
> new file mode 100644
> index 0000000..5ac2fd9
> --- /dev/null
> +++ b/drivers/clk/ingenic/Makefile
> @@ -0,0 +1 @@
> +obj-y				+=3D cgu.o
> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> new file mode 100644
> index 0000000..81a720e
> --- /dev/null
> +++ b/drivers/clk/ingenic/cgu.c
> @@ -0,0 +1,713 @@
> +/*
> + * Ingenic SoC CGU driver
> + *
> + * Copyright (c) 2013-2015 Imagination Technologies
> + * Author: Paul Burton <paul.burton@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include "cgu.h"
> +
> +#define MHZ (1000 * 1000)
> +
> +/**
> + * ingenic_cgu_gate_get - get the value of clock gate register bit

I think you should have "()" in there because its a function (if
Documentation/kernel-doc-nano-HOWTO.txt is anything to go by).

> + * @cgu: reference to the CGU whose registers should be read
> + * @idx: index of the gate bit

Stale

> + *
> + * Returns 1 if the gate bit is set, else 0. The index begins with 0 bei=
ng

I believe its common for return value to have its own section at the
end, which shows up nicer in the output, e.g.

 * The index begins with 0 being bit 0 of CLKGR0, continuing from 32 for
 * bit 0 of CLKGR1 etc. For example, the index of bit 9 of CLKGR1 would
 * be (32+9) =3D=3D 41.
 *
 * The caller must hold cgu->power_lock.
 *
 * Return: 1 if the gate bit is set, else 0.

> + * bit 0 of CLKGR0, continuing from 32 for bit 0 of CLKGR1 etc. For exam=
ple,
> + * the index of bit 9 of CLKGR1 would be (32+9) =3D=3D 41.

I'm guessing that's a bit stale too.

> + *
> + * The caller must hold cgu->power_lock.
> + */
> +static inline unsigned

maybe return bool and scrap the !!(

> +ingenic_cgu_gate_get(struct ingenic_cgu *cgu,
> +		     const struct ingenic_cgu_gate_info *info)
> +{
> +	return !!(readl(cgu->base + info->reg) & BIT(info->bit));
> +}
> +
> +/**
> + * ingenic_cgu_gate_set - set the value of clock gate register bit
> + * @cgu: reference to the CGU whose registers should be modified
> + * @idx: index of the gate bit
> + * @val: non-zero to gate a clock, otherwise zero
> + *
> + * Sets the given gate bit in order to gate or ungate a clock. See
> + * ingenic_cgu_gate_get for a description of the idx parameter.
> + *
> + * The caller must hold cgu->power_lock.
> + */

same as above

> +static inline void
> +ingenic_cgu_gate_set(struct ingenic_cgu *cgu,
> +		     const struct ingenic_cgu_gate_info *info, bool val)
> +{
> +	u32 clkgr =3D readl(cgu->base + info->reg);
> +
> +	if (val)
> +		clkgr |=3D BIT(info->bit);

Don't forget
#include <linux/bitops.h>
for BIT() and GENMASK()

> +	else
> +		clkgr &=3D ~BIT(info->bit);
> +
> +	writel(clkgr, cgu->base + info->reg);
> +}
> +
> +/*
> + * PLL operations
> + */
> +
> +static unsigned long
> +ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +	const struct ingenic_cgu_pll_info *pll_info;
> +	unsigned m, n, od_enc, od;
> +	bool bypass, enable;
> +	unsigned long flags;
> +	u32 ctl;
> +
> +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> +	BUG_ON(clk_info->type !=3D CGU_CLK_PLL);
> +	pll_info =3D &clk_info->pll;
> +
> +	spin_lock_irqsave(&cgu->pll_lock, flags);
> +	ctl =3D readl(cgu->base + pll_info->reg);
> +	spin_unlock_irqrestore(&cgu->pll_lock, flags);
> +
> +	m =3D ((ctl >> pll_info->m_shift) & GENMASK(pll_info->m_bits - 1, 0));
> +	m +=3D pll_info->m_offset;
> +	n =3D ((ctl >> pll_info->n_shift) & GENMASK(pll_info->n_bits - 1, 0));
> +	n +=3D pll_info->n_offset;
> +	od_enc =3D ctl >> pll_info->od_shift;
> +	od_enc &=3D GENMASK(pll_info->od_bits - 1, 0);
> +	bypass =3D !!(ctl & BIT(pll_info->bypass_bit));
> +	enable =3D !!(ctl & BIT(pll_info->enable_bit));
> +
> +	if (bypass)
> +		return parent_rate;
> +
> +	if (!enable)
> +		return 0;
> +
> +	for (od =3D 0; od < pll_info->od_max; od++) {
> +		if (pll_info->od_encoding[od] =3D=3D od_enc)
> +			break;
> +	}
> +	BUG_ON(od =3D=3D pll_info->od_max);
> +	od++;
> +
> +	return parent_rate * m / (n * od);

In the worst case for jz4740 looking a couple of patches ahead, raw m
can be as high as 0x1ff, offset to 0x201 =3D 513. That means parent_rate
must be < 8.37MHz to avoid overflow. TZ1090 PLL (which looks
conceptually similar) does this:

f_out =3D div_u64((u64)f_in * clk_f,
		2 * clk_r * clk_od);

https://lkml.org/lkml/2014/12/1/832

> +}
> +
> +static unsigned long
> +ingenic_pll_calc(const struct ingenic_cgu_clk_info *clk_info,
> +		 unsigned long rate, unsigned long parent_rate,
> +		 unsigned *pm, unsigned *pn, unsigned *pod)
> +{
> +	unsigned m, n, od;
> +
> +	od =3D 1;
> +
> +	/*
> +	 * The frequency after the input divider must be between 10 and 50 MHz.
> +	 * The highest divider yields the best resolution.
> +	 */
> +	n =3D parent_rate / (10 * MHZ);
> +	n =3D min_t(unsigned, n, 1 << clk_info->pll.n_bits);
> +	n =3D max_t(unsigned, n, 1);
> +
> +	m =3D (rate / MHZ) * od * n / (parent_rate / MHZ);
> +	m =3D min_t(unsigned, m, 1 << clk_info->pll.m_bits);
> +	m =3D max_t(unsigned, m, 1);

These appear to assume m_offset & n_offset are both 1.

> +
> +	if (pm)
> +		*pm =3D m;
> +	if (pn)
> +		*pn =3D n;
> +	if (pod)
> +		*pod =3D od;
> +
> +	return parent_rate * m / (n * od);

same again


You may want to consider a more brute force approach like TZ1090 does at
some point, for maximum accuracy and to avoid problems when output is
fed back in as input and gives a different result:

rate =3D clk_round_rate(clk, desired);
clk_set_rate(clk, rate);
actual_rate =3D clk_get_rate(clk);

rate !=3D actual_rate

I can't tell from a superficial glance whether its vulnerable to that
problem.

> +}
> +
> +static long
> +ingenic_pll_round_rate(struct clk_hw *hw, unsigned long req_rate,
> +		       unsigned long *prate)
> +{
> +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +
> +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> +	BUG_ON(clk_info->type !=3D CGU_CLK_PLL);
> +
> +	return ingenic_pll_calc(clk_info, req_rate, *prate, NULL, NULL, NULL);
> +}
> +
> +static int
> +ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
> +		     unsigned long parent_rate)
> +{
> +	const unsigned timeout =3D 100;
> +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +	const struct ingenic_cgu_pll_info *pll_info;
> +	unsigned long rate, flags;
> +	unsigned m, n, od, i;
> +	u32 ctl;
> +
> +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> +	BUG_ON(clk_info->type !=3D CGU_CLK_PLL);
> +	pll_info =3D &clk_info->pll;
> +
> +	rate =3D ingenic_pll_calc(clk_info, req_rate, parent_rate,
> +			       &m, &n, &od);
> +	if (rate !=3D req_rate)
> +		pr_info("ingenic-cgu: request '%s' rate %luHz, actual %luHz\n",
> +			clk_info->name, req_rate, rate);
> +
> +	spin_lock_irqsave(&cgu->pll_lock, flags);
> +	ctl =3D readl(cgu->base + pll_info->reg);
> +
> +	ctl &=3D ~(GENMASK(pll_info->m_bits - 1, 0) << pll_info->m_shift);
> +	ctl |=3D (m - pll_info->m_offset) << pll_info->m_shift;
> +
> +	ctl &=3D ~(GENMASK(pll_info->n_bits - 1, 0) << pll_info->n_shift);
> +	ctl |=3D (n - pll_info->n_offset) << pll_info->n_shift;
> +
> +	ctl &=3D ~(GENMASK(pll_info->od_bits - 1, 0) << pll_info->od_shift);
> +	ctl |=3D pll_info->od_encoding[od - 1] << pll_info->od_shift;
> +
> +	ctl &=3D ~BIT(pll_info->bypass_bit);
> +	ctl |=3D BIT(pll_info->enable_bit);
> +
> +	writel(ctl, cgu->base + pll_info->reg);
> +
> +	/* wait for the PLL to stabilise */
> +	for (i =3D 0; i < timeout; i++) {
> +		ctl =3D readl(cgu->base + pll_info->reg);
> +		if (ctl & BIT(pll_info->stable_bit))
> +			break;
> +		mdelay(1);
> +	}
> +
> +	spin_unlock_irqrestore(&cgu->pll_lock, flags);
> +
> +	if (i =3D=3D timeout)
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops ingenic_pll_ops =3D {
> +	.recalc_rate =3D ingenic_pll_recalc_rate,
> +	.round_rate =3D ingenic_pll_round_rate,
> +	.set_rate =3D ingenic_pll_set_rate,
> +};
> +
> +/*
> + * Operations for all non-PLL clocks
> + */
> +
> +static u8 ingenic_clk_get_parent(struct clk_hw *hw)
> +{
> +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +	u32 reg;
> +	u8 i, hw_idx, idx =3D 0;
> +
> +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> +
> +	if (clk_info->type & CGU_CLK_MUX) {
> +		reg =3D readl(cgu->base + clk_info->mux.reg);
> +		hw_idx =3D (reg >> clk_info->mux.shift) &
> +			 ((1 << clk_info->mux.bits) - 1);

Looks like a good place for GENMASK like elsewhere. Maybe same in a few
places below.

> +
> +		/*
> +		 * Convert the hardware index to the parent index by skipping
> +		 * over any -1's in the parents array.
> +		 */
> +		for (i =3D 0; i < hw_idx; i++) {
> +			if (clk_info->parents[i] !=3D -1)
> +				idx++;
> +		}
> +	}
> +
> +	return idx;
> +}
> +
> +static int ingenic_clk_set_parent(struct clk_hw *hw, u8 idx)
> +{
> +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +	unsigned long flags;
> +	u8 curr_idx, hw_idx, num_poss;
> +	u32 reg, mask;
> +
> +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> +
> +	if (clk_info->type & CGU_CLK_MUX) {
> +		/*
> +		 * Convert the parent index to the hardware index by adding
> +		 * 1 for any -1 in the parents array preceding the given
> +		 * index. That is, we want the index of idx'th entry in
> +		 * clk_info->parents which does not equal -1.
> +		 */
> +		hw_idx =3D curr_idx =3D 0;
> +		num_poss =3D 1 << clk_info->mux.bits;
> +		for (; (hw_idx < num_poss) && (curr_idx !=3D idx); hw_idx++) {

if idx=3D=3D0, this'll never iterate since curr_idx starts at 0, even if the
first parent is -1. It's basically an off-by-one error I think.

> +			if (clk_info->parents[hw_idx] =3D=3D -1)
> +				continue;
> +			curr_idx++;

maybe move the curr_idx =3D=3D idx check here.

> +		}
> +
> +		/* idx should always be a valid parent */
> +		BUG_ON(curr_idx !=3D idx);

Hmm, i suppose. BUG_ON(hw_idx =3D=3D num_poss) looks more direct/intuitive
to me, but probably subjective.

> +
> +		mask =3D ((1 << clk_info->mux.bits) - 1) << clk_info->mux.shift;
> +
> +		spin_lock_irqsave(&cgu->divmux_lock, flags);
> +
> +		/* write the register */
> +		reg =3D readl(cgu->base + clk_info->mux.reg);
> +		reg &=3D ~mask;
> +		reg |=3D hw_idx << clk_info->mux.shift;
> +		writel(reg, cgu->base + clk_info->mux.reg);
> +
> +		spin_unlock_irqrestore(&cgu->divmux_lock, flags);
> +		return 0;
> +	}
> +
> +	return idx ? -EINVAL : 0;
> +}
> +
> +static unsigned long
> +ingenic_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +	unsigned long rate =3D parent_rate;
> +	u32 div_reg, div;
> +
> +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> +
> +	if (clk_info->type & CGU_CLK_DIV) {
> +		div_reg =3D readl(cgu->base + clk_info->div.reg);
> +		div =3D (div_reg >> clk_info->div.shift) &
> +		      ((1 << clk_info->div.bits) - 1);
> +		div +=3D 1;
> +
> +		rate /=3D div;
> +	}
> +
> +	return rate;
> +}
> +
> +static unsigned
> +ingenic_clk_calc_div(const struct ingenic_cgu_clk_info *clk_info,
> +		     unsigned long parent_rate, unsigned long req_rate)
> +{
> +	unsigned div;
> +
> +	/* calculate the divide */
> +	div =3D DIV_ROUND_UP(parent_rate, req_rate);
> +
> +	/* and impose hardware constraints */
> +	div =3D min_t(unsigned, div, 1 << clk_info->div.bits);
> +	div =3D max_t(unsigned, div, 1);
> +
> +	return div;
> +}
> +
> +static long
> +ingenic_clk_round_rate(struct clk_hw *hw, unsigned long req_rate,
> +		       unsigned long *parent_rate)
> +{
> +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +	long rate =3D req_rate;

should the default be *parent_rate?

> +	unsigned div;
> +
> +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> +
> +	if (clk_info->type & CGU_CLK_DIV) {
> +		div =3D ingenic_clk_calc_div(clk_info, *parent_rate, req_rate);
> +		rate =3D *parent_rate / div;
> +	} else if (clk_info->type & CGU_CLK_FIXDIV) {
> +		rate =3D *parent_rate / clk_info->fixdiv.div;
> +	}
> +
> +	return rate;
> +}
> +
> +static int
> +ingenic_clk_set_rate(struct clk_hw *hw, unsigned long req_rate,
> +		     unsigned long parent_rate)
> +{
> +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +	const unsigned timeout =3D 100;
> +	unsigned long rate, flags;
> +	unsigned div, i;
> +	u32 reg, mask;
> +	int ret =3D 0;
> +
> +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> +
> +	if (clk_info->type & CGU_CLK_DIV) {
> +		div =3D ingenic_clk_calc_div(clk_info, parent_rate, req_rate);
> +		rate =3D parent_rate / div;
> +
> +		if (rate !=3D req_rate)
> +			return -EINVAL;
> +
> +		spin_lock_irqsave(&cgu->divmux_lock, flags);
> +		reg =3D readl(cgu->base + clk_info->div.reg);
> +
> +		/* update the divide */
> +		mask =3D (1 << clk_info->div.bits) - 1;
> +		reg &=3D ~(mask << clk_info->div.shift);
> +		reg |=3D (div - 1) << clk_info->div.shift;
> +
> +		/* clear the stop bit */
> +		if (clk_info->div.stop_bit !=3D -1)
> +			reg &=3D ~(1 << clk_info->div.stop_bit);

BIT() (same for a couple of cases below)

> +
> +		/* set the change enable bit */
> +		if (clk_info->div.ce_bit !=3D -1)
> +			reg |=3D 1 << clk_info->div.ce_bit;
> +
> +		/* update the hardware */
> +		writel(reg, cgu->base + clk_info->div.reg);
> +
> +		/* wait for the change to take effect */
> +		if (clk_info->div.busy_bit !=3D -1) {
> +			for (i =3D 0; i < timeout; i++) {
> +				reg =3D readl(cgu->base + clk_info->div.reg);
> +				if (!(reg & (1 << clk_info->div.busy_bit)))
> +					break;
> +				mdelay(1);
> +			}
> +			if (i =3D=3D timeout)
> +				ret =3D -EBUSY;
> +		}
> +
> +		spin_unlock_irqrestore(&cgu->divmux_lock, flags);

Is the main common clk lock & mutex insufficient? Setting rate appears
to take a mutex anyway, so you're already not in atomic context, in
which case maybe s/mdelay/msleep/ throughout if you can get rid of the
locks.

Its getting late. I'll continue looking at this patch some other time.

Cheers
James

> +		return ret;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ingenic_clk_enable(struct clk_hw *hw)
> +{
> +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +	unsigned long flags;
> +
> +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> +
> +	if (clk_info->type & CGU_CLK_GATE) {
> +		/* ungate the clock */
> +		spin_lock_irqsave(&cgu->power_lock, flags);
> +		ingenic_cgu_gate_set(cgu, &clk_info->gate, false);
> +		spin_unlock_irqrestore(&cgu->power_lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static void ingenic_clk_disable(struct clk_hw *hw)
> +{
> +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +	unsigned long flags;
> +
> +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> +
> +	if (clk_info->type & CGU_CLK_GATE) {
> +		/* gate the clock */
> +		spin_lock_irqsave(&cgu->power_lock, flags);
> +		ingenic_cgu_gate_set(cgu, &clk_info->gate, true);
> +		spin_unlock_irqrestore(&cgu->power_lock, flags);
> +	}
> +}
> +
> +static int ingenic_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +	unsigned long flags;
> +	int enabled =3D 1;
> +
> +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> +
> +	if (clk_info->type & CGU_CLK_GATE) {
> +		spin_lock_irqsave(&cgu->power_lock, flags);
> +		enabled =3D !ingenic_cgu_gate_get(cgu, &clk_info->gate);
> +		spin_unlock_irqrestore(&cgu->power_lock, flags);
> +	}
> +
> +	return enabled;
> +}
> +
> +static const struct clk_ops ingenic_clk_ops =3D {
> +	.get_parent =3D ingenic_clk_get_parent,
> +	.set_parent =3D ingenic_clk_set_parent,
> +
> +	.recalc_rate =3D ingenic_clk_recalc_rate,
> +	.round_rate =3D ingenic_clk_round_rate,
> +	.set_rate =3D ingenic_clk_set_rate,
> +
> +	.enable =3D ingenic_clk_enable,
> +	.disable =3D ingenic_clk_disable,
> +	.is_enabled =3D ingenic_clk_is_enabled,
> +};
> +
> +/*
> + * Setup functions.
> + */
> +
> +static int register_clock(struct ingenic_cgu *cgu, unsigned idx)
> +{
> +	const struct ingenic_cgu_clk_info *clk_info =3D &cgu->clock_info[idx];
> +	struct clk_init_data clk_init;
> +	struct ingenic_clk *ingenic_clk =3D NULL;
> +	struct clk *clk, *parent;
> +	const char *parent_names[4];
> +	unsigned caps, i, num_possible;
> +	int err =3D -EINVAL;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(clk_info->parents) > ARRAY_SIZE(parent_names));
> +
> +	if (clk_info->type =3D=3D CGU_CLK_EXT) {
> +		clk =3D of_clk_get_by_name(cgu->np, clk_info->name);
> +		if (IS_ERR(clk)) {
> +			pr_err("%s: no external clock '%s' provided\n",
> +			       __func__, clk_info->name);
> +			err =3D -ENODEV;
> +			goto out;
> +		}
> +		err =3D clk_register_clkdev(clk, clk_info->name, NULL);
> +		if (err) {
> +			clk_put(clk);
> +			goto out;
> +		}
> +		cgu->clocks.clks[idx] =3D clk;
> +		return 0;
> +	}
> +
> +	if (!clk_info->type) {
> +		pr_err("%s: no clock type specified for '%s'\n", __func__,
> +		       clk_info->name);
> +		goto out;
> +	}
> +
> +	ingenic_clk =3D kzalloc(sizeof(*ingenic_clk), GFP_KERNEL);
> +	if (!ingenic_clk) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	ingenic_clk->hw.init =3D &clk_init;
> +	ingenic_clk->cgu =3D cgu;
> +	ingenic_clk->idx =3D idx;
> +
> +	clk_init.name =3D clk_info->name;
> +	clk_init.flags =3D 0;
> +	clk_init.parent_names =3D parent_names;
> +
> +	caps =3D clk_info->type;
> +
> +	if (caps & (CGU_CLK_MUX | CGU_CLK_CUSTOM)) {
> +		clk_init.num_parents =3D 0;
> +
> +		if (caps & CGU_CLK_MUX)
> +			num_possible =3D 1 << clk_info->mux.bits;
> +		else
> +			num_possible =3D ARRAY_SIZE(clk_info->parents);
> +
> +		for (i =3D 0; i < num_possible; i++) {
> +			if (clk_info->parents[i] =3D=3D -1)
> +				continue;
> +
> +			parent =3D cgu->clocks.clks[clk_info->parents[i]];
> +			parent_names[clk_init.num_parents] =3D
> +				__clk_get_name(parent);
> +			clk_init.num_parents++;
> +		}
> +
> +		BUG_ON(!clk_init.num_parents);
> +		BUG_ON(clk_init.num_parents > ARRAY_SIZE(parent_names));
> +	} else {
> +		BUG_ON(clk_info->parents[0] =3D=3D -1);
> +		clk_init.num_parents =3D 1;
> +		parent =3D cgu->clocks.clks[clk_info->parents[0]];
> +		parent_names[0] =3D __clk_get_name(parent);
> +	}
> +
> +	if (caps & CGU_CLK_CUSTOM) {
> +		clk_init.ops =3D clk_info->custom.clk_ops;
> +
> +		caps &=3D ~CGU_CLK_CUSTOM;
> +
> +		if (caps) {
> +			pr_err("%s: custom clock may not be combined with type 0x%x\n",
> +			       __func__, caps);
> +			goto out;
> +		}
> +	} else if (caps & CGU_CLK_PLL) {
> +		clk_init.ops =3D &ingenic_pll_ops;
> +
> +		caps &=3D ~CGU_CLK_PLL;
> +
> +		if (caps) {
> +			pr_err("%s: PLL may not be combined with type 0x%x\n",
> +			       __func__, caps);
> +			goto out;
> +		}
> +	} else {
> +		clk_init.ops =3D &ingenic_clk_ops;
> +	}
> +
> +	/* nothing to do for gates or fixed dividers */
> +	caps &=3D ~(CGU_CLK_GATE | CGU_CLK_FIXDIV);
> +
> +	if (caps & CGU_CLK_MUX) {
> +		if (!(caps & CGU_CLK_MUX_GLITCHFREE))
> +			clk_init.flags |=3D CLK_SET_PARENT_GATE;
> +
> +		caps &=3D ~(CGU_CLK_MUX | CGU_CLK_MUX_GLITCHFREE);
> +	}
> +
> +	if (caps & CGU_CLK_DIV) {
> +		caps &=3D ~CGU_CLK_DIV;
> +	} else {
> +		/* pass rate changes to the parent clock */
> +		clk_init.flags |=3D CLK_SET_RATE_PARENT;
> +	}
> +
> +	if (caps) {
> +		pr_err("%s: unknown clock type 0x%x\n", __func__, caps);
> +		goto out;
> +	}
> +
> +	clk =3D clk_register(NULL, &ingenic_clk->hw);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: failed to register clock '%s'\n", __func__,
> +		       clk_info->name);
> +		err =3D PTR_ERR(clk);
> +		goto out;
> +	}
> +
> +	err =3D clk_register_clkdev(clk, clk_info->name, NULL);
> +	if (err)
> +		goto out;
> +
> +	cgu->clocks.clks[idx] =3D clk;
> +out:
> +	if (err)
> +		kfree(ingenic_clk);
> +	return err;
> +}
> +
> +struct ingenic_cgu *
> +ingenic_cgu_new(const struct ingenic_cgu_clk_info *clock_info,
> +		unsigned num_clocks, struct device_node *np)
> +{
> +	struct ingenic_cgu *cgu;
> +
> +	cgu =3D kzalloc(sizeof(*cgu), GFP_KERNEL);
> +	if (!cgu)
> +		goto err_out;
> +
> +	cgu->base =3D of_iomap(np, 0);
> +	if (!cgu->base) {
> +		pr_err("%s: failed to map CGU registers\n", __func__);
> +		goto err_out_free;
> +	}
> +
> +	cgu->np =3D np;
> +	cgu->clock_info =3D clock_info;
> +	cgu->clocks.clk_num =3D num_clocks;
> +
> +	spin_lock_init(&cgu->divmux_lock);
> +	spin_lock_init(&cgu->power_lock);
> +	spin_lock_init(&cgu->pll_lock);
> +
> +	return cgu;
> +
> +err_out_free:
> +	kfree(cgu);
> +err_out:
> +	return NULL;
> +}
> +
> +int ingenic_cgu_register_clocks(struct ingenic_cgu *cgu)
> +{
> +	unsigned i;
> +	int err;
> +
> +	cgu->clocks.clks =3D kcalloc(cgu->clocks.clk_num, sizeof(struct clk *),
> +				   GFP_KERNEL);
> +	if (!cgu->clocks.clks) {
> +		err =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	for (i =3D 0; i < cgu->clocks.clk_num; i++) {
> +		err =3D register_clock(cgu, i);
> +		if (err)
> +			goto err_out_unregister;
> +	}
> +
> +	err =3D of_clk_add_provider(cgu->np, of_clk_src_onecell_get,
> +				  &cgu->clocks);
> +	if (err)
> +		goto err_out_unregister;
> +
> +	return 0;
> +
> +err_out_unregister:
> +	if (cgu) {
> +		for (i =3D 0; i < cgu->clocks.clk_num; i++) {
> +			if (!cgu->clocks.clks[i])
> +				continue;
> +			if (cgu->clock_info[i].type & CGU_CLK_EXT)
> +				clk_put(cgu->clocks.clks[i]);
> +			else
> +				clk_unregister(cgu->clocks.clks[i]);
> +		}
> +		kfree(cgu->clocks.clks);
> +	}
> +err_out:
> +	return err;
> +}
> diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
> new file mode 100644
> index 0000000..47e0552
> --- /dev/null
> +++ b/drivers/clk/ingenic/cgu.h
> @@ -0,0 +1,223 @@
> +/*
> + * Ingenic SoC CGU driver
> + *
> + * Copyright (c) 2013-2015 Imagination Technologies
> + * Author: Paul Burton <paul.burton@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __DRIVERS_CLK_INGENIC_CGU_H__
> +#define __DRIVERS_CLK_INGENIC_CGU_H__
> +
> +#include <linux/of.h>
> +#include <linux/spinlock.h>
> +
> +/**
> + * struct ingenic_cgu_pll_info - information about a PLL
> + * @reg: the offset of the PLL's control register within the CGU
> + * @m_shift: the number of bits to shift the multiplier value by (ie. the
> + *           index of the lowest bit of the multiplier value in the PLL's
> + *           control register)
> + * @m_bits: the size of the multiplier field in bits
> + * @m_offset: the multiplier value which encodes to 0 in the PLL's contr=
ol
> + *            register
> + * @n_shift: the number of bits to shift the divider value by (ie. the
> + *           index of the lowest bit of the divider value in the PLL's
> + *           control register)
> + * @n_bits: the size of the divider field in bits
> + * @n_offset: the divider value which encodes to 0 in the PLL's control
> + *            register
> + * @od_shift: the number of bits to shift the post-VCO divider value by =
(ie.
> + *            the index of the lowest bit of the post-VCO divider value =
in
> + *            the PLL's control register)
> + * @od_bits: the size of the post-VCO divider field in bits
> + * @od_max: the maximum post-VCO divider value
> + * @od_encoding: a pointer to an array mapping post-VCO divider values to
> + *               their encoded values in the PLL control register, or -1=
 for
> + *               unsupported values
> + * @bypass_bit: the index of the bypass bit in the PLL control register
> + * @enable_bit: the index of the enable bit in the PLL control register
> + * @stable_bit: the index of the stable bit in the PLL control register
> + */
> +struct ingenic_cgu_pll_info {
> +	unsigned reg;
> +	unsigned m_shift, m_bits, m_offset;
> +	unsigned n_shift, n_bits, n_offset;
> +	unsigned od_shift, od_bits, od_max;
> +	const s8 *od_encoding;
> +	unsigned bypass_bit;
> +	unsigned enable_bit;
> +	unsigned stable_bit;
> +};
> +
> +/**
> + * struct ingenic_cgu_mux_info - information about a clock mux
> + * @reg: offset of the mux control register within the CGU
> + * @shift: number of bits to shift the mux value by (ie. the index of
> + *         the lowest bit of the mux value within its control register)
> + * @bits: the size of the mux value in bits
> + */
> +struct ingenic_cgu_mux_info {
> +	unsigned reg;
> +	unsigned shift:5;
> +	unsigned bits:5;
> +};
> +
> +/**
> + * struct ingenic_cgu_div_info - information about a divider
> + * @reg: offset of the divider control register within the CGU
> + * @shift: number of bits to shift the divide value by (ie. the index of
> + *         the lowest bit of the divide value within its control registe=
r)
> + * @bits: the size of the divide value in bits
> + * @ce_bit: the index of the change enable bit within reg, or -1 is there
> + *          isn't one
> + * @busy_bit: the index of the busy bit within reg, or -1 is there isn't=
 one
> + * @stop_bit: the index of the stop bit within reg, or -1 is there isn't=
 one
> + */
> +struct ingenic_cgu_div_info {
> +	unsigned reg;
> +	unsigned shift:5;
> +	unsigned bits:5;
> +	int ce_bit:6;
> +	int busy_bit:6;
> +	int stop_bit:6;
> +};
> +
> +/**
> + * struct ingenic_cgu_fixdiv_info - information about a fixed divider
> + * @div: the divider applied to the parent clock
> + */
> +struct ingenic_cgu_fixdiv_info {
> +	unsigned div;
> +};
> +
> +/**
> + * struct ingenic_cgu_gate_info - information about a clock gate
> + * @reg: offset of the gate control register within the CGU
> + * @bit: offset of the bit in the register that controls the gate
> + */
> +struct ingenic_cgu_gate_info {
> +	unsigned reg;
> +	unsigned bit:5;
> +};
> +
> +/**
> + * struct ingenic_cgu_custom_info - information about a custom (SoC) clo=
ck
> + */
> +struct ingenic_cgu_custom_info {
> +	struct clk_ops *clk_ops;
> +};
> +
> +/**
> + * struct ingenic_cgu_clk_info - information about a clock
> + * @name: name of the clock
> + * @type: a bitmask formed from CGU_CLK_* values
> + * @parents: an array of the indices of potential parents of this clock
> + *           within the clock_info array of the CGU, or -1 in entries
> + *           which correspond to no valid parent
> + * @pll: information valid if type includes CGU_CLK_PLL
> + * @gate: information valid if type includes CGU_CLK_GATE
> + * @mux: information valid if type includes CGU_CLK_MUX
> + * @div: information valid if type includes CGU_CLK_DIV
> + */
> +struct ingenic_cgu_clk_info {
> +	const char *name;
> +
> +	enum {
> +		CGU_CLK_NONE		=3D 0,
> +		CGU_CLK_EXT		=3D (1 << 0),
> +		CGU_CLK_PLL		=3D (1 << 1),
> +		CGU_CLK_GATE		=3D (1 << 2),
> +		CGU_CLK_MUX		=3D (1 << 3),
> +		CGU_CLK_MUX_GLITCHFREE	=3D (1 << 4),
> +		CGU_CLK_DIV		=3D (1 << 5),
> +		CGU_CLK_FIXDIV		=3D (1 << 6),
> +		CGU_CLK_CUSTOM		=3D (1 << 7),
> +	} type;
> +
> +	int parents[4];
> +
> +	union {
> +		struct ingenic_cgu_pll_info pll;
> +
> +		struct {
> +			struct ingenic_cgu_gate_info gate;
> +			struct ingenic_cgu_mux_info mux;
> +			struct ingenic_cgu_div_info div;
> +			struct ingenic_cgu_fixdiv_info fixdiv;
> +		};
> +
> +		struct ingenic_cgu_custom_info custom;
> +	};
> +};
> +
> +/**
> + * struct ingenic_cgu - data about the CGU
> + * @np: the device tree node that caused the CGU to be probed
> + * @base: the ioremap'ed base address of the CGU registers
> + * @clock_info: an array containing information about implemented clocks
> + * @clocks: used to provide clocks to DT, allows lookup of struct clk*
> + * @gate_lock: lock to be held whilst (un)gating a clock
> + * @divmux_lock: lock to be held whilst re-muxing of rate-changing a clo=
ck
> + */
> +struct ingenic_cgu {
> +	struct device_node *np;
> +	void __iomem *base;
> +
> +	const struct ingenic_cgu_clk_info *clock_info;
> +	struct clk_onecell_data clocks;
> +
> +	spinlock_t divmux_lock;		/* must be held when changing a divide
> +					   or re-muxing a clock */
> +	spinlock_t power_lock;		/* must be held when changing a power
> +					   manager register */
> +	spinlock_t pll_lock;		/* must be held when changing a PLL
> +					   control register */
> +};
> +
> +/**
> + * struct ingenic_clk - private data for a clock
> + * @hw: see Documentation/clk.txt
> + * @cgu: a pointer to the CGU data
> + * @idx: the index of this clock in cgu->clock_info
> + */
> +struct ingenic_clk {
> +	struct clk_hw hw;
> +	struct ingenic_cgu *cgu;
> +	unsigned idx;
> +};
> +
> +#define to_ingenic_clk(_hw) container_of(_hw, struct ingenic_clk, hw)
> +
> +/**
> + * ingenic_cgu_new - create a new CGU instance
> + * @clock_info: an array of clock information structures describing the =
clocks
> + *              which are implemented by the CGU
> + * @num_clocks: the number of entries in clock_info
> + * @np: the device tree node which causes this CGU to be probed
> + *
> + * Returns an opaque pointer to the CGU instance if initialisation & clo=
ck
> + * registration is successful, otherwise NULL.
> + */
> +struct ingenic_cgu *
> +ingenic_cgu_new(const struct ingenic_cgu_clk_info *clock_info,
> +		unsigned num_clocks, struct device_node *np);
> +
> +/**
> + * ingenic_cgu_register_clocks - Registers the clocks
> + * @cgu: pointer to cgu data
> + *
> + * Returns 1 on success and -EINVAL if unsuccesful.
> + */
> +int ingenic_cgu_register_clocks(struct ingenic_cgu *cgu);
> +
> +#endif /* __DRIVERS_CLK_INGENIC_CGU_H__ */
> --=20
> 2.3.5
>=20
>=20

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVNtxsAAoJEGwLaZPeOHZ6CPcP+wUoxzPbBfkrKw20Xz2af/ZC
6m9hzn31YKaegwKseWs/SNjqkoxViRaRXj/+yAtXZrHA9qm+IKEryr22XtQ6eO+H
4ZLv9gEKnY8uDR53EVabrozsoiVBY7QTCflkHGCtIesI+smZ5h44t6OVIlQch5uB
NhaK6clumpYVifeWAijSvii1q0/z5E/IKfq9W+bX1jOSYF3EbCAaeytVmuLcTVEA
6Yx0z/6BfmrrwTipGGLVlnomKQzO5sm3yqVqwA+oI8yrz2PGgZhy/DjoJoKDsC0G
PWxLwjoE2cpFTpyL+pWQ2PP7/4jfk/R+IZjFg/+tptlWhZHx9r3ogi4/jmki2+N0
5L5wRT2SD92J83WWbh7F2czPWQM03mlECdLolcKe6O2Xsnmuzu1iljt1+8NxjGkZ
aDDjs+iTyV6VFC1DGghfrlXte5auwUO43m/QAZZKptag9J6iDEtwL50E5sLS+GH/
7POl894fY2JBT98Lf4Oe8daVhkUyUTC8iJ4XxM3mVZgIMzPv/+/v7H6EC/UPkfi2
osF6C4By35m3YjpZIoaZ1rVDIBuuiKSsjuvaJSkTim/huri6VWW8xwJCOC1v6lkP
210u1dhPU90tKW9HsBkVZkDsV0EqLou9otCa50WMy15lQaF8Km9Ws1txGqGSAk5Y
aNnZgQXkz8UOAOoknKOp
=QG/m
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
