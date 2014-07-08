Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 16:57:14 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37322 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861348AbaGHOyHBGj1n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jul 2014 16:54:07 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 5A95E28B44E;
        Tue,  8 Jul 2014 16:52:02 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (p5081183E.dip0.t-ipconnect.de [80.129.24.62])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 507DA28BB84;
        Tue,  8 Jul 2014 16:51:32 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 8/8] MIPS: BCM63XX: remove !RUNTIME_DETECT code for bcmcpu_get_id
Date:   Tue,  8 Jul 2014 16:53:24 +0200
Message-Id: <1404831204-30659-9-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
References: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41083
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

Use the same pattern as with get_*_cpu_type() to allow the compiler
to remove code for non enabled SoC types.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/cpu.c                          |  11 +--
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h | 120 +++++++----------------
 2 files changed, 38 insertions(+), 93 deletions(-)

diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index fd4e76c..536f644 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -24,7 +24,9 @@ EXPORT_SYMBOL(bcm63xx_regs_base);
 const int *bcm63xx_irqs;
 EXPORT_SYMBOL(bcm63xx_irqs);
 
-static u16 bcm63xx_cpu_id;
+u16 bcm63xx_cpu_id __read_mostly;
+EXPORT_SYMBOL(bcm63xx_cpu_id);
+
 static u8 bcm63xx_cpu_rev;
 static unsigned int bcm63xx_cpu_freq;
 static unsigned int bcm63xx_memory_size;
@@ -97,13 +99,6 @@ static const int bcm6368_irqs[] = {
 
 };
 
