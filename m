From: James Hogan <james.hogan@imgtec.com>
Date: Fri, 4 Dec 2015 22:25:02 +0000
Subject: MIPS: Avoid using unwind_stack() with usermode
Message-ID: <20151204222502.6c1FVe1Ot3kNQXSkGKj2HDyFFkghU6PQmjZe2q9O09E@z>

commit 81a76d7119f63c359750e4adeff922a31ad1135f upstream.

When showing backtraces in response to traps, for example crashes and
address errors (usually unaligned accesses) when they are set in debugfs
to be reported, unwind_stack will be used if the PC was in the kernel
text address range. However since EVA it is possible for user and kernel
address ranges to overlap, and even without EVA userland can still
trigger an address error by jumping to a KSeg0 address.

Adjust the check to also ensure that it was running in kernel mode. I
don't believe any harm can come of this problem, since unwind_stack() is
sufficiently defensive, however it is only meant for unwinding kernel
code, so to be correct it should use the raw backtracing instead.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11701/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
(cherry picked from commit d2941a975ac745c607dfb590e92bb30bc352dad9)
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index ef1e9d3..86454f5 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -143,7 +143,7 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs)
 	if (!task)
 		task = current;

-	if (raw_show_trace || !__kernel_text_address(pc)) {
+	if (raw_show_trace || user_mode(regs) || !__kernel_text_address(pc)) {
 		show_raw_backtrace(sp);
 		return;
 	}
--
2.7.4
