From: Markos Chandras <markos.chandras@imgtec.com>
Date: Mon, 17 Nov 2014 09:32:38 +0000
Subject: MIPS: lib: memcpy: Restore NOP on delay slot before returning to
 caller
Message-ID: <20141117093238.rr03zjl_PDPDBcPOvOX2RhhAj3YLvChTmUUi_lvNsnY@z>

commit 51b1029d9966060c6ad02030e6f251425b4f06c1 upstream.

Commit cf62a8b8134dd3 ("MIPS: lib: memcpy: Use macro to build the
copy_user code") switched to a macro in order to build the memcpy
symbols in preparation for the EVA support. However, this commit
also removed the NOP instruction after the 'jr ra' when returning
back to the caller. This had no visible side-effects since the next
instruction was a load to the t0 register which was already in the
clobbered list, but it may have undesired effects in the future
if some other code is introduced in between the .Ldone and
the .Ll_exc_copy labels.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8512/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/lib/memcpy.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index c17ef80cf65a..5d3238af9b5c 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -503,6 +503,7 @@
 	STOREB(t0, NBYTES-2(dst), .Ls_exc_p1\@)
 .Ldone\@:
 	jr	ra
+	 nop
 	.if __memcpy == 1
 	END(memcpy)
 	.set __memcpy, 0
--
2.1.0
