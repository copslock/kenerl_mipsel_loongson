Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Oct 2013 21:26:05 +0100 (CET)
Received: from perceval.ideasonboard.com ([95.142.166.194]:50924 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817514Ab3J1U0CsUNzz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Oct 2013 21:26:02 +0100
Received: from avalon.localnet (unknown [91.177.152.157])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 11BE535A46;
        Mon, 28 Oct 2013 21:25:19 +0100 (CET)
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, LMML <linux-media@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] clk: clock deregistration support
Date:   Mon, 28 Oct 2013 21:26:22 +0100
Message-ID: <1918100.pYljUktTbF@avalon>
User-Agent: KMail/4.10.5 (Linux/3.10.7-gentoo-r1; KDE/4.10.5; x86_64; ; )
In-Reply-To: <525D9FC1.2040204@gmail.com>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com> <3160771.O1gFkR91vK@avalon> <525D9FC1.2040204@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <laurent.pinchart@ideasonboard.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurent.pinchart@ideasonboard.com
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

Hi Sylwester,

On Tuesday 15 October 2013 22:04:17 Sylwester Nawrocki wrote:
> Hi,
> 
> (adding linux-media mailing list at Cc)
> 
> On 09/25/2013 11:47 AM, Laurent Pinchart wrote:
> > On Tuesday 24 September 2013 23:38:44 Sylwester Nawrocki wrote:
> [...]
> 
> >> The only issue I found might be at the omap3isp driver, which provides
> >> clock to its sub-drivers and takes reference on the sub-driver modules.
> >> When sub-driver calls clk_get() all modules would get locked in memory,
> >> due to circular reference. One solution to that could be to pass NULL
> >> struct device pointer, as in the below patch.
> > 
> > Doesn't that introduce race conditions ? If the sub-drivers require the
> > clock, they want to be sure that the clock won't disappear beyond their
> > backs. I agree that the circular dependency needs to be solved somehow,
> > but we probably need a more generic solution. The problem will become
> > more widespread in the future with DT-based device instantiation in both
> > V4L2 and KMS.
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

That's a workaround I can live with in the short term, as long as we work on a 
generic solution to this problem. It will bite us back in the not too distant 
future if we pretend to forget about it.

-- 
Regards,

Laurent Pinchart
