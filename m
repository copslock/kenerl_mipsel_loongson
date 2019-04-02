Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7BEC4360F
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 20:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F3C2084B
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554235686;
	bh=XyEkjn7qx+PzZoDTxyEnI6Fo9eGypwG6G7VB5frpVNs=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=rmg8KkvSunzokLgC4YS3t1sXHC6P81hfHVea+Qh84bzlS0cOIQGySUlOwk3WJOewE
	 zl54Yiq6T7LZRBbE9YQcV5DnXknlMcWpodkQ9JrR1slQXDCdV9RuHI/AgoOFb6jmCq
	 MjiLIdzQjc7XebaDrCb3aGtiG3ZL7svTBNTTgl1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfDBUIG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfDBUIF (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 2 Apr 2019 16:08:05 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 718512082C;
        Tue,  2 Apr 2019 20:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554235684;
        bh=XyEkjn7qx+PzZoDTxyEnI6Fo9eGypwG6G7VB5frpVNs=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=L4Cz7jLiqbqG9ML+r1NtUPkdZzREB5Uw5hIkqo7xyLw7i5/FztZHWQsOwTZdk0/rd
         5i5mQP2G5LqEwsgdbBjMJut5U8JdEgal6kZmIM/1oCB06bRJH2cleaWueEm97aWWbp
         98Wuyl01tFuafgBtdN8+pCxbAh3mIE+WdryQBJvM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190330123317.16821-2-drvlabo@gmail.com>
References: <20190330123317.16821-1-drvlabo@gmail.com> <20190330123317.16821-2-drvlabo@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC 1/5] mips: ralink: add rt2880-clock driver
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Message-ID: <155423568358.20095.11135907708934310380@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 02 Apr 2019 13:08:03 -0700
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Quoting NOGUCHI Hiroshi (2019-03-30 05:33:13)
> This patch adds SoC peripheral clock gating driver.
> The driver loads gating clock table from of_device_id.data in individual =
SoC sources.

Please line wrap this to the column length standard of something like 76
columns.

>=20
> Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
> diff --git a/arch/mips/ralink/rt2880-clk_internal.h b/arch/mips/ralink/rt=
2880-clk_internal.h
> new file mode 100644
> index 000000000000..9d5dded16a80
> --- /dev/null
> +++ b/arch/mips/ralink/rt2880-clk_internal.h
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 NOGUCHI Hiroshi <drvlabo@gmail.com>
> + */
> +
> +#ifndef __RT2880_CLOCK_INTERNAL_H
> +
> +
> +#define GATE_CLK_NUM   (32)
> +
> +struct gate_clk_desc {
> +       const char *name;
> +       const char *parent_name;
> +};
> +
> +extern const struct of_device_id __initconst of_match_rt2880_clk[];

Why is it extern?

> +
> +
> +#endif
> +
> +
> diff --git a/arch/mips/ralink/rt2880-clock.c b/arch/mips/ralink/rt2880-cl=
ock.c
> new file mode 100644
> index 000000000000..46cc067225ab
> --- /dev/null
> +++ b/arch/mips/ralink/rt2880-clock.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 NOGUCHI Hiroshi <drvlabo@gmail.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/jiffies.h>

Used?

> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/clk.h>

Used?

> +#include <linux/clkdev.h>

Used?

> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/bug.h>

Drop? Don't use panic().

> +
> +#include "rt2880-clk_internal.h"
> +
> +
> +/* clock configuration 1 */
> +#define        SYSC_REG_CLKCFG1        0x30
> +
> +struct rt2880_gate {
> +       struct clk_hw   hw;
> +       u8      shift;
> +};
> +
> +#define        to_rt2880_gate(_hw)     container_of(_hw, struct rt2880_g=
ate, hw)
> +
> +static struct clk_onecell_data clk_data;
> +static struct clk *clks[GATE_CLK_NUM];

Why does it need to be static? Why not allocate at runtime?

