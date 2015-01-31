Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Jan 2015 02:32:05 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.11.231]:49846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012349AbbAaBcCTYuP9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Jan 2015 02:32:02 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0669F1406A2;
        Sat, 31 Jan 2015 01:32:00 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id E69721406B2; Sat, 31 Jan 2015 01:31:59 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DEED1406A2;
        Sat, 31 Jan 2015 01:31:59 +0000 (UTC)
Date:   Fri, 30 Jan 2015 17:31:58 -0800
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Mike Turquette <mturquette@linaro.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Chao Xie <chao.xie@marvell.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Emilio L??pez <emilio@elopez.com.ar>,
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
Subject: Re: [PATCH v13 4/6] clk: Add rate constraints to clocks
Message-ID: <20150131013158.GA4323@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-5-git-send-email-tomeu.vizoso@collabora.com>
 <CAMuHMdUGgA70o2SgdJR3X6AkCcMssHU0POLfzppADT-O=BrYDw@mail.gmail.com>
 <54CA8662.7040008@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54CA8662.7040008@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

On 01/29, Stephen Boyd wrote:
> On 01/29/15 05:31, Geert Uytterhoeven wrote:
> > Hi Tomeu, Mike,
> >
> > On Fri, Jan 23, 2015 at 12:03 PM, Tomeu Vizoso
> > <tomeu.vizoso@collabora.com> wrote:
> >> --- a/drivers/clk/clk.c
> >> +++ b/drivers/clk/clk.c
> >> @@ -2391,25 +2543,24 @@ int __clk_get(struct clk *clk)
> >>         return 1;
> >>  }
> >>
> >> -static void clk_core_put(struct clk_core *core)
> >> +void __clk_put(struct clk *clk)
> >>  {
> >>         struct module *owner;
> >>
> >> -       owner = core->owner;
> >> +       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> >> +               return;
> >>
> >>         clk_prepare_lock();
> >> -       kref_put(&core->ref, __clk_release);
> >> +
> >> +       hlist_del(&clk->child_node);
> >> +       clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
> > At this point, clk->core->req_rate is still zero, causing
> > cpg_div6_clock_round_rate() to be called with a zero "rate" parameter,
> > e.g. on r8a7791:
> 
> Hmm.. I wonder if we should assign core->req_rate to be the same as
> core->rate during __clk_init()? That would make this call to
> clk_core_set_rate_nolock() a nop in this case.
> 

Here's a patch to do this

---8<----
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] clk: Assign a requested rate by default

We need to assign a requested rate here so that we avoid
requesting a rate of 0 on clocks when we remove clock consumers.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a29daf9edea4..8416ed1c40be 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2142,6 +2142,7 @@ int __clk_init(struct device *dev, struct clk *clk_user)
 	struct clk_core *orphan;
 	struct hlist_node *tmp2;
 	struct clk_core *clk;
+	unsigned long rate;
 
 	if (!clk_user)
 		return -EINVAL;
@@ -2266,12 +2267,13 @@ int __clk_init(struct device *dev, struct clk *clk_user)
 	 * then rate is set to zero.
 	 */
 	if (clk->ops->recalc_rate)
-		clk->rate = clk->ops->recalc_rate(clk->hw,
+		rate = clk->ops->recalc_rate(clk->hw,
 				clk_core_get_rate_nolock(clk->parent));
 	else if (clk->parent)
-		clk->rate = clk->parent->rate;
+		rate = clk->parent->rate;
 	else
-		clk->rate = 0;
+		rate = 0;
+	clk->rate = clk->req_rate = rate;
 
 	/*
 	 * walk the list of orphan clocks and reparent any that are children of
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
