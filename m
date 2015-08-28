Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2015 03:30:27 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33800 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013231AbbH1BaSqOxKj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2015 03:30:18 +0200
Received: by pabzx8 with SMTP id zx8so43950790pab.1;
        Thu, 27 Aug 2015 18:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TDY35R3wzYcIVB9qpoGtMSqHsQ3i5wDDeQYBy3FdgX0=;
        b=xyGm3bVOqZQM1MMeoxo6dW1XGGYfNKF9XItmjK8sX0mXKLyp12rDjhba1jHZxjIGCv
         Sp+DAAyhaG8nX+g75pgafspZRqfh1jmnpB83QhmZT4NeK1KAoGRKal/RzH/MscIZ0FLi
         XCk3Zbf1GKTZAlXNze/5gi7B9vNpnho13FfFqT5Q3a0Olnz/NQLPlaTE+hkaj+eapOnG
         Yv3yiGqpM8u7Qf8ZS10ommMNmrCHl94sAOsfAFvfTy6cCOiDWuJCkdYR1hri9Hki0AV8
         +w+bmly3sm2ZOBKnvLvvSYOQC7dQC72VeBAr80bKSVETjBlZYbd8+IPqTSQpfK3DSOBv
         v2bA==
X-Received: by 10.66.141.231 with SMTP id rr7mr11205804pab.11.1440725412755;
        Thu, 27 Aug 2015 18:30:12 -0700 (PDT)
Received: from gregory-irv-00.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id hy5sm3778919pac.22.2015.08.27.18.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2015 18:30:12 -0700 (PDT)
From:   Gregory Fong <gregory.0xf0@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Nicolas Schichan <nschichan@freebox.fr>,
        linux-mips@linux-mips.org (open list:MIPS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MIPS: BCM63XX: Use pr_* instead of printk
Date:   Thu, 27 Aug 2015 18:30:02 -0700
Message-Id: <1440725410-2082-1-git-send-email-gregory.0xf0@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <gregory.0xf0@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregory.0xf0@gmail.com
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

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c | 11 ++++++-----
 arch/mips/bcm63xx/cpu.c                   |  6 +++---
 arch/mips/bcm63xx/dev-pcmcia.c            |  2 +-
 arch/mips/bcm63xx/irq.c                   |  2 +-
 arch/mips/bcm63xx/setup.c                 |  8 ++++----
 arch/mips/bcm63xx/timer.c                 |  2 +-
 6 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 33727e7..7e001d3 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
  */
 
+#define pr_fmt(fmt) "board_bcm963xx: " fmt
+
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -31,7 +33,6 @@
 
 #include <uapi/linux/bcm933xx_hcs.h>
 
-#define PFX	"board_bcm963xx: "
 
 #define HCS_OFFSET_128K			0x20000
 
@@ -740,7 +741,7 @@ int bcm63xx_get_fallback_sprom(struct ssb_bus *bus, struct ssb_sprom *out)
 		memcpy(out, &bcm63xx_sprom, sizeof(struct ssb_sprom));
 		return 0;
 	} else {
-		printk(KERN_ERR PFX "unable to fill SPROM for given bustype.\n");
+		pr_err("unable to fill SPROM for given bustype.\n");
 		return -EINVAL;
 	}
 }
@@ -784,7 +785,7 @@ void __init board_prom_init(void)
 			 cfe[5], cfe[6], cfe[7], cfe[8], cfe[9]);
 	else
 		strcpy(cfe_version, "unknown");
-	printk(KERN_INFO PFX "CFE version: %s\n", cfe_version);
+	pr_info("CFE version: %s\n", cfe_version);
 
 	bcm63xx_nvram_init(boot_addr + BCM963XX_NVRAM_OFFSET);
 
@@ -808,7 +809,7 @@ void __init board_prom_init(void)
 		char name[17];
 		memcpy(name, board_name, 16);
 		name[16] = 0;
-		printk(KERN_ERR PFX "unknown bcm963xx board: %s\n",
+		pr_err("unknown bcm963xx board: %s\n",
 		       name);
 		return;
 	}
