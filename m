Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 13:28:38 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34544 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009438AbbJNL2gXFOry (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2015 13:28:36 +0200
Received: by padda3 with SMTP id da3so3028338pad.1;
        Wed, 14 Oct 2015 04:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sXIDpVp86Lf+5UnWsXJPsTZAaxH1TJc2T6E15KzzIi0=;
        b=k5+fz7aKIZhbUM4go1PrwXtfAXi9SIqp3Fd3U9ymGDa6OfctSZTOd7k06rw8yqKCe+
         ifOxeKesx5f/tKtv9XoniaHN72g+iy0Gkvd2XmHti6fgTOkOoaDbWxtYVhenbwOEq3+0
         FslQ9Cvg9fl5Bz89l6+x4FhFPFVgMGD1tRBXgQUtfWS2Rt6MIYlGLD30x5GgHYm+ODoZ
         M+vM+y1leadp74kXMSNjOaEnhjr4sS3y6YpvfRJD02vhoYMD+Mh4lh7qmBTXMSr4RcKJ
         c/S4QwRJyPz2pSMNHJpm2FLN7LJsrA09VXb9u0qkRpys/fxInrLbD3b8qZGZ686yv2DV
         zKZw==
X-Received: by 10.66.144.165 with SMTP id sn5mr3326343pab.122.1444822110133;
        Wed, 14 Oct 2015 04:28:30 -0700 (PDT)
Received: from corellia.google.com (cpe-98-148-132-5.socal.res.rr.com. [98.148.132.5])
        by smtp.gmail.com with ESMTPSA id po7sm9155057pbc.56.2015.10.14.04.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2015 04:28:29 -0700 (PDT)
From:   Gregory Fong <gregory.0xf0@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        Nicolas Schichan <nschichan@freebox.fr>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>, Joe Perches <joe@perches.com>
Subject: [PATCH v2] MIPS: BCM63XX: Use pr_* instead of printk
Date:   Wed, 14 Oct 2015 04:27:38 -0700
Message-Id: <1444822058-7410-1-git-send-email-gregory.0xf0@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <gregory.0xf0@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49535
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
Cc: Joe Perches <joe@perches.com>
---
v1->v2: Address Joe's comments on v1 (see
http://lkml.iu.edu/hypermail/linux/kernel/1508.3/03472.html )

 arch/mips/bcm63xx/boards/board_bcm963xx.c | 14 +++++++-------
 arch/mips/bcm63xx/cpu.c                   | 12 ++++++------
 arch/mips/bcm63xx/dev-pcmcia.c            |  2 +-
 arch/mips/bcm63xx/irq.c                   |  2 +-
 arch/mips/bcm63xx/setup.c                 |  8 ++++----
 arch/mips/bcm63xx/timer.c                 |  2 +-
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 33727e7..b2097c0 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
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
+		pr_err("unable to fill SPROM for given bustype\n");
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
 
@@ -808,8 +809,7 @@ void __init board_prom_init(void)
 		char name[17];
 		memcpy(name, board_name, 16);
 		name[16] = 0;
-		printk(KERN_ERR PFX "unknown bcm963xx board: %s\n",
-		       name);
+		pr_err("unknown bcm963xx board: %s\n", name);
 		return;
 	}
 
@@ -854,7 +854,7 @@ void __init board_setup(void)
 {
 	if (!board.name[0])
 		panic("unable to detect bcm963xx board");
-	printk(KERN_INFO PFX "board name: %s\n", board.name);
+	pr_info("board name: %s\n", board.name);
 
 	/* make sure we're running on expected cpu */
 	if (bcm63xx_get_cpu_id() != board.expected_cpu_id)
@@ -910,7 +910,7 @@ int __init board_register_devices(void)
 		memcpy(bcm63xx_sprom.et1mac, bcm63xx_sprom.il0mac, ETH_ALEN);
 		if (ssb_arch_register_fallback_sprom(
 				&bcm63xx_get_fallback_sprom) < 0)
-			pr_err(PFX "failed to register fallback SPROM\n");
+			pr_err("failed to register fallback SPROM\n");
 	}
 #endif
 
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 307ec8b..1c7c3fb 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -376,10 +376,10 @@ void __init bcm63xx_cpu_init(void)
 	bcm63xx_cpu_freq = detect_cpu_clock();
 	bcm63xx_memory_size = detect_memory_size();
 
-	printk(KERN_INFO "Detected Broadcom 0x%04x CPU revision %02x\n",
-	       bcm63xx_cpu_id, bcm63xx_cpu_rev);
-	printk(KERN_INFO "CPU frequency is %u MHz\n",
-	       bcm63xx_cpu_freq / 1000000);
-	printk(KERN_INFO "%uMB of RAM installed\n",
-	       bcm63xx_memory_size >> 20);
+	pr_info("Detected Broadcom 0x%04x CPU revision %02x\n",
+		bcm63xx_cpu_id, bcm63xx_cpu_rev);
+	pr_info("CPU frequency is %u MHz\n",
+		bcm63xx_cpu_freq / 1000000);
+	pr_info("%uMB of RAM installed\n",
+		bcm63xx_memory_size >> 20);
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
index 1a47ec2..c961390 100644
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
index 5f11359..2110359 100644
--- a/arch/mips/bcm63xx/timer.c
+++ b/arch/mips/bcm63xx/timer.c
@@ -195,7 +195,7 @@ int bcm63xx_timer_init(void)
 	irq = bcm63xx_get_irq_number(IRQ_TIMER);
 	ret = request_irq(irq, timer_interrupt, 0, "bcm63xx_timer", NULL);
 	if (ret) {
-		printk(KERN_ERR "bcm63xx_timer: failed to register irq\n");
+		pr_err("%s: failed to register irq\n", __func__);
 		return ret;
 	}
 
-- 
1.9.1
