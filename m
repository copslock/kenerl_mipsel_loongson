Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 01:36:12 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38447 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817975Ab3EVXgHvFXQi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 01:36:07 +0200
Received: by mail-pa0-f47.google.com with SMTP id kl1so465633pab.20
        for <multiple recipients>; Wed, 22 May 2013 16:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=iFN8UAAX3x3AdAnf6hV70XhYf7a9GIyDaFwW8SKnOmc=;
        b=Dp8CBm5dLSm6uoYuvfNhJQOQvuMANUhhnesVZsboJ/ySXG3bxCQgApuj9SCJ3o+4ZH
         7kCpKqcMGqOmUpH3US56G5I0+BR5IfrkDYjyXaou7qBlY4rAw6Uo2LYUUBczOmUrESMY
         0U93CWOxHYl1kobwmrb+m2gf5cHrbLflaF5Mp6vxbZdUJoGf1zKMpJhJLpGq5uSlmseY
         5LTiTWI6XKeiwt929So3W3FGD4zswYlDrCAkGmI8cRlAnQMRWPUjav5+fLYF7FWJ+Hcm
         +XW688n3orb9mtnYT/8kL/02D18I8LdFJpQRCCzWDDh2D/WP1Qy1ppTMVEe8fYuD/owd
         +MMA==
X-Received: by 10.66.150.106 with SMTP id uh10mr10696292pab.118.1369265761158;
        Wed, 22 May 2013 16:36:01 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ov2sm9009247pbc.34.2013.05.22.16.35.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 May 2013 16:36:00 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4MNZwwC004247;
        Wed, 22 May 2013 16:35:58 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4MNZvjw004246;
        Wed, 22 May 2013 16:35:57 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Quit exposing Kconfig symbols in uapi headers.
Date:   Wed, 22 May 2013 16:35:56 -0700
Message-Id: <1369265756-4213-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36546
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

The kernel's struct pt_regs has many fields conditional on various
Kconfig variables, we cannot be exporting this garbage to user-space.

Move the kernel's definition to asm/ptrace.h, and put a uapi only
version in uapi/asm/ptrace.h gated by #ifndef __KERNEL__

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/ptrace.h      | 32 ++++++++++++++++++++++++++++++++
 arch/mips/include/uapi/asm/ptrace.h | 17 ++---------------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index a3186f2..5e6cd09 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -16,6 +16,38 @@
 #include <asm/isadep.h>
 #include <uapi/asm/ptrace.h>
 
+/*
+ * This struct defines the way the registers are stored on the stack during a
+ * system call/exception. As usual the registers k0/k1 aren't being saved.
+ */
+struct pt_regs {
+#ifdef CONFIG_32BIT
+	/* Pad bytes for argument save space on the stack. */
+	unsigned long pad0[6];
+#endif
+
+	/* Saved main processor registers. */
+	unsigned long regs[32];
+
+	/* Saved special registers. */
+	unsigned long cp0_status;
+	unsigned long hi;
+	unsigned long lo;
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+	unsigned long acx;
+#endif
+	unsigned long cp0_badvaddr;
+	unsigned long cp0_cause;
+	unsigned long cp0_epc;
+#ifdef CONFIG_MIPS_MT_SMTC
+	unsigned long cp0_tcstatus;
+#endif /* CONFIG_MIPS_MT_SMTC */
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+	unsigned long long mpl[3];	  /* MTM{0,1,2} */
+	unsigned long long mtp[3];	  /* MTP{0,1,2} */
+#endif
+} __aligned(8);
+
 struct task_struct;
 
 extern int ptrace_getregs(struct task_struct *child, __s64 __user *data);
diff --git a/arch/mips/include/uapi/asm/ptrace.h b/arch/mips/include/uapi/asm/ptrace.h
index 4d58d84..b26f7e3 100644
--- a/arch/mips/include/uapi/asm/ptrace.h
+++ b/arch/mips/include/uapi/asm/ptrace.h
@@ -22,16 +22,12 @@
 #define DSP_CONTROL	77
 #define ACX		78
 
+#ifndef __KERNEL__
 /*
  * This struct defines the way the registers are stored on the stack during a
  * system call/exception. As usual the registers k0/k1 aren't being saved.
  */
 struct pt_regs {
-#ifdef CONFIG_32BIT
-	/* Pad bytes for argument save space on the stack. */
-	unsigned long pad0[6];
-#endif
-
 	/* Saved main processor registers. */
 	unsigned long regs[32];
 
@@ -39,20 +35,11 @@ struct pt_regs {
 	unsigned long cp0_status;
 	unsigned long hi;
 	unsigned long lo;
-#ifdef CONFIG_CPU_HAS_SMARTMIPS
-	unsigned long acx;
-#endif
 	unsigned long cp0_badvaddr;
 	unsigned long cp0_cause;
 	unsigned long cp0_epc;
-#ifdef CONFIG_MIPS_MT_SMTC
-	unsigned long cp0_tcstatus;
-#endif /* CONFIG_MIPS_MT_SMTC */
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
-	unsigned long long mpl[3];	  /* MTM{0,1,2} */
-	unsigned long long mtp[3];	  /* MTP{0,1,2} */
-#endif
 } __attribute__ ((aligned (8)));
+#endif /* __KERNEL__ */
 
 /* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
 #define PTRACE_GETREGS		12
-- 
1.7.11.7
