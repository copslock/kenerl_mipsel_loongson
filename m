Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 23:20:18 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8597 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012497AbcCAWT6pFYJ- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 23:19:58 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id AE906980F46A4;
        Tue,  1 Mar 2016 22:19:48 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 22:19:52 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 22:19:52 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/4] MIPS: Fix watchpoint restoration
Date:   Tue, 1 Mar 2016 22:19:36 +0000
Message-ID: <1456870779-21007-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1456870779-21007-1-git-send-email-james.hogan@imgtec.com>
References: <1456870779-21007-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Commit f51246efee2b ("MIPS: Get rid of finish_arch_switch().") moved the
__restore_watch() call from finish_arch_switch() (i.e. after resume()
returns) to before the resume() call in switch_to(). This results in
watchpoints only being restored when a task is descheduled, preventing
the watchpoints from being effective most of the time, except due to
chance before the watchpoints are lazily removed.

Fix the call sequence from switch_to() through to
mips_install_watch_registers() to pass the task_struct pointer of the
next task, instead of using current. This allows the watchpoints for the
next (non-current) task to be restored without reintroducing
finish_arch_switch().

Fixes: f51246efee2b ("MIPS: Get rid of finish_arch_switch().")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.3.x-
---
 arch/mips/include/asm/switch_to.h |  2 +-
 arch/mips/include/asm/watch.h     | 10 +++++-----
 arch/mips/kernel/pm.c             |  2 +-
 arch/mips/kernel/watch.c          |  5 ++---
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index 28b5d84a5022..ebb5c0f2f90d 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -105,7 +105,7 @@ do {									\
 	__clear_software_ll_bit();					\
 	if (cpu_has_userlocal)						\
 		write_c0_userlocal(task_thread_info(next)->tp_value);	\
-	__restore_watch();						\
+	__restore_watch(next);						\
 	(last) = resume(prev, next, task_thread_info(next));		\
 } while (0)
 
diff --git a/arch/mips/include/asm/watch.h b/arch/mips/include/asm/watch.h
index 20126ec79359..6ffe3eadf105 100644
--- a/arch/mips/include/asm/watch.h
+++ b/arch/mips/include/asm/watch.h
@@ -12,21 +12,21 @@
 
 #include <asm/mipsregs.h>
 
-void mips_install_watch_registers(void);
+void mips_install_watch_registers(struct task_struct *t);
 void mips_read_watch_registers(void);
 void mips_clear_watch_registers(void);
 void mips_probe_watch_registers(struct cpuinfo_mips *c);
 
 #ifdef CONFIG_HARDWARE_WATCHPOINTS
-#define __restore_watch() do {						\
+#define __restore_watch(task) do {					\
 	if (unlikely(test_bit(TIF_LOAD_WATCH,				\
-			      &current_thread_info()->flags))) {	\
-		mips_install_watch_registers();				\
+			      &task_thread_info(task)->flags))) {	\
+		mips_install_watch_registers(task);			\
 	}								\
 } while (0)
 
 #else
-#define __restore_watch() do {} while (0)
+#define __restore_watch(task) do {} while (0)
 #endif
 
 #endif /* _ASM_WATCH_H */
diff --git a/arch/mips/kernel/pm.c b/arch/mips/kernel/pm.c
index fefdf39d3df3..dc814892133c 100644
--- a/arch/mips/kernel/pm.c
+++ b/arch/mips/kernel/pm.c
@@ -56,7 +56,7 @@ static void mips_cpu_restore(void)
 		write_c0_userlocal(current_thread_info()->tp_value);
 
 	/* Restore watch registers */
-	__restore_watch();
+	__restore_watch(current);
 }
 
 /**
diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
index 2a03abb5bd2c..9b78e375118e 100644
--- a/arch/mips/kernel/watch.c
+++ b/arch/mips/kernel/watch.c
@@ -15,10 +15,9 @@
  * Install the watch registers for the current thread.	A maximum of
  * four registers are installed although the machine may have more.
  */
-void mips_install_watch_registers(void)
+void mips_install_watch_registers(struct task_struct *t)
 {
-	struct mips3264_watch_reg_state *watches =
-		&current->thread.watch.mips3264;
+	struct mips3264_watch_reg_state *watches = &t->thread.watch.mips3264;
 	switch (current_cpu_data.watch_reg_use_cnt) {
 	default:
 		BUG();
-- 
2.4.10
