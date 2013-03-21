Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 16:04:13 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37245 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823083Ab3CUPDwm24PO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Mar 2013 16:03:52 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U8lAJp_x-XXG; Thu, 21 Mar 2013 16:03:19 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 87CBE2815AD;
        Thu, 21 Mar 2013 16:03:19 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/7] MIPS: BCM63XX: fix revision ID width
Date:   Thu, 21 Mar 2013 16:03:15 +0100
Message-Id: <1363878200-4523-2-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1363878200-4523-1-git-send-email-jogo@openwrt.org>
References: <1363878001-4461-1-git-send-email-jogo@openwrt.org>
 <1363878200-4523-1-git-send-email-jogo@openwrt.org>
X-archive-position: 35930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

The REVID is only 8 bit wide.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/cpu.c                           |    4 ++--
 arch/mips/bcm63xx/setup.c                         |    2 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |    2 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index a7afb28..ae16626 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -25,7 +25,7 @@ const int *bcm63xx_irqs;
 EXPORT_SYMBOL(bcm63xx_irqs);
 
 static u16 bcm63xx_cpu_id;
-static u16 bcm63xx_cpu_rev;
+static u8 bcm63xx_cpu_rev;
 static unsigned int bcm63xx_cpu_freq;
 static unsigned int bcm63xx_memory_size;
 
@@ -87,7 +87,7 @@ u16 __bcm63xx_get_cpu_id(void)
 
 EXPORT_SYMBOL(__bcm63xx_get_cpu_id);
 
-u16 bcm63xx_get_cpu_rev(void)
+u8 bcm63xx_get_cpu_rev(void)
 {
 	return bcm63xx_cpu_rev;
 }
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 35e18e9..911fd7d 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -126,7 +126,7 @@ static void __bcm63xx_machine_reboot(char *p)
 const char *get_system_type(void)
 {
 	static char buf[128];
-	snprintf(buf, sizeof(buf), "bcm63xx/%s (0x%04x/0x%04X)",
+	snprintf(buf, sizeof(buf), "bcm63xx/%s (0x%04x/0x%02X)",
 		 board_get_name(),
 		 bcm63xx_get_cpu_id(), bcm63xx_get_cpu_rev());
 	return buf;
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index cb922b9..19a80ea 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -18,7 +18,7 @@
 
 void __init bcm63xx_cpu_init(void);
 u16 __bcm63xx_get_cpu_id(void);
-u16 bcm63xx_get_cpu_rev(void);
+u8 bcm63xx_get_cpu_rev(void);
 unsigned int bcm63xx_get_cpu_freq(void);
 
 #ifdef CONFIG_BCM63XX_CPU_6328
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index acd1f93..fe3601a 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -10,7 +10,7 @@
 #define REV_CHIPID_SHIFT		16
 #define REV_CHIPID_MASK			(0xffff << REV_CHIPID_SHIFT)
 #define REV_REVID_SHIFT			0
-#define REV_REVID_MASK			(0xffff << REV_REVID_SHIFT)
+#define REV_REVID_MASK			(0xff << REV_REVID_SHIFT)
 
 /* Clock Control register */
 #define PERF_CKCTL_REG			0x4
-- 
1.7.10.4
