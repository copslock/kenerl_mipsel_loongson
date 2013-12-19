From: David Daney <david.daney@cavium.com>
Date: Thu, 19 Dec 2013 14:00:17 -0800
Subject: [PATCH] MIPS: Replace __get_cpu_var uses in FPU emulator.
Message-ID: <20131219220017.RgLt0v4z9ZQy6zAuR94mSY62PS9ZA6aqYcQB5AwzABM@z>

The use of __this_cpu_inc() requires a fundamental integer type, so
change the type of all the counters to unsigned long, which is the
same width they were before, but not wrapped in local_t.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/fpu_emulator.h | 14 +++++++-------
 arch/mips/math-emu/cp1emu.c          |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2abb587..619fa5f 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -30,12 +30,12 @@
 #ifdef CONFIG_DEBUG_FS
 
 struct mips_fpu_emulator_stats {
-	local_t emulated;
-	local_t loads;
-	local_t stores;
-	local_t cp1ops;
-	local_t cp1xops;
-	local_t errors;
+	unsigned long emulated;
+	unsigned long loads;
+	unsigned long stores;
+	unsigned long cp1ops;
+	unsigned long cp1xops;
+	unsigned long errors;
 };
 
 DECLARE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
@@ -43,7 +43,7 @@ DECLARE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
 #define MIPS_FPU_EMU_INC_STATS(M)					\
 do {									\
 	preempt_disable();						\
-	__local_inc(&__get_cpu_var(fpuemustats).M);			\
+	__this_cpu_inc(fpuemustats.M);					\
 	preempt_enable();						\
 } while (0)
 
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index efe0088..b853d05 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -2110,13 +2110,13 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 static int fpuemu_stat_get(void *data, u64 *val)
 {
 	int cpu;
-	unsigned long sum = 0;
+	u64 sum = 0;
 	for_each_online_cpu(cpu) {
 		struct mips_fpu_emulator_stats *ps;
-		local_t *pv;
+		unsigned long *pv;
 		ps = &per_cpu(fpuemustats, cpu);
 		pv = (void *)ps + (unsigned long)data;
-		sum += local_read(pv);
+		sum += *pv;
 	}
 	*val = sum;
 	return 0;
-- 
1.7.11.7


--------------070507070702050801040409--
