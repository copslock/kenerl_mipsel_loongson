Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 01:02:24 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:59703 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008873AbbGMXCWVmyp2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 01:02:22 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A731D1412FF;
        Mon, 13 Jul 2015 23:02:19 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 871E8141301; Mon, 13 Jul 2015 23:02:19 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D07051412FF;
        Mon, 13 Jul 2015 23:02:18 +0000 (UTC)
Date:   Mon, 13 Jul 2015 16:02:18 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Tero Kristo <t-kristo@ti.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5] clk: change clk_ops' ->determine_rate() prototype
Message-ID: <20150713230217.GI30412@codeaurora.org>
References: <1436294888-25752-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150708005748.GG30412@codeaurora.org>
 <20150708110005.704c49ff@bbrezillon>
 <559D66EE.4060707@codeaurora.org>
 <20150709223938.19450e75@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150709223938.19450e75@bbrezillon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48249
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

On 07/09, Boris Brezillon wrote:
> Hi Stephen,
> 
> On Wed, 08 Jul 2015 11:07:42 -0700
> Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > On 07/08/2015 02:00 AM, Boris Brezillon wrote:
> > > Hi Stephen,
> > >
> > > On Tue, 7 Jul 2015 17:57:48 -0700
> > > Stephen Boyd <sboyd@codeaurora.org> wrote:
> > >
> > >> On 07/07, Boris Brezillon wrote:
> > >>>
> > >>>  	} else {
> > >>>  		pr_err("clk: clk_composite_determine_rate function called, but no mux or rate callback set!\n");
> > >>> +		req->rate = 0;
> > >>>  		return 0;
> > >> Shouldn't this return an error now? And then assigning req->rate
> > >> wouldn't be necessary. Sorry I must have missed this last round.
> > >>
> > > Actually I wanted to keep the existing behavior: return a 0 rate (not
> > > an error) when there is no mux or rate ops.
> > >
> > > That's something we can change afterwards, but it might reveals
> > > new bugs if some users are checking for a 0 rate to detect errors.
> > >
> > 
> > Ok. Care to send the patch now to do that while we're thinking about it?
> > We can test it out for a month or two.
> > 
> 
> Here is a patch modifying a few drivers to return errors instead of a 0
> rate. Feel free to squash it in the previous one if you think this is
> better.
> 
> Best Regards,
> 
> Boris
> 
> --- >8 ---
> 
> From dca9c28301042cf19dad4b1e4555cdb7c1063745 Mon Sep 17 00:00:00 2001
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> Date: Thu, 9 Jul 2015 12:20:21 +0200
> Subject: [PATCH] clk: fix some determine_rate implementations
> 
> Some determine_rate implementations are not returning an error when then
> failed to adapt the rate according to the rate request.
> Fix them so that they return an error instead of silently returning 0.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

The linewrap is seriously messed up here. Please fix your mailer
next time. I had to hand edit the patch to get it to apply. I've
applied this in top of the original patch as a different commit,
in case we need to revert it later.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
