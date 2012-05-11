Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 08:28:37 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:34374 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903548Ab2EKG2d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 08:28:33 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SSjL0-0001vX-Bd; Fri, 11 May 2012 01:28:26 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: [PATCH v2] Fix race condition with FPU thread task flag during context switch.
Date:   Fri, 11 May 2012 01:28:22 -0500
Message-Id: <1336717702-731-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/switch_to.h |    6 ++++--
 arch/mips/kernel/r4k_switch.S     |   12 +++---------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index 5d33621..4f8ddba8 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -22,7 +22,7 @@ struct task_struct;
  * switch_to(n) should switch tasks to task nr n, first
  * checking that n isn't the current task, in which case it does nothing.
  */
-extern asmlinkage void *resume(void *last, void *next, void *next_ti);
+extern asmlinkage void *resume(void *last, void *next, void *next_ti, u32 __usedfpu);
 
 extern unsigned int ll_bit;
 extern struct task_struct *ll_task;
@@ -66,11 +66,13 @@ do {									\
 
 #define switch_to(prev, next, last)					\
 do {									\
+	u32 __usedfpu;							\
 	__mips_mt_fpaff_switch_to(prev);				\
 	if (cpu_has_dsp)						\
 		__save_dsp(prev);					\
 	__clear_software_ll_bit();					\
-	(last) = resume(prev, next, task_thread_info(next));		\
+	__usedfpu = test_and_clear_tsk_thread_flag(prev, TIF_USEDFPU);	\
+	(last) = resume(prev, next, task_thread_info(next), __usedfpu);	\
 } while (0)
 
 #define finish_arch_switch(prev)					\
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 9414f93..a675752 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -41,7 +41,7 @@
 
 /*
  * task_struct *resume(task_struct *prev, task_struct *next,
- *                     struct thread_info *next_ti)
+ *                     struct thread_info *next_ti, u32 __usedfpu)
  */
 	.align	5
 	LEAF(resume)
@@ -53,16 +53,10 @@
 	/*
 	 * check if we need to save FPU registers
 	 */
-	PTR_L	t3, TASK_THREAD_INFO(a0)
-	LONG_L	t0, TI_FLAGS(t3)
-	li	t1, _TIF_USEDFPU
-	and	t2, t0, t1
-	beqz	t2, 1f
-	nor	t1, zero, t1
 
-	and	t0, t0, t1
-	LONG_S	t0, TI_FLAGS(t3)
+	beqz    a3, 1f
 
+	PTR_L	t3, TASK_THREAD_INFO(a0)
 	/*
 	 * clear saved user stack CU1 bit
 	 */
-- 
1.7.10
