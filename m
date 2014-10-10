Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 05:40:45 +0200 (CEST)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44327 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010245AbaJJDkaDJaci (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 05:40:30 +0200
Received: by mail-pd0-f171.google.com with SMTP id ft15so872948pdb.16
        for <multiple recipients>; Thu, 09 Oct 2014 20:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kt8KmYUtiqKtYwz3E+gtgIyzYUib3aJ7lalemD45TYE=;
        b=CKJr5M5LWi6eBrbfslkbr8d2KRXoi1xfOS2SMse39rgSZDQzCHS1cPzjffZKoDjjp9
         ZHzTs5Mjo/4DQYirge1RE5sskNxdXA2qW8mLECPerq4HG7oMT1ZdIvgEF/qhVpJUlBFy
         7Nd8IPmV1vJTxa1qc/2n/keONDxlhdymW7KiqAO8N/gnjoON0R+AIZmIRa6b6AhRSPxU
         LfOKHOxr6IJS9HHQv/fyKVSXUHTtDOC8WyYDXECIkrHWTk2U44oeCrnbYPitokhGUFUO
         AMTpwGiJWvMXSFaHG8WDd5A2eNV407leFtzdxc6nexF66qgA7RcSJ15hCVxWmLRxVzvu
         GGWA==
X-Received: by 10.66.220.40 with SMTP id pt8mr2251667pac.108.1412912423686;
        Thu, 09 Oct 2014 20:40:23 -0700 (PDT)
Received: from localhost.localdomain ([171.213.62.98])
        by mx.google.com with ESMTPSA id sa6sm1563051pbb.29.2014.10.09.20.40.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Oct 2014 20:40:22 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 1/6] MIPS: Loongson1B: Fix reboot problem on LS1B
Date:   Fri, 10 Oct 2014 11:39:59 +0800
Message-Id: <1412912402-6002-2-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412912402-6002-1-git-send-email-keguang.zhang@gmail.com>
References: <1412912402-6002-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

 - Correct the header file of watchdog registers
 - Use ioremap_nocache() to access watchdog registers instead

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/include/asm/mach-loongson1/regs-wdt.h | 11 ++++-------
 arch/mips/loongson1/common/reset.c              | 20 ++++++++++++++------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson1/regs-wdt.h b/arch/mips/include/asm/mach-loongson1/regs-wdt.h
index 6574568..c39ee98 100644
--- a/arch/mips/include/asm/mach-loongson1/regs-wdt.h
+++ b/arch/mips/include/asm/mach-loongson1/regs-wdt.h
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
  *
- * Loongson 1 watchdog register definitions.
+ * Loongson 1 Watchdog Register Definitions.
  *
  * This program is free software; you can redistribute	it and/or modify it
  * under  the terms of	the GNU General	 Public License as published by the
@@ -12,11 +12,8 @@
 #ifndef __ASM_MACH_LOONGSON1_REGS_WDT_H
 #define __ASM_MACH_LOONGSON1_REGS_WDT_H
 
-#define LS1X_WDT_REG(x) \
-		((void __iomem *)KSEG1ADDR(LS1X_WDT_BASE + (x)))
-
-#define LS1X_WDT_EN			LS1X_WDT_REG(0x0)
-#define LS1X_WDT_SET			LS1X_WDT_REG(0x4)
-#define LS1X_WDT_TIMER			LS1X_WDT_REG(0x8)
+#define WDT_EN			0x0
+#define WDT_TIMER		0x4
+#define WDT_SET			0x8
 
 #endif /* __ASM_MACH_LOONGSON1_REGS_WDT_H */
diff --git a/arch/mips/loongson1/common/reset.c b/arch/mips/loongson1/common/reset.c
index 547f34b..c41e4ca 100644
--- a/arch/mips/loongson1/common/reset.c
+++ b/arch/mips/loongson1/common/reset.c
@@ -14,12 +14,7 @@
 
 #include <loongson1.h>
 
-static void ls1x_restart(char *command)
-{
-	__raw_writel(0x1, LS1X_WDT_EN);
-	__raw_writel(0x5000000, LS1X_WDT_TIMER);
-	__raw_writel(0x1, LS1X_WDT_SET);
-}
+static void __iomem *wdt_base;
 
 static void ls1x_halt(void)
 {
@@ -29,6 +24,15 @@ static void ls1x_halt(void)
 	}
 }
 
+static void ls1x_restart(char *command)
+{
+	__raw_writel(0x1, wdt_base + WDT_EN);
+	__raw_writel(0x1, wdt_base + WDT_TIMER);
+	__raw_writel(0x1, wdt_base + WDT_SET);
+
+	ls1x_halt();
+}
+
 static void ls1x_power_off(void)
 {
 	ls1x_halt();
@@ -36,6 +40,10 @@ static void ls1x_power_off(void)
 
 static int __init ls1x_reboot_setup(void)
 {
+	wdt_base = ioremap_nocache(LS1X_WDT_BASE, 0x0f);
+	if (!wdt_base)
+		panic("Failed to remap watchdog registers");
+
 	_machine_restart = ls1x_restart;
 	_machine_halt = ls1x_halt;
 	pm_power_off = ls1x_power_off;
-- 
1.9.1
