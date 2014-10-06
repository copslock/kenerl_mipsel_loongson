Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2014 22:12:25 +0200 (CEST)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:48682 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010644AbaJFUMXaP75g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Oct 2014 22:12:23 +0200
Received: by mail-ig0-f178.google.com with SMTP id l13so3460286iga.17
        for <multiple recipients>; Mon, 06 Oct 2014 13:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5BozhqMCiPelhuA79pcazC0DQVKO+HZGlLO61UxZwH4=;
        b=yrwKeadYIhU5d30qHYDirYHvJHBDf5kGFmqBhGblukaoG6zHLkOt4VJoJtIcszI12F
         8bgyhSQMekNnB0JKWMSjBNtnZOmucCXuq46/nQmkVOomAp92XtNhFUStE+PG/VAEebXr
         boG8cYpkmZDNalTWajiwjCXZBO5WPUvManT+DAzB0Zz4qRK+XOPC3l9/GVfs/we323Ay
         HX6XS6nXFTfmfvMAoiByZtbW+t6uRdgt9EKW6PJxatMknljlTWO6KZa98mZRiQByDHDq
         tAaEvcjxriXKnQbBmfFlaZshACpE8TkZSa3NojG5fvbZiFBWPZhZAuTA/ectvr2z+gHv
         oBPQ==
X-Received: by 10.50.73.163 with SMTP id m3mr24825414igv.28.1412626337157;
        Mon, 06 Oct 2014 13:12:17 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id f19sm10374369igo.10.2014.10.06.13.12.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 Oct 2014 13:12:16 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id s96KCD6r004164;
        Mon, 6 Oct 2014 13:12:13 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id s96KC8ZT004163;
        Mon, 6 Oct 2014 13:12:08 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Zubair.Kakakhel@imgtec.com, peterz@infradead.org,
        paul.gortmaker@windriver.com, davidlohr@hp.com,
        macro@linux-mips.org, chenhc@lemote.com, zajec5@gmail.com,
        james.hogan@imgtec.com, keescook@chromium.org,
        alex@alex-smith.me.uk, tglx@linutronix.de, blogic@openwrt.org,
        jchandra@broadcom.com, paul.burton@imgtec.com,
        qais.yousef@imgtec.com, ralf@linux-mips.org,
        markos.chandras@imgtec.com, manuel.lauss@gmail.com,
        akpm@linux-foundation.org, lars.persson@axis.com,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        libc-alpha@sourceware.org, David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Allow FPU emulator to use non-stack area.
Date:   Mon,  6 Oct 2014 13:11:57 -0700
Message-Id: <1412626317-4128-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: David Daney <david.daney@cavium.com>

In order for MIPS to be able to support a non-executable stack, we
need to supply a method to specify a userspace area that can be used
for executing emulated branch delay slot instructions.

We add a new system call, sys_set_fpuemul_xol_area so that userspace
threads that are using the FPU can specify the location of the FPU
emulation out of line execution area.

Background:

MIPS floating point support requires that any instruction that cannot
be directly executed by the FPU, be emulated by the kernel.  Part of
this emulation involves executing non-FPU instructions that fall in
the delay slots of FP branch instructions.  Since the beginning of
MIPS/Linux time, this has been done by placing the instructions on the
userspace thread stack, and executing them there, as the instructions
must be executed in the MM context of the thread receiving the
emulation.

Because of this, the de facto MIPS Linux userspace ABI requires that
the userspace thread have an executable stack.  It is de facto,
because it is not written anywhere that this must be the case, but it
is never the less a requirement.

Problem:

How do we get MIPS Linux to use a non-executable stack in the face of
the FPU emulation problem?

Since userspace desires to change the ABI, put some of the onus on the
userspace code.  Any userspace thread desiring a non-executable stack,
must allocate a 4-byte aligned area at least 8 bytes long with that
has read/write/execute permissions and pass the address of that area
to the kernel with the new sys_set_fpuemul_xol_area system call.

This is similar to how we require userspace to notify the kernel of
the value of the thread local pointer.

Signed-off-by: David Daney <david.daney@cavium.com>
---

This patch has only been compile tested, and lacks the userspace
component.  It is presented as an alternate approch to the recently
proposed MIPS non-executable stack patches posted here:

