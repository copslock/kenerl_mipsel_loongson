Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 02:33:49 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:33884 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025537AbcDNAdpxSWWA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2016 02:33:45 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id ADD17605BD;
        Thu, 14 Apr 2016 00:33:43 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9EFCB615C7; Thu, 14 Apr 2016 00:33:43 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB62F601B3;
        Thu, 14 Apr 2016 00:33:41 +0000 (UTC)
Date:   Wed, 13 Apr 2016 17:33:41 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-clk@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Ryan Mallon <rmallon@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        adi-buildroot-devel@lists.sourceforge.net,
        Russell King <linux@arm.linux.org.uk>,
        linux-m68k@lists.linux-m68k.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
Message-ID: <20160414003341.GH14441@codeaurora.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
 <CAK7LNASW+D0B_k97r__AZeYDR5UqNPqn_j1aoQepHz-bGgV2ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASW+D0B_k97r__AZeYDR5UqNPqn_j1aoQepHz-bGgV2ng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52974
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

On 04/08, Masahiro Yamada wrote:
> 
> 
> This makes our driver programming life easier.
> 
> 
> For example, let's see drivers/tty/serial/8250/8250_of.c
> 
> 
> The "clock-frequency" DT property takes precedence over "clocks" property.
> So, it is valid to probe the driver with a NULL pointer for info->clk.
> 
> 
>         if (of_property_read_u32(np, "clock-frequency", &clk)) {
> 
>                 /* Get clk rate through clk driver if present */
>                 info->clk = devm_clk_get(&ofdev->dev, NULL);
>                 if (IS_ERR(info->clk)) {
>                         dev_warn(&ofdev->dev,
>                                 "clk or clock-frequency not defined\n");
>                         return PTR_ERR(info->clk);
>                 }
> 
>                 ret = clk_prepare_enable(info->clk);
>                 if (ret < 0)
>                         return ret;
> 
>                 clk = clk_get_rate(info->clk);
>         }
> 
> 
> As a result, we need to make sure the clk pointer is valid
> before calling clk_disable_unprepare().
> 
> 
> If we could support pointer checking in callees, we would be able to
> clean-up lots of clock consumers.
> 
> 

I'm not sure if you meant to use that example for the error
pointer case? It bails out if clk_get() returns an error pointer.

I'm all for a no-op in clk_disable()/unprepare() when the pointer
is NULL. But when it's an error pointer the driver should be
handling it and bail out before it would ever call enable/prepare
on it or disable/unprepare.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
