Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 22:18:34 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13207 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491801Ab0FAUS1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 22:18:27 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c056b230000>; Tue, 01 Jun 2010 13:18:43 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 1 Jun 2010 13:18:23 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 1 Jun 2010 13:18:22 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o51KIIvV006786;
        Tue, 1 Jun 2010 13:18:18 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o51KIG80006785;
        Tue, 1 Jun 2010 13:18:16 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Implement delays with cycle counter.
Date:   Tue,  1 Jun 2010 13:18:15 -0700
Message-Id: <1275423495-6751-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 01 Jun 2010 20:18:22.0809 (UTC) FILETIME=[9579AC90:01CB01C7]
X-archive-position: 26974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 692

Power throttling make deterministic delay loops impossible.
Re-implement delays using the cycle counter.  This also allows us to
get rid of the code that calculates loops per jiffy.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/csrc-octeon.c              |   55 ++++++++++++++++++++
 arch/mips/cavium-octeon/setup.c                    |    4 +-
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |   11 ----
 arch/mips/include/asm/octeon/octeon.h              |    1 +
 4 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index 0bf4bbe..a7d2b39 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -88,3 +88,58 @@ void __init plat_time_init(void)
 	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
 	clocksource_register(&clocksource_mips);
 }
+
+static u64 octeon_udelay_factor;
+static u64 octeon_ndelay_factor;
+
+void __init octeon_setup_delays(void)
+{
+	octeon_udelay_factor = octeon_get_clock_rate() / 1000000;
+	/*
+	 * For __ndelay we divide by 2^16, so the factor is multiplied
+	 * by the same amount.
+	 */
+	octeon_ndelay_factor = (octeon_udelay_factor * 0x10000ull) / 1000ull;
+
+	preset_lpj = octeon_get_clock_rate() / HZ;
+}
+
+void __udelay(unsigned long us)
+{
+	u64 cur, end, inc;
+
+	cur = read_c0_cvmcount();
+
+	inc = us * octeon_udelay_factor;
+	end = cur + inc;
+
+	while (end > cur)
+		cur = read_c0_cvmcount();
+}
+EXPORT_SYMBOL(__udelay);
+
+void __ndelay(unsigned long ns)
+{
+	u64 cur, end, inc;
+
+	cur = read_c0_cvmcount();
+
+	inc = ((ns * octeon_ndelay_factor) >> 16);
+	end = cur + inc;
+
+	while (end > cur)
+		cur = read_c0_cvmcount();
+}
+EXPORT_SYMBOL(__ndelay);
+
+void __delay(unsigned long loops)
+{
+	u64 cur, end;
+
+	cur = read_c0_cvmcount();
+	end = cur + loops;
+
+	while (end > cur)
+		cur = read_c0_cvmcount();
+}
+EXPORT_SYMBOL(__delay);
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index d1b5ffa..6f36bc1 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -598,13 +598,13 @@ void __init prom_init(void)
 		 * the filesystem. Also specify the calibration delay
 		 * to avoid calculating it every time.
 		 */
-		strcat(arcs_cmdline, " rw root=1f00"
-		       " lpj=60176 slram=root,0x40000000,+1073741824");
+		strcat(arcs_cmdline, " rw root=1f00 slram=root,0x40000000,+1073741824");
 	}
 
 	mips_hpt_frequency = octeon_get_clock_rate();
 
 	octeon_init_cvmcount();
+	octeon_setup_delays();
 
 	_machine_restart = octeon_restart;
 	_machine_halt = octeon_halt;
diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index bbf0540..e412777 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -61,22 +61,11 @@
 
 #define kernel_uses_smartmips_rixi (cpu_data[0].cputype == CPU_CAVIUM_OCTEON_PLUS)
 
-#define ARCH_HAS_READ_CURRENT_TIMER 1
 #define ARCH_HAS_IRQ_PER_CPU	1
 #define ARCH_HAS_SPINLOCK_PREFETCH 1
 #define spin_lock_prefetch(x) prefetch(x)
 #define PREFETCH_STRIDE 128
 
-static inline int read_current_timer(unsigned long *result)
-{
-	asm volatile ("rdhwr %0,$31\n"
-#ifndef CONFIG_64BIT
-		      "\tsll %0, 0"
-#endif
-		      : "=r" (*result));
-	return 0;
-}
-
 static inline int octeon_has_saa(void)
 {
 	int id;
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index ca6214b..8a3eb3b 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -50,6 +50,7 @@ extern void octeon_crypto_disable(struct octeon_cop2_state *state,
 extern asmlinkage void octeon_cop2_restore(struct octeon_cop2_state *task);
 
 extern void octeon_init_cvmcount(void);
+extern void octeon_setup_delays(void);
 
 #define OCTEON_ARGV_MAX_ARGS	64
 #define OCTOEN_SERIAL_LEN	20
-- 
1.6.6.1
