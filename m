Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 14:04:39 +0100 (CET)
Received: from mail-qa0-f51.google.com ([209.85.216.51]:59740 "EHLO
        mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011153AbbATNEg1CsXy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 14:04:36 +0100
Received: by mail-qa0-f51.google.com with SMTP id f12so27233539qad.10;
        Tue, 20 Jan 2015 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MhP1Z6iqI6PmF0FYXgmG4ozcOmNaB+ndAcut/1XSEA8=;
        b=x4jmw0rqvR7wujsBcsMcAI3JMUOhwMaomxDmEKIt0HNQZAlDJAQPQ3ns8jVd3Cg6gO
         vIxMpduw2cz7HEa3gt4I32Fj9Xot9CXZxaOb4q4/OWugRsc6IS8j1DeAeYLLlHUHmnfQ
         8NRGzH0zb2tYUh/WLDJ7vnMNTE8ma8LWFun2x4BgSn1UFhAMm/EtykqHq363L5vdmuVA
         kCH0fy2hN5/yl2Rfyj932TLEqHxAw3qIq93HIOGL02BJf1ENA/+j4KmCsXYjXblYlx1I
         F5JLLntbnyLR6UZiyh0Oj3txTl62weHYDuiE5YQFnCfnNkB75Vz1aauFmsfGnDdcplAz
         RBoQ==
X-Received: by 10.224.166.71 with SMTP id l7mr57851032qay.50.1421759070656;
 Tue, 20 Jan 2015 05:04:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.148.7 with HTTP; Tue, 20 Jan 2015 05:04:10 -0800 (PST)
In-Reply-To: <20150120000019.GD27202@codeaurora.org>
References: <1421688067-24426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421688067-24426-4-git-send-email-tomeu.vizoso@collabora.com> <20150120000019.GD27202@codeaurora.org>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Tue, 20 Jan 2015 14:04:10 +0100
X-Google-Sender-Auth: qOCXAelK545Awh-k2b-BO4dTmiI
Message-ID: <CAAObsKAUc9wrQ+uj-tmQA+HrnRjUD1qXRmytGV9WT0ySZ6VJpA@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] clk: Add floor and ceiling constraints to clock rates
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
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
X-archive-position: 45367
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

On 20 January 2015 at 01:00, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/19, Tomeu Vizoso wrote:
>> Adds a way for clock consumers to set maximum and minimum rates. This can be
>> used for thermal drivers to set ceiling rates, or by misc. drivers to set
>> floor rates to assure a minimum performance level.
>>
>> Changes the signature of the determine_rate callback by adding the
>> parameters floor_rate and ceiling_rate.
>
> Commit text needs the s/floor/min and s/ceiling/max treatment
> too.
>
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index f2a1ff3..55b3124 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -1026,6 +1051,28 @@ static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
>>       else
>>               return clk->rate;
>>  }
>> +unsigned long __clk_determine_rate(struct clk_hw *hw,
>> +                                unsigned long rate,
>> +                                unsigned long min_rate,
>> +                                unsigned long max_rate)
>> +{
>> +     unsigned long parent_rate = 0;
>> +     struct clk_core *core = hw->core;
>> +     struct clk_hw *parent_hw;
>> +
>> +     if (!core->ops->determine_rate)
>> +             return 0;
>> +
>> +     if (core->parent) {
>> +             parent_rate = core->parent->rate;
>> +             parent_hw = core->parent->hw;
>> +     }
>> +
>> +     return core->ops->determine_rate(core->hw, rate,
>> +                                     min_rate, max_rate,
>> +                                     &parent_rate, &parent_hw);
>> +}
>> +EXPORT_SYMBOL_GPL(__clk_determine_rate);
>
> Maybe I misled you with the API name. I was thinking more along
> the lines of clk_round_rate() and this new function ending up
> calling clk_core_round_rate(), but clk_round_rate() would call it
> with whatever range the clock is constrained to while this new
> function would allow driver authors to specify the range. It
> should be easy enough to add min/max to clk_core_round_rate()
> given that it's a private API in this file.

Yeah, I wasn't sure whether it made sense for __clk_determine_rate to
have the fallbacks because any caller would need to have checked that
the clock implementation supports determine_rate and is aware of the
rate constraints.

As long as people don't get confused, I'm fine with any of the possibilities.

Regards,

Tomeu

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
