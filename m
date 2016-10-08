Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Oct 2016 16:13:33 +0200 (CEST)
Received: from spo001.leaseweb.nl ([85.17.2.162]:40208 "EHLO
        spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993006AbcJHONZgwB1o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Oct 2016 16:13:25 +0200
Received: from wimvs by spo001.leaseweb.nl with local (Exim 4.50)
        id 1bssNQ-00067H-F1; Sat, 08 Oct 2016 16:13:24 +0200
Date:   Sat, 8 Oct 2016 16:13:24 +0200
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: txx9wdt: Add missing clock (un)prepare calls for CCF
Message-ID: <20161008141324.GH23290@spo001.leaseweb.nl>
References: <1473584398-12942-1-git-send-email-geert@linux-m68k.org> <1473584398-12942-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473584398-12942-2-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.4.1i
Return-Path: <wimvs@spo001.leaseweb.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
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

Hi Geert,

> While the custom minimal TXx9 clock implementation doesn't need or use
> clock (un)prepare calls (they are dummies if !CONFIG_HAVE_CLK_PREPARE),
> they are mandatory when using the Common Clock Framework.
> 
> Hence add them, to prepare for the advent of CCF.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

This patch was added to linux-watchdog-next almost 2 weeks ago.

Kind regards,
Wim.
