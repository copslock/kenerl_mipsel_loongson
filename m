From: Aaro Koskinen <aaro.koskinen@nsn.com>
Date: Fri, 17 Oct 2014 18:10:24 +0300
Subject: MIPS: oprofile: Fix backtrace on 64-bit kernel
Message-ID: <20141017151024.zp3gFz1iEgmdPIWDXaghyVmk0zCFEiDbtbHNd6Ia7PY@z>

commit bbaf113a481b6ce32444c125807ad3618643ce57 upstream.

Fix incorrect cast that always results in wrong address for the new
frame on 64-bit kernels.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8110/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/oprofile/backtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/oprofile/backtrace.c b/arch/mips/oprofile/backtrace.c
index 6854ed5097d2..83a1dfd8f0e3 100644
--- a/arch/mips/oprofile/backtrace.c
+++ b/arch/mips/oprofile/backtrace.c
@@ -92,7 +92,7 @@ static inline int unwind_user_frame(struct stackframe *old_frame,
 				/* This marks the end of the previous function,
 				   which means we overran. */
 				break;
-			stack_size = (unsigned) stack_adjustment;
+			stack_size = (unsigned long) stack_adjustment;
 		} else if (is_ra_save_ins(&ip)) {
 			int ra_slot = ip.i_format.simmediate;
 			if (ra_slot < 0)
--
2.1.0
