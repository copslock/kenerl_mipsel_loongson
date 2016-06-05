Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:44:45 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042447AbcFEVmiueeRp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:42:38 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BFBB7723;
        Sun,  5 Jun 2016 21:42:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 08/99] MIPS: Fix watchpoint restoration
Date:   Sun,  5 Jun 2016 14:40:41 -0700
Message-Id: <20160605213903.817912051@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605213902.974592018@linuxfoundation.org>
References: <20160605213902.974592018@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit a7e89326b415b5d81c4b1016fd4a40db861eb58d upstream.

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
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12726/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/switch_to.h |    2 +-
 arch/mips/include/asm/watch.h     |   10 +++++-----
 arch/mips/kernel/pm.c             |    2 +-
 arch/mips/kernel/watch.c          |    5 ++---
 4 files changed, 9 insertions(+), 10 deletions(-)

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
--- a/arch/mips/kernel/pm.c
+++ b/arch/mips/kernel/pm.c
@@ -56,7 +56,7 @@ static void mips_cpu_restore(void)
 		write_c0_userlocal(current_thread_info()->tp_value);
 
 	/* Restore watch registers */
-	__restore_watch();
+	__restore_watch(current);
 }
 
 /**
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
