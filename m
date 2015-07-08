Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 11:00:23 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:53245 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009407AbbGHJAVEls5W convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jul 2015 11:00:21 +0200
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id E0B97272F; Wed,  8 Jul 2015 11:00:17 +0200 (CEST)
Received: from bbrezillon (unknown [109.109.201.182])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 060082712;
        Wed,  8 Jul 2015 11:00:10 +0200 (CEST)
Date:   Wed, 8 Jul 2015 11:00:05 +0200
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
Message-ID: <20150708110005.704c49ff@bbrezillon>
In-Reply-To: <20150708005748.GG30412@codeaurora.org>
References: <1436294888-25752-1-git-send-email-boris.brezillon@free-electrons.com>
        <20150708005748.GG30412@codeaurora.org>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48114
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

On Tue, 7 Jul 2015 17:57:48 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 07/07, Boris Brezillon wrote:
> > Clock rates are stored in an unsigned long field, but ->determine_rate()
> > (which returns a rounded rate from a requested one) returns a long
> > value (errors are reported using negative error codes), which can lead
> > to long overflow if the clock rate exceed 2Ghz.
> > 
> > Change ->determine_rate() prototype to return 0 or an error code, and pass
> > a pointer to a clk_rate_request structure containing the expected target
> > rate and the rate constraints imposed by clk users.
> > 
> > The clk_rate_request structure might be extended in the future to contain
> > other kind of constraints like the rounding policy, the maximum clock
> > inaccuracy or other things that are not yet supported by the CCF
> > (power consumption constraints ?).
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > 
> > CC: Jonathan Corbet <corbet@lwn.net>
> > CC: Tony Lindgren <tony@atomide.com>
> > CC: Ralf Baechle <ralf@linux-mips.org>
> > CC: "Emilio López" <emilio@elopez.com.ar>
> > CC: Maxime Ripard <maxime.ripard@free-electrons.com>
> > CC: Tero Kristo <t-kristo@ti.com>
> > CC: Peter De Schrijver <pdeschrijver@nvidia.com>
> > CC: Prashant Gaikwad <pgaikwad@nvidia.com>
> > CC: Stephen Warren <swarren@wwwdotorg.org>
> > CC: Thierry Reding <thierry.reding@gmail.com>
> > CC: Alexandre Courbot <gnurou@gmail.com>
> > CC: linux-doc@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: linux-omap@vger.kernel.org
> > CC: linux-mips@linux-mips.org
> > CC: linux-tegra@vger.kernel.org
> > 
> > ---
> 
> I'll throw this patch into -next now to see if any other problems
> shake out. I'm hoping we get some more acks though, so it'll be
> on it's own branch and become immutable in a week or so. One
> question below.
> 
> > diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> > index 616f5ae..9e69f34 100644
> > --- a/drivers/clk/clk-composite.c
> > +++ b/drivers/clk/clk-composite.c
> > @@ -99,33 +99,33 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
> >  
> >  			parent_rate = __clk_get_rate(parent);
> >  
> > -			tmp_rate = rate_ops->round_rate(rate_hw, rate,
> > +			tmp_rate = rate_ops->round_rate(rate_hw, req->rate,
> >  							&parent_rate);
> >  			if (tmp_rate < 0)
> >  				continue;
> >  
> > -			rate_diff = abs(rate - tmp_rate);
> > +			rate_diff = abs(req->rate - tmp_rate);
> >  
> > -			if (!rate_diff || !*best_parent_p
> > +			if (!rate_diff || !req->best_parent_hw
> >  				       || best_rate_diff > rate_diff) {
> > -				*best_parent_p = __clk_get_hw(parent);
> > -				*best_parent_rate = parent_rate;
> > +				req->best_parent_hw = __clk_get_hw(parent);
> > +				req->best_parent_rate = parent_rate;
> >  				best_rate_diff = rate_diff;
> >  				best_rate = tmp_rate;
> >  			}
> >  
> >  			if (!rate_diff)
> > -				return rate;
> > +				return 0;
> >  		}
> >  
> > -		return best_rate;
> > +		req->rate = best_rate;
> > +		return 0;
> >  	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
> >  		__clk_hw_set_clk(mux_hw, hw);
> > -		return mux_ops->determine_rate(mux_hw, rate, min_rate,
> > -					       max_rate, best_parent_rate,
> > -					       best_parent_p);
> > +		return mux_ops->determine_rate(mux_hw, req);
> >  	} else {
> >  		pr_err("clk: clk_composite_determine_rate function called, but no mux or rate callback set!\n");
> > +		req->rate = 0;
> >  		return 0;
> 
> Shouldn't this return an error now? And then assigning req->rate
> wouldn't be necessary. Sorry I must have missed this last round.
> 

Actually I wanted to keep the existing behavior: return a 0 rate (not
an error) when there is no mux or rate ops.

That's something we can change afterwards, but it might reveals
new bugs if some users are checking for a 0 rate to detect errors.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
