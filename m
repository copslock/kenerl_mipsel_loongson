Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:39:47 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:57529 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842522AbaGWOg56VKqn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:36:57 +0200
Received: by mail-wg0-f43.google.com with SMTP id l18so1247826wgh.2
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M+t31eA0bXrRBhJGg8ji2oXa7aekpe0NwW1e0Nhi/Rs=;
        b=RxXjOKola4OrBYrtCk0+JqyOZk/psC2H7htHsZNlHnfUPQsm9LpTp28LMj2xJVABEq
         i6XWzLlYWVuUmstImcwkPtZ4jcrf1c7H0vGPsHwwQ33tvZMgRLnj+tJgab6eeyRrU7ng
         iIWxFyPa33G44Mt9Dm3hE1hBuO2wuAiz/Nhzu5nOBAfejnpI97j3y5PNmwqjMWivvK40
         1OEtsKoxNZQA7yuoIVmrmuj5uu8Fva8811Y9KTMGFUqvI+Wl7fJhyCQ0QlLwlzHKKkpV
         Rf43LqAUI98P46DzE7p9IWBsCieBsEdz4JYyUQbNBzz0gDszWq1qcpMNRv5S5nc94sld
         yEBQ==
X-Received: by 10.194.22.201 with SMTP id g9mr2512158wjf.98.1406126210106;
        Wed, 23 Jul 2014 07:36:50 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id h3sm6717751wjz.48.2014.07.23.07.36.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:36:49 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 5/6] MIPS: Alchemy: add helpers to access static memory ctrl registers.
Date:   Wed, 23 Jul 2014 16:36:25 +0200
Message-Id: <1406126186-471228-6-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

This patch changes the static memory controller registers to offsets
from base, prefixes them with AU1000_ to avoid silent failures due to
changed addresses and introduces helpers to access them.

No functional changes, comparing assembly of a few select functions shows
no differences.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/power.c           | 48 ++++++++++++++--------------
 arch/mips/alchemy/devboards/db1200.c       |  2 +-
 arch/mips/alchemy/devboards/db1300.c       |  2 +-
 arch/mips/alchemy/devboards/db1550.c       |  4 +--
 arch/mips/include/asm/mach-au1x00/au1000.h | 50 ++++++++++++++++++------------
 drivers/mtd/nand/au1550nd.c                |  8 ++---
 6 files changed, 62 insertions(+), 52 deletions(-)

diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index 2d3831b..921ed30 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -64,18 +64,18 @@ static void save_core_regs(void)
 	sleep_sys_pinfunc = alchemy_rdsys(AU1000_SYS_PINFUNC);
 
 	/* Save the static memory controller configuration. */
-	sleep_static_memctlr[0][0] = au_readl(MEM_STCFG0);
-	sleep_static_memctlr[0][1] = au_readl(MEM_STTIME0);
-	sleep_static_memctlr[0][2] = au_readl(MEM_STADDR0);
-	sleep_static_memctlr[1][0] = au_readl(MEM_STCFG1);
-	sleep_static_memctlr[1][1] = au_readl(MEM_STTIME1);
-	sleep_static_memctlr[1][2] = au_readl(MEM_STADDR1);
-	sleep_static_memctlr[2][0] = au_readl(MEM_STCFG2);
-	sleep_static_memctlr[2][1] = au_readl(MEM_STTIME2);
-	sleep_static_memctlr[2][2] = au_readl(MEM_STADDR2);
-	sleep_static_memctlr[3][0] = au_readl(MEM_STCFG3);
-	sleep_static_memctlr[3][1] = au_readl(MEM_STTIME3);
-	sleep_static_memctlr[3][2] = au_readl(MEM_STADDR3);
+	sleep_static_memctlr[0][0] = alchemy_rdsmem(AU1000_MEM_STCFG0);
+	sleep_static_memctlr[0][1] = alchemy_rdsmem(AU1000_MEM_STTIME0);
+	sleep_static_memctlr[0][2] = alchemy_rdsmem(AU1000_MEM_STADDR0);
+	sleep_static_memctlr[1][0] = alchemy_rdsmem(AU1000_MEM_STCFG1);
+	sleep_static_memctlr[1][1] = alchemy_rdsmem(AU1000_MEM_STTIME1);
+	sleep_static_memctlr[1][2] = alchemy_rdsmem(AU1000_MEM_STADDR1);
+	sleep_static_memctlr[2][0] = alchemy_rdsmem(AU1000_MEM_STCFG2);
+	sleep_static_memctlr[2][1] = alchemy_rdsmem(AU1000_MEM_STTIME2);
+	sleep_static_memctlr[2][2] = alchemy_rdsmem(AU1000_MEM_STADDR2);
+	sleep_static_memctlr[3][0] = alchemy_rdsmem(AU1000_MEM_STCFG3);
+	sleep_static_memctlr[3][1] = alchemy_rdsmem(AU1000_MEM_STTIME3);
+	sleep_static_memctlr[3][2] = alchemy_rdsmem(AU1000_MEM_STADDR3);
 }
 
 static void restore_core_regs(void)
