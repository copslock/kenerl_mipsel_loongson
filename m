From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2017 21:30:11 +0200
Subject: [PATCH 1/5] MIPS: pm-cps: Delete an error message for a failed memory allocation in cps_pm_online_cpu()
Message-ID: <20170523193011.7jcuUSZi0qi5118HYDDALyd00xIyhowWBRsvmVMO_qc@z>

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/pm-cps.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 5f928c34c148..d662838e418f 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -666,7 +666,6 @@ static int cps_pm_online_cpu(unsigned int cpu)
-		if (!core_rc) {
-			pr_err("Failed allocate core %u ready_count\n", core);
+		if (!core_rc)
 			return -ENOMEM;
-		}
+
 		per_cpu(ready_count_alloc, core) = core_rc;
 
 		/* Ensure ready_count is aligned to a cacheline boundary */
-- 
2.13.0
