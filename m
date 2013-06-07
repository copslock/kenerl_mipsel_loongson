Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:10:10 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:40041 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835168Ab3FGXD6IQYOi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:58 +0200
Received: by mail-ie0-f182.google.com with SMTP id 9so12059322iec.41
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iFN8UAAX3x3AdAnf6hV70XhYf7a9GIyDaFwW8SKnOmc=;
        b=JLhKsSW8GNDeORoCHyUgxyxlmmYmjWhj1ZrD7vcEXGWtb40NJoIcgLaGcSuOA1h/JE
         C+sQG2LcdbNRn6CMHKuXwSb1BOYiSs1X9lgLuKSdF8a3fm8p/zb6ocJU6JXdUNl8tjir
         78BQtVp+qTVAUSitXd19BsKeHcSRVh+Vr8aSrcO2XMq1Sb6yfdkE2Uqdw1uDDSnQwLfC
         v9+Duz6v8Mb+euG4C3dV2KvqDflBhycAsz7ZLh/lqAv3stp7xCZEBxd+oGEQESdXG3zP
         kstwkwe54/fiY3upW3ZXjZZarPnbnlokN59ummJUOKq0GwRwSvu6y0kanaDAmEAxFTWt
         8Ouw==
X-Received: by 10.50.106.114 with SMTP id gt18mr2231265igb.7.1370646232067;
        Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id h3sm1221662igv.1.2013.06.07.16.03.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:51 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3mrL006678;
        Fri, 7 Jun 2013 16:03:48 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3mRB006677;
        Fri, 7 Jun 2013 16:03:48 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 17/31] MIPS: Quit exposing Kconfig symbols in uapi headers.
Date:   Fri,  7 Jun 2013 16:03:21 -0700
Message-Id: <1370646215-6543-18-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36735
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
