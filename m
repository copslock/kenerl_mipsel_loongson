Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 19:04:40 +0200 (CEST)
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34409 "EHLO
        mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006627AbbEVREiQdHdb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 19:04:38 +0200
Received: by qgez61 with SMTP id z61so11938820qge.1
        for <linux-mips@linux-mips.org>; Fri, 22 May 2015 10:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1yYhzAImfjDJdRr6L4P3ueIROmQ7ht4Dp8e5WFO0Xbs=;
        b=dZqVLbCTmk2I7635TTCpqUMdtznVypHuPGBF3GckbtS841KOjXIv2w4pW65yTbfG+S
         OsIQIabf1aSphXbI/l/qCmktlBhhKUPNv4ZKUKsotaHoWh6zYvtaulB+/BM9g/lWT33E
         uD6pdguUo1bIdy1ljllKgAd5hsV9YHR+3yupM/Agrh57LqbibDP1kSjeFPSj+bQ8SB9S
         U/RVKKyApe5QBQZCzBCBbUpkMQ7bhEgqMN807Ss2IwMnQJQ8tnRuRBqx78mFt+n626Ld
         qoLSPE35y797VHQT+2dgNL7zziOxwdlMi7aSm5HDTA+UfaMf5M2tJUm94YV8tu4re2nJ
         I85Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1yYhzAImfjDJdRr6L4P3ueIROmQ7ht4Dp8e5WFO0Xbs=;
        b=N+RXg8CbknM1Jm9T8CTKH+/I1tBB2cDEWLnnuOmvz/ADYnvdb5aVcG3shlP1fSfIR+
         YM60HdvyrdmqMglOG59vjfrC3SskcuYtVPqPh3JNDfUI+dSRnFS1ciIBn1l6YZ1WyHZS
         0jK2tnO6PbrnQOLfgNB/AXUBS2jjU5MLCC/nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1yYhzAImfjDJdRr6L4P3ueIROmQ7ht4Dp8e5WFO0Xbs=;
        b=ezUlEiZeP/5yPjNvXvvcQGfuEnVAz1052DfsqqEfsbQSmXxMfIWXN+X6dT0qThsro1
         o7fC+rPn8wRMuj2TWG5XKxZqxCjahxr6OUo84CXyBxVJAipiSvVd3KMi1hPdFbZq6Lim
         5bvuauM5wO87HPZXcLlLO/atSMh1TH7t+W4zMHKqU/O18P/3PY4JtnRcTlVKs7f9lGNS
         m1oi5FeSdd8fv9T+auR6+j7wwiDVJ3jU8jcuw6zKx0e1q9zub6LNAJtXvwIBktMeKrwR
         UdxPX5bs3qx40cobvFPnyisxEj54K59SbFxcMIQcm7MFrMrXNbQZtVN3HPLk8vTukog+
         nv2A==
X-Gm-Message-State: ALoCoQkN2v5VC9rf+1CzOeLa65gBPiC51wRkrwi4eKXtf/zikQHrMM4d0fNHiVX7EnX5+CA0quq8
MIME-Version: 1.0
X-Received: by 10.55.56.8 with SMTP id f8mr20026632qka.97.1432314275052; Fri,
 22 May 2015 10:04:35 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Fri, 22 May 2015 10:04:34 -0700 (PDT)
In-Reply-To: <1432252663-31318-4-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432252663-31318-4-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Fri, 22 May 2015 10:04:34 -0700
X-Google-Sender-Auth: pZVCopJ9FjYbZ8YCMkW6DZyD7Bg
Message-ID: <CAL1qeaFEg-kd2hwqRApbOUi69u=YMP5sDb3em7xqxcxmoDpCgA@mail.gmail.com>
Subject: Re: [PATCH 3/9] clk: pistachio: Implement PLL rate adjustment
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Hartley <james.hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47575
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

On Thu, May 21, 2015 at 4:57 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> This commit implements small rate changes to the fractional PLL.
> This is done using the PLL frac parameter. The .set_rate function
> first finds the parameters associated to the closest nominal rate.
>
> Then the new rate is set, using parameters from the table entry,
> except for the frac parameter, which is calculated from the rate
> using the fractional PLL rate formula.
>
> Using .round_rate, the driver guarantees that only rates near
> a table nominal rate is applied. To this extent, add two parameters
> fout_min and fout_max, which allows to define the allowed rate
> adjustment.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>  drivers/clk/pistachio/clk-pll.c | 48 +++++++++++++++++++++++++++++++----------
>  drivers/clk/pistachio/clk.h     |  2 ++
>  2 files changed, 39 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
> index f12d520..cf000bb 100644
> --- a/drivers/clk/pistachio/clk-pll.c
> +++ b/drivers/clk/pistachio/clk-pll.c
> @@ -90,29 +90,50 @@ static struct pistachio_pll_rate_table *
>  pll_get_params(struct pistachio_clk_pll *pll, unsigned long fref,
>                unsigned long fout)
>  {
> -       unsigned int i;
> +       unsigned int i, best;
> +       unsigned long err, best_err = ~0;
>
>         for (i = 0; i < pll->nr_rates; i++) {
> -               if (pll->rates[i].fref == fref && pll->rates[i].fout == fout)
> -                       return &pll->rates[i];
> +               err = abs(pll->rates[i].fout - fout);
> +               if (pll->rates[i].fref == fref && err < best_err) {
> +                       best = i;
> +                       best_err = err;
> +               }
>         }
>
> -       return NULL;
> +       return &pll->rates[best];
>  }
>
>  static long pll_round_rate(struct clk_hw *hw, unsigned long rate,
>                            unsigned long *parent_rate)
>  {
>         struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
> -       unsigned int i;
> +       unsigned int i, best;
> +       unsigned long err, best_err = ~0;
>
>         for (i = 0; i < pll->nr_rates; i++) {
> -               if (i > 0 && pll->rates[i].fref == *parent_rate &&
> -                   pll->rates[i].fout <= rate)
> -                       return pll->rates[i - 1].fout;
> +               err = abs(pll->rates[i].fout - rate);
> +               if (pll->rates[i].fref == *parent_rate && err < best_err) {
> +                       best = i;
> +                       best_err = err;
> +               }
>         }
>
> -       return pll->rates[0].fout;
> +       /* Make sure fout_{min,max} parameters have sane values */
> +       if (!pll->rates[best].fout_min)
> +               pll->rates[best].fout_min = pll->rates[best].fout;
> +       if (!pll->rates[best].fout_max)
> +               pll->rates[best].fout_max = pll->rates[best].fout;

Perhaps the rate tables should just always populate fout_min and fout_max?
