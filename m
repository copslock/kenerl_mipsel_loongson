From: Kevin D. Kissell <kevink@paralogos.com>
Date: Tue, 31 Mar 2009 12:49:30 +0200
Subject: [PATCH] Fix xxx_clockevent_init() naming conflict for SMTC
Message-ID: <20090331104930.wrIx83o6gte0uTQmwTlOF36TNqQqV9d6SZv2OWZtscw@z>


Signed-off-by: Kevin D. Kissell <kevink@paralogos.com>
---
 arch/mips/include/asm/time.h |    6 +++++-
 arch/mips/kernel/cevt-smtc.c |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 38a30d2..e46f23f 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -57,7 +57,11 @@ extern int r4k_clockevent_init(void);
 
 static inline int mips_clockevent_init(void)
 {
-#ifdef CONFIG_CEVT_R4K
+#ifdef CONFIG_MIPS_MT_SMTC
+	extern int smtc_clockevent_init(void);
+
+	return smtc_clockevent_init();
+#elif CONFIG_CEVT_R4K
 	return r4k_clockevent_init();
 #else
 	return -ENXIO;
diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
index 6d45e24..df6f5bc 100644
--- a/arch/mips/kernel/cevt-smtc.c
+++ b/arch/mips/kernel/cevt-smtc.c
@@ -245,7 +245,7 @@ irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
 }
 
 
-int __cpuinit mips_clockevent_init(void)
+int __cpuinit smtc_clockevent_init(void)
 {
 	uint64_t mips_freq = mips_hpt_frequency;
 	unsigned int cpu = smp_processor_id();
-- 
1.5.3.3


--------------070601030706030107070108--
