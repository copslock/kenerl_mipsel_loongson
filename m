Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Feb 2015 23:19:09 +0100 (CET)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:44809 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010831AbbBAWTGzY6ET convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 1 Feb 2015 23:19:06 +0100
Received: by mail-ie0-f181.google.com with SMTP id rd18so4795080iec.12
        for <linux-mips@linux-mips.org>; Sun, 01 Feb 2015 14:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=vJ6BQItj13PmS15WNqlY+77y9M3tMUiKjvIe5r2D2c4=;
        b=DgRRbITeK42KVncbODOeS1SnSITXnx/WYYHqLTgWruMtpBfgLWrjWOa9vkM12+39Ds
         cXSCxVNRJNzjRpWO8tPMuyWR0M/HeeXHOF2NuzLVz+B+tjnqKfQZMw4SJ4v8akGCim7H
         X59ihgI+XI6aiV6zYOFkNrM8+mA1AyGg9vBs63g8JBxeyvE5wixo3MDWjC4NYoiMk2aM
         044ziAOAJPYU/SSln1wShuaYctVbdJEv65R1UjASumTE6RtcNlWkAwSkupOvFs32KQDZ
         PZlQkTlIxktkNxxbthaAOQrDVi1AcISNvAwizwGYd9GiK4EJEhDHU0sbaAmRvcsUm7Tc
         jLZw==
X-Gm-Message-State: ALoCoQk1SWjIua9IPpJWBVIndlodboIKTa0Qhid6IxG1DinFotN40uLw9+cbA0COxGmy3diFA/bY
X-Received: by 10.42.199.211 with SMTP id et19mr16664093icb.9.1422829140874;
        Sun, 01 Feb 2015 14:19:00 -0800 (PST)
Received: from localhost (pool-71-119-96-202.lsanca.fios.verizon.net. [71.119.96.202])
        by mx.google.com with ESMTPSA id g15sm4995169ioi.22.2015.02.01.14.18.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Feb 2015 14:18:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "Stephen Boyd" <sboyd@codeaurora.org>
From:   Mike Turquette <mturquette@linaro.org>
In-Reply-To: <CAAObsKDxhV7Vveq5FizTUp9ur2Rsq1bM+YQa4uPksh5ntMQV3Q@mail.gmail.com>
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Linux MIPS Mailing List" <linux-mips@linux-mips.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Tony Lindgren" <tony@atomide.com>,
        "Chao Xie" <chao.xie@marvell.com>,
        "Haojian Zhuang" <haojian.zhuang@linaro.org>,
        "Boris Brezillon" <boris.brezillon@free-electrons.com>,
        "Russell King" <linux@arm.linux.org.uk>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Emilio L??pez" <emilio@elopez.com.ar>,
        "Linux-sh list" <linux-sh@vger.kernel.org>,
        "Alex Elder" <elder@linaro.org>,
        "Zhangfei Gao" <zhangfei.gao@linaro.org>,
        "Bintian Wang" <bintian.wang@huawei.com>,
        "Matt Porter" <mporter@linaro.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Tero Kristo" <t-kristo@ti.com>,
        "Manuel Lauss" <manuel.lauss@gmail.com>,
        "Maxime Ripard" <maxime.ripard@free-electrons.com>,
        "Javier Martinez Canillas" <javier.martinez@collabora.co.uk>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-5-git-send-email-tomeu.vizoso@collabora.com>
 <CAMuHMdUGgA70o2SgdJR3X6AkCcMssHU0POLfzppADT-O=BrYDw@mail.gmail.com>
 <54CA8662.7040008@codeaurora.org> <20150131013158.GA4323@codeaurora.org>
 <CAAObsKDxhV7Vveq5FizTUp9ur2Rsq1bM+YQa4uPksh5ntMQV3Q@mail.gmail.com>
Message-ID: <20150201221856.421.6151@quantum>
User-Agent: alot/0.3.5
Subject: Re: [PATCH v13 4/6] clk: Add rate constraints to clocks
Date:   Sun, 01 Feb 2015 14:18:56 -0800
Return-Path: <mturquette@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@linaro.org
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

Quoting Tomeu Vizoso (2015-01-31 10:36:22)
> On 31 January 2015 at 02:31, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 01/29, Stephen Boyd wrote:
> >> On 01/29/15 05:31, Geert Uytterhoeven wrote:
> >> > Hi Tomeu, Mike,
> >> >
> >> > On Fri, Jan 23, 2015 at 12:03 PM, Tomeu Vizoso
> >> > <tomeu.vizoso@collabora.com> wrote:
> >> >> --- a/drivers/clk/clk.c
> >> >> +++ b/drivers/clk/clk.c
> >> >> @@ -2391,25 +2543,24 @@ int __clk_get(struct clk *clk)
> >> >>         return 1;
> >> >>  }
> >> >>
> >> >> -static void clk_core_put(struct clk_core *core)
> >> >> +void __clk_put(struct clk *clk)
> >> >>  {
> >> >>         struct module *owner;
> >> >>
> >> >> -       owner = core->owner;
> >> >> +       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> >> >> +               return;
> >> >>
> >> >>         clk_prepare_lock();
> >> >> -       kref_put(&core->ref, __clk_release);
> >> >> +
> >> >> +       hlist_del(&clk->child_node);
> >> >> +       clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
> >> > At this point, clk->core->req_rate is still zero, causing
> >> > cpg_div6_clock_round_rate() to be called with a zero "rate" parameter,
> >> > e.g. on r8a7791:
> >>
> >> Hmm.. I wonder if we should assign core->req_rate to be the same as
> >> core->rate during __clk_init()? That would make this call to
> >> clk_core_set_rate_nolock() a nop in this case.
> >>
> >
> > Here's a patch to do this
> >
> > ---8<----
> > From: Stephen Boyd <sboyd@codeaurora.org>
> > Subject: [PATCH] clk: Assign a requested rate by default
> >
> > We need to assign a requested rate here so that we avoid
> > requesting a rate of 0 on clocks when we remove clock consumers.
> 
> Hi, this looks good to me.
> 
> Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

It seems to fix the total boot failure on OMAPs, and hopefully does the
same for SH Mobile and others. I've squashed this into Tomeu's rate
constraints patch to maintain bisect.

Regards,
Mike

> 
> Thanks,
> 
> Tomeu
> 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/clk/clk.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index a29daf9edea4..8416ed1c40be 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -2142,6 +2142,7 @@ int __clk_init(struct device *dev, struct clk *clk_user)
> >         struct clk_core *orphan;
> >         struct hlist_node *tmp2;
> >         struct clk_core *clk;
> > +       unsigned long rate;
> >
> >         if (!clk_user)
> >                 return -EINVAL;
> > @@ -2266,12 +2267,13 @@ int __clk_init(struct device *dev, struct clk *clk_user)
> >          * then rate is set to zero.
> >          */
> >         if (clk->ops->recalc_rate)
> > -               clk->rate = clk->ops->recalc_rate(clk->hw,
> > +               rate = clk->ops->recalc_rate(clk->hw,
> >                                 clk_core_get_rate_nolock(clk->parent));
> >         else if (clk->parent)
> > -               clk->rate = clk->parent->rate;
> > +               rate = clk->parent->rate;
> >         else
> > -               clk->rate = 0;
> > +               rate = 0;
> > +       clk->rate = clk->req_rate = rate;
> >
> >         /*
> >          * walk the list of orphan clocks and reparent any that are children of
> > --
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
