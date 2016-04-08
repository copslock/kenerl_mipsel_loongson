Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2016 02:33:38 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:43788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008912AbcDHAdcanPDA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Apr 2016 02:33:32 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6B02A61649;
        Fri,  8 Apr 2016 00:33:30 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F2366160E; Fri,  8 Apr 2016 00:33:30 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F0FA601A1;
        Fri,  8 Apr 2016 00:33:29 +0000 (UTC)
Date:   Thu, 7 Apr 2016 17:33:28 -0700
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
Message-ID: <20160408003328.GA14441@codeaurora.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52928
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

On 04/05, Masahiro Yamada wrote:
> The clk_disable() in the common clock framework (drivers/clk/clk.c)
> returns immediately if a given clk is NULL or an error pointer.  It
> allows clock consumers to call clk_disable() without IS_ERR_OR_NULL
> checking if drivers are only used with the common clock framework.
> 
> Unfortunately, NULL/error checking is missing from some of non-common
> clk_disable() implementations.  This prevents us from completely
> dropping NULL/error checking from callers.  Let's make it tree-wide
> consistent by adding IS_ERR_OR_NULL(clk) to all callees.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Greg Ungerer <gerg@uclinux.org>
> Acked-by: Wan Zongshun <mcuos.com@gmail.com>
> ---
> 
> Stephen,
> 
> This patch has been unapplied for a long time.
> 
> Please let me know if there is something wrong with this patch.
> 

I'm mostly confused why we wouldn't want to encourage people to
call clk_disable or unprepare on a clk that's an error pointer.
Typically an error pointer should be dealt with, instead of
silently ignored, so why wasn't it dealt with by passing it up
the probe() path?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
