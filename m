Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 16:27:14 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:54083 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025751AbbDQO0x68qBT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Apr 2015 16:26:53 +0200
Received: from localhost.localdomain (unknown [85.177.206.240])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id 122054B0289;
        Fri, 17 Apr 2015 16:24:00 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] MIPS: ath79: Use the common clk API
Date:   Fri, 17 Apr 2015 16:24:23 +0200
Message-Id: <1429280669-2986-9-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429280669-2986-1-git-send-email-albeu@free.fr>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46893
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
index 1fa7f2f..a7b8ef4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -120,6 +120,7 @@ config ATH79
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
