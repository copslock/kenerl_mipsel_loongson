Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2015 10:52:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22573 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010134AbbDVIwMU7k6N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2015 10:52:12 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 53BA441F8E0B;
        Wed, 22 Apr 2015 09:52:08 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 22 Apr 2015 09:52:08 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 22 Apr 2015 09:52:08 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BA69B273B1138;
        Wed, 22 Apr 2015 09:52:05 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 22 Apr 2015 09:52:07 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 22 Apr
 2015 09:52:07 +0100
Date:   Wed, 22 Apr 2015 09:52:07 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Mike Turquette" <mturquette@linaro.org>
Subject: Re: [PATCH v3 25/37] clk: ingenic: add driver for Ingenic SoC CGU
 clocks
Message-ID: <20150422085207.GE10157@jhogan-linux.le.imgtec.org>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
 <1429627624-30525-26-git-send-email-paul.burton@imgtec.com>
 <20150421232532.GC10157@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline
In-Reply-To: <20150421232532.GC10157@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47006
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

--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 12:25:32AM +0100, James Hogan wrote:
> On Tue, Apr 21, 2015 at 03:46:52PM +0100, Paul Burton wrote:
> > +static int ingenic_clk_set_parent(struct clk_hw *hw, u8 idx)
> > +{
> > +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> > +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> > +	const struct ingenic_cgu_clk_info *clk_info;
> > +	unsigned long flags;
> > +	u8 curr_idx, hw_idx, num_poss;
> > +	u32 reg, mask;
> > +
> > +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> > +
> > +	if (clk_info->type & CGU_CLK_MUX) {
> > +		/*
> > +		 * Convert the parent index to the hardware index by adding
> > +		 * 1 for any -1 in the parents array preceding the given
> > +		 * index. That is, we want the index of idx'th entry in
> > +		 * clk_info->parents which does not equal -1.
> > +		 */
> > +		hw_idx =3D curr_idx =3D 0;
> > +		num_poss =3D 1 << clk_info->mux.bits;
> > +		for (; (hw_idx < num_poss) && (curr_idx !=3D idx); hw_idx++) {
>=20
> if idx=3D=3D0, this'll never iterate since curr_idx starts at 0, even if =
the
> first parent is -1. It's basically an off-by-one error I think.
>=20
> > +			if (clk_info->parents[hw_idx] =3D=3D -1)
> > +				continue;
> > +			curr_idx++;
>=20
> maybe move the curr_idx =3D=3D idx check here.

Sorry. Before the curr_idx++ would of course be better.

> Its getting late. I'll continue looking at this patch some other time.

Here goes...

> > +
> > +static int ingenic_clk_enable(struct clk_hw *hw)
> > +{
> > +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> > +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> > +	const struct ingenic_cgu_clk_info *clk_info;
> > +	unsigned long flags;
> > +
> > +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> > +
> > +	if (clk_info->type & CGU_CLK_GATE) {
> > +		/* ungate the clock */
> > +		spin_lock_irqsave(&cgu->power_lock, flags);
> > +		ingenic_cgu_gate_set(cgu, &clk_info->gate, false);
> > +		spin_unlock_irqrestore(&cgu->power_lock, flags);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void ingenic_clk_disable(struct clk_hw *hw)
> > +{
> > +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> > +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> > +	const struct ingenic_cgu_clk_info *clk_info;
> > +	unsigned long flags;
> > +
> > +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> > +
> > +	if (clk_info->type & CGU_CLK_GATE) {
> > +		/* gate the clock */
> > +		spin_lock_irqsave(&cgu->power_lock, flags);
> > +		ingenic_cgu_gate_set(cgu, &clk_info->gate, true);
> > +		spin_unlock_irqrestore(&cgu->power_lock, flags);
> > +	}
> > +}
> > +
> > +static int ingenic_clk_is_enabled(struct clk_hw *hw)
> > +{
> > +	struct ingenic_clk *ingenic_clk =3D to_ingenic_clk(hw);
> > +	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
> > +	const struct ingenic_cgu_clk_info *clk_info;
> > +	unsigned long flags;
> > +	int enabled =3D 1;
> > +
> > +	clk_info =3D &cgu->clock_info[ingenic_clk->idx];
> > +
> > +	if (clk_info->type & CGU_CLK_GATE) {
> > +		spin_lock_irqsave(&cgu->power_lock, flags);
> > +		enabled =3D !ingenic_cgu_gate_get(cgu, &clk_info->gate);
> > +		spin_unlock_irqrestore(&cgu->power_lock, flags);
> > +	}
> > +
> > +	return enabled;
> > +}
> > +
> > +static const struct clk_ops ingenic_clk_ops =3D {
> > +	.get_parent =3D ingenic_clk_get_parent,
> > +	.set_parent =3D ingenic_clk_set_parent,
> > +
> > +	.recalc_rate =3D ingenic_clk_recalc_rate,
> > +	.round_rate =3D ingenic_clk_round_rate,
> > +	.set_rate =3D ingenic_clk_set_rate,
> > +
> > +	.enable =3D ingenic_clk_enable,
> > +	.disable =3D ingenic_clk_disable,
> > +	.is_enabled =3D ingenic_clk_is_enabled,
> > +};
> > +
> > +/*
> > + * Setup functions.
> > + */
> > +
> > +static int register_clock(struct ingenic_cgu *cgu, unsigned idx)
> > +{
> > +	const struct ingenic_cgu_clk_info *clk_info =3D &cgu->clock_info[idx];
> > +	struct clk_init_data clk_init;
> > +	struct ingenic_clk *ingenic_clk =3D NULL;
> > +	struct clk *clk, *parent;
> > +	const char *parent_names[4];
> > +	unsigned caps, i, num_possible;
> > +	int err =3D -EINVAL;
> > +
> > +	BUILD_BUG_ON(ARRAY_SIZE(clk_info->parents) > ARRAY_SIZE(parent_names)=
);
> > +
> > +	if (clk_info->type =3D=3D CGU_CLK_EXT) {
> > +		clk =3D of_clk_get_by_name(cgu->np, clk_info->name);
> > +		if (IS_ERR(clk)) {
> > +			pr_err("%s: no external clock '%s' provided\n",
> > +			       __func__, clk_info->name);
> > +			err =3D -ENODEV;
> > +			goto out;
> > +		}
> > +		err =3D clk_register_clkdev(clk, clk_info->name, NULL);
> > +		if (err) {
> > +			clk_put(clk);
> > +			goto out;
> > +		}
> > +		cgu->clocks.clks[idx] =3D clk;
> > +		return 0;
> > +	}
> > +
> > +	if (!clk_info->type) {
> > +		pr_err("%s: no clock type specified for '%s'\n", __func__,
> > +		       clk_info->name);
> > +		goto out;
> > +	}
> > +
> > +	ingenic_clk =3D kzalloc(sizeof(*ingenic_clk), GFP_KERNEL);
> > +	if (!ingenic_clk) {
> > +		err =3D -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	ingenic_clk->hw.init =3D &clk_init;
> > +	ingenic_clk->cgu =3D cgu;
> > +	ingenic_clk->idx =3D idx;
> > +
> > +	clk_init.name =3D clk_info->name;
> > +	clk_init.flags =3D 0;
> > +	clk_init.parent_names =3D parent_names;
> > +
> > +	caps =3D clk_info->type;
> > +
> > +	if (caps & (CGU_CLK_MUX | CGU_CLK_CUSTOM)) {
> > +		clk_init.num_parents =3D 0;
> > +
> > +		if (caps & CGU_CLK_MUX)
> > +			num_possible =3D 1 << clk_info->mux.bits;
> > +		else
> > +			num_possible =3D ARRAY_SIZE(clk_info->parents);
> > +
> > +		for (i =3D 0; i < num_possible; i++) {
> > +			if (clk_info->parents[i] =3D=3D -1)
> > +				continue;
> > +
> > +			parent =3D cgu->clocks.clks[clk_info->parents[i]];
> > +			parent_names[clk_init.num_parents] =3D
> > +				__clk_get_name(parent);
> > +			clk_init.num_parents++;
> > +		}
> > +
> > +		BUG_ON(!clk_init.num_parents);
> > +		BUG_ON(clk_init.num_parents > ARRAY_SIZE(parent_names));
> > +	} else {
> > +		BUG_ON(clk_info->parents[0] =3D=3D -1);
> > +		clk_init.num_parents =3D 1;
> > +		parent =3D cgu->clocks.clks[clk_info->parents[0]];
> > +		parent_names[0] =3D __clk_get_name(parent);
> > +	}
> > +
> > +	if (caps & CGU_CLK_CUSTOM) {
> > +		clk_init.ops =3D clk_info->custom.clk_ops;
> > +
> > +		caps &=3D ~CGU_CLK_CUSTOM;
> > +
> > +		if (caps) {
> > +			pr_err("%s: custom clock may not be combined with type 0x%x\n",
> > +			       __func__, caps);
> > +			goto out;
> > +		}
> > +	} else if (caps & CGU_CLK_PLL) {
> > +		clk_init.ops =3D &ingenic_pll_ops;
> > +
> > +		caps &=3D ~CGU_CLK_PLL;
> > +
> > +		if (caps) {
> > +			pr_err("%s: PLL may not be combined with type 0x%x\n",
> > +			       __func__, caps);
> > +			goto out;
> > +		}
> > +	} else {
> > +		clk_init.ops =3D &ingenic_clk_ops;
> > +	}
> > +
> > +	/* nothing to do for gates or fixed dividers */
> > +	caps &=3D ~(CGU_CLK_GATE | CGU_CLK_FIXDIV);
> > +
> > +	if (caps & CGU_CLK_MUX) {
> > +		if (!(caps & CGU_CLK_MUX_GLITCHFREE))
> > +			clk_init.flags |=3D CLK_SET_PARENT_GATE;
> > +
> > +		caps &=3D ~(CGU_CLK_MUX | CGU_CLK_MUX_GLITCHFREE);
> > +	}
> > +
> > +	if (caps & CGU_CLK_DIV) {
> > +		caps &=3D ~CGU_CLK_DIV;
> > +	} else {
> > +		/* pass rate changes to the parent clock */
> > +		clk_init.flags |=3D CLK_SET_RATE_PARENT;
> > +	}
> > +
> > +	if (caps) {
> > +		pr_err("%s: unknown clock type 0x%x\n", __func__, caps);
> > +		goto out;
> > +	}
> > +
> > +	clk =3D clk_register(NULL, &ingenic_clk->hw);
> > +	if (IS_ERR(clk)) {
> > +		pr_err("%s: failed to register clock '%s'\n", __func__,
> > +		       clk_info->name);
> > +		err =3D PTR_ERR(clk);
> > +		goto out;
> > +	}
> > +
> > +	err =3D clk_register_clkdev(clk, clk_info->name, NULL);
> > +	if (err)
> > +		goto out;

Should this unregister the clock in case of failure?

> > +
> > +	cgu->clocks.clks[idx] =3D clk;
> > +out:
> > +	if (err)
> > +		kfree(ingenic_clk);
> > +	return err;
> > +}
> > +
> > +struct ingenic_cgu *
> > +ingenic_cgu_new(const struct ingenic_cgu_clk_info *clock_info,
> > +		unsigned num_clocks, struct device_node *np)
> > +{
> > +	struct ingenic_cgu *cgu;
> > +
> > +	cgu =3D kzalloc(sizeof(*cgu), GFP_KERNEL);
> > +	if (!cgu)
> > +		goto err_out;
> > +
> > +	cgu->base =3D of_iomap(np, 0);
> > +	if (!cgu->base) {
> > +		pr_err("%s: failed to map CGU registers\n", __func__);
> > +		goto err_out_free;
> > +	}
> > +
> > +	cgu->np =3D np;
> > +	cgu->clock_info =3D clock_info;
> > +	cgu->clocks.clk_num =3D num_clocks;
> > +
> > +	spin_lock_init(&cgu->divmux_lock);
> > +	spin_lock_init(&cgu->power_lock);
> > +	spin_lock_init(&cgu->pll_lock);
> > +
> > +	return cgu;
> > +
> > +err_out_free:
> > +	kfree(cgu);
> > +err_out:
> > +	return NULL;
> > +}
> > +
> > +int ingenic_cgu_register_clocks(struct ingenic_cgu *cgu)
> > +{
> > +	unsigned i;
> > +	int err;
> > +
> > +	cgu->clocks.clks =3D kcalloc(cgu->clocks.clk_num, sizeof(struct clk *=
),
> > +				   GFP_KERNEL);
> > +	if (!cgu->clocks.clks) {
> > +		err =3D -ENOMEM;
> > +		goto err_out;
> > +	}
> > +
> > +	for (i =3D 0; i < cgu->clocks.clk_num; i++) {
> > +		err =3D register_clock(cgu, i);
> > +		if (err)
> > +			goto err_out_unregister;
> > +	}
> > +
> > +	err =3D of_clk_add_provider(cgu->np, of_clk_src_onecell_get,
> > +				  &cgu->clocks);
> > +	if (err)
> > +		goto err_out_unregister;
> > +
> > +	return 0;
> > +
> > +err_out_unregister:
> > +	if (cgu) {

This check looks redundant, since the rest of the function already assumes
non-NULL.

> > +		for (i =3D 0; i < cgu->clocks.clk_num; i++) {
> > +			if (!cgu->clocks.clks[i])
> > +				continue;
> > +			if (cgu->clock_info[i].type & CGU_CLK_EXT)
> > +				clk_put(cgu->clocks.clks[i]);
> > +			else
> > +				clk_unregister(cgu->clocks.clks[i]);
> > +		}
> > +		kfree(cgu->clocks.clks);
> > +	}
> > +err_out:
> > +	return err;
> > +}
> > diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
> > new file mode 100644
> > index 0000000..47e0552
> > --- /dev/null
> > +++ b/drivers/clk/ingenic/cgu.h
> > @@ -0,0 +1,223 @@
> > +/*
> > + * Ingenic SoC CGU driver
> > + *
> > + * Copyright (c) 2013-2015 Imagination Technologies
> > + * Author: Paul Burton <paul.burton@imgtec.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef __DRIVERS_CLK_INGENIC_CGU_H__
> > +#define __DRIVERS_CLK_INGENIC_CGU_H__
> > +
> > +#include <linux/of.h>
> > +#include <linux/spinlock.h>
> > +
> > +/**
> > + * struct ingenic_cgu_pll_info - information about a PLL
> > + * @reg: the offset of the PLL's control register within the CGU
> > + * @m_shift: the number of bits to shift the multiplier value by (ie. =
the
> > + *           index of the lowest bit of the multiplier value in the PL=
L's
> > + *           control register)
> > + * @m_bits: the size of the multiplier field in bits
> > + * @m_offset: the multiplier value which encodes to 0 in the PLL's con=
trol
> > + *            register
> > + * @n_shift: the number of bits to shift the divider value by (ie. the
> > + *           index of the lowest bit of the divider value in the PLL's
> > + *           control register)
> > + * @n_bits: the size of the divider field in bits
> > + * @n_offset: the divider value which encodes to 0 in the PLL's control
> > + *            register
> > + * @od_shift: the number of bits to shift the post-VCO divider value b=
y (ie.
> > + *            the index of the lowest bit of the post-VCO divider valu=
e in
> > + *            the PLL's control register)
> > + * @od_bits: the size of the post-VCO divider field in bits
> > + * @od_max: the maximum post-VCO divider value
> > + * @od_encoding: a pointer to an array mapping post-VCO divider values=
 to
> > + *               their encoded values in the PLL control register, or =
-1 for
> > + *               unsupported values
> > + * @bypass_bit: the index of the bypass bit in the PLL control register
> > + * @enable_bit: the index of the enable bit in the PLL control register
> > + * @stable_bit: the index of the stable bit in the PLL control register
> > + */
> > +struct ingenic_cgu_pll_info {
> > +	unsigned reg;
> > +	unsigned m_shift, m_bits, m_offset;
> > +	unsigned n_shift, n_bits, n_offset;
> > +	unsigned od_shift, od_bits, od_max;
> > +	const s8 *od_encoding;
> > +	unsigned bypass_bit;
> > +	unsigned enable_bit;
> > +	unsigned stable_bit;

I suppose a bunch of these could be reduced to u8's, but no big deal...

> > +};
> > +
> > +/**
> > + * struct ingenic_cgu_mux_info - information about a clock mux
> > + * @reg: offset of the mux control register within the CGU
> > + * @shift: number of bits to shift the mux value by (ie. the index of
> > + *         the lowest bit of the mux value within its control register)
> > + * @bits: the size of the mux value in bits
> > + */
> > +struct ingenic_cgu_mux_info {
> > +	unsigned reg;
> > +	unsigned shift:5;
> > +	unsigned bits:5;

=2E.. especially as this seems to go to the other extreme

> > +};
> > +
> > +/**
> > + * struct ingenic_cgu_div_info - information about a divider
> > + * @reg: offset of the divider control register within the CGU
> > + * @shift: number of bits to shift the divide value by (ie. the index =
of
> > + *         the lowest bit of the divide value within its control regis=
ter)
> > + * @bits: the size of the divide value in bits
> > + * @ce_bit: the index of the change enable bit within reg, or -1 is th=
ere
> > + *          isn't one
> > + * @busy_bit: the index of the busy bit within reg, or -1 is there isn=
't one
> > + * @stop_bit: the index of the stop bit within reg, or -1 is there isn=
't one

s/is/if/ for all 3 *_bit fields?

> > + */
> > +struct ingenic_cgu_div_info {
> > +	unsigned reg;
> > +	unsigned shift:5;
> > +	unsigned bits:5;
> > +	int ce_bit:6;
> > +	int busy_bit:6;
> > +	int stop_bit:6;
> > +};
> > +
> > +/**
> > + * struct ingenic_cgu_fixdiv_info - information about a fixed divider
> > + * @div: the divider applied to the parent clock
> > + */
> > +struct ingenic_cgu_fixdiv_info {
> > +	unsigned div;
> > +};
> > +
> > +/**
> > + * struct ingenic_cgu_gate_info - information about a clock gate
> > + * @reg: offset of the gate control register within the CGU
> > + * @bit: offset of the bit in the register that controls the gate
> > + */
> > +struct ingenic_cgu_gate_info {
> > +	unsigned reg;
> > +	unsigned bit:5;
> > +};
> > +
> > +/**
> > + * struct ingenic_cgu_custom_info - information about a custom (SoC) c=
lock

no description of clk_ops.

> > + */
> > +struct ingenic_cgu_custom_info {
> > +	struct clk_ops *clk_ops;
> > +};
> > +
> > +/**
> > + * struct ingenic_cgu_clk_info - information about a clock
> > + * @name: name of the clock
> > + * @type: a bitmask formed from CGU_CLK_* values
> > + * @parents: an array of the indices of potential parents of this clock
> > + *           within the clock_info array of the CGU, or -1 in entries
> > + *           which correspond to no valid parent
> > + * @pll: information valid if type includes CGU_CLK_PLL
> > + * @gate: information valid if type includes CGU_CLK_GATE
> > + * @mux: information valid if type includes CGU_CLK_MUX
> > + * @div: information valid if type includes CGU_CLK_DIV

fixdiv and custom are undescribed.

> > + */
> > +struct ingenic_cgu_clk_info {
> > +	const char *name;
> > +
> > +	enum {
> > +		CGU_CLK_NONE		=3D 0,
> > +		CGU_CLK_EXT		=3D (1 << 0),
> > +		CGU_CLK_PLL		=3D (1 << 1),
> > +		CGU_CLK_GATE		=3D (1 << 2),
> > +		CGU_CLK_MUX		=3D (1 << 3),
> > +		CGU_CLK_MUX_GLITCHFREE	=3D (1 << 4),
> > +		CGU_CLK_DIV		=3D (1 << 5),
> > +		CGU_CLK_FIXDIV		=3D (1 << 6),
> > +		CGU_CLK_CUSTOM		=3D (1 << 7),

Appropriate to use BIT() from <linux/bitops.h> here?

> > +	} type;
> > +
> > +	int parents[4];
> > +
> > +	union {
> > +		struct ingenic_cgu_pll_info pll;
> > +
> > +		struct {
> > +			struct ingenic_cgu_gate_info gate;
> > +			struct ingenic_cgu_mux_info mux;
> > +			struct ingenic_cgu_div_info div;
> > +			struct ingenic_cgu_fixdiv_info fixdiv;
> > +		};
> > +
> > +		struct ingenic_cgu_custom_info custom;
> > +	};
> > +};
> > +
> > +/**
> > + * struct ingenic_cgu - data about the CGU
> > + * @np: the device tree node that caused the CGU to be probed
> > + * @base: the ioremap'ed base address of the CGU registers
> > + * @clock_info: an array containing information about implemented cloc=
ks
> > + * @clocks: used to provide clocks to DT, allows lookup of struct clk*
> > + * @gate_lock: lock to be held whilst (un)gating a clock

stale

> > + * @divmux_lock: lock to be held whilst re-muxing of rate-changing a c=
lock

power_lock and pll_lock undescribed

> > + */
> > +struct ingenic_cgu {
> > +	struct device_node *np;
> > +	void __iomem *base;
> > +
> > +	const struct ingenic_cgu_clk_info *clock_info;
> > +	struct clk_onecell_data clocks;
> > +
> > +	spinlock_t divmux_lock;		/* must be held when changing a divide
> > +					   or re-muxing a clock */
> > +	spinlock_t power_lock;		/* must be held when changing a power
> > +					   manager register */
> > +	spinlock_t pll_lock;		/* must be held when changing a PLL
> > +					   control register */

those comments should go in the kernel doc description.

(Although see my previous email about locking in common clock framework).

> > +};
> > +
> > +/**
> > + * struct ingenic_clk - private data for a clock
> > + * @hw: see Documentation/clk.txt
> > + * @cgu: a pointer to the CGU data
> > + * @idx: the index of this clock in cgu->clock_info
> > + */
> > +struct ingenic_clk {
> > +	struct clk_hw hw;
> > +	struct ingenic_cgu *cgu;
> > +	unsigned idx;
> > +};
> > +
> > +#define to_ingenic_clk(_hw) container_of(_hw, struct ingenic_clk, hw)
> > +
> > +/**
> > + * ingenic_cgu_new - create a new CGU instance

function, so needs ()

> > + * @clock_info: an array of clock information structures describing th=
e clocks
> > + *              which are implemented by the CGU
> > + * @num_clocks: the number of entries in clock_info
> > + * @np: the device tree node which causes this CGU to be probed
> > + *
> > + * Returns an opaque pointer to the CGU instance if initialisation & c=
lock
> > + * registration is successful, otherwise NULL.

As above, do this sort of thing:
 * Return:	an opaque pointer to the CGU instance if initialisation & clock
 *		registration is successful, otherwise NULL.

> > + */
> > +struct ingenic_cgu *
> > +ingenic_cgu_new(const struct ingenic_cgu_clk_info *clock_info,
> > +		unsigned num_clocks, struct device_node *np);
> > +
> > +/**
> > + * ingenic_cgu_register_clocks - Registers the clocks
> > + * @cgu: pointer to cgu data
> > + *
> > + * Returns 1 on success and -EINVAL if unsuccesful.

same

> > + */
> > +int ingenic_cgu_register_clocks(struct ingenic_cgu *cgu);
> > +
> > +#endif /* __DRIVERS_CLK_INGENIC_CGU_H__ */

Nice work guys!

Cheers
James

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVN2E3AAoJEGwLaZPeOHZ6ZFEP/RbiG9gwRFw3g6+jD3awANg/
obgizhuMaj5SeVnRNgk8FmQoHQr0np5A+2s5GTZbV4b0tyxlFtRS98HNp9mDJQfS
/Ek34d3xABfNaDrrxXFIMZu/gnVy5GtkBpXGudnpHprrpf3rkfsfRvVhqkaCziu2
+HLXpQ2Z/r8FlthUl14Q1SMQjAZ3TWl22jv+2ZvcUJMQzw1wZcIOGgv7o3jOtbxR
wVKviedx8ffW1W/D8xxVo59egWuVGWE0JWZ5OYfC3025rNIMEfMVpDpfxpmLrmVI
DaSH6goaNleAHit35tn1Uok8nS4/5/K1mXKT9i4eBetkKILSTY4J6bsLJz5j5dl2
LCgmyZezmnmSJljAHh84MUd8EJo0cd5zlvHjplOovgjhFJY/wPKH98pIv+YAZXSg
RlQCzmHQiyWkIsZE0FarlHgXL1SyHgpg95UFYiewIvQN8mvr/oT+LxGjH0uHZ4Ql
/bSPUxCeiua2rxERdccC6O+Crm1gT3SsREEGk22PChM4qFAIQn9uKUQvZpGQ4cDo
a97VTbVd9Yf/Giz3FFezbCGk5N+pBa8jy1M2czR0JX4L0r3WxUg4LKv7ascYxTsq
0myFjay+dzTUf4Z+YzuMVCrl3fLo6On3PjnFw6aKeZoH4+voK6b9/rSpKfYw3oNa
vjJ/WKazmPdIhH4Asa8O
=lMeN
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
