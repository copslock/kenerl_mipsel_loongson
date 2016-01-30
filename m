From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 29 Jan 2016 21:17:26 -0800
Subject: MIPS: BMIPS: Fix PRID_IMP_BMIPS5000 masking for BMIPS5200
Message-ID: <20160130051726.6AKl6AS2CSDmE6HYJjk54XosMO__RaVXjwsRjj74fxU@z>

commit cbbda6e7c9c3e4532bd70a73ff9d5e6655c894dc upstream.

BMIPS5000 have a PrID value of 0x5A00 and BMIPS5200 have a PrID value of
0x5B00, which, masked with 0x5A00, returns 0x5A00. Update all conditionals on
the PrID to cover both variants since we are going to need this to enable
BMIPS5200 SMP. The existing check, masking with 0xFF00 would not cover
BMIPS5200 at all.

Fixes: 68e6a78373a6d ("MIPS: BMIPS: Add PRId for BMIPS5200 (Whirlwind)")
Fixes: 6465460c92a85 ("MIPS: BMIPS: change compile time checks to runtime checks")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: john@phrozen.org
Cc: cernekee@gmail.com
Cc: jogo@openwrt.org
Cc: jaedon.shin@gmail.com
Cc: jfraser@broadcom.com
Cc: pgynther@google.com
Cc: dragan.stancevic@gmail.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12279/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/bmips_vec.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index 8649507..d9495f3 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -93,7 +93,8 @@ NESTED(bmips_reset_nmi_vec, PT_SIZE, sp)
 #if defined(CONFIG_CPU_BMIPS5000)
 	mfc0	k0, CP0_PRID
 	li	k1, PRID_IMP_BMIPS5000
-	andi	k0, 0xff00
+	/* mask with PRID_IMP_BMIPS5000 to cover both variants */
+	andi	k0, PRID_IMP_BMIPS5000
 	bne	k0, k1, 1f

 	/* if we're not on core 0, this must be the SMP boot signal */
@@ -166,10 +167,12 @@ bmips_smp_entry:
 2:
 #endif /* CONFIG_CPU_BMIPS4350 || CONFIG_CPU_BMIPS4380 */
 #if defined(CONFIG_CPU_BMIPS5000)
-	/* set exception vector base */
+	/* mask with PRID_IMP_BMIPS5000 to cover both variants */
 	li	k1, PRID_IMP_BMIPS5000
+	andi	k0, PRID_IMP_BMIPS5000
 	bne	k0, k1, 3f

+	/* set exception vector base */
 	la	k0, ebase
 	lw	k0, 0(k0)
 	mtc0	k0, $15, 1
@@ -263,6 +266,8 @@ LEAF(bmips_enable_xks01)
 #endif /* CONFIG_CPU_BMIPS4380 */
 #if defined(CONFIG_CPU_BMIPS5000)
 	li	t1, PRID_IMP_BMIPS5000
+	/* mask with PRID_IMP_BMIPS5000 to cover both variants */
+	andi	t2, PRID_IMP_BMIPS5000
 	bne	t2, t1, 2f

 	mfc0	t0, $22, 5
--
2.7.4
