Return-Path: <SRS0=AFgm=S3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C406C43218
	for <linux-mips@archiver.kernel.org>; Thu, 25 Apr 2019 19:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67EA2077C
	for <linux-mips@archiver.kernel.org>; Thu, 25 Apr 2019 19:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556219914;
	bh=D0ON8FsihrfvsDtBGenqSdtuQVunTmA4dMb5DSSQ4xU=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=gV673QXJ0ZjdHSxTQgE6gx6KBQTeLaJh0X+qy/4fWmqZ/uOPrsUCIOtinVzuQ8UK9
	 dozmc/JR00E9KHGDNKHwvcwJYO3XBIzOtM/YG4XN+6cnjxtZqUK1DCMNoIez5PZIUP
	 DIu0CKsQ1wwOR7zs11QN547t51oO0T/6FtjxB2kU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfDYTSe (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfDYTSe (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 25 Apr 2019 15:18:34 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D80E0206BA;
        Thu, 25 Apr 2019 19:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556219913;
        bh=D0ON8FsihrfvsDtBGenqSdtuQVunTmA4dMb5DSSQ4xU=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=d4NflG7PuSjv2/jiZLBn4dllBe9xebmNNGPTb+oL/CVJerZYPWNThNmTMEKcFF5/e
         eq+pF6QR3Q8Zxz0eEqjN/wLT/wrz39YGJnTxAFa2BztHJfZ7Rvfwuia5vOJbtuqHCB
         +gpa2lIPurzF9qt8pIymEEg95lvEUBiTRU9jIT4U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190405000129.19331-4-drvlabo@gmail.com>
References: <20190405000129.19331-1-drvlabo@gmail.com> <20190405000129.19331-4-drvlabo@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v2 3/5] mips: ralink: mt7620/76x8 use common clk framework
To:     John Crispin <john@phrozen.org>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Message-ID: <155621991161.15276.10817226280025481008@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 12:18:31 -0700
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Quoting NOGUCHI Hiroshi (2019-04-04 17:01:27)
> diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
> index 1b7df115eb60..0fd2f0091ea4 100644
> --- a/arch/mips/ralink/clk.c
> +++ b/arch/mips/ralink/clk.c
> @@ -15,8 +15,15 @@
> =20
>  #include <asm/time.h>
> =20
> +#if IS_ENABLED(CONFIG_COMMON_CLK)

Please drop this unless you need it, and move the linux/ include above
any asm/ includes.

> +#include <linux/clk-provider.h>
> +#endif
> +
>  #include "common.h"
> =20
> +
> +#if !IS_ENABLED(CONFIG_COMMON_CLK)
> +
>  struct clk {
>         struct clk_lookup cl;
>         unsigned long rate;
> @@ -72,6 +79,28 @@ long clk_round_rate(struct clk *clk, unsigned long rat=
e)
>  }
>  EXPORT_SYMBOL_GPL(clk_round_rate);
> =20
> +#else  /* CONFIG_COMMON_CLK */
> +
> +struct clk_hw * __init add_sys_clkdev(const char *id, unsigned long rate)
> +{
> +       struct clk_hw *clk_hw;
> +       int err;
> +
> +       clk_hw =3D clk_hw_register_fixed_rate(NULL, id, NULL, 0, rate);
> +       if (IS_ERR(clk_hw))
> +               panic("failed to allocate %s clock structure", id);

This one panics but the other just continues. Why can't we continue from
here too? Is clkdev actually used by anything on this platform?

> +
> +       err =3D clk_hw_register_clkdev(clk_hw, NULL, id);
> +       if (err) {
> +               pr_err("unable to register %s clock device\n", id);
> +               clk_hw =3D ERR_PTR(err);
> +       }
> +
> +       return clk_hw;
> +}
> +
> +#endif /* CONFIG_COMMON_CLK */
> +
>  void __init plat_time_init(void)
>  {
>         struct clk *clk;
> diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
> index c1ce6f43642b..74aed8f7e502 100644
> --- a/arch/mips/ralink/mt7620.c
> +++ b/arch/mips/ralink/mt7620.c
> @@ -504,6 +505,12 @@ mt7620_get_sys_rate(unsigned long cpu_rate)
>         return cpu_rate / div;
>  }
> =20
> +static struct clk_hw_onecell_data *clk_data;
> +
> +#define RFMT(label)    label ":%lu.%03luMHz "
> +#define RINT(x)                ((x) / 1000000)
> +#define RFRAC(x)       (((x) / 1000) % 1000)

Is this necessary to move?

> +
>  void __init ralink_clk_init(void)
>  {
>         unsigned long xtal_rate;
> @@ -586,6 +593,31 @@ void __init ralink_clk_init(void)
>         }
>  }
> =20
> +#undef RFRAC
> +#undef RINT
> +#undef RFMT
> +
> +static int mt7620_pll_probe(struct platform_device *pdev)
> +{
> +       of_clk_add_hw_provider(pdev->dev.of_node,
> +                               of_clk_hw_onecell_get, clk_data);
> +       return 0;

Why not return of_clk_add_hw_provider()?

> +}
> +
