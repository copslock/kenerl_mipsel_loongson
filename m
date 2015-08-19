Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Aug 2015 23:09:36 +0200 (CEST)
Received: from mail-io0-f174.google.com ([209.85.223.174]:35508 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012850AbbHSVJes-SAh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Aug 2015 23:09:34 +0200
Received: by iodt126 with SMTP id t126so24316824iod.2
        for <linux-mips@linux-mips.org>; Wed, 19 Aug 2015 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EdRa3fsJ+t1dmkWXaWOSjj+JqNYs9YIrRvVjG56dQVY=;
        b=RH105LVS8glfOJVCselHu1uCmC9SdX82KZY/P0aWEjae7dLzy+1kw9qnoPlcm4I4HG
         sUnKkkKe2/N0ChWhpe812FQa3lUnYl1bElAQwnFEeZnSGUEy4fmi5T4c7IinAgmUfcH3
         aJpR9qkHPp4YoVqwnMRGxADZRhbZoX/G14yFJoY0/i3jRjhBXE5jz2XkyazJEOuPs4x1
         GyySCvf0NSGw3po/OAJQPU2xrz/IiPmxYZIwTUEyB+J0DFgRtCaZUSmR/a5Mq162DVwW
         NUu60XE0htb9ztxoaUNpzu/lyhFEwUwOu/+2cCY0L2PeyHreseekpgY22uj4MByysXc2
         JPhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EdRa3fsJ+t1dmkWXaWOSjj+JqNYs9YIrRvVjG56dQVY=;
        b=ZhxxD+ntjjdyj78N8hKAWlrmCePaCp8gMRHwrfW+8dp/7o2NbUNKZB7Gd3yRcbhPX2
         2jfAb3loZJT3sE1mOLJGJa7hki2QM4t5WtVDcVLoaqmi4qfHMWPcfGwdpFchNjqZWb9y
         bFuk+hWDVb78GPY+xp136PEE9SALsLKMEF45s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EdRa3fsJ+t1dmkWXaWOSjj+JqNYs9YIrRvVjG56dQVY=;
        b=jqJkmx5o7dnE6Ds3biPNIvFQqb8KvvKdGZI1BBic3qd7DFbjPzD0NKz82Kz+SmZrXp
         nOF+DTsIuyorXIUw9yci6rOAPefBje2pg9KAmOd8uBCA2rv0jT2bmHc8Rgt/z3Nt3xbh
         a+PUBT5qW2gCUBeS3a265ksYw3Uy/vSXoJnA9PpuQJQl4VO5T6RjuMNcaAFvlqb1xSEk
         46t4D9k/5jBw1tS523u6CFBqIsh1u54llbz7dqkCQUtY8cKlYkVMdkrXsmXm8yn6tonn
         Wd7hShE8IFv2BgkVnC9U+M/m3MABiT1FhWhTvkzDqGWc6Fr3Itg5bWYTTm6e9M8dY3jc
         9J9A==
X-Gm-Message-State: ALoCoQnFl2pLXfwfqf7ePv9lwE4pFr5ulD2znDHVkqZbgh8y/eJWWh8+42RVbXVOmBtdbVvZQAo4
MIME-Version: 1.0
X-Received: by 10.107.137.195 with SMTP id t64mr15474623ioi.150.1440018569065;
 Wed, 19 Aug 2015 14:09:29 -0700 (PDT)
Received: by 10.64.236.98 with HTTP; Wed, 19 Aug 2015 14:09:28 -0700 (PDT)
In-Reply-To: <1439890337-13803-4-git-send-email-govindraj.raja@imgtec.com>
References: <1439890337-13803-1-git-send-email-govindraj.raja@imgtec.com>
        <1439890337-13803-4-git-send-email-govindraj.raja@imgtec.com>
Date:   Wed, 19 Aug 2015 14:09:28 -0700
X-Google-Sender-Auth: dXmZ4ED7wXJK_eYrvKCpJx2tyRg
Message-ID: <CAL1qeaEYF2dx8E6MA6c7YCHi-e5OqiMMWDC3cCTC8ZvfMCiXww@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] clk: pistachio: Fix PLL rate calculation in
 integer mode
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Govindraj Raja <govindraj.raja@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48949
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

On Tue, Aug 18, 2015 at 2:32 AM, Govindraj Raja
<govindraj.raja@imgtec.com> wrote:
> From: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
>
> .recalc_rate callback for the fractional PLL doesn't take operating
> mode into account when calculating PLL rate. This results in
> the incorrect PLL rates when PLL is operating in integer mode.
>
> Operating mode of fractional PLL is based on the value of the
> fractional divider. Currently it assumes that the PLL will always
> be configured in fractional mode which may not be
> the case. This may result in the wrong output frequency.
>
> Also vco was calculated based on the current operating mode which
> makes no sense because .set_rate is setting operating mode. Instead,
> vco should be calculated using PLL settings that are about to be set.
>
> Signed-off-by: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>

One minor comment below, otherwise:

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>

> --- a/drivers/clk/pistachio/clk-pll.c
> +++ b/drivers/clk/pistachio/clk-pll.c

> @@ -65,6 +65,10 @@
>  #define MIN_OUTPUT_FRAC                        12000000UL
>  #define MAX_OUTPUT_FRAC                        1600000000UL
>
> +/* Fractional PLL operating modes */
> +#define PLL_MODE_INT                   1
> +#define PLL_MODE_FRAC                  0

Make this an enum (e.g. enum pll_mode) and ...

> +static inline u32 pll_frac_get_mode(struct clk_hw *hw)
> +{
> +       struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
> +       u32 val;
> +
> +       val = pll_readl(pll, PLL_CTRL3) & PLL_FRAC_CTRL3_DSMPD;
> +       return val ? PLL_MODE_INT : PLL_MODE_FRAC;
> +}
> +
> +static inline void pll_frac_set_mode(struct clk_hw *hw, u32 mode)
> +{
> +       struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
> +       u32 val;
> +
> +       val = pll_readl(pll, PLL_CTRL3);
> +       if (mode == PLL_MODE_INT)
> +               val |= PLL_FRAC_CTRL3_DSMPD | PLL_FRAC_CTRL3_DACPD;
> +       else
> +               val &= ~(PLL_FRAC_CTRL3_DSMPD | PLL_FRAC_CTRL3_DACPD);
> +
> +       pll_writel(pll, val, PLL_CTRL3);
> +}

... use the enum type instead of u32 for the mode.
