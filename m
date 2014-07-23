Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 15:47:00 +0200 (CEST)
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59275 "EHLO
        mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842529AbaGWNnk6J8-A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 15:43:40 +0200
Received: by mail-wg0-f44.google.com with SMTP id m15so1190204wgh.15
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 06:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SvaoXRz/TQNne7KZZPpYKy9ZF0M63i3FOAMEskd9A3Y=;
        b=FYAUWucyATRL3xeUIJF1ZYv8E7tDl8im9in7yt2G9beqUxlYLRVTNz5ifjyZbqzEBu
         9SBE++sRklyuNuSd+N7gNdmxzcTWamGXCxjQGGOnCV8G+s5qw4ubwbPet4SCVrMm7qt4
         7Aouqh1RbrpHjWN4DJNPfWcJ9kGWSuiATFJm2vYuprTniVy4g/cJ7G9a+Gh2RXGzQunw
         ogObhCWQCBSJfWpuF0GvsCYCG5nTWGi6aPoF5nq7IYJHdwRPI6l4wT5ZjB3X0LE1A0z9
         YcIKRj1iMpYzLyOvCF80OLzJnXIInJiHau3H1+31pGj6ko10sHGBovo/h7vcMQCvSe8m
         mU2w==
X-Gm-Message-State: ALoCoQlttr6+z0zAOix8hPMeuBPzGq2vf6dqwf924Yr4Z2pPQ/vXH1U3rkKjlwlufd0QBSc5QWJA
X-Received: by 10.194.186.178 with SMTP id fl18mr1829794wjc.83.1406123011221;
        Wed, 23 Jul 2014 06:43:31 -0700 (PDT)
Received: from localhost.localdomain (host31-50-226-70.range31-50.btcentralplus.com. [31.50.226.70])
        by mx.google.com with ESMTPSA id w10sm9359341wie.22.2014.07.23.06.43.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 06:43:30 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mips@linux-mips.org
Cc:     Alex Smith <alex@alex-smith.me.uk>
Subject: [PATCH 08/11] MIPS: ptrace: Fix user pt_regs definition, use in ptrace_{get,set}regs()
Date:   Wed, 23 Jul 2014 14:40:13 +0100
Message-Id: <1406122816-2424-9-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

In uapi/asm/ptrace.h, a user version of pt_regs is defined wrapped in
ifndef __KERNEL__. This structure definition does not match anything
used by any kernel API, in particular it does not match the format used
by PTRACE_{GET,SET}REGS.

Therefore, replace the structure definition with one matching what is
used by PTRACE_{GET,SET}REGS. The format used by these is the same for
both 32-bit and 64-bit.

