Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 03:21:58 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:40744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010156AbbCaBV4fPsYo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 03:21:56 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 346E51406DB;
        Tue, 31 Mar 2015 01:21:54 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 1B1A01406DD; Tue, 31 Mar 2015 01:21:54 +0000 (UTC)
Received: from [10.134.64.202] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2F571406DB;
        Tue, 31 Mar 2015 01:21:52 +0000 (UTC)
Message-ID: <5519F6B0.5040809@codeaurora.org>
Date:   Mon, 30 Mar 2015 18:21:52 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Mike Turquette <mturquette@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 2/7] clk: Add basic infrastructure for Pistachio clocks
References: <1424836567-7252-1-git-send-email-abrestic@chromium.org>    <1424836567-7252-3-git-send-email-abrestic@chromium.org>        <5519E37C.9010201@codeaurora.org> <CAL1qeaGTtMWDM+p+FpDRP=L-yqQ_ai7LY8GwcBUO_C1F+V1LzQ@mail.gmail.com>
In-Reply-To: <CAL1qeaGTtMWDM+p+FpDRP=L-yqQ_ai7LY8GwcBUO_C1F+V1LzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46635
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

On 03/30/15 17:15, Andrew Bresticker wrote:
> On Mon, Mar 30, 2015 at 4:59 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 02/24/15 19:56, Andrew Bresticker wrote:
>>> +
>>> +void pistachio_clk_force_enable(struct pistachio_clk_provider *p,
>>> +                             unsigned int *clk_ids, unsigned int num)
>>> +{
>>> +     unsigned int i;
>>> +     int err;
>>> +
>>> +     for (i = 0; i < num; i++) {
>>> +             struct clk *clk = p->clk_data.clks[clk_ids[i]];
>>> +
>>> +             if (IS_ERR(clk))
>>> +                     continue;
>>> +
>>> +             err = clk_prepare_enable(clk);
>>> +             if (err)
>>> +                     pr_err("Failed to enable clock %s: %d\n",
>>> +                            __clk_get_name(clk), err);
>>> +     }
>>> +}
>>>
>> Is this to workaround some problems in the framework where clocks are
>> turned off? Or is it that these clocks are already on before we boot
>> Linux and we need to make sure the framework knows that?
> It's the former.  These clocks are enabled at POR and may only be
> gated as the final step to entering suspend, so they must remain on at
> runtime.  The issue we were running into was that consumers of these
> critical clocks or their descendants would enable/disable their clocks
> during boot or runtime PM and cause these clocks to get disabled.
> Bumping up the prepare/enable count of these critical clocks seemed
> like the best way to handle this - is there a more preferred way?
> FWIW, this is also how the Tegra and Rockchip drivers handled this
> problem.

Ideally clock providers just provide clocks and don't actually call
clock consumer APIs. I don't see where these clocks are disabled in this
series. Is it just because suspend isn't done right now so there isn't a
place to hook the disable part? I hope that it's a 1:1 relation between
the clocks that are turned on here and the clocks that are turned off
during suspend.

I have a slightly similar problem on my hardware. Consider the case
where the bootloader has left on the display and audio clocks and they
share a common parent PLL. When the kernel boots up, all it knows is
that the display clock and audio clock share a common PLL and the rate
they're running at. If the audio driver probes first, calls clk_enable()
on the audio clock (almost a no-op except for the fact that we call the
.enable op when it's already on) and then calls clk_disable() on the
audio clock when it's done we'll also turn off the shared PLL.
Unfortunately it's also being used by the display clock for the display
driver that hasn't probed yet and so the display stops working and it
may show an artifact or black screen.

Other cases are where certain clocks should never be turned off because
they're used by some non-linux entity (dram controller for example) and
we don't have a place to put the clk_prepare_enable() besides in the
clock driver itself. In these cases, it may be better to tell the
framework that a clock should always be on. I think this case is what
Lee Jones is working on here[1].

Do you fall into one of these two cases? It isn't clear to me how
suspend is special and needs to be dealt with differently. Why wouldn't
these clocks be always on?

[1] https://lkml.org/lkml/2015/2/27/548

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
