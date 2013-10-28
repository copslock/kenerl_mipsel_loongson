Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Oct 2013 20:54:25 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56652 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822668Ab3J1TyU0x8zp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Oct 2013 20:54:20 +0100
Received: by mail-pa0-f41.google.com with SMTP id rd3so2956469pab.28
        for <linux-mips@linux-mips.org>; Mon, 28 Oct 2013 12:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=lUVvZJJmRYW3fbvMxFCajnLHgbwT2Eit2OHHXaPz80U=;
        b=Rt3N1D75PkDn2YTGyYpJadGW0mgJ8tpDghoDgQhbosgJ3xTk9pNHrCW4ByjiPVBF3w
         9hUCHNsa4UoGAL+AFdJfdqDA6WASFDLBDBi9NEckQp9JGTXOSzOI3Wl5DK33udv1F6DT
         K4vF++MUQBgFMTNFJadrdo/WMGoS1/yFO7soYKXZlb0s3QEznse91qMKQCSqY7zOlqaY
         PuArwHdSDoSVUZPzEbdixhfjG1QXXx9uUjBH9bQGLcJMnI0wxqf7QQ1Oh0uzBT0qTMip
         sgTV0/zn1AP0WXzae+DTRdwOxzYVFVJjxghgRsPxtBjlwl8kL30rMAmVggsMrmFwAFBj
         rvvA==
X-Gm-Message-State: ALoCoQkaqYRAbRbfaHu5SHFESrhjO4CtqYbNAj81qBRsTcQzncpUfMwIg47oqvO/dGoBJqtueFqc
X-Received: by 10.66.246.229 with SMTP id xz5mr8979256pac.128.1382990053684;
        Mon, 28 Oct 2013 12:54:13 -0700 (PDT)
Received: from localhost ([2601:9:5b00:11d:ca60:ff:fe0a:8a36])
        by mx.google.com with ESMTPSA id x8sm30423308pbf.0.2013.10.28.12.54.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Oct 2013 12:54:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
From:   Mike Turquette <mturquette@linaro.org>
In-Reply-To: <525D9FC1.2040204@gmail.com>
Cc:     linux@arm.linux.org.uk,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, LMML <linux-media@vger.kernel.org>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
 <52420664.2040604@gmail.com> <3160771.O1gFkR91vK@avalon>
 <525D9FC1.2040204@gmail.com>
Message-ID: <20131028195401.11662.11969@quantum>
User-Agent: alot/0.3.4
Subject: Re: [PATCH v6 0/5] clk: clock deregistration support
Date:   Mon, 28 Oct 2013 12:54:01 -0700
Return-Path: <mturquette@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38394
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

Quoting Sylwester Nawrocki (2013-10-15 13:04:17)
> Hi,
> 
> (adding linux-media mailing list at Cc)
> 
> On 09/25/2013 11:47 AM, Laurent Pinchart wrote:
> > On Tuesday 24 September 2013 23:38:44 Sylwester Nawrocki wrote:
> [...]
> >> The only issue I found might be at the omap3isp driver, which provides
> >> clock to its sub-drivers and takes reference on the sub-driver modules.
> >> When sub-driver calls clk_get() all modules would get locked in memory,
> >> due to circular reference. One solution to that could be to pass NULL
> >> struct device pointer, as in the below patch.
> >
> > Doesn't that introduce race conditions ? If the sub-drivers require the clock,
> > they want to be sure that the clock won't disappear beyond their backs. I
> > agree that the circular dependency needs to be solved somehow, but we probably
> > need a more generic solution. The problem will become more widespread in the
> > future with DT-based device instantiation in both V4L2 and KMS.
> 
> I'm wondering whether subsystems and drivers itself should be written so
> they deal with such dependencies they are aware of.
> 
> There is similar situation in the regulator API, regulator_get() simply
> takes a reference on a module providing the regulator object.
> 
> Before a "more generic solution" is available, what do you think about
> keeping obtaining a reference on a clock provider module in clk_get() and
> doing clk_get(), clk_prepare_enable(), ..., clk_unprepare_disable(),
> clk_put() in sub-driver whenever a clock is actively used, to avoid
> permanent circular reference ?

Laurent,