> +
> +static struct regmap *syscon_regmap;
> +
> +static int rt2880_gate_enable(struct clk_hw *hw)
> +{
> +       struct rt2880_gate *clk_gate =3D to_rt2880_gate(hw);
> +       u32 val =3D 0x01UL << clk_gate->shift;

Just write BIT(clk_gate->shift) instead.

> +
> +       regmap_update_bits(syscon_regmap, SYSC_REG_CLKCFG1, val, val);

return regmap_udpate_bits()?

> +
> +       return 0;
> +}
> +
> +static void rt2880_gate_disable(struct clk_hw *hw)
> +{
> +       struct rt2880_gate *clk_gate =3D to_rt2880_gate(hw);
> +       u32 val =3D 0x01UL << clk_gate->shift;

Same, use BIT() macro.

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
> +       return (!!(rdval & (0x01UL << clk_gate->shift)));

Doesn't need to be a bool. Just 'return rdval & BIT(clk_gate->shift)'

> +}
> +
> +static const struct clk_ops rt2880_gate_ops =3D {
> +       .enable =3D rt2880_gate_enable,
> +       .disable =3D rt2880_gate_disable,
> +       .is_enabled =3D rt2880_gate_is_enabled,
> +};
> +
> +static struct clk * __init
> +rt2880_register_gate(const char *name, const char *parent_name, u8 shift)
> +{
> +       struct rt2880_gate      *clk_gate;
> +       struct clk              *clk;
> +       struct clk_init_data    init;
> +       const char *_parent_names[1] =3D { parent_name };
> +
> +       clk_gate =3D kzalloc(sizeof(*clk_gate), GFP_KERNEL);
> +       if (!clk_gate)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D &rt2880_gate_ops;
> +       init.flags =3D 0;
> +       init.parent_names =3D parent_name ? _parent_names : NULL;
> +       init.num_parents =3D parent_name ? 1 : 0;
> +
> +       clk_gate->hw.init =3D &init;
> +       clk_gate->shift =3D shift;
> +
> +       clk =3D clk_register(NULL, &clk_gate->hw);

Please use clk_hw_register() instead of clk_register().

> +       if (IS_ERR(clk))
> +               kfree(clk_gate);
> +
> +       return clk;
> +}
> +
> +static void __init rt2880_clkctrl_init_dt(struct device_node *np)
> +{
> +       struct clk *clk;
> +       int i;
> +       const struct of_device_id *match;
> +       struct gate_clk_desc *clk_tbl;
> +
> +       match =3D of_match_node(of_match_rt2880_clk, np);
> +       if (!match) {
> +               pr_info("rt2880-clock: could not get compatible node");

How is this possible?

> +               return;
> +       }
> +       clk_tbl =3D (struct gate_clk_desc *)match->data;

Drop useless cast from void.

> +
> +       syscon_regmap =3D syscon_regmap_lookup_by_phandle(np, "ralink,sys=
ctl");
> +       if (IS_ERR(syscon_regmap)) {
> +               pr_info("rt2880-clock: could not get syscon regmap");

Why are error messages at 'info' print level? Should be pr_err().

> +               return;
> +       }
> +
> +       clk_data.clk_num =3D GATE_CLK_NUM;
> +       clk_data.clks =3D clks;
> +
> +       for (i =3D 0; i < GATE_CLK_NUM; i++) {
> +               if (clk_tbl[i].name) {
> +                       clk =3D rt2880_register_gate(
> +                               clk_tbl[i].name, clk_tbl[i].parent_name, =
i);
> +                       if (IS_ERR_OR_NULL(clk))
> +                               panic("rt2880-clock : could not register =
gate clock");

Do we need to panic here? Maybe things will still work?

> +                       clk_data.clks[i] =3D clk;
> +               }
> +       }
> +
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);

Please add a clk_hw provider instead of a clk provider.

> +}
> +CLK_OF_DECLARE(rt2880, "ralink,rt2880-clock", rt2880_clkctrl_init_dt);

Can this be a platform driver?

