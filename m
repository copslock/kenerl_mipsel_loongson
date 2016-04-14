Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 02:40:56 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:34502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025537AbcDNAkzOTeYA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2016 02:40:55 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2B13B60CF5;
        Thu, 14 Apr 2016 00:40:52 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A97560DBA; Thu, 14 Apr 2016 00:40:52 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 74264605BD;
        Thu, 14 Apr 2016 00:40:51 +0000 (UTC)
Date:   Wed, 13 Apr 2016 17:40:50 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org,
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
        linux-m68k@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        John Crispin <blogic@openwrt.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Paul Walmsley <paul@pwsan.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
Message-ID: <20160414004050.GJ14441@codeaurora.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
 <20160408100600.GI1668@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160408100600.GI1668@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52975
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

On 04/08, Ralf Baechle wrote:
> 
> While your argument makes perfect sense, Many clk_disable implementations
> are already doing similar checks, for example:
> 
> arch/arm/mach-davinci/clock.c:
> 
[...]
> 
> So should we go and weed out these checks?

Yes, it would be nice to at least make the differing
implementations of the clk API consistent. Of course, we should
really put our efforts towards getting rid of the non-CCF
implementations instead so that there's less confusion overall.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
