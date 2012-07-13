Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 10:47:56 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:54946 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903474Ab2GMIra (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2012 10:47:30 +0200
Received: by bkcji2 with SMTP id ji2so2825825bkc.36
        for <multiple recipients>; Fri, 13 Jul 2012 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qTJAs01VSMmr5k+FyJOoO25VGprtdyTTVdKB4fsS6DI=;
        b=tzoRxTEQOkVhFVdcXoI1adSu1A324wirdesk7uL/qgYk+ESeO5OEJkfraKmpzL2kkY
         Yi9d40sX8E81rOeKWWWtqQ0jMg66DOGdr/7kMCwmC6KZ1uyFQCHT+9KPqoyZ+9vFk7k2
         33ZMMzmCu+OPcRwgK0yTW7Q+Ux/jGDuF8PP3m5Za8NvI50AMxZK3YJyAuvW5cfu8YMBX
         OVtfPywLatJ5H1xc5JoFysMvBkrJvNJYhNUhf/BjhuPQJCucJzvTCxJCDsPUWGpvVrLV
         vUkMMaI0CIquHYlcE66XdRaIi4waCCocuqRXMEXeE98414wt+H8CziurTmXlOHQLN6d2
         i32A==
Received: by 10.204.130.10 with SMTP id q10mr156633bks.90.1342169244788;
        Fri, 13 Jul 2012 01:47:24 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-145-009.pools.arcor-ip.net. [88.73.145.9])
        by mx.google.com with ESMTPS id hg13sm4243506bkc.7.2012.07.13.01.47.23
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jul 2012 01:47:23 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/3] MIPS: BCM63XX: add external irq support for BCM6345
Date:   Fri, 13 Jul 2012 10:46:03 +0200
Message-Id: <1342169165-18382-2-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1342169165-18382-1-git-send-email-jonas.gorski@gmail.com>
References: <1342169165-18382-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 33904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Maxime Bizon <mbizon@freebox.fr>

Add the missing definitions for BCM6345.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/irq.c                           |    8 ++++++--
 arch/mips/bcm63xx/setup.c                         |    3 +++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 18e051a..d40169f 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -56,8 +56,8 @@ static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
 #define is_ext_irq_cascaded	0
 #define ext_irq_start		0
 #define ext_irq_end		0
-#define ext_irq_count		0
-#define ext_irq_cfg_reg1	0
+#define ext_irq_count		4
+#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6345
 #define ext_irq_cfg_reg2	0
 #endif
 #ifdef CONFIG_BCM63XX_CPU_6348
@@ -143,11 +143,15 @@ static void bcm63xx_init_irq(void)
 		irq_stat_addr += PERF_IRQSTAT_6338_REG;
 		irq_mask_addr += PERF_IRQMASK_6338_REG;
 		irq_bits = 32;
+		ext_irq_count = 4;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6338;
 		break;
 	case BCM6345_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6345_REG;
 		irq_mask_addr += PERF_IRQMASK_6345_REG;
 		irq_bits = 32;
+		ext_irq_count = 4;
+		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6345;
 		break;
 	case BCM6348_CPU_ID:
 		irq_stat_addr += PERF_IRQSTAT_6348_REG;
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 0e74a13..bd83836 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -74,6 +74,9 @@ void bcm63xx_machine_reboot(void)
 	case BCM6338_CPU_ID:
 		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6338;
 		break;
+	case BCM6345_CPU_ID:
+		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6345;
+		break;
 	case BCM6348_CPU_ID:
 		perf_regs[0] = PERF_EXTIRQ_CFG_REG_6348;
 		break;
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 4ccc2a7..75f162d 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -161,6 +161,7 @@
 /* External Interrupt Configuration register */
 #define PERF_EXTIRQ_CFG_REG_6328	0x18
 #define PERF_EXTIRQ_CFG_REG_6338	0x14
+#define PERF_EXTIRQ_CFG_REG_6345	0x14
 #define PERF_EXTIRQ_CFG_REG_6348	0x14
 #define PERF_EXTIRQ_CFG_REG_6358	0x14
 #define PERF_EXTIRQ_CFG_REG_6368	0x18
-- 
1.7.2.5
