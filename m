From: Hauke Mehrtens <hauke@hauke-m.de>
Date: Sun, 6 Mar 2016 22:28:56 +0100
Subject: MIPS: Fix build error when SMP is used without GIC
Message-ID: <20160306212856.BcHMcjI2U-1xVpza1IjKLRs7KHuE3HUq-89E_2k958Y@z>

commit 7a50e4688dabb8005df39b2b992d76629b8af8aa upstream.

The MIPS_GIC_IPI should only be selected when MIPS_GIC is also
selected, otherwise it results in a compile error. smp-gic.c uses some
functions from include/linux/irqchip/mips-gic.h like
plat_ipi_call_int_xlate() which are only added to the header file when
MIPS_GIC is set. The Lantiq SoC does not use the GIC, but supports SMP.
The calls top the functions from smp-gic.c are already protected by
some #ifdefs

The first part of this was introduced in commit 72e20142b2bf ("MIPS:
Move GIC IPI functions out of smp-cmp.c")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12774/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2a50476..023b29b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1977,7 +1977,7 @@ config MIPS_MT_SMP
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select MIPS_MT
 	select SMP
 	select SMP_UP
@@ -2062,7 +2062,7 @@ config MIPS_VPE_APSP_API_MT
 config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
 	depends on SYS_SUPPORTS_MIPS_CMP
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select SMP
 	select SYNC_R4K
 	select SYS_SUPPORTS_SMP
@@ -2082,7 +2082,7 @@ config MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
-	select MIPS_GIC_IPI
+	select MIPS_GIC_IPI if MIPS_GIC
 	select SMP
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
@@ -2101,6 +2101,7 @@ config MIPS_CPS_PM
 	bool

 config MIPS_GIC_IPI
+	depends on MIPS_GIC
 	bool

 config MIPS_CM
--
2.7.0
