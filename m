From: Paul Burton <paul.burton@imgtec.com>
Date: Thu, 21 Apr 2016 14:04:46 +0100
Subject: MIPS: Fix BC1{EQ,NE}Z return offset calculation
Message-ID: <20160421130446.FQkJEzx-_rHwPPvXoe0CVll93UVRIO1Jr__wc6LH0jQ@z>

commit ac1496980f1d2752f26769f5db63afbc9ac2b603 upstream.

The conditions for branching when emulating the BC1EQZ & BC1NEZ
instructions were backwards, leading to each of those instructions being
treated as the other. Fix this by reversing the conditions, and clear up
the code a little for readability & checkpatch.

Fixes: c8a34581ec09 ("MIPS: Emulate the BC1{EQ,NE}Z FPU instructions")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13151/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/branch.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index d8f9b35..ceca6cc 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -688,21 +688,9 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			}
 			lose_fpu(1);    /* Save FPU state for the emulator. */
 			reg = insn.i_format.rt;
-			bit = 0;
-			switch (insn.i_format.rs) {
-			case bc1eqz_op:
-				/* Test bit 0 */
-				if (get_fpr32(&current->thread.fpu.fpr[reg], 0)
-				    & 0x1)
-					bit = 1;
-				break;
-			case bc1nez_op:
-				/* Test bit 0 */
-				if (!(get_fpr32(&current->thread.fpu.fpr[reg], 0)
-				      & 0x1))
-					bit = 1;
-				break;
-			}
+			bit = get_fpr32(&current->thread.fpu.fpr[reg], 0) & 0x1;
+			if (insn.i_format.rs == bc1eqz_op)
+				bit = !bit;
 			own_fpu(1);
 			if (bit)
 				epc = epc + 4 +
--
2.7.4
