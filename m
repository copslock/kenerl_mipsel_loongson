Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Oct 2013 21:44:07 +0100 (CET)
Received: from perceval.ideasonboard.com ([95.142.166.194]:51020 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817514Ab3J1UoFZFIPF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Oct 2013 21:44:05 +0100
Received: from avalon.localnet (unknown [91.177.152.157])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9FC2235A46;
        Mon, 28 Oct 2013 21:43:22 +0100 (CET)
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v6 0/5] clk: clock deregistration support
Date:   Mon, 28 Oct 2013 21:44:25 +0100
Message-ID: <13300609.Rh0Q97QhcX@avalon>
User-Agent: KMail/4.10.5 (Linux/3.10.7-gentoo-r1; KDE/4.10.5; x86_64; ; )
In-Reply-To: <52434CBC.2070408@gmail.com>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com> <3160771.O1gFkR91vK@avalon> <52434CBC.2070408@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <laurent.pinchart@ideasonboard.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38396
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

On Wednesday 25 September 2013 22:51:08 Sylwester Nawrocki wrote:
> On 09/25/2013 11:47 AM, Laurent Pinchart wrote:
> > Doesn't that introduce race conditions ? If the sub-drivers require the
> > clock, they want to be sure that the clock won't disappear beyond their
> > backs. I agree that the circular dependency needs to be solved somehow,
> > but we probably need a more generic solution. The problem will become
> > more widespread in the future with DT-based device instantiation in both
> > V4L2 and KMS.
> 
> It doesn't introduce any new race conditions AFAICT. I doubt all these
> issues can be resolved in one single step. Currently the modular clock
> providers are seriously broken, there is no reference tracking and the clock
> consumers can easily get into a state where they have invalid references to
> clocks supplied by already unregistered drivers.
> 
> With this patch series the clock consumer drivers will not crash thanks
> to the clock object reference counting. So the worst thing may happen is a
> clock left in an unexpected state.
> 
> However there should be no problems with the v4l2-async API, the host driver
> in its de-initialization routine unregisters its sub-drivers (they should
> stop using the clock when notified of such an event), only then the host
> would unregister the clock (subsequently the sub-drivers get re-attached and
> put into deferred probing state).

That in itself is a workaround I believe. Unbinding/rebinding devices from/to 
drivers isn't something the v4l core should do.

> There may be issues when a sub-driver's file handle is opened while the host
> is about to de-initialize. But I doubt resolution of such problems belongs
> to the common clock framework. I have been trying to improve the situation
> in small steps, rather than waiting forever for a perfect solution.
> 
> Do you perhaps have any ideas WRT to a "more generic solution" ? In general
> I have been trying to avoid using v4l2-clk and add what's missing in the
> common clock framework.
> 
> Perhaps we should leave only the kref part in the __clk_get(), __clk_put()
> hooks and be taking reference to a clock in clk_prepare() and releasing it
> in clk_unprepare() ? This way circular reference would exist only between
> clk_prepare(), clk_unprepare() calls.
> 
> Assuming a driver prepares clock in device's open() and unprepares in device
> close() handler perhaps it could all work better, without relying on the
> host to ensure the resource reference tracking. I'm not sure if that is not
> making too many assumptions for a generic API.

This is indeed an architecture decision that goes beyond the boundaries of the 
clock framework. The question boils down to how we want to acquire/release and 
refcount resources. Should drivers acquire and release hotpluggable resources 
at probe and remove time respectively, or only when they need them ? Or should 
they acquire them at probe them and be notified when they should release them 
? The first option adds an overhead but could help solving the circular 
dependency problem in a simpler way.

-- 
Regards,

Laurent Pinchart
