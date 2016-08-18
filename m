Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 19:35:26 +0200 (CEST)
Received: from michel.telenet-ops.be ([195.130.137.88]:57073 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993145AbcHRRegqax9- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 19:34:36 +0200
Received: from ayla.of.borg ([84.193.137.253])
        by michel.telenet-ops.be with bizsmtp
        id YhaZ1t00N5UCtCs06haZD4; Thu, 18 Aug 2016 19:34:36 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1baRD7-0002hQ-Jl; Thu, 18 Aug 2016 19:34:33 +0200
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1baRD9-0007zl-LK; Thu, 18 Aug 2016 19:34:35 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] spi: spi-txx9: Add missing clock (un)prepare calls for CCF
Date:   Thu, 18 Aug 2016 19:34:25 +0200
Message-Id: <1471541667-30689-2-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54658
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

While the custom minimal TXx9 clock implementation doesn't need or use
clock (un)prepare calls (they are dummies if !CONFIG_HAVE_CLK_PREPARE),
they are mandatory when using the Common Clock Framework.

Hence add them, to prepare for the advent of CCF.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Untested due to lack of hardware.
---
 drivers/spi/spi-txx9.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 7492ea346b43ed5b..51759d3fd45f6b06 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -346,7 +346,7 @@ static int txx9spi_probe(struct platform_device *dev)
 		c->clk = NULL;
 		goto exit;
 	}
-	ret = clk_enable(c->clk);
+	ret = clk_prepare_enable(c->clk);
 	if (ret) {
 		c->clk = NULL;
 		goto exit;
@@ -395,7 +395,7 @@ static int txx9spi_probe(struct platform_device *dev)
 exit_busy:
 	ret = -EBUSY;
 exit:
-	clk_disable(c->clk);
+	clk_disable_unprepare(c->clk);
 	spi_master_put(master);
 	return ret;
 }
@@ -406,7 +406,7 @@ static int txx9spi_remove(struct platform_device *dev)
 	struct txx9spi *c = spi_master_get_devdata(master);
 
 	flush_work(&c->work);
-	clk_disable(c->clk);
+	clk_disable_unprepare(c->clk);
 	return 0;
 }
 
-- 
1.9.1
