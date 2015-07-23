From: Felix Fietkau <nbd@openwrt.org>
Date: Thu, 23 Jul 2015 18:59:52 +0200
Subject: MIPS: Export get_c0_perfcount_int()
Message-ID: <20150723165952.Brvtgo8IpHGdDRVxGi_2sUnVMP-fXZZdmbly60PSNyg@z>

commit 0cb0985f57783c2f3c6c8ffe7e7665e80c56bd92 upstream.

get_c0_perfcount_int is tested from oprofile code. If oprofile is
compiled as module, get_c0_perfcount_int needs to be exported, otherwise
it cannot be resolved.

Fixes: a669efc4a3b4 ("MIPS: Add hook to get C0 performance counter interrupt")
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: abrestic@chromium.org
Patchwork: https://patchwork.linux-mips.org/patch/10763/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[ kamal: backport to 3.19-stable: no pistachio/time.c ]
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/ath79/setup.c          | 1 +
 arch/mips/lantiq/irq.c           | 1 +
 arch/mips/mti-malta/malta-time.c | 1 +
 arch/mips/mti-sead3/sead3-time.c | 1 +
 arch/mips/ralink/irq.c           | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index a73c93c..c0277e9 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -186,6 +186,7 @@ int get_c0_perfcount_int(void)
 {
 	return ATH79_MISC_IRQ(5);
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);

 unsigned int get_c0_compare_int(void)
 {
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 6ab1057..d01ade6 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -466,6 +466,7 @@ int get_c0_perfcount_int(void)
 {
 	return ltq_perfcount_irq;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);

 unsigned int get_c0_compare_int(void)
 {
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 644ecce..a6cc3ef 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -130,6 +130,7 @@ int get_c0_perfcount_int(void)

 	return mips_cpu_perf_irq;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);

 unsigned int get_c0_compare_int(void)
 {
diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
index ec1dd24..90e303e 100644
--- a/arch/mips/mti-sead3/sead3-time.c
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -77,6 +77,7 @@ int get_c0_perfcount_int(void)
 		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 	return -1;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);

 unsigned int get_c0_compare_int(void)
 {
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 7cf91b9..199ace4 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -89,6 +89,7 @@ int get_c0_perfcount_int(void)
 {
 	return rt_perfcount_irq;
 }
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);

 unsigned int get_c0_compare_int(void)
 {
--
1.9.1
