Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2014 02:26:09 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35993 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822421AbaDMAZHwJu3N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Apr 2014 02:25:07 +0200
Received: by mail-pa0-f42.google.com with SMTP id fb1so6907024pad.1
        for <multiple recipients>; Sat, 12 Apr 2014 17:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vmG3GCzQZv6k1AxbTB4rHzuFvKtOPzgL3trFYSBdp7g=;
        b=AxUD9fm+gUszDjBcAvnwAf+cPxAOUT1barkogisPBYf+9W1DXLFkIMx4CBwIkmnWV6
         G9YQXPSa5xG66SLUkpQ6zJGrQm5WhBJo0/EviWYIni2BNGpK34jwsQOfJK7G5kkuAbVD
         WgznU06fl0HIxV/1Q8Co3FTL3zckXMK55If3N2ifQSz9H4floVnsGgFtU957YAx9zV6l
         JiUERG/X1Q026VNpgYMgjwb25npcUt8IDkgsWzkNUk9TCedu1Te5RXXLq3lZOxl13SOE
         uP+vGdrLTUaR2R09sqev6lmLPYFIOycL8bcpeLfhfwa50lfaSY4zrLxQvP3fFwNBugrp
         2tMA==
X-Received: by 10.69.2.2 with SMTP id bk2mr35773975pbd.75.1397348701602;
        Sat, 12 Apr 2014 17:25:01 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id sh5sm24474879pbc.21.2014.04.12.17.24.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 17:25:01 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 3/8] MIPS: Loongson: Modify ChipConfig register definition
Date:   Sun, 13 Apr 2014 08:24:17 +0800
Message-Id: <1397348662-22502-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This patch is prepared for Multi-chip interconnection. Since each chip
has a ChipConfig register, LOONGSON_CHIPCFG should be an array.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    7 +++++--
 arch/mips/loongson/common/env.c                |   11 +++++++++++
 arch/mips/loongson/common/pm.c                 |    8 ++++----
 arch/mips/loongson/lemote-2f/clock.c           |    4 ++--
 arch/mips/loongson/lemote-2f/reset.c           |    2 +-
 arch/mips/loongson/loongson-3/smp.c            |    4 ++--
 drivers/cpufreq/loongson2_cpufreq.c            |    6 +++---
 7 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index f3fd1eb..a1c76ca 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -249,8 +249,11 @@ static inline void do_perfcnt_IRQ(void)
 #define LOONGSON_PXARB_CFG		LOONGSON_REG(LOONGSON_REGBASE + 0x68)
 #define LOONGSON_PXARB_STATUS		LOONGSON_REG(LOONGSON_REGBASE + 0x6c)
 
-/* Chip Config */
-#define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
+#define MAX_PACKAGES 4
+
+/* Chip Config registor of each physical cpu package, PRid >= Loongson-2F */
+extern u64 loongson_chipcfg[MAX_PACKAGES];
+#define LOONGSON_CHIPCFG(id) (*(volatile u32 *)(loongson_chipcfg[id]))
 
 /* pcimap */
 
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index 0c543ea..dc59241 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -27,6 +27,8 @@ EXPORT_SYMBOL(cpu_clock_freq);
 struct efi_memory_map_loongson *loongson_memmap;
 struct loongson_system_configuration loongson_sysconf;
 
+u64 loongson_chipcfg[MAX_PACKAGES] = {0xffffffffbfc00180};
+
 #define parse_even_earlier(res, option, p)				\
 do {									\
 	unsigned int tmp __maybe_unused;				\
@@ -77,6 +79,15 @@ void __init prom_init_env(void)
 
 	cpu_clock_freq = ecpu->cpu_clock_freq;
 	loongson_sysconf.cputype = ecpu->cputype;
+	if (ecpu->cputype == Loongson_3A) {
+		loongson_chipcfg[0] = 0x900000001fe00180;
+		loongson_chipcfg[1] = 0x900010001fe00180;
+		loongson_chipcfg[2] = 0x900020001fe00180;
+		loongson_chipcfg[3] = 0x900030001fe00180;
+	} else {
+		loongson_chipcfg[0] = 0x900000001fe00180;
+	}
+
 	loongson_sysconf.nr_cpus = ecpu->nr_cpus;
 	if (ecpu->nr_cpus > NR_CPUS || ecpu->nr_cpus == 0)
 		loongson_sysconf.nr_cpus = NR_CPUS;
diff --git a/arch/mips/loongson/common/pm.c b/arch/mips/loongson/common/pm.c
index f55e07a..a6b67cc 100644
--- a/arch/mips/loongson/common/pm.c
+++ b/arch/mips/loongson/common/pm.c
@@ -79,7 +79,7 @@ int __weak wakeup_loongson(void)
 static void wait_for_wakeup_events(void)
 {
 	while (!wakeup_loongson())
-		LOONGSON_CHIPCFG0 &= ~0x7;
+		LOONGSON_CHIPCFG(0) &= ~0x7;
 }
 
 /*
@@ -102,15 +102,15 @@ static void loongson_suspend_enter(void)
 
 	stop_perf_counters();
 
-	cached_cpu_freq = LOONGSON_CHIPCFG0;
+	cached_cpu_freq = LOONGSON_CHIPCFG(0);
 
 	/* Put CPU into wait mode */
-	LOONGSON_CHIPCFG0 &= ~0x7;
+	LOONGSON_CHIPCFG(0) &= ~0x7;
 
 	/* wait for the given events to wakeup cpu from wait mode */
 	wait_for_wakeup_events();
 
-	LOONGSON_CHIPCFG0 = cached_cpu_freq;
+	LOONGSON_CHIPCFG(0) = cached_cpu_freq;
 	mmiowb();
 }
 
