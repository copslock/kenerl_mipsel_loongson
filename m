Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 22:39:51 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:42253 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010176AbbGIUjrPRidh convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jul 2015 22:39:47 +0200
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id 2BE6166B; Thu,  9 Jul 2015 22:39:41 +0200 (CEST)
Received: from bbrezillon (unknown [46.189.28.236])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 81F551D0;
        Thu,  9 Jul 2015 22:39:40 +0200 (CEST)
Date:   Thu, 9 Jul 2015 22:39:38 +0200
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Emilio =?UTF-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
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
Message-ID: <20150709223938.19450e75@bbrezillon>
In-Reply-To: <559D66EE.4060707@codeaurora.org>
References: <1436294888-25752-1-git-send-email-boris.brezillon@free-electrons.com>
        <20150708005748.GG30412@codeaurora.org>
        <20150708110005.704c49ff@bbrezillon>
        <559D66EE.4060707@codeaurora.org>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

Hi Stephen,

On Wed, 08 Jul 2015 11:07:42 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 07/08/2015 02:00 AM, Boris Brezillon wrote:
> > Hi Stephen,
> >
> > On Tue, 7 Jul 2015 17:57:48 -0700
> > Stephen Boyd <sboyd@codeaurora.org> wrote:
> >
> >> On 07/07, Boris Brezillon wrote:
> >>>
> >>>  	} else {
> >>>  		pr_err("clk: clk_composite_determine_rate function called, but no mux or rate callback set!\n");
> >>> +		req->rate = 0;
> >>>  		return 0;
> >> Shouldn't this return an error now? And then assigning req->rate
> >> wouldn't be necessary. Sorry I must have missed this last round.
> >>
> > Actually I wanted to keep the existing behavior: return a 0 rate (not
> > an error) when there is no mux or rate ops.
> >
> > That's something we can change afterwards, but it might reveals
> > new bugs if some users are checking for a 0 rate to detect errors.
> >
> 
> Ok. Care to send the patch now to do that while we're thinking about it?
> We can test it out for a month or two.
> 

Here is a patch modifying a few drivers to return errors instead of a 0
rate. Feel free to squash it in the previous one if you think this is
better.

Best Regards,

Boris

--- >8 ---