@@ -95,18 +95,18 @@ static void restore_core_regs(void)
 	alchemy_wrsys(sleep_sys_pinfunc, AU1000_SYS_PINFUNC);
 
 	/* Restore the static memory controller configuration. */
-	au_writel(sleep_static_memctlr[0][0], MEM_STCFG0);
-	au_writel(sleep_static_memctlr[0][1], MEM_STTIME0);
-	au_writel(sleep_static_memctlr[0][2], MEM_STADDR0);
-	au_writel(sleep_static_memctlr[1][0], MEM_STCFG1);
-	au_writel(sleep_static_memctlr[1][1], MEM_STTIME1);
-	au_writel(sleep_static_memctlr[1][2], MEM_STADDR1);
-	au_writel(sleep_static_memctlr[2][0], MEM_STCFG2);
-	au_writel(sleep_static_memctlr[2][1], MEM_STTIME2);
-	au_writel(sleep_static_memctlr[2][2], MEM_STADDR2);
-	au_writel(sleep_static_memctlr[3][0], MEM_STCFG3);
-	au_writel(sleep_static_memctlr[3][1], MEM_STTIME3);
-	au_writel(sleep_static_memctlr[3][2], MEM_STADDR3);
+	alchemy_wrsmem(sleep_static_memctlr[0][0], AU1000_MEM_STCFG0);
+	alchemy_wrsmem(sleep_static_memctlr[0][1], AU1000_MEM_STTIME0);
+	alchemy_wrsmem(sleep_static_memctlr[0][2], AU1000_MEM_STADDR0);
+	alchemy_wrsmem(sleep_static_memctlr[1][0], AU1000_MEM_STCFG1);
+	alchemy_wrsmem(sleep_static_memctlr[1][1], AU1000_MEM_STTIME1);
+	alchemy_wrsmem(sleep_static_memctlr[1][2], AU1000_MEM_STADDR1);
+	alchemy_wrsmem(sleep_static_memctlr[2][0], AU1000_MEM_STCFG2);
+	alchemy_wrsmem(sleep_static_memctlr[2][1], AU1000_MEM_STTIME2);
+	alchemy_wrsmem(sleep_static_memctlr[2][2], AU1000_MEM_STADDR2);
+	alchemy_wrsmem(sleep_static_memctlr[3][0], AU1000_MEM_STCFG3);
+	alchemy_wrsmem(sleep_static_memctlr[3][1], AU1000_MEM_STTIME3);
+	alchemy_wrsmem(sleep_static_memctlr[3][2], AU1000_MEM_STADDR3);
 }
 
 void au_sleep(void)
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 408c36f..5ccfd83 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -246,7 +246,7 @@ static void au1200_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 
 static int au1200_nand_device_ready(struct mtd_info *mtd)
 {
-	return __raw_readl((void __iomem *)MEM_STSTAT) & 1;
+	return alchemy_rdsmem(AU1000_MEM_STSTAT) & 1;
 }
 
 static struct mtd_partition db1200_nand_parts[] = {
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index f3525ca..e0ed9b9 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -170,7 +170,7 @@ static void au1300_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 
 static int au1300_nand_device_ready(struct mtd_info *mtd)
 {
-	return __raw_readl((void __iomem *)MEM_STSTAT) & 1;
+	return alchemy_rdsmem(AU1000_MEM_STSTAT) & 1;
 }
 
 static struct mtd_partition db1300_nand_parts[] = {
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 392fb89..d132066 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -151,7 +151,7 @@ static void au1550_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
 
 static int au1550_nand_device_ready(struct mtd_info *mtd)
 {
-	return __raw_readl((void __iomem *)MEM_STSTAT) & 1;
+	return alchemy_rdsmem(AU1000_MEM_STSTAT) & 1;
 }
 
 static struct mtd_partition db1550_nand_parts[] = {
@@ -217,7 +217,7 @@ static struct platform_device pb1550_nand_dev = {
 
 static void __init pb1550_nand_setup(void)
 {
-	int boot_swapboot = (au_readl(MEM_STSTAT) & (0x7 << 1)) |
+	int boot_swapboot = (alchemy_rdsmem(AU1000_MEM_STSTAT) & (0x7 << 1)) |
 			    ((bcsr_read(BCSR_STATUS) >> 6) & 0x1);
 
 	gpio_direction_input(206);	/* de-assert NAND CS# */
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index c8cfca9..d664b11 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -309,25 +309,21 @@
 #define AU1550_MEM_SDSREF		0x08D0
 #define AU1550_MEM_SDSLEEP		MEM_SDSREF
 
-/* Static Bus Controller */
-#define MEM_STCFG0		0xB4001000
-#define MEM_STTIME0		0xB4001004
-#define MEM_STADDR0		0xB4001008
-
-#define MEM_STCFG1		0xB4001010
-#define MEM_STTIME1		0xB4001014
-#define MEM_STADDR1		0xB4001018
-
-#define MEM_STCFG2		0xB4001020
-#define MEM_STTIME2		0xB4001024
-#define MEM_STADDR2		0xB4001028
-
-#define MEM_STCFG3		0xB4001030
-#define MEM_STTIME3		0xB4001034
-#define MEM_STADDR3		0xB4001038
-
-#define MEM_STNDCTL		0xB4001100
-#define MEM_STSTAT		0xB4001104
+/* Static Bus Controller register offsets */
+#define AU1000_MEM_STCFG0	0x000
+#define AU1000_MEM_STTIME0	0x004
+#define AU1000_MEM_STADDR0	0x008
+#define AU1000_MEM_STCFG1	0x010
+#define AU1000_MEM_STTIME1	0x014
+#define AU1000_MEM_STADDR1	0x018
+#define AU1000_MEM_STCFG2	0x020
+#define AU1000_MEM_STTIME2	0x024
+#define AU1000_MEM_STADDR2	0x028
+#define AU1000_MEM_STCFG3	0x030
+#define AU1000_MEM_STTIME3	0x034
+#define AU1000_MEM_STADDR3	0x038
+#define AU1000_MEM_STNDCTL	0x100
+#define AU1000_MEM_STSTAT	0x104
 
 #define MEM_STNAND_CMD		0x0
 #define MEM_STNAND_ADDR		0x4
@@ -713,6 +709,22 @@ static inline void alchemy_wrsys(unsigned long v, int regofs)
 	wmb(); /* drain writebuffer */
 }
 
+/* helpers to access static memctrl registers */
+static inline unsigned long alchemy_rdsmem(int regofs)
+{
+	void __iomem *b = (void __iomem *)KSEG1ADDR(AU1000_STATIC_MEM_PHYS_ADDR);
+
+	return __raw_readl(b + regofs);
+}
+
+static inline void alchemy_wrsmem(unsigned long v, int regofs)
+{
+	void __iomem *b = (void __iomem *)KSEG1ADDR(AU1000_STATIC_MEM_PHYS_ADDR);
+
+	__raw_writel(v, b + regofs);
+	wmb(); /* drain writebuffer */
+}
+
 /* Early Au1000 have a write-only SYS_CPUPLL register. */
 static inline int au1xxx_cpu_has_pll_wo(void)
 {
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index bc5c518..6cece6e 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -223,12 +223,12 @@ static void au1550_hwcontrol(struct mtd_info *mtd, int cmd)
 
 	case NAND_CTL_SETNCE:
 		/* assert (force assert) chip enable */
-		au_writel((1 << (4 + ctx->cs)), MEM_STNDCTL);
+		alchemy_wrsmem((1 << (4 + ctx->cs)), AU1000_MEM_STNDCTL);
 		break;
 
 	case NAND_CTL_CLRNCE:
 		/* deassert chip enable */
-		au_writel(0, MEM_STNDCTL);
+		alchemy_wrsmem(0, AU1000_MEM_STNDCTL);
 		break;
 	}
 
@@ -240,9 +240,7 @@ static void au1550_hwcontrol(struct mtd_info *mtd, int cmd)
 
 int au1550_device_ready(struct mtd_info *mtd)
 {
-	int ret = (au_readl(MEM_STSTAT) & 0x1) ? 1 : 0;
-	au_sync();
-	return ret;
+	return (alchemy_rdsmem(AU1000_MEM_STSTAT) & 0x1) ? 1 : 0;
 }
 
 /**
-- 
2.0.1
