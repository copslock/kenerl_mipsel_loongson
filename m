Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 14:31:41 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:57062 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011785AbbDSMbF25MgC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Apr 2015 14:31:05 +0200
Received: from localhost.localdomain (unknown [85.177.79.58])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id DBA8794007A;
        Sun, 19 Apr 2015 14:28:43 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] MIPS: ath79: Use the common clk API
Date:   Sun, 19 Apr 2015 14:30:04 +0200
Message-Id: <1429446604-15403-6-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429446604-15403-1-git-send-email-albeu@free.fr>
References: <1429446604-15403-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Make the code simpler and open the way for device tree clocks.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/Kconfig       |  1 +
 arch/mips/ath79/clock.c | 29 ++---------------------------
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9075147..874bbaf 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -123,6 +123,7 @@ config ATH79
 	select CSRC_R4K
 	select DMA_NONCOHERENT
 	select HAVE_CLK
+	select COMMON_CLK
 	select CLKDEV_LOOKUP
 	select IRQ_CPU
 	select MIPS_MACHINE
diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 226ddf0..1fcb691 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 
 #include <asm/div64.h>
 
@@ -28,21 +29,15 @@
 #define AR724X_BASE_FREQ	5000000
 #define AR913X_BASE_FREQ	5000000
 
-struct clk {
-	unsigned long rate;
-};
-
 static void __init ath79_add_sys_clkdev(const char *id, unsigned long rate)
 {
 	struct clk *clk;
 	int err;
 
-	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	clk = clk_register_fixed_rate(NULL, id, NULL, CLK_IS_ROOT, rate);
 	if (!clk)
 		panic("failed to allocate %s clock structure", id);
 
-	clk->rate = rate;
-
 	err = clk_register_clkdev(clk, id, NULL);
 	if (err)
 		panic("unable to register %s clock device", id);
@@ -468,23 +463,3 @@ ath79_get_sys_clk_rate(const char *id)
 
 	return rate;
 }
-
-/*
- * Linux clock API
- */
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return clk->rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
-- 
2.0.0
