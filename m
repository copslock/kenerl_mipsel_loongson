Return-Path: <SRS0=AFgm=S3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1FDC43219
	for <linux-mips@archiver.kernel.org>; Thu, 25 Apr 2019 19:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246782067D
	for <linux-mips@archiver.kernel.org>; Thu, 25 Apr 2019 19:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220442;
	bh=teroNSE84Avh46HZJbqbo3wSAYrAHykawJeuAr1a15A=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=gXjcrXMg/ngBku6hep/gs6vYKNqPxnpH3BxLWT6squntz+Ppn2qGFW+E8fkkbCWBl
	 pi+h0bo6by2F8I4oqSnUk1MsHWeSkST93iStvk1+NvYrcJzuV0On6FZfxhJIrvLnGB
	 hJmIITWH1eB6QdAxuNbprEr6JEs8i8AHP0Ru/yLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfDYT1S (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbfDYT1S (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 25 Apr 2019 15:27:18 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C8FA20717;
        Thu, 25 Apr 2019 19:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556220437;
        bh=teroNSE84Avh46HZJbqbo3wSAYrAHykawJeuAr1a15A=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=Ryubw02GmMMyT6Pvq5i3+H8V74CYN61Xqsbm5gOcrekXiZCu0u1htWysTajI0QtpI
         ONhJCGr+InrbUp7TDXAB7TCqbXNb09ACRKnMZgGToZhnHOpBgLcJ+AQQpCzwIaZLyB
         VD8LY3LXtmswGh/qqL0KaJnu2z0yFc7jdEKL+Egs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190405000129.19331-2-drvlabo@gmail.com>
References: <20190405000129.19331-1-drvlabo@gmail.com> <20190405000129.19331-2-drvlabo@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v2 1/5] clk: mips: ralink: add Ralink MIPS gating clock driver
To:     John Crispin <john@phrozen.org>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Message-ID: <155622043597.15276.9250071449626345612@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 12:27:15 -0700
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Quoting NOGUCHI Hiroshi (2019-04-04 17:01:25)
> This patch adds clock gating driver for Ralink/Mediatek MIPS Socs.

Please read Documentation/process/submitting-patches.rst and look at
this part of it in detail:

 Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
 instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
 to do frotz", as if you are giving orders to the codebase to change
 its behaviour.

>=20
> Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
> ---
>  drivers/clk/Kconfig      |   6 ++
>  drivers/clk/Makefile     |   1 +
>  drivers/clk/clk-rt2880.c | 199 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 drivers/clk/clk-rt2880.c
>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index f96c7f39ab7e..dbfdf1bcdc6c 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -290,6 +290,12 @@ config COMMON_CLK_BD718XX
>           This driver supports ROHM BD71837 and ROHM BD71847
>           PMICs clock gates.
> =20
> +config COMMON_CLK_RT2880
> +       bool "Clock driver for Mediatek/Ralink MIPS SoC Family"
> +       depends on COMMON_CLK && OF

Does it really depend on OF? Or just depends on it at runtime? If it's a
runtime requirement, perhaps make it just be depends on COMMON_CLK.

> +       help
> +         This driver support Mediatek/Ralink MIPS SoCs' clock gates.
> +
>  config COMMON_CLK_FIXED_MMIO
>         bool "Clock driver for Memory Mapped Fixed values"
> diff --git a/drivers/clk/clk-rt2880.c b/drivers/clk/clk-rt2880.c
> new file mode 100644
> index 000000000000..bcdb4c1486d3
> --- /dev/null
> +++ b/drivers/clk/clk-rt2880.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 NOGUCHI Hiroshi <drvlabo@gmail.com>
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>

Sort these includes alphabetically?

> +
> +
> +/* clock configuration 1 */

Comment seems useless.

> +#define        SYSC_REG_CLKCFG1        0x30
> +
> +#define GATE_CLK_NUM   32
> +
> +struct rt2880_gate {
> +       struct clk_hw   hw;
> +       u8      shift;
> +};
> +
> +#define        to_rt2880_gate(_hw)     container_of(_hw, struct rt2880_g=
ate, hw)
> +
> +static struct clk_hw_onecell_data *clk_data;
> +static struct regmap *syscon_regmap;

Can these be per some driver instance instead of globals? If they have
to stay global, please make a better name so that they're not so
generic.