http://www.linux-mips.org/archives/linux-mips/2014-10/msg00024.html

 arch/mips/include/asm/thread_info.h |  2 ++
 arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
 arch/mips/kernel/process.c          |  1 +
 arch/mips/kernel/scall32-o32.S      |  1 +
 arch/mips/kernel/scall64-64.S       |  1 +
 arch/mips/kernel/scall64-n32.S      |  1 +
 arch/mips/kernel/scall64-o32.S      |  1 +
 arch/mips/kernel/syscall.c          |  8 ++++++++
 arch/mips/math-emu/dsemul.c         | 11 +++++++----
 9 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 7de8658..20d47f6 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -26,6 +26,7 @@ struct thread_info {
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned long		tp_value;	/* thread pointer */
+	unsigned long		fpu_emul_xol;	/* FPU emul eXecute Out of Line VA */
 	__u32			cpu;		/* current CPU */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 
@@ -46,6 +47,7 @@ struct thread_info {
 	.task		= &tsk,			\
 	.exec_domain	= &default_exec_domain, \
 	.flags		= _TIF_FIXADE,		\
+	.fpu_emul_xol	= ~0ul,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 	.addr_limit	= KERNEL_DS,		\
diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index fdb4923..f1270ee 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -375,16 +375,17 @@
 #define __NR_seccomp			(__NR_Linux + 352)
 #define __NR_getrandom			(__NR_Linux + 353)
 #define __NR_memfd_create		(__NR_Linux + 354)
+#define __NR_set_fpuemul_xol_area	(__NR_Linux + 355)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		354
+#define __NR_Linux_syscalls		355
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		354
+#define __NR_O32_Linux_syscalls		355
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -707,16 +708,17 @@
 #define __NR_seccomp			(__NR_Linux + 312)
 #define __NR_getrandom			(__NR_Linux + 313)
 #define __NR_memfd_create		(__NR_Linux + 314)
+#define __NR_set_fpuemul_xol_area	(__NR_Linux + 315)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		314
+#define __NR_Linux_syscalls		315
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		314
+#define __NR_64_Linux_syscalls		315
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1043,15 +1045,16 @@
 #define __NR_seccomp			(__NR_Linux + 316)
 #define __NR_getrandom			(__NR_Linux + 317)
 #define __NR_memfd_create		(__NR_Linux + 318)
+#define __NR_set_fpuemul_xol_area	(__NR_Linux + 319)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		318
+#define __NR_Linux_syscalls		319
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		318
+#define __NR_N32_Linux_syscalls		319
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 636b074..6dde6bb 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -151,6 +151,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	if (clone_flags & CLONE_SETTLS)
 		ti->tp_value = regs->regs[7];
+	ti->fpu_emul_xol = ~0ul;
 
 	return 0;
 }
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 744cd10..8c19a39 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -579,3 +579,4 @@ EXPORT(sys_call_table)
 	PTR	sys_seccomp
 	PTR	sys_getrandom
 	PTR	sys_memfd_create
+	PTR	sys_set_fpuemul_xol_area	/* 4355 */
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 002b1bc..0b9f72e 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -434,4 +434,5 @@ EXPORT(sys_call_table)
 	PTR	sys_seccomp
 	PTR	sys_getrandom
 	PTR	sys_memfd_create
+	PTR	sys_set_fpuemul_xol_area	/* 5315 */
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index ca6cbbe..48f1760 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -427,4 +427,5 @@ EXPORT(sysn32_call_table)
 	PTR	sys_seccomp
 	PTR	sys_getrandom
 	PTR	sys_memfd_create
+	PTR	sys_set_fpuemul_xol_area
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 9e10d11..60def68 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -564,4 +564,5 @@ EXPORT(sys32_call_table)
 	PTR	sys_seccomp
 	PTR	sys_getrandom
 	PTR	sys_memfd_create
+	PTR	sys_set_fpuemul_xol_area	/* 4355 */
 	.size	sys32_call_table,.-sys32_call_table
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 4a4f9dd..5f9d9e8 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -96,6 +96,14 @@ SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
 	return 0;
 }
 
+SYSCALL_DEFINE1(set_fpuemul_xol_area, unsigned long, addr)
+{
+	struct thread_info *ti = task_thread_info(current);
+
+	ti->fpu_emul_xol = addr;
+	return 0;
+}
+
 static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 {
 	unsigned long old, tmp;
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index 4f514f3..bf4ff61 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -34,6 +34,7 @@ struct emuframe {
 int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 {
 	extern asmlinkage void handle_dsemulret(void);
+	struct thread_info *ti = task_thread_info(current);
 	struct emuframe __user *fr;
 	int err;
 
@@ -64,10 +65,12 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 	 * branches, but gives us a cleaner interface to the exception
 	 * handler (single entry point).
 	 */
-
-	/* Ensure that the two instructions are in the same cache line */
-	fr = (struct emuframe __user *)
-		((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
+	if (ti->fpu_emul_xol != ~0ul)
+		fr = (struct emuframe *)ti->fpu_emul_xol;
+	else
+		/* Ensure that the two instructions are in the same cache line */
+		fr = (struct emuframe __user *)
+			((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
 
 	/* Verify that the stack pointer is not competely insane */
 	if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
-- 
1.7.11.7