Also, change the implementation of PTRACE_{GET,SET}REGS to use this new
structure definition. The structure is renamed to user_pt_regs when
__KERNEL__ is defined to avoid conflicts with the kernel's own pt_regs.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
---
 arch/mips/include/asm/ptrace.h      |  6 ++++--
 arch/mips/include/uapi/asm/ptrace.h | 25 ++++++++++++++-----------
 arch/mips/kernel/ptrace.c           | 26 +++++++++++++-------------
 arch/mips/kernel/ptrace32.c         |  6 ++++--
 4 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index c301fa9..fc783f8 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -47,8 +47,10 @@ struct pt_regs {
 
 struct task_struct;
 
-extern int ptrace_getregs(struct task_struct *child, __s64 __user *data);
-extern int ptrace_setregs(struct task_struct *child, __s64 __user *data);
+extern int ptrace_getregs(struct task_struct *child,
+	struct user_pt_regs __user *data);
+extern int ptrace_setregs(struct task_struct *child,
+	struct user_pt_regs __user *data);
 
 extern int ptrace_getfpregs(struct task_struct *child, __u32 __user *data);
 extern int ptrace_setfpregs(struct task_struct *child, __u32 __user *data);
diff --git a/arch/mips/include/uapi/asm/ptrace.h b/arch/mips/include/uapi/asm/ptrace.h
index b26f7e3..bbcfb8b 100644
--- a/arch/mips/include/uapi/asm/ptrace.h
+++ b/arch/mips/include/uapi/asm/ptrace.h
@@ -22,24 +22,27 @@
 #define DSP_CONTROL	77
 #define ACX		78
 
-#ifndef __KERNEL__
 /*
- * This struct defines the way the registers are stored on the stack during a
- * system call/exception. As usual the registers k0/k1 aren't being saved.
+ * This struct defines the registers as used by PTRACE_{GET,SET}REGS. The
+ * format is the same for both 32- and 64-bit processes. Registers for 32-bit
+ * processes are sign extended.
  */
+#ifdef __KERNEL__
+struct user_pt_regs {
+#else
 struct pt_regs {
+#endif
 	/* Saved main processor registers. */
-	unsigned long regs[32];
+	__u64 regs[32];
 
 	/* Saved special registers. */
-	unsigned long cp0_status;
-	unsigned long hi;
-	unsigned long lo;
-	unsigned long cp0_badvaddr;
-	unsigned long cp0_cause;
-	unsigned long cp0_epc;
+	__u64 lo;
+	__u64 hi;
+	__u64 cp0_epc;
+	__u64 cp0_badvaddr;
+	__u64 cp0_status;
+	__u64 cp0_cause;
 } __attribute__ ((aligned (8)));
-#endif /* __KERNEL__ */
 
 /* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
 #define PTRACE_GETREGS		12
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index ffc2e37..c0c582e 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -63,7 +63,7 @@ void ptrace_disable(struct task_struct *child)
  * for 32-bit kernels and for 32-bit processes on a 64-bit kernel.
  * Registers are sign extended to fill the available space.
  */
-int ptrace_getregs(struct task_struct *child, __s64 __user *data)
+int ptrace_getregs(struct task_struct *child, struct user_pt_regs __user *data)
 {
 	struct pt_regs *regs;
 	int i;
@@ -74,13 +74,13 @@ int ptrace_getregs(struct task_struct *child, __s64 __user *data)
 	regs = task_pt_regs(child);
 
 	for (i = 0; i < 32; i++)
-		__put_user((long)regs->regs[i], data + i);
-	__put_user((long)regs->lo, data + EF_LO - EF_R0);
-	__put_user((long)regs->hi, data + EF_HI - EF_R0);
-	__put_user((long)regs->cp0_epc, data + EF_CP0_EPC - EF_R0);
-	__put_user((long)regs->cp0_badvaddr, data + EF_CP0_BADVADDR - EF_R0);
-	__put_user((long)regs->cp0_status, data + EF_CP0_STATUS - EF_R0);
-	__put_user((long)regs->cp0_cause, data + EF_CP0_CAUSE - EF_R0);
+		__put_user((long)regs->regs[i], (__s64 __user *)&data->regs[i]);
+	__put_user((long)regs->lo, (__s64 __user *)&data->lo);
+	__put_user((long)regs->hi, (__s64 __user *)&data->hi);
+	__put_user((long)regs->cp0_epc, (__s64 __user *)&data->cp0_epc);
+	__put_user((long)regs->cp0_badvaddr, (__s64 __user *)&data->cp0_badvaddr);
+	__put_user((long)regs->cp0_status, (__s64 __user *)&data->cp0_status);
+	__put_user((long)regs->cp0_cause, (__s64 __user *)&data->cp0_cause);
 
 	return 0;
 }
@@ -90,7 +90,7 @@ int ptrace_getregs(struct task_struct *child, __s64 __user *data)
  * the 64-bit format.  On a 32-bit kernel only the lower order half
  * (according to endianness) will be used.
  */
-int ptrace_setregs(struct task_struct *child, __s64 __user *data)
+int ptrace_setregs(struct task_struct *child, struct user_pt_regs __user *data)
 {
 	struct pt_regs *regs;
 	int i;
@@ -101,10 +101,10 @@ int ptrace_setregs(struct task_struct *child, __s64 __user *data)
 	regs = task_pt_regs(child);
 
 	for (i = 0; i < 32; i++)
-		__get_user(regs->regs[i], data + i);
-	__get_user(regs->lo, data + EF_LO - EF_R0);
-	__get_user(regs->hi, data + EF_HI - EF_R0);
-	__get_user(regs->cp0_epc, data + EF_CP0_EPC - EF_R0);
+		__get_user(regs->regs[i], (__s64 __user *)&data->regs[i]);
+	__get_user(regs->lo, (__s64 __user *)&data->lo);
+	__get_user(regs->hi, (__s64 __user *)&data->hi);
+	__get_user(regs->cp0_epc, (__s64 __user *)&data->cp0_epc);
 
 	/* badvaddr, status, and cause may not be written.  */
 
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index a83fb73..dee8729 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -256,11 +256,13 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		}
 
 	case PTRACE_GETREGS:
-		ret = ptrace_getregs(child, (__s64 __user *) (__u64) data);
+		ret = ptrace_getregs(child,
+				(struct user_pt_regs __user *) (__u64) data);
 		break;
 
 	case PTRACE_SETREGS:
-		ret = ptrace_setregs(child, (__s64 __user *) (__u64) data);
+		ret = ptrace_setregs(child,
+				(struct user_pt_regs __user *) (__u64) data);
 		break;
 
 	case PTRACE_GETFPREGS:
-- 
1.9.1
