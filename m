Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 03:01:49 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:37971 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013022AbbETBBrUmzWA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2015 03:01:47 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3CBBF14058B;
        Wed, 20 May 2015 01:01:46 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 1D2A61405CE; Wed, 20 May 2015 01:01:46 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B43E814058B;
        Wed, 20 May 2015 01:01:45 +0000 (UTC)
Date:   Tue, 19 May 2015 18:01:44 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Mike Turquette <mturquette@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        ascha Hauer <kernel@pengutronix.de>,
        David Brown <davidb@codeaurora.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Paul Walmsley <paul@pwsan.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Viresh Kumar <viresh.linux@gmail.com>,
        Emilio L?pez <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Tero Kristo <t-kristo@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, patches@opensource.wolfsonmicro.com,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, spear-devel@list.st.com,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH v2 1/2] clk: change clk_ops' ->round_rate() prototype
Message-ID: <20150520010144.GA31054@codeaurora.org>
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com>
 <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>
 <20150507063953.GC32399@codeaurora.org>
 <20150507093702.0b58753d@bbrezillon>
 <20150515174048.4a31af49@bbrezillon>
 <5557267D.7080209@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5557267D.7080209@kapsi.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47483
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

On 05/16, Mikko Perttunen wrote:
> On 05/15/2015 06:40 PM, Boris Brezillon wrote:
> >Hi Stephen,
> >
> >Adding Mikko in the loop (after all, he was the one complaining about
> >this signed long limitation in the first place, and I forgot to add
> >him in the Cc list :-/).
> 
> I think I got it through linux-tegra anyway, but thanks :)
> 
> >
> >Mikko, are you okay with the approach proposed by Stephen (adding a
> >new method) ?
> 
> Yes, sounds good to me. If a driver uses the existing methods with
> too large frequencies, the issue is pretty discoverable anyway. I
> think "adjust_rate" sounds a bit too much like it sets the clock's
> rate, though; perhaps "adjust_rate_request" or something like that?
> 

Well I'm also OK with changing the determine_rate API one more
time, but we'll have to be careful. Invariably someone will push
a new clock driver through some non-clk tree path and we'll get
build breakage. They shouldn't be doing that, so either we do the
change now and push it to -next and see what breaks, or we do
this after -rc1 comes out and make sure everyone has lots of
warning.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