> +
> +static int rt2880_gate_enable(struct clk_hw *hw)
> +{
> +       struct rt2880_gate *clk_gate =3D to_rt2880_gate(hw);
> +       u32 val =3D BIT(clk_gate->shift);
> +
> +       return regmap_update_bits(syscon_regmap, SYSC_REG_CLKCFG1, val, v=
al);
> +}
> +
> +static void rt2880_gate_disable(struct clk_hw *hw)
> +{
> +       struct rt2880_gate *clk_gate =3D to_rt2880_gate(hw);
> +       u32 val =3D BIT(clk_gate->shift);
> +
> +       regmap_update_bits(syscon_regmap, SYSC_REG_CLKCFG1, val, 0);
> +}
> +
> +static int rt2880_gate_is_enabled(struct clk_hw *hw)
> +{
> +       struct rt2880_gate *clk_gate =3D to_rt2880_gate(hw);
> +       unsigned int rdval;
> +
> +       if (regmap_read(syscon_regmap, SYSC_REG_CLKCFG1, &rdval))
> +               return 0;
> +
> +       return rdval & BIT(clk_gate->shift);
> +}
> +
> +static const struct clk_ops rt2880_gate_ops =3D {
> +       .enable =3D rt2880_gate_enable,
> +       .disable =3D rt2880_gate_disable,
> +       .is_enabled =3D rt2880_gate_is_enabled,
> +};
> +
> +static struct clk_hw * __init
> +rt2880_register_gate(const char *name, const char *parent_name, u8 shift)
> +{
> +       struct rt2880_gate      *clk_gate;
> +       struct clk_init_data    init;
> +       int err;
> +       const char *_parent_names[1] =3D { parent_name };

This isn't necessary.

> +
> +       clk_gate =3D kzalloc(sizeof(*clk_gate), GFP_KERNEL);
> +       if (!clk_gate)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D &rt2880_gate_ops;
> +       init.flags =3D 0;
> +       init.parent_names =3D parent_name ? _parent_names : NULL;

Just use &parent_name instead.

> +       init.num_parents =3D parent_name ? 1 : 0;
> +
> +       clk_gate->hw.init =3D &init;
> +       clk_gate->shift =3D shift;
> +
> +       err =3D clk_hw_register(NULL, &clk_gate->hw);

Please pass in the device during registration.

> +       if (err) {
> +               kfree(clk_gate);
> +               return ERR_PTR(err);
> +       }
> +
> +       return &clk_gate->hw;
> +}
> +
> +static struct clk_hw *
> +rt2880_clk_hw_get(struct of_phandle_args *clkspec, void *data)
> +{
> +       struct clk_hw_onecell_data *hw_data =3D data;
> +       unsigned int idx =3D clkspec->args[0];
> +       int i;
> +
> +       if (idx >=3D GATE_CLK_NUM)
> +               goto err;
> +
> +       for (i =3D 0; i < hw_data->num; i++)
> +               if (idx =3D=3D to_rt2880_gate(hw_data->hws[i])->shift)
> +                       break;
> +       if (i >=3D hw_data->num)
> +               goto err;
> +
> +       return hw_data->hws[i];
> +
> +err:
> +       pr_err("%s: invalid index %u\n", __func__, idx);
> +       return ERR_PTR(-EINVAL);
> +}
> +
> +static int __init _rt2880_clkctrl_init_dt(struct device_node *np)

Drop __init, this is called from probe(). Also, please just collapse it
into the driver probe and use platform device APIs throughout this
function.

> +{
> +       struct clk_hw *clk_hw;
> +       const char *name;
> +       const char *parent_name;
> +       u32 val;
> +       int cnt;
> +       int num;
> +       int i;
> +       int idx;
> +
> +       syscon_regmap =3D syscon_regmap_lookup_by_phandle(np, "ralink,sys=
ctl");
> +       if (IS_ERR(syscon_regmap)) {
> +               pr_err("rt2880-clock: could not get syscon regmap.\n");
> +               return PTR_ERR(syscon_regmap);
> +       }
> +
> +       cnt =3D of_property_count_u32_elems(np, "clock-indices");
> +       if (cnt < 0) {
> +               pr_err("rt2880-clock: clock-indices property is invalid.\=
n");
> +               return cnt;
> +       }
> +
> +       num =3D 0;
> +       for (i =3D 0; i < cnt; i++) {
> +               if (of_property_read_u32_index(np, "clock-indices", i, &v=
al))

I'm a little lost one what the indices are for? Why is the number space
being folded like this?

> +                       break;
> +               if (val < GATE_CLK_NUM)
> +                       num++;
> +       }
> +       if ((num <=3D 0) || (num > GATE_CLK_NUM)) {

Please remove useless parenthesis.

> +               pr_err("rt2880-clock: clock-indices property is invalid.\=
n");

Drop the full-stop on all error messages please.

> +               return -EINVAL;
> +       }
> +
> +       clk_data =3D kzalloc(struct_size(clk_data, hws, num), GFP_KERNEL);
> +       if (!clk_data)
> +               return -ENOMEM;
> +       clk_data->num =3D num;
> +
> +       idx =3D 0;
> +       for (i =3D 0; (i < cnt) && (idx < num); i++) {

Please drop useless parenthesis.

> +               if (of_property_read_u32_index(np, "clock-indices", i, &v=
al))
> +                       break;
> +               if ((int)val >=3D GATE_CLK_NUM)

Why are we casting to int?

> +                       continue;
> +
> +               if (of_property_read_string_index(np, "clock-output-names=
",
> +                               i, &name))
> +                       break;
> +
> +               parent_name =3D of_clk_get_parent_name(np, i);
> +
> +               clk_hw =3D rt2880_register_gate(name, parent_name, val);
> +               if (IS_ERR_OR_NULL(clk_hw)) {

When does it return NULL? Should probably just be IS_ERR() check here.


> +                       pr_err("rt2880-clock: could not register clock fo=
r %s\n",

Consider dev_err() so that the prefix (rt2880-clock:) can be dropped.

> +                               name);
> +                       continue;
> +               }
> +               clk_data->hws[idx] =3D clk_hw;
> +               idx++;
> +       }
> +
> +       of_clk_add_hw_provider(np, rt2880_clk_hw_get, clk_data);

Why not return of_clk_add_hw_provider()?

> +
> +       return 0;
> +}
> +
> +static int rt2880_clkctrl_probe(struct platform_device *pdev)
> +{
> +       return _rt2880_clkctrl_init_dt(pdev->dev.of_node);
> +}
> +
> +static const struct of_device_id rt2880_clkctrl_ids[] =3D {
> +       { .compatible =3D "ralink,rt2880-clock" },
> +       { }
> +};
> +
> +static struct platform_driver rt2880_clkctrl_driver =3D {
> +       .probe =3D rt2880_clkctrl_probe,
> +       .driver =3D {
> +               .name =3D "rt2880-clock",
> +               .of_match_table =3D rt2880_clkctrl_ids,
> +       },
> +};
> +builtin_platform_driver(rt2880_clkctrl_driver);
> --=20
> 2.20.1
>=20
