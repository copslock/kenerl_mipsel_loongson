Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 03:38:17 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:60162 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6828076Ab2KVCfDoRjnY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Nov 2012 03:35:03 +0100
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 21 Nov 2012 18:34:55 -0800
Received: by agni.kymasys.com (Postfix, from userid 500)
        id B29B4630284; Wed, 21 Nov 2012 18:34:18 -0800 (PST)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 15/18] MIPS: Pull in MIPS fix: fix endless loop when processing signals for kernel tasks.
Date:   Wed, 21 Nov 2012 18:34:13 -0800
Message-Id: <1353551656-23579-16-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
X-archive-position: 35086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This bug is discussed in: http://lkml.indiana.edu/hypermail/linux/kernel/1205.2/00719.html

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kernel/entry.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index a6c1332..9b00362 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -36,6 +36,11 @@ FEXPORT(ret_from_exception)
 FEXPORT(ret_from_irq)
 	LONG_S	s0, TI_REGS($28)
 FEXPORT(__ret_from_irq)
+/*
+ * We can be coming here from a syscall done in the kernel space,
+ * e.g. a failed kernel_execve().
+ */
+resume_userspace_check:
 	LONG_L	t0, PT_STATUS(sp)		# returning to kernel mode?
 	andi	t0, t0, KU_USER
 	beqz	t0, resume_kernel
@@ -162,7 +167,7 @@ work_notifysig:				# deal with pending signals and
 	move	a0, sp
 	li	a1, 0
 	jal	do_notify_resume	# a2 already loaded
-	j	resume_userspace
+	j	resume_userspace_check
 
 FEXPORT(syscall_exit_partial)
 	local_irq_disable		# make sure need_resched doesn't
-- 
1.7.11.3