-u16 __bcm63xx_get_cpu_id(void)
-{
-	return bcm63xx_cpu_id;
-}
-
-EXPORT_SYMBOL(__bcm63xx_get_cpu_id);
-
 u8 bcm63xx_get_cpu_rev(void)
 {
 	return bcm63xx_cpu_rev;
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 4d76fc7..56bb192 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -19,118 +19,68 @@
 #define BCM6368_CPU_ID		0x6368
 
 void __init bcm63xx_cpu_init(void);
-u16 __bcm63xx_get_cpu_id(void);
 u8 bcm63xx_get_cpu_rev(void);
 unsigned int bcm63xx_get_cpu_freq(void);
 
+static inline u16 __pure __bcm63xx_get_cpu_id(const u16 cpu_id)
+{
+	switch (cpu_id) {
 #ifdef CONFIG_BCM63XX_CPU_3368
-# ifdef bcm63xx_get_cpu_id
-#  undef bcm63xx_get_cpu_id
-#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
-#  define BCMCPU_RUNTIME_DETECT
-# else
-#  define bcm63xx_get_cpu_id()	BCM3368_CPU_ID
-# endif
-# define BCMCPU_IS_3368()	(bcm63xx_get_cpu_id() == BCM3368_CPU_ID)
-#else
-# define BCMCPU_IS_3368()	(0)
+		case BCM3368_CPU_ID:
 #endif
 
 #ifdef CONFIG_BCM63XX_CPU_6328
-# ifdef bcm63xx_get_cpu_id
-#  undef bcm63xx_get_cpu_id
-#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
-#  define BCMCPU_RUNTIME_DETECT
-# else
-#  define bcm63xx_get_cpu_id()	BCM6328_CPU_ID
-# endif
-# define BCMCPU_IS_6328()	(bcm63xx_get_cpu_id() == BCM6328_CPU_ID)
-#else
-# define BCMCPU_IS_6328()	(0)
+		case BCM6328_CPU_ID:
 #endif
 
 #ifdef CONFIG_BCM63XX_CPU_6338
-# ifdef bcm63xx_get_cpu_id
-#  undef bcm63xx_get_cpu_id
-#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
-#  define BCMCPU_RUNTIME_DETECT
-# else
-#  define bcm63xx_get_cpu_id()	BCM6338_CPU_ID
-# endif
-# define BCMCPU_IS_6338()	(bcm63xx_get_cpu_id() == BCM6338_CPU_ID)
-#else
-# define BCMCPU_IS_6338()	(0)
+		case BCM6338_CPU_ID:
 #endif
 
 #ifdef CONFIG_BCM63XX_CPU_6345
-# ifdef bcm63xx_get_cpu_id
-#  undef bcm63xx_get_cpu_id
-#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
-#  define BCMCPU_RUNTIME_DETECT
-# else
-#  define bcm63xx_get_cpu_id()	BCM6345_CPU_ID
-# endif
-# define BCMCPU_IS_6345()	(bcm63xx_get_cpu_id() == BCM6345_CPU_ID)
-#else
-# define BCMCPU_IS_6345()	(0)
+		case BCM6345_CPU_ID:
 #endif
 
 #ifdef CONFIG_BCM63XX_CPU_6348
-# ifdef bcm63xx_get_cpu_id
-#  undef bcm63xx_get_cpu_id
-#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
-#  define BCMCPU_RUNTIME_DETECT
-# else
-#  define bcm63xx_get_cpu_id()	BCM6348_CPU_ID
-# endif
-# define BCMCPU_IS_6348()	(bcm63xx_get_cpu_id() == BCM6348_CPU_ID)
-#else
-# define BCMCPU_IS_6348()	(0)
+		case BCM6348_CPU_ID:
 #endif
 
 #ifdef CONFIG_BCM63XX_CPU_6358
-# ifdef bcm63xx_get_cpu_id
-#  undef bcm63xx_get_cpu_id
-#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
-#  define BCMCPU_RUNTIME_DETECT
-# else
-#  define bcm63xx_get_cpu_id()	BCM6358_CPU_ID
-# endif
-# define BCMCPU_IS_6358()	(bcm63xx_get_cpu_id() == BCM6358_CPU_ID)
-#else
-# define BCMCPU_IS_6358()	(0)
+		case BCM6358_CPU_ID:
 #endif
 
 #ifdef CONFIG_BCM63XX_CPU_6362
-# ifdef bcm63xx_get_cpu_id
-#  undef bcm63xx_get_cpu_id
-#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
-#  define BCMCPU_RUNTIME_DETECT
-# else
-#  define bcm63xx_get_cpu_id()	BCM6362_CPU_ID
-# endif
-# define BCMCPU_IS_6362()	(bcm63xx_get_cpu_id() == BCM6362_CPU_ID)
-#else
-# define BCMCPU_IS_6362()	(0)
+		case BCM6362_CPU_ID:
 #endif
 
-
 #ifdef CONFIG_BCM63XX_CPU_6368
-# ifdef bcm63xx_get_cpu_id
-#  undef bcm63xx_get_cpu_id
-#  define bcm63xx_get_cpu_id()	__bcm63xx_get_cpu_id()
-#  define BCMCPU_RUNTIME_DETECT
-# else
-#  define bcm63xx_get_cpu_id()	BCM6368_CPU_ID
-# endif
-# define BCMCPU_IS_6368()	(bcm63xx_get_cpu_id() == BCM6368_CPU_ID)
-#else
-# define BCMCPU_IS_6368()	(0)
+		case BCM6368_CPU_ID:
 #endif
+		break;
+	default:
+		unreachable();
+	}
 
-#ifndef bcm63xx_get_cpu_id
-#error "No CPU support configured"
-#endif
+	return cpu_id;
+}
+
+extern u16 bcm63xx_cpu_id;
+
+static inline u16 __pure bcm63xx_get_cpu_id(void)
+{
+	const u16 cpu_id = bcm63xx_cpu_id;
+
+	return __bcm63xx_get_cpu_id(cpu_id);
+}
+
+#define BCMCPU_IS_3368()	(bcm63xx_get_cpu_id() == BCM3368_CPU_ID)
+#define BCMCPU_IS_6328()	(bcm63xx_get_cpu_id() == BCM6328_CPU_ID)
+#define BCMCPU_IS_6338()	(bcm63xx_get_cpu_id() == BCM6338_CPU_ID)
+#define BCMCPU_IS_6345()	(bcm63xx_get_cpu_id() == BCM6345_CPU_ID)
+#define BCMCPU_IS_6348()	(bcm63xx_get_cpu_id() == BCM6348_CPU_ID)
+#define BCMCPU_IS_6358()	(bcm63xx_get_cpu_id() == BCM6358_CPU_ID)
+#define BCMCPU_IS_6362()	(bcm63xx_get_cpu_id() == BCM6362_CPU_ID)
+#define BCMCPU_IS_6368()	(bcm63xx_get_cpu_id() == BCM6368_CPU_ID)
 
 /*
  * While registers sets are (mostly) the same across 63xx CPU, base
-- 
2.0.0
