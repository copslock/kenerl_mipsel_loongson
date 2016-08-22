Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2016 19:37:13 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:50295 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992002AbcHVRhGWZ9IJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Aug 2016 19:37:06 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D373615A4; Mon, 22 Aug 2016 17:37:04 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F219461C86;
        Mon, 22 Aug 2016 17:37:02 +0000 (UTC)
Date:   Mon, 22 Aug 2016 10:37:02 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 3/3] MIPS: TXx9: Convert to Common Clock Framework
Message-ID: <20160822173702.GM6502@codeaurora.org>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
 <1471541667-30689-4-git-send-email-geert@linux-m68k.org>
 <20160819191750.GV361@codeaurora.org>
 <CAMuHMdVjd5iJL8AJBb0aVOEkcgJ-m-K19pjD-tJL=GLhPVm_Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVjd5iJL8AJBb0aVOEkcgJ-m-K19pjD-tJL=GLhPVm_Pg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54726
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

On 08/22, Geert Uytterhoeven wrote:
> Hi Stephen,
> 
> On Fri, Aug 19, 2016 at 9:17 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 08/18, Geert Uytterhoeven wrote:
> >> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
> >> index ada92db92f87d91a..2fdbcf91b2cc472c 100644
> >> --- a/arch/mips/txx9/generic/setup.c
> >> +++ b/arch/mips/txx9/generic/setup.c
> >> @@ -560,8 +527,39 @@ void __init plat_time_init(void)
> >>       txx9_board_vec->time_init();
> >>  }
> >>
> >> +static void txx9_clk_init(void)
> >> +{
> >> +     struct clk *clk;
> >> +     int error;
> >> +
> >> +     clk = clk_register_fixed_rate(NULL, "gbus", NULL, 0, txx9_gbus_clock);
> >
> > Can we use the clk_hw_*() based variants instead please?
> 
> Yes we can.
> 
> BTW, is it intentional that clk_hw_register_clkdev() doesn't detect errors
> from a previous registration call, like clk_register_clkdev() does?
> 

Slightly intentional, because the assumption is providers already
have a clk_hw structure that they've created themselves when they
register a clkdev, whereas a struct clk is more likely to be an
error pointer because of clk_get(), etc. But I suppose we can add
the error check to ease registration in cases where providers are
using the basic types.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
