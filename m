Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2016 02:04:51 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:59047 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026634AbcDPAEsQ2sNU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Apr 2016 02:04:48 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1DA22615F1;
        Sat, 16 Apr 2016 00:04:45 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01C6B615D8; Sat, 16 Apr 2016 00:04:44 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68495605B6;
        Sat, 16 Apr 2016 00:04:44 +0000 (UTC)
Date:   Fri, 15 Apr 2016 17:04:43 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Greg Ungerer <gerg@uclinux.org>, linux-clk@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Steven Miao <realmz6@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-m68k@lists.linux-m68k.org, Simon Horman <horms@verge.net.au>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        John Crispin <blogic@openwrt.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-renesas-soc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>
Subject: Re: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
Message-ID: <20160416000443.GA26353@codeaurora.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
 <CAK7LNASW+D0B_k97r__AZeYDR5UqNPqn_j1aoQepHz-bGgV2ng@mail.gmail.com>
 <20160414003341.GH14441@codeaurora.org>
 <CAK7LNARbzRLq_NGWJ8CFBBf6w4cVGCNh45fo6JO=+F7FACBSxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARbzRLq_NGWJ8CFBBf6w4cVGCNh45fo6JO=+F7FACBSxA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53020
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

On 04/14, Masahiro Yamada wrote:
> 
> OK, now I notice another problem in my code;
> if foo_clk_init() fails for reason [2],
> clk_disable() WARN's due to zero enable_count.
> 
> if (WARN_ON(core->enable_count == 0))
>          return;
> 
> 
> 
> Perhaps, I got screwed up by splitting clock init stuff
> into a helper function.

Yep! Can't we just split the enable/disable out into another
function separate from the clk_get/put part? That would make
things more symmetric and avoid this problem.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
