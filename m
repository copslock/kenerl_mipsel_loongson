Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 19:15:44 +0100 (CET)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:41925 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008717AbbCMSPmN6poJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 19:15:42 +0100
Received: by wiwl15 with SMTP id l15so8125506wiw.0;
        Fri, 13 Mar 2015 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3+2h8da0BPISMBjyYvBTr+ZM6pxHJZvtAopyOCeEjs8=;
        b=rSnn5AJYUIzhyMK8If9pHN+dwYpivpU+TfariFXWuOmVqLwqpPm52lpi4K7nkloiLS
         f+XQJgd+8oy4XnrllBxcWOGX/+CSl7ORftWzCtUFscB32bwDUxeivRQYJdAOXupBv4CQ
         QFdptsdPRVnDctrX1Q405qgQ7gpFje/yho7CWsratchWZfmHOm0fMH/1U60Mctt2ynEq
         rC4Z14Jj7KhpmhkI9W0bdWVU/QoE9qTIMStyJvSMsB9/jycA0cryz7HkQ1v9fp++20eh
         ciWg4fNjeL8Tl1KurR6169gSBmnlkq2tBbNzp7drEhcITIrRvW0s+LgjoZMULiSAI12w
         qyaw==
X-Received: by 10.180.76.4 with SMTP id g4mr142361083wiw.43.1426270537665;
        Fri, 13 Mar 2015 11:15:37 -0700 (PDT)
Received: from alex-ThinkPad-L530.resnet.local ([41.215.180.30])
        by mx.google.com with ESMTPSA id gj16sm3789705wic.24.2015.03.13.11.15.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Mar 2015 11:15:36 -0700 (PDT)
From:   Alex Dowad <alexinbeijing@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Eunbong Song <eunb.song@samsung.com>,
        linux-mips@linux-mips.org (open list:MIPS)
Subject: [PATCH 18/32] mips: copy_thread(): rename 'arg' argument to 'kthread_arg'
Date:   Fri, 13 Mar 2015 20:14:41 +0200
Message-Id: <1426270496-26362-8-git-send-email-alexinbeijing@gmail.com>
X-Mailer: git-send-email 2.0.0.GIT
In-Reply-To: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
References: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
Return-Path: <alexinbeijing@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexinbeijing@gmail.com
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

The 'arg' argument to copy_thread() is only ever used when forking a new
kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
with do_fork() and other arch-specific implementations of copy_thread()).

Signed-off-by: Alex Dowad <alexinbeijing@gmail.com>
---
 arch/mips/kernel/process.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index bf85cc1..d295bd1 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -107,8 +107,11 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
+/*
+ * Copy architecture-specific thread state
+ */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
-	unsigned long arg, struct task_struct *p)
+	unsigned long kthread_arg, struct task_struct *p)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
@@ -123,11 +126,12 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = read_c0_status() & ~(ST0_CU2|ST0_CU1);
 	if (unlikely(p->flags & PF_KTHREAD)) {
+		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
 		memset(childregs, 0, sizeof(struct pt_regs));
 		ti->addr_limit = KERNEL_DS;
 		p->thread.reg16 = usp; /* fn */
-		p->thread.reg17 = arg;
+		p->thread.reg17 = kthread_arg;
 		p->thread.reg29 = childksp;
 		p->thread.reg31 = (unsigned long) ret_from_kernel_thread;
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
@@ -139,6 +143,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		childregs->cp0_status = status;
 		return 0;
 	}
+
+	/* user thread */
 	*childregs = *regs;
 	childregs->regs[7] = 0; /* Clear error flag */
 	childregs->regs[2] = 0; /* Child gets zero as return value */
-- 
2.0.0.GIT