diff --git a/arch/mips/loongson/lemote-2f/clock.c b/arch/mips/loongson/lemote-2f/clock.c
index 7d8c9cc..2e2067b 100644
--- a/arch/mips/loongson/lemote-2f/clock.c
+++ b/arch/mips/loongson/lemote-2f/clock.c
@@ -120,10 +120,10 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 
 	clk->rate = rate;
 
-	regval = LOONGSON_CHIPCFG0;
+	regval = LOONGSON_CHIPCFG(0);
 	regval = (regval & ~0x7) |
 		(loongson2_clockmod_table[i].driver_data - 1);
-	LOONGSON_CHIPCFG0 = regval;
+	LOONGSON_CHIPCFG(0) = regval;
 
 	return ret;
 }
diff --git a/arch/mips/loongson/lemote-2f/reset.c b/arch/mips/loongson/lemote-2f/reset.c
index 90962a3..79ac694 100644
--- a/arch/mips/loongson/lemote-2f/reset.c
+++ b/arch/mips/loongson/lemote-2f/reset.c
@@ -28,7 +28,7 @@ static void reset_cpu(void)
 	 * reset cpu to full speed, this is needed when enabling cpu frequency
 	 * scalling
 	 */
-	LOONGSON_CHIPCFG0 |= 0x7;
+	LOONGSON_CHIPCFG(0) |= 0x7;
 }
 
 /* reset support for fuloong2f */
diff --git a/arch/mips/loongson/loongson-3/smp.c b/arch/mips/loongson/loongson-3/smp.c
index c665fe1..1d120d3 100644
--- a/arch/mips/loongson/loongson-3/smp.c
+++ b/arch/mips/loongson/loongson-3/smp.c
@@ -406,12 +406,12 @@ static int loongson3_cpu_callback(struct notifier_block *nfb,
 	case CPU_POST_DEAD:
 	case CPU_POST_DEAD_FROZEN:
 		pr_info("Disable clock for CPU#%d\n", cpu);
-		LOONGSON_CHIPCFG0 &= ~(1 << (12 + cpu));
+		LOONGSON_CHIPCFG(0) &= ~(1 << (12 + cpu));
 		break;
 	case CPU_UP_PREPARE:
 	case CPU_UP_PREPARE_FROZEN:
 		pr_info("Enable clock for CPU#%d\n", cpu);
-		LOONGSON_CHIPCFG0 |= 1 << (12 + cpu);
+		LOONGSON_CHIPCFG(0) |= 1 << (12 + cpu);
 		break;
 	}
 
diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index fe891ed..82a7f7f 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -148,9 +148,9 @@ static void loongson2_cpu_wait(void)
 	u32 cpu_freq;
 
 	spin_lock_irqsave(&loongson2_wait_lock, flags);
-	cpu_freq = LOONGSON_CHIPCFG0;
-	LOONGSON_CHIPCFG0 &= ~0x7;	/* Put CPU into wait mode */
-	LOONGSON_CHIPCFG0 = cpu_freq;	/* Restore CPU state */
+	cpu_freq = LOONGSON_CHIPCFG(0);
+	LOONGSON_CHIPCFG(0) &= ~0x7;	/* Put CPU into wait mode */
+	LOONGSON_CHIPCFG(0) = cpu_freq;	/* Restore CPU state */
 	spin_unlock_irqrestore(&loongson2_wait_lock, flags);
 	local_irq_enable();
 }
-- 
1.7.7.3
