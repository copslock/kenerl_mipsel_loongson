Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 18:01:31 +0100 (CET)
Received: from mail-qg0-f52.google.com ([209.85.192.52]:42543 "EHLO
        mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011481AbbASRB3XMiqb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 18:01:29 +0100
Received: by mail-qg0-f52.google.com with SMTP id z107so4243670qgd.11;
        Mon, 19 Jan 2015 09:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JS6smh4wB2QUX75WixYojLIuRcb1sPE/gUymIKMK79k=;
        b=X/8hofxyyYcV7xT3kfwVh5cQv15fnnX9vb7B6ArXtqq09aeJuGjyUlRZaOkpXRk+eT
         fUxUZs5QW6CrsNYUFscRAKkPA5s/NCsW51lPSZw0c4qjgiSAe13H9b7W/VtXS9SwKaHQ
         O1ujT04SxZy9WvCo9EXz9bdncc3+WI/4rf88lZEp2RdnY2qJ/rLevOJuPD5Pgnbz8Frh
         Wnp48pUP4acNB3d3e9oUfsifiYyIzXh8cweOWC+9/79Uk01y+gh+51CqLnNstaZmR5la
         GHrzQAIqju3Sn2j+SrlS96jDBGFj9qwEDmG7Kisj+Om9rPsR7DaAfSgxeCcpEsEur7v5
         +d+g==
X-Received: by 10.224.79.12 with SMTP id n12mr50125980qak.2.1421686877077;
 Mon, 19 Jan 2015 09:01:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.148.7 with HTTP; Mon, 19 Jan 2015 09:00:56 -0800 (PST)
In-Reply-To: <20150117015701.GB27202@codeaurora.org>
References: <1421071809-17402-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421071809-17402-3-git-send-email-tomeu.vizoso@collabora.com> <20150117015701.GB27202@codeaurora.org>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Mon, 19 Jan 2015 18:00:56 +0100
X-Google-Sender-Auth: S_Z8CbsQ0dXeo_bQ_HedEo-u7vs
Message-ID: <CAAObsKA=6tPiR2MMwJ2Wn7mcL-nr_5NtpLL6wmURLGubnVdX6A@mail.gmail.com>
Subject: Re: [PATCH RESEND v8 2/2] clk: Add floor and ceiling constraints to
 clock rates
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Tero Kristo <t-kristo@ti.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Matt Porter <mporter@linaro.org>,
        Tim Kryger <tim.kryger@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Bintian Wang <bintian.wang@huawei.com>,
        Chao Xie <chao.xie@marvell.com>, linux-doc@vger.kernel.org,
        linux-omap@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomeu.vizoso@collabora.com
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

On 17 January 2015 at 02:57, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/12, Tomeu Vizoso wrote:
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 7eddfd8..2793bd7 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -1013,8 +1015,8 @@ static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
>>
>>       if (clk->ops->determine_rate) {
>>               parent_hw = parent ? parent->hw : NULL;
>> -             return clk->ops->determine_rate(clk->hw, rate, &parent_rate,
>> -                                             &parent_hw);
>> +             return clk->ops->determine_rate(clk->hw, rate, 0, ULONG_MAX,
>> +                                             &parent_rate, &parent_hw);
>>       } else if (clk->ops->round_rate)
>>               return clk->ops->round_rate(clk->hw, rate, &parent_rate);
>>       else if (clk->flags & CLK_SET_RATE_PARENT)
>> @@ -1453,8 +1458,20 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *clk,
>>
>>       /* find the closest rate and parent clk/rate */
>>       if (clk->ops->determine_rate) {
>> +             hlist_for_each_entry(clk_user, &clk->clks, child_node) {
>> +                     floor_rate = max(floor_rate,
>> +                                      clk_user->floor_constraint);
>> +             }
>> +
>> +             hlist_for_each_entry(clk_user, &clk->clks, child_node) {
>> +                     ceiling_rate = min(ceiling_rate,
>> +                                        clk_user->ceiling_constraint);
>> +             }
>
> I would think we need to do this in the clk_round_rate() path as
> well. We can't just pass 0 and ULONG_MAX there or we'll determine
> one rate here and another rate in round_rate(), violating the
> contract between set_rate() and round_rate().

Right, I have added a test for this.

>> +
>>               parent_hw = parent ? parent->hw : NULL;
>>               new_rate = clk->ops->determine_rate(clk->hw, rate,
>> +                                                 floor_rate,
>> +                                                 ceiling_rate,
>>                                                   &best_parent_rate,
>>                                                   &parent_hw);
>>               parent = parent_hw ? parent_hw->core : NULL;
>
> We should enforce a constraint if the clk is using the
> round_rate() op too. If the .round_rate() op returns some rate
> within range it should be ok.  Otherwise we can fail the rate
> change because it's out of range.

Ok.

> We'll also need to introduce some sort of
> clk_core_determine_rate(core, rate, min, max) so that clock
> providers can ask parent clocks to find a rate within some range
> that they can tolerate. If we update __clk_mux_determine_rate()
> we can see how that would work out.

Ok, I'm testing this case as well now.

>> @@ -1660,13 +1657,92 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
> [...]
>> + */
>> +int clk_set_rate(struct clk *clk, unsigned long rate)
>> +{
>> +     return clk_core_set_rate(clk->core, rate);
>
> clk could be NULL.
>
>> +}
>>  EXPORT_SYMBOL_GPL(clk_set_rate);
>>
>> +int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
>> +{
>> +     int ret = 0;
>
> Check for NULL clk.
>
>> +
>> +/**
>> + * clk_set_floor_rate - set a minimum clock rate for a clock source
>> + * @clk: clock source
>> + * @rate: desired minimum clock rate in Hz
>> + *
>> + * Returns success (0) or negative errno.
>> + */
>> +int clk_set_floor_rate(struct clk *clk, unsigned long rate)
>> +{
>> +     return clk_set_rate_range(clk, rate, clk->ceiling_constraint);
>
> clk could be NULL.
>
>> +}
>> +EXPORT_SYMBOL_GPL(clk_set_floor_rate);
>> +
>> +/**
>> + * clk_set_ceiling_rate - set a maximum clock rate for a clock source
>> + * @clk: clock source
>> + * @rate: desired maximum clock rate in Hz
>> + *
>> + * Returns success (0) or negative errno.
>> + */
>> +int clk_set_ceiling_rate(struct clk *clk, unsigned long rate)
>> +{
>> +     return clk_set_rate_range(clk, clk->floor_constraint, rate);
>
> clk could be NULL.
>
>> +}
>> +EXPORT_SYMBOL_GPL(clk_set_ceiling_rate);
>> +
>>  static struct clk_core *clk_core_get_parent(struct clk_core *core)
>>  {
>>       struct clk_core *parent;
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 2e65419..ae5c800 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -175,9 +175,12 @@ struct clk_ops {
>>                                       unsigned long parent_rate);
>>       long            (*round_rate)(struct clk_hw *hw, unsigned long rate,
>>                                       unsigned long *parent_rate);
>> -     long            (*determine_rate)(struct clk_hw *hw, unsigned long rate,
>> -                                     unsigned long *best_parent_rate,
>> -                                     struct clk_hw **best_parent_hw);
>> +     long            (*determine_rate)(struct clk_hw *hw,
>> +                                       unsigned long rate,
>> +                                       unsigned long floor_rate,
>> +                                       unsigned long ceiling_rate,
>
> I wonder if we should call this min_rate and max_rate?

I have gone ahead and replaced all floor/ceiling instances for
min/max. I don't even remember why I went with the formers any more.

>> +                                       unsigned long *best_parent_rate,
>> +                                       struct clk_hw **best_parent_hw);
>>       int             (*set_parent)(struct clk_hw *hw, u8 index);
>>       u8              (*get_parent)(struct clk_hw *hw);
>>       int             (*set_rate)(struct clk_hw *hw, unsigned long rate,
>> diff --git a/include/linux/clk.h b/include/linux/clk.h
>> index c7f258a..f99ae67 100644
>> --- a/include/linux/clk.h
>> +++ b/include/linux/clk.h
>> @@ -302,6 +302,34 @@ long clk_round_rate(struct clk *clk, unsigned long rate);
>>  int clk_set_rate(struct clk *clk, unsigned long rate);
>>
>>  /**
>> + * clk_set_rate_range - set a rate range for a clock source
>> + * @clk: clock source
>> + * @min: desired minimum clock rate in Hz
>> + * @max: desired maximum clock rate in Hz
>> + *
>> + * Returns success (0) or negative errno.
>> + */
>> +int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max);
>> +
>> +/**
>> + * clk_set_floor_rate - set a minimum clock rate for a clock source
>> + * @clk: clock source
>> + * @rate: desired minimum clock rate in Hz
>> + *
>> + * Returns success (0) or negative errno.
>> + */
>> +int clk_set_floor_rate(struct clk *clk, unsigned long rate);
>
> And this called clk_set_max_rate()?
>
>> +
>> +/**
>> + * clk_set_ceiling_rate - set a maximum clock rate for a clock source
>> + * @clk: clock source
>> + * @rate: desired maximum clock rate in Hz
>> + *
>> + * Returns success (0) or negative errno.
>> + */
>> +int clk_set_ceiling_rate(struct clk *clk, unsigned long rate);
>
> And this called clk_set_min_rate()?
>
>> +
>> +/**
>>   * clk_set_parent - set the parent clock source for this clock
>>   * @clk: clock source
>>   * @parent: parent clock source

Thanks for the review!

Tomeu

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
