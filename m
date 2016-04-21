From: Paul Burton <paul.burton@imgtec.com>
Date: Thu, 21 Apr 2016 14:04:45 +0100
Subject: MIPS: math-emu: Fix BC1{EQ,NE}Z emulation
Message-ID: <20160421130445.eGWkjhaVFO9ZMUdvjev--vt0sNGqBFe1BT3B2A0U9LU@z>

commit 93583e178ebfdd2fadf950eef1547f305cac12ca upstream.

The conditions for branching when emulating the BC1EQZ & BC1NEZ
instructions were backwards, leading to each of those instructions being
treated as the other. Fix this by reversing the conditions, and clear up
the code a little for readability & checkpatch.

Fixes: c909ca718e8f ("MIPS: math-emu: Emulate missing BC1{EQ,NE}Z instructions")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13150/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/math-emu/cp1emu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 2bf9209..8d9133f 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -975,9 +975,10 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		struct mm_decoded_insn dec_insn, void *__user *fault_addr)
 {
 	unsigned long contpc = xcp->cp0_epc + dec_insn.pc_inc;
-	unsigned int cond, cbit;
+	unsigned int cond, cbit, bit0;
 	mips_instruction ir;
 	int likely, pc_inc;
+	union fpureg *fpr;
 	u32 __user *wva;
 	u64 __user *dva;
 	u32 wval;
@@ -1189,14 +1190,14 @@ emul:
 				return SIGILL;

 			cond = likely = 0;
+			fpr = &current->thread.fpu.fpr[MIPSInst_RT(ir)];
+			bit0 = get_fpr32(fpr, 0) & 0x1;
 			switch (MIPSInst_RS(ir)) {
 			case bc1eqz_op:
-				if (get_fpr32(&current->thread.fpu.fpr[MIPSInst_RT(ir)], 0) & 0x1)
-				    cond = 1;
+				cond = bit0 == 0;
 				break;
 			case bc1nez_op:
-				if (!(get_fpr32(&current->thread.fpu.fpr[MIPSInst_RT(ir)], 0) & 0x1))
-				    cond = 1;
+				cond = bit0 != 0;
 				break;
 			}
 			goto branch_common;
--
2.7.4
