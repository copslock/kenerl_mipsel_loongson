From: Paul Burton <paul.burton@imgtec.com>
Date: Tue, 22 Jul 2014 14:21:21 +0100
Subject: MIPS: Prevent user from setting FCSR cause bits
Message-ID: <20140722132121.6LhpDjZZn4cBnYcT3HwRYMAeRwPyYNBM5mOMLR9WASM@z>

commit b1442d39fac2fcfbe6a4814979020e993ca59c9e upstream.

If one or more matching FCSR cause & enable bits are set in saved thread
context then when that context is restored the kernel will take an FP
exception. This is of course undesirable and considered an oops, leading
to the kernel writing a backtrace to the console and potentially
rebooting depending upon the configuration. Thus the kernel avoids this
situation by clearing the cause bits of the FCSR register when handling
FP exceptions and after emulating FP instructions.

However the kernel does not prevent userland from setting arbitrary FCSR
cause & enable bits via ptrace, using either the PTRACE_POKEUSR or
PTRACE_SETFPREGS requests. This means userland can trivially cause the
kernel to oops on any system with an FPU. Prevent this from happening
by clearing the cause bits when writing to the saved FCSR context via
ptrace.

This problem appears to exist at least back to the beginning of the git
era in the PTRACE_POKEUSR case.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@imgtec.com>
Patchwork: https://patchwork.linux-mips.org/patch/7438/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index b52e1d2..f6e6709 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -170,6 +170,7 @@ int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
 		__get_user(fregs[i], i + (__u64 __user *) data);

 	__get_user(child->thread.fpu.fcr31, data + 64);
+	child->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;

 	/* FIR may not be written.  */

@@ -587,7 +588,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			break;
 #endif
 		case FPC_CSR:
-			child->thread.fpu.fcr31 = data;
+			child->thread.fpu.fcr31 = data & ~FPU_CSR_ALL_X;
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
--
1.9.1
