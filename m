Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 19:34:43 +0200 (CEST)
Received: from baptiste.telenet-ops.be ([195.130.132.51]:40852 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992474AbcHRRedcS8b- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 19:34:33 +0200
Received: from ayla.of.borg ([84.193.137.253])
        by baptiste.telenet-ops.be with bizsmtp
        id YhaY1t0035UCtCs01haYa2; Thu, 18 Aug 2016 19:34:32 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1baRD6-0002hM-7S; Thu, 18 Aug 2016 19:34:32 +0200
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1baRD8-0007zg-7Q; Thu, 18 Aug 2016 19:34:34 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] MIPS: TXx9: Common Clock Framework Conversion
Date:   Thu, 18 Aug 2016 19:34:24 +0200
Message-Id: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54656
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

	Hi Ralf, Nemoto-san, Mark, Wim, Günter,

This patch series converts the Toshiba TXx9 platforms from their own
custom minimal clock implementation to the Common Clock Framework.

  - Patches 1 and 2 add missing clock (un)prepare calls to TXx9-specific
    drivers,
  - Patch 3 replaces the custom clock implementation by a CCF-based one,
    providing a minimal set of clocks.

Patches 1 and 2 can be applied independently.
Patch 3 has a hard dependency on patches 1 and 2.
I don't know how you prefer to handle this?

This has been tested with the watchdog on RBTX4927.

Thanks!

Geert Uytterhoeven (3):
  spi: spi-txx9: Add missing clock (un)prepare calls for CCF
  watchdog: txx9wdt: Add missing clock (un)prepare calls for CCF
  MIPS: TXx9: Convert to Common Clock Framework

 arch/mips/txx9/Kconfig         |  2 +-
 arch/mips/txx9/generic/setup.c | 68 ++++++++++++++++++++----------------------
 drivers/spi/spi-txx9.c         |  6 ++--
 drivers/watchdog/txx9wdt.c     |  6 ++--
 4 files changed, 40 insertions(+), 42 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
