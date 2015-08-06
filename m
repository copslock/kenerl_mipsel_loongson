Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 18:16:47 +0200 (CEST)
Received: from mail-io0-f177.google.com ([209.85.223.177]:35295 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012667AbbHFQQpQXDe7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 18:16:45 +0200
Received: by iodd187 with SMTP id d187so86119614iod.2
        for <linux-mips@linux-mips.org>; Thu, 06 Aug 2015 09:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DLiIhhkZri1lgr176ViiNPPNV9KW/wSCZuGPqHJwuus=;
        b=UnkddOf4X8l8Bb+b1iBNCcEW6GWWsDfWLm0uE7xSoyFE2yYDZDvnc7lcTE9RKSq4RF
         SerwrDkx2F7wmPFvammez4T+OkmfZnPYy8SGI+P3n5PZ6fhMv3VwLZRlOZMgxuybCAnX
         GsIO3K5p5EQQNNOIeXKLZ2wfnSivHoLbKk4fnHgvjL1rtr2H5P2iuSq5/aEcDiQmwH80
         Zl1sN9FBs/mnUbi4fDBOMpXaxKHGnXP8I0Yfad1LwsXhr3HPflbpq0NyF4yeM9tC8Bka
         FW3Zyd0YSN0iD0Ft1bcUb/frC31TItGCuAKvB+Li12/UQBD8ig+mP3a227qx7JMKCVla
         susw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DLiIhhkZri1lgr176ViiNPPNV9KW/wSCZuGPqHJwuus=;
        b=FcHVBbhHt8chp6mzoGUz5Z12OTeizn4G+Mf8t8O3eK2XoIyg+Y/9u7QGU2xztJZKGB
         TTx+SCIxo4u6p6LGBH9zjfGGNRvBDDhnjXbEvrUGw3Nu+TWTRNAuOIYbv50VUFP8R7et
         7bnaifnz1CzpHaxy/Ab14YYsqaeEqadMbFMe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DLiIhhkZri1lgr176ViiNPPNV9KW/wSCZuGPqHJwuus=;
        b=g6AYwo9nCLOxgkFwzxpGv/oMF0vz9XvO4aunyKWv8yZhTTq3eunItooWrnFreOCSVn
         s98IuVVr1t8RrRcRXo1RnRpX+K441uwlRCbWWUqKLa13xa/x6jmi6Tcd8JFpMru5JMTo
         lXJoynXlaCuBYpIr5yqyqPKff6CJps5icQ4zQilD1DE9fx9mAjBm/eh4WgKxha61C1mk
         IXfj5zPtfAyhGb3XmjJiGk/NFHZXm5WTlgPF3Wk+uAlPzWd8tZukRsIOvryyueDUVuRB
         Hw8bYFIoQIfEOTLLh2UrA2186RJR1tScz8mCHQSJF46gpUVzKgg+K78FzxzjoisJboIk
         xJLg==
X-Gm-Message-State: ALoCoQnTdmgCHc9Ib1Au4RT0tV4Wz+INVwcrt3J+NJTuY3SwRTqbHqycq1XewYCD+JDCU5czns25
MIME-Version: 1.0
X-Received: by 10.107.137.195 with SMTP id t64mr1197048ioi.150.1438877799033;
 Thu, 06 Aug 2015 09:16:39 -0700 (PDT)
Received: by 10.64.236.98 with HTTP; Thu, 6 Aug 2015 09:16:38 -0700 (PDT)
In-Reply-To: <1438868614-7672-2-git-send-email-govindraj.raja@imgtec.com>
References: <1438868614-7672-1-git-send-email-govindraj.raja@imgtec.com>
        <1438868614-7672-2-git-send-email-govindraj.raja@imgtec.com>
Date:   Thu, 6 Aug 2015 09:16:38 -0700
X-Google-Sender-Auth: cz-wQdmj8QuYTeJbIETgHMVB7ys
Message-ID: <CAL1qeaHBkJqiWSR8wSqjLShFSAWku=M8+qwjbig9qGys2SAS7Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: pistachio: Fix 32bit integer overflows
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Govindraj Raja <govindraj.raja@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, linux-clk@vger.kernel.org,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Govindraj,

On Thu, Aug 6, 2015 at 6:43 AM, Govindraj Raja
<govindraj.raja@imgtec.com> wrote:
> From: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
>
> This commit fixes 32bit integer overflows throughout the pll driver
> (i.e. wherever the result of integer multiplication may exceed the
> range of u32).
>
> One of the functions affected by this problem is .recalc_rate. It
> returns incorrect rate for some pll settings (not for all though)
> which in turn results in the incorrect rate setup of pll's child
> clocks.
>
> Signed-off-by: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
> ---
>  drivers/clk/pistachio/clk-pll.c | 26 ++++++++++++--------------
>  drivers/clk/pistachio/clk.h     | 18 +++++++++++-------
>  2 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
> index e17dada..68066ef 100644
> --- a/drivers/clk/pistachio/clk-pll.c
> +++ b/drivers/clk/pistachio/clk-pll.c
> @@ -88,12 +88,10 @@ static inline void pll_lock(struct pistachio_clk_pll *pll)
>                 cpu_relax();
>  }
>
> -static inline u32 do_div_round_closest(u64 dividend, u32 divisor)
> +static inline u64 do_div_round_closest(u64 dividend, u64 divisor)
>  {
>         dividend += divisor / 2;
> -       do_div(dividend, divisor);
> -
> -       return dividend;
> +       return div64_u64(dividend, divisor);
>  }
>
>  static inline struct pistachio_clk_pll *to_pistachio_pll(struct clk_hw *hw)
> @@ -173,7 +171,7 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
>         struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
>         struct pistachio_pll_rate_table *params;
>         int enabled = pll_gf40lp_frac_is_enabled(hw);
> -       u32 val, vco, old_postdiv1, old_postdiv2;
> +       u64 val, vco, old_postdiv1, old_postdiv2;
>         const char *name = __clk_get_name(hw->clk);
>
>         if (rate < MIN_OUTPUT_FRAC || rate > MAX_OUTPUT_FRAC)
> @@ -183,17 +181,17 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
>         if (!params || !params->refdiv)
>                 return -EINVAL;
>
> -       vco = params->fref * params->fbdiv / params->refdiv;
> +       vco = div64_u64(params->fref * params->fbdiv, params->refdiv);
>         if (vco < MIN_VCO_FRAC_FRAC || vco > MAX_VCO_FRAC_FRAC)
> -               pr_warn("%s: VCO %u is out of range %lu..%lu\n", name, vco,
> +               pr_warn("%s: VCO %llu is out of range %lu..%lu\n", name, vco,
>                         MIN_VCO_FRAC_FRAC, MAX_VCO_FRAC_FRAC);
>
> -       val = params->fref / params->refdiv;
> +       val = div64_u64(params->fref, params->refdiv);
>         if (val < MIN_PFD)
> -               pr_warn("%s: PFD %u is too low (min %lu)\n",
> +               pr_warn("%s: PFD %llu is too low (min %lu)\n",
>                         name, val, MIN_PFD);
>         if (val > vco / 16)
> -               pr_warn("%s: PFD %u is too high (max %u)\n",
> +               pr_warn("%s: PFD %llu is too high (max %llu)\n",
>                         name, val, vco / 16);
>
>         val = pll_readl(pll, PLL_CTRL1);
> @@ -237,8 +235,7 @@ static unsigned long pll_gf40lp_frac_recalc_rate(struct clk_hw *hw,
>                                                  unsigned long parent_rate)
>  {
>         struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
> -       u32 val, prediv, fbdiv, frac, postdiv1, postdiv2;
> -       u64 rate = parent_rate;
> +       u64 val, prediv, fbdiv, frac, postdiv1, postdiv2, rate;
>
>         val = pll_readl(pll, PLL_CTRL1);
>         prediv = (val >> PLL_CTRL1_REFDIV_SHIFT) & PLL_CTRL1_REFDIV_MASK;
> @@ -251,6 +248,7 @@ static unsigned long pll_gf40lp_frac_recalc_rate(struct clk_hw *hw,
>                 PLL_FRAC_CTRL2_POSTDIV2_MASK;
>         frac = (val >> PLL_FRAC_CTRL2_FRAC_SHIFT) & PLL_FRAC_CTRL2_FRAC_MASK;
>
> +       rate = parent_rate;
>         rate *= (fbdiv << 24) + frac;
>         rate = do_div_round_closest(rate, (prediv * postdiv1 * postdiv2) << 24);
>
> @@ -325,12 +323,12 @@ static int pll_gf40lp_laint_set_rate(struct clk_hw *hw, unsigned long rate,
>         if (!params || !params->refdiv)
>                 return -EINVAL;
>
> -       vco = params->fref * params->fbdiv / params->refdiv;
> +       vco = div_u64(params->fref * params->fbdiv, params->refdiv);
>         if (vco < MIN_VCO_LA || vco > MAX_VCO_LA)
>                 pr_warn("%s: VCO %u is out of range %lu..%lu\n", name, vco,
>                         MIN_VCO_LA, MAX_VCO_LA);
>
> -       val = params->fref / params->refdiv;
> +       val = div_u64(params->fref, params->refdiv);
>         if (val < MIN_PFD)
>                 pr_warn("%s: PFD %u is too low (min %lu)\n",
>                         name, val, MIN_PFD);
> diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
> index 52fabbc..6ea6f4b 100644
> --- a/drivers/clk/pistachio/clk.h
> +++ b/drivers/clk/pistachio/clk.h
> @@ -94,14 +94,18 @@ struct pistachio_fixed_factor {
>                 .parent         = _pname,                       \
>         }
>
> +/*
> + * in order to avoid u32 multiplication overflow, declare all
> + * members of this structure as u64
> + */

These parameters should all fit within 32-bits and they're not used to
store the results of any computation, so I think it's fine to leave
these as 32-bit values.

>  struct pistachio_pll_rate_table {
> -       unsigned long fref;
> -       unsigned long fout;
> -       unsigned int refdiv;
> -       unsigned int fbdiv;
> -       unsigned int postdiv1;
> -       unsigned int postdiv2;
> -       unsigned int frac;
> +       unsigned long long fref;
> +       unsigned long long fout;
> +       unsigned long long refdiv;
> +       unsigned long long fbdiv;
> +       unsigned long long postdiv1;
> +       unsigned long long postdiv2;
> +       unsigned long long frac;
>  };
>
>  enum pistachio_pll_type {
> --
> 1.9.1
>
