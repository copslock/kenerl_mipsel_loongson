Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Sep 2016 11:00:33 +0200 (CEST)
Received: from albert.telenet-ops.be ([195.130.137.90]:47230 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992029AbcIKI75bWq7m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Sep 2016 10:59:57 +0200
Received: from ayla.of.borg ([84.193.137.253])
        by albert.telenet-ops.be with bizsmtp
        id i8zx1t00P5UCtCs068zxSV; Sun, 11 Sep 2016 10:59:57 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1bj0cH-0003ZF-2H; Sun, 11 Sep 2016 10:59:57 +0200
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1bj0cL-0003NX-6U; Sun, 11 Sep 2016 11:00:01 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Wim Van Sebroeck <wim@iguana.be>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 2/2] MIPS: TXx9: Convert to Common Clock Framework
Date:   Sun, 11 Sep 2016 10:59:58 +0200
Message-Id: <1473584398-12942-3-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1473584398-12942-1-git-send-email-geert@linux-m68k.org>
References: <1473584398-12942-1-git-send-email-geert@linux-m68k.org>
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55092
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

Replace the custom minimal clock implementation for Toshiba TXx9 by a
basic implementation using the Common Clock Framework.

The only clocks that are provided are those needed by TXx9-specific
drivers ("imbus" and "spi" (TX4938 only)), and their common parent
clock "gbus". Other clocks can be added when needed.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Tested on RBTX4927.

v2:
  - Protect the TX4938_REV_PCODE() check by #ifdef CONFIG_CPU_TX49XX,
  - Use new clk_hw-centric clock registration API.
---
 arch/mips/txx9/Kconfig         |  2 +-
 arch/mips/txx9/generic/setup.c | 70 +++++++++++++++++++++---------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 8c337d60f790db9f..42923478d45ca363 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -20,7 +20,7 @@ config MACH_TXX9
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
-	select HAVE_CLK
+	select COMMON_CLK
 
 config TOSHIBA_JMR3927
 	bool "Toshiba JMR-TX3927 board"
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index ada92db92f87d91a..a1d98b5c8fd67576 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -15,7 +15,8 @@
 #include <linux/interrupt.h>
 #include <linux/string.h>
 #include <linux/module.h>
-#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
@@ -83,40 +84,6 @@ int txx9_ccfg_toeon __initdata;
 int txx9_ccfg_toeon __initdata = 1;
 #endif
 
-/* Minimum CLK support */
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	if (!strcmp(id, "spi-baseclk"))
-		return (struct clk *)((unsigned long)txx9_gbus_clock / 2 / 2);
-	if (!strcmp(id, "imbus_clk"))
-		return (struct clk *)((unsigned long)txx9_gbus_clock / 2);
-	return ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
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
-	return (unsigned long)clk;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
-
 #define BOARD_VEC(board)	extern struct txx9_board_vec board;
 #include <asm/txx9/boards.h>
 #undef BOARD_VEC
@@ -560,8 +527,41 @@ void __init plat_time_init(void)
 	txx9_board_vec->time_init();
 }
 
+static void txx9_clk_init(void)
+{
+	struct clk_hw *hw;
+	int error;
+
+	hw = clk_hw_register_fixed_rate(NULL, "gbus", NULL, 0, txx9_gbus_clock);
+	if (IS_ERR(hw)) {
+		error = PTR_ERR(hw);
+		goto fail;
+	}
+
+	hw = clk_hw_register_fixed_factor(NULL, "imbus", "gbus", 0, 1, 2);
+	error = clk_hw_register_clkdev(hw, "imbus_clk", NULL);
+	if (error)
+		goto fail;
+
+#ifdef CONFIG_CPU_TX49XX
+	if (TX4938_REV_PCODE() == 0x4938) {
+		hw = clk_hw_register_fixed_factor(NULL, "spi", "gbus", 0, 1, 4);
+		error = clk_hw_register_clkdev(hw, "spi-baseclk", NULL);
+		if (error)
+			goto fail;
+	}
+#endif
+
+	return;
+
+fail:
+	pr_err("Failed to register clocks: %d\n", error);
+}
+
 static int __init _txx9_arch_init(void)
 {
+	txx9_clk_init();
+
 	if (txx9_board_vec->arch_init)
 		txx9_board_vec->arch_init();
 	return 0;
-- 
1.9.1
