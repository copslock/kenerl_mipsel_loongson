Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Sep 2016 11:00:54 +0200 (CEST)
Received: from michel.telenet-ops.be ([195.130.137.88]:38489 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbcIKI75EH0mm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Sep 2016 10:59:57 +0200
Received: from ayla.of.borg ([84.193.137.253])
        by michel.telenet-ops.be with bizsmtp
        id i8zw1t0015UCtCs068zwKm; Sun, 11 Sep 2016 10:59:56 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1bj0cF-0003Z7-Tv; Sun, 11 Sep 2016 10:59:55 +0200
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1bj0cK-0003NN-0I; Sun, 11 Sep 2016 11:00:00 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Wim Van Sebroeck <wim@iguana.be>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/2] MIPS: TXx9: Common Clock Framework Conversion
Date:   Sun, 11 Sep 2016 10:59:56 +0200
Message-Id: <1473584398-12942-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

	Hi Ralf, Nemoto-san, Wim,

This patch series converts the Toshiba TXx9 platforms from their own
custom minimal clock implementation to the Common Clock Framework.

  - Patch 1 adds missing clock (un)prepare calls to the TXx9 watchdog
    driver,
  - Patch 2 replaces the custom clock implementation by a CCF-based one,
    providing a minimal set of clocks.

This has been tested with the watchdog on RBTX4927.

Changes since v1:
  - Dropped "spi: spi-txx9: Add missing clock (un)prepare calls for
    CCF", which has been accepted in spi/for-next,
  - Protect the TX4938_REV_PCODE() check by #ifdef CONFIG_CPU_TX49XX,
  - Use new clk_hw-centric clock registration API,
  - Add Reviewed-by.

Dependencies:
  - Patch 1 can be applied independently,
  - Patch 2 depends on patch 1 and on "spi: spi-txx9: Add missing clock
    (un)prepare calls for CCF" in spi/for-next,
  - The error path in patch 2 depends on "clkdev: Detect errors in
    clk_hw_register_clkdev() for mass registration", but this is less
    critical.

Wim: Can you please appply patch 1 directly, so we can get at least the
hard dependencies in v4.9?

Thanks!

Geert Uytterhoeven (2):
  watchdog: txx9wdt: Add missing clock (un)prepare calls for CCF
  MIPS: TXx9: Convert to Common Clock Framework

 arch/mips/txx9/Kconfig         |  2 +-
 arch/mips/txx9/generic/setup.c | 70 +++++++++++++++++++++---------------------
 drivers/watchdog/txx9wdt.c     |  6 ++--
 3 files changed, 39 insertions(+), 39 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
