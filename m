Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 09:00:09 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:58083 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010999AbbBBIADi0069 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 09:00:03 +0100
Received: by mail-ob0-f169.google.com with SMTP id wp4so1243325obc.0;
        Sun, 01 Feb 2015 23:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MBo2/gFv/xx40SlQNiciGjj//RizTFMwm9bngTtB+WA=;
        b=bhzrHas4W1ZbFnZp4H0UwAU2kYj10N1RiaCcluu7tmAbQ25ynhJpmjrlbXvxI5eLX6
         /SM/sJ5ljo20bReRB3mA4xNB1rBUPN6BY6Syb0gVm1Y21ZvziOflBpO+adw98tknwQVt
         FBsYAw+MKWc4GiRa9xJNSmSJ+ds0mUi0s7lOvghRBamyxHHIuvi9Pf8+Vk673dy5sxpp
         Q5GTGSE2QIYS9d0DqXCN/xBTaSbLMi49WSUxDZ/xy7l2KVIz6tsm8BkUPyQ5SkLJDy4r
         DmaqBfZ4T0vQGnVR828RRUgATJS3o5A282wJiuUrhcTDMiQWh9hzhoOfelyt+8bvqca8
         cEmw==
MIME-Version: 1.0
X-Received: by 10.202.205.16 with SMTP id d16mr10430821oig.121.1422863997845;
 Sun, 01 Feb 2015 23:59:57 -0800 (PST)
Received: by 10.60.103.210 with HTTP; Sun, 1 Feb 2015 23:59:57 -0800 (PST)
In-Reply-To: <20150201221856.421.6151@quantum>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
        <1422011024-32283-5-git-send-email-tomeu.vizoso@collabora.com>
        <CAMuHMdUGgA70o2SgdJR3X6AkCcMssHU0POLfzppADT-O=BrYDw@mail.gmail.com>
        <54CA8662.7040008@codeaurora.org>
        <20150131013158.GA4323@codeaurora.org>
        <CAAObsKDxhV7Vveq5FizTUp9ur2Rsq1bM+YQa4uPksh5ntMQV3Q@mail.gmail.com>
        <20150201221856.421.6151@quantum>
Date:   Mon, 2 Feb 2015 08:59:57 +0100
X-Google-Sender-Auth: s1t9qbzvCy16JSBeoEsqwklzmaE
Message-ID: <CAMuHMdU4QBVOb4WqmcfHkj2K7v8dt1hKKWXS0qAnTvsJSafdPQ@mail.gmail.com>
Subject: Re: [PATCH v13 4/6] clk: Add rate constraints to clocks
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Mike Turquette <mturquette@linaro.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Chao Xie <chao.xie@marvell.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Emilio L??pez" <emilio@elopez.com.ar>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Alex Elder <elder@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bintian Wang <bintian.wang@huawei.com>,
        Matt Porter <mporter@linaro.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Tero Kristo <t-kristo@ti.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Sun, Feb 1, 2015 at 11:18 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Tomeu Vizoso (2015-01-31 10:36:22)
>> On 31 January 2015 at 02:31, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 01/29, Stephen Boyd wrote:
>> >> On 01/29/15 05:31, Geert Uytterhoeven wrote:
>> >> > Hi Tomeu, Mike,
>> >> >
>> >> > On Fri, Jan 23, 2015 at 12:03 PM, Tomeu Vizoso
>> >> > <tomeu.vizoso@collabora.com> wrote:
>> >> >> --- a/drivers/clk/clk.c
>> >> >> +++ b/drivers/clk/clk.c
>> >> >> @@ -2391,25 +2543,24 @@ int __clk_get(struct clk *clk)
>> >> >>         return 1;
>> >> >>  }
>> >> >>
>> >> >> -static void clk_core_put(struct clk_core *core)
>> >> >> +void __clk_put(struct clk *clk)
>> >> >>  {
>> >> >>         struct module *owner;
>> >> >>
>> >> >> -       owner = core->owner;
>> >> >> +       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>> >> >> +               return;
>> >> >>
>> >> >>         clk_prepare_lock();
>> >> >> -       kref_put(&core->ref, __clk_release);
>> >> >> +
>> >> >> +       hlist_del(&clk->child_node);
>> >> >> +       clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
>> >> > At this point, clk->core->req_rate is still zero, causing
>> >> > cpg_div6_clock_round_rate() to be called with a zero "rate" parameter,
>> >> > e.g. on r8a7791:
>> >>
>> >> Hmm.. I wonder if we should assign core->req_rate to be the same as
>> >> core->rate during __clk_init()? That would make this call to
>> >> clk_core_set_rate_nolock() a nop in this case.
>> >>
>> >
>> > Here's a patch to do this
>> >
>> > ---8<----
>> > From: Stephen Boyd <sboyd@codeaurora.org>
>> > Subject: [PATCH] clk: Assign a requested rate by default
>> >
>> > We need to assign a requested rate here so that we avoid
>> > requesting a rate of 0 on clocks when we remove clock consumers.
>>
>> Hi, this looks good to me.
>>
>> Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> It seems to fix the total boot failure on OMAPs, and hopefully does the
> same for SH Mobile and others. I've squashed this into Tomeu's rate
> constraints patch to maintain bisect.

Yes, it fixes shmobile. .round_rate() is now called with a sane value of rate.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
