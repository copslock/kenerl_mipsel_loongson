From: "Maciej W. Rozycki" <macro@imgtec.com>
Date: Thu, 12 May 2016 10:18:27 +0100
Subject: MIPS: ptrace: Fix FP context restoration FCSR regression
Message-ID: <20160512091827.KOvDBNYgrYbRQzVZSO_b5TuCb3Ie3YU8lzibmRy0TL0@z>

commit 4249548454f7ba4581aeee26bd83f42b48a14d15 upstream.

Fix a floating-point context restoration regression introduced with
commit 9b26616c8d9d ("MIPS: Respect the ISA level in FCSR handling")
that causes a Floating Point exception and consequently a kernel oops
with hard float configurations when one or more FCSR Enable and their
corresponding Cause bits are set both at a time via a ptrace(2) call.

To do so reinstate Cause bit masking originally introduced with commit
b1442d39fac2 ("MIPS: Prevent user from setting FCSR cause bits") to
address this exact problem and then inadvertently removed from the
PTRACE_SETFPREGS request with the commit referred above.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13238/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/ptrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index e933a30..d56642a 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -175,6 +175,7 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
 	}

 	__get_user(value, data + 64);
+	value &= ~FPU_CSR_ALL_X;
 	fcr31 = child->thread.fpu.fcr31;
 	mask = boot_cpu_data.fpu_msk31;
 	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
--
2.7.4