@@ -854,7 +855,7 @@ void __init board_setup(void)
 {
 	if (!board.name[0])
 		panic("unable to detect bcm963xx board");
-	printk(KERN_INFO PFX "board name: %s\n", board.name);
+	pr_info("board name: %s\n", board.name);
 
 	/* make sure we're running on expected cpu */
 	if (bcm63xx_get_cpu_id() != board.expected_cpu_id)
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 307ec8b..57dfe7c 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -376,10 +376,10 @@ void __init bcm63xx_cpu_init(void)
 	bcm63xx_cpu_freq = detect_cpu_clock();
 	bcm63xx_memory_size = detect_memory_size();
 
-	printk(KERN_INFO "Detected Broadcom 0x%04x CPU revision %02x\n",
+	pr_info("Detected Broadcom 0x%04x CPU revision %02x\n",
 	       bcm63xx_cpu_id, bcm63xx_cpu_rev);
-	printk(KERN_INFO "CPU frequency is %u MHz\n",
+	pr_info("CPU frequency is %u MHz\n",
 	       bcm63xx_cpu_freq / 1000000);
-	printk(KERN_INFO "%uMB of RAM installed\n",
+	pr_info("%uMB of RAM installed\n",
 	       bcm63xx_memory_size >> 20);
 }
diff --git a/arch/mips/bcm63xx/dev-pcmcia.c b/arch/mips/bcm63xx/dev-pcmcia.c
index a551bab..9496cd2 100644
--- a/arch/mips/bcm63xx/dev-pcmcia.c
+++ b/arch/mips/bcm63xx/dev-pcmcia.c
@@ -139,6 +139,6 @@ int __init bcm63xx_pcmcia_register(void)
 	return platform_device_register(&bcm63xx_pcmcia_device);
 
 out_err:
-	printk(KERN_ERR "unable to set pcmcia chip select\n");
+	pr_err("unable to set pcmcia chip select\n");
 	return ret;
 }
diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index e3e808a..99d3d14 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -311,7 +311,7 @@ static int bcm63xx_external_irq_set_type(struct irq_data *d,
 		break;
 
 	default:
-		printk(KERN_ERR "bogus flow type combination given !\n");
+		pr_err("bogus flow type combination given !\n");
 		return -EINVAL;
 	}
 
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 240fb4f..2be9caa 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -24,7 +24,7 @@
 
 void bcm63xx_machine_halt(void)
 {
-	printk(KERN_INFO "System halted\n");
+	pr_info("System halted\n");
 	while (1)
 		;
 }
@@ -34,7 +34,7 @@ static void bcm6348_a1_reboot(void)
 	u32 reg;
 
 	/* soft reset all blocks */
-	printk(KERN_INFO "soft-resetting all blocks ...\n");
+	pr_info("soft-resetting all blocks ...\n");
 	reg = bcm_perf_readl(PERF_SOFTRESET_REG);
 	reg &= ~SOFTRESET_6348_ALL;
 	bcm_perf_writel(reg, PERF_SOFTRESET_REG);
@@ -46,7 +46,7 @@ static void bcm6348_a1_reboot(void)
 	mdelay(10);
 
 	/* Jump to the power on address. */
-	printk(KERN_INFO "jumping to reset vector.\n");
+	pr_info("jumping to reset vector.\n");
 	/* set high vectors (base at 0xbfc00000 */
 	set_c0_status(ST0_BEV | ST0_ERL);
 	/* run uncached in kseg0 */
@@ -110,7 +110,7 @@ void bcm63xx_machine_reboot(void)
 	if (BCMCPU_IS_6348() && (bcm63xx_get_cpu_rev() == 0xa1))
 		bcm6348_a1_reboot();
 
-	printk(KERN_INFO "triggering watchdog soft-reset...\n");
+	pr_info("triggering watchdog soft-reset...\n");
 	if (BCMCPU_IS_6328()) {
 		bcm_wdt_writel(1, WDT_SOFTRESET_REG);
 	} else {
diff --git a/arch/mips/bcm63xx/timer.c b/arch/mips/bcm63xx/timer.c
index 5f11359..bedc497 100644
--- a/arch/mips/bcm63xx/timer.c
+++ b/arch/mips/bcm63xx/timer.c
@@ -195,7 +195,7 @@ int bcm63xx_timer_init(void)
 	irq = bcm63xx_get_irq_number(IRQ_TIMER);
 	ret = request_irq(irq, timer_interrupt, 0, "bcm63xx_timer", NULL);
 	if (ret) {
-		printk(KERN_ERR "bcm63xx_timer: failed to register irq\n");
+		pr_err("bcm63xx_timer: failed to register irq\n");
 		return ret;
 	}
 
-- 
1.9.1