Did you have any feedback on this proposal? I would like to merge these
patches so that folks with clock driver modules can use them properly.
We can fix up things in the core code as we figure them out.

Regards,
Mike

> 
> --
> Thanks,
> Sylwester
> 
> >> ---------8<------------------
> >>   From ca5963041aad67e31324cb5d4d5e2cfce1706d4f Mon Sep 17 00:00:00 2001
> >> From: Sylwester Nawrocki<s.nawrocki@samsung.com>
> >> Date: Thu, 19 Sep 2013 23:52:04 +0200
> >> Subject: [PATCH] omap3isp: Pass NULL device pointer to clk_register()
> >>
> >> Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
> >> ---
> >>    drivers/media/platform/omap3isp/isp.c |   15 ++++++++++-----
> >>    drivers/media/platform/omap3isp/isp.h |    1 +
> >>    2 files changed, 11 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/omap3isp/isp.c
> >> b/drivers/media/platform/omap3isp/isp.c
> >> index df3a0ec..d7f3c98 100644
> >> --- a/drivers/media/platform/omap3isp/isp.c
> >> +++ b/drivers/media/platform/omap3isp/isp.c
> >> @@ -290,9 +290,11 @@ static int isp_xclk_init(struct isp_device *isp)
> >>      struct clk_init_data init;
> >>      unsigned int i;
> >>
> >> +    for (i = 0; i<  ARRAY_SIZE(isp->xclks); ++i)
> >> +            isp->xclks[i] = ERR_PTR(-EINVAL);
> >> +
> >>      for (i = 0; i<  ARRAY_SIZE(isp->xclks); ++i) {
> >>              struct isp_xclk *xclk =&isp->xclks[i];
> >> -            struct clk *clk;
> >>
> >>              xclk->isp = isp;
> >>              xclk->id = i == 0 ? ISP_XCLK_A : ISP_XCLK_B;
> >> @@ -306,9 +308,9 @@ static int isp_xclk_init(struct isp_device *isp)
> >>
> >>              xclk->hw.init =&init;
> >>
> >> -            clk = devm_clk_register(isp->dev,&xclk->hw);
> >> -            if (IS_ERR(clk))
> >> -                    return PTR_ERR(clk);
> >> +            xclk->clk = clk_register(NULL,&xclk->hw);
> >> +            if (IS_ERR(xclk->clk))
> >> +                    return PTR_ERR(xclk->clk);
> >>
> >>              if (pdata->xclks[i].con_id == NULL&&
> >>              pdata->xclks[i].dev_id == NULL)
> >> @@ -320,7 +322,7 @@ static int isp_xclk_init(struct isp_device *isp)
> >>
> >>              xclk->lookup->con_id = pdata->xclks[i].con_id;
> >>              xclk->lookup->dev_id = pdata->xclks[i].dev_id;
> >> -            xclk->lookup->clk = clk;
> >> +            xclk->lookup->clk = xclk->clk;
> >>
> >>              clkdev_add(xclk->lookup);
> >>      }
> >> @@ -335,6 +337,9 @@ static void isp_xclk_cleanup(struct isp_device *isp)
> >>      for (i = 0; i<  ARRAY_SIZE(isp->xclks); ++i) {
> >>              struct isp_xclk *xclk =&isp->xclks[i];
> >>
> >> +            if (!IS_ERR(xclk->clk))
> >> +                    clk_unregister(xclk->clk);
> >> +
> >>              if (xclk->lookup)
> >>                      clkdev_drop(xclk->lookup);
> >>      }
> >> diff --git a/drivers/media/platform/omap3isp/isp.h
> >> b/drivers/media/platform/omap3isp/isp.h
> >> index cd3eff4..1498f2b 100644
> >> --- a/drivers/media/platform/omap3isp/isp.h
> >> +++ b/drivers/media/platform/omap3isp/isp.h
> >> @@ -135,6 +135,7 @@ struct isp_xclk {
> >>      struct isp_device *isp;
> >>      struct clk_hw hw;
> >>      struct clk_lookup *lookup;
> >> +    struct clk *clk;
> >>      enum isp_xclk_id id;
> >>
> >>      spinlock_t lock;        /* Protects enabled and divider */
> >> ---------8<------------------
