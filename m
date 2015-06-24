From: Markos Chandras <markos.chandras@imgtec.com>
Date: Wed, 24 Jun 2015 09:29:20 +0100
Subject: MIPS: kernel: traps: Fix broken indentation
Message-ID: <20150624082920.RuoaMOEps9TsA80th9ypK_a1aW21SBlFNTU37LSM1oc@z>

commit 761b4493bbb7b614387794f39e3969716e9e0215 upstream.

Fix broken indentation caused by the SMTC removal
commit b633648c5ad3cfbda0b3daea50d2135d44899259
("MIPS: MT: Remove SMTC support")

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: b633648c5ad3c ("MIPS: MT: Remove SMTC support")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10581/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kernel/traps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 51706d6dd5b0..c65062a6ff23 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1931,10 +1931,10 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	BUG_ON(current->mm);
 	enter_lazy_tlb(&init_mm, current);

-		/* Boot CPU's cache setup in setup_arch(). */
-		if (!is_boot_cpu)
-			cpu_cache_init();
-		tlb_init();
+	/* Boot CPU's cache setup in setup_arch(). */
+	if (!is_boot_cpu)
+		cpu_cache_init();
+	tlb_init();
 	TLBMISS_HANDLER_SETUP();
 }
