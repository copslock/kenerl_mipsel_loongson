Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 13:38:57 +0200 (CEST)
Received: from mail.zhinst.com ([212.126.164.98]:46312 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992800AbdIRLitETZmD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Sep 2017 13:38:49 +0200
Received: from ziws08.zhinst.com ([10.42.0.7])
        by mail.zhinst.com (Kerio Connect 9.2.4) with ESMTP;
        Mon, 18 Sep 2017 13:38:40 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: make thread_saved_pc static
Date:   Mon, 18 Sep 2017 13:38:40 +0200
Message-Id: <20170918113840.28861-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.13.0
Return-Path: <tklauser@distanz.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tklauser@distanz.ch
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

The only user of thread_saved_pc() in non-arch-specific code was removed
in commit 8243d5597793 ("sched/core: Remove pointless printout in
sched_show_task()"), so it no longer needs to be globally defined for
MIPS and can be made static.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/mips/include/asm/processor.h | 2 --
 arch/mips/kernel/process.c        | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 95b8c471f572..af34afbc32d9 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -368,8 +368,6 @@ struct task_struct;
 /* Free all resources held by a thread. */
 #define release_thread(thread) do { } while(0)
 
-extern unsigned long thread_saved_pc(struct task_struct *tsk);
-
 /*
  * Do necessary setup to start up a newly executed thread.
  */
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index c5ff6bfe2825..45d0b6b037ee 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -487,7 +487,7 @@ arch_initcall(frame_info_init);
 /*
  * Return saved PC of a blocked thread.
  */
-unsigned long thread_saved_pc(struct task_struct *tsk)
+static unsigned long thread_saved_pc(struct task_struct *tsk)
 {
 	struct thread_struct *t = &tsk->thread;
 
-- 
2.13.0
