Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 11:26:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28207 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009050AbaIYJ0cGOMkh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 11:26:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 08C464D260EC9
        for <linux-mips@linux-mips.org>; Thu, 25 Sep 2014 10:26:23 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 25 Sep 2014 10:26:25 +0100
Received: from localhost.localdomain (192.168.159.161) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 25 Sep 2014 10:26:24 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: prevent compiler warning from cop2_{save,restore}
Date:   Thu, 25 Sep 2014 10:26:15 +0100
Message-ID: <1411637175-30010-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.161]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The no-op cases of cop2_save & cop2_restore lead to the following
warnings being emitted during build with recent versions of gcc (tested
using gcc 4.8.3 from the Mentor Sourcery CodeBench 2014.05 toolchain):

  In file included from ./arch/mips/include/asm/switch_to.h:18:0,
                   from kernel/sched/core.c:78:
  kernel/sched/core.c: In function 'finish_task_switch':
  include/asm-generic/current.h:6:45: warning: value computed is not used [-Wunused-value]
   #define get_current() (current_thread_info()->task)
                                               ^
  ./arch/mips/include/asm/cop2.h:48:32: note: in definition of macro 'cop2_restore'
   #define cop2_restore(r)  do { (r); } while (0)
                                  ^
  include/asm-generic/current.h:7:17: note: in expansion of macro 'get_current'
   #define current get_current()
                   ^
  ./arch/mips/include/asm/switch_to.h:114:16: note: in expansion of macro 'current'
     cop2_restore(current);     \
                  ^
  kernel/sched/core.c:2225:2: note: in expansion of macro 'finish_arch_switch'
    finish_arch_switch(prev);
    ^

Avoid the warning by "using" the value by casting to void.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/cop2.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cop2.h b/arch/mips/include/asm/cop2.h
index 51f80bd..63b3468 100644
--- a/arch/mips/include/asm/cop2.h
+++ b/arch/mips/include/asm/cop2.h
@@ -37,15 +37,15 @@ extern void nlm_cop2_restore(struct nlm_cop2_state *);
 
 #define cop2_present		1
 #define cop2_lazy_restore	1
-#define cop2_save(r)		do { (r); } while (0)
-#define cop2_restore(r)		do { (r); } while (0)
+#define cop2_save(r)		do { (void)(r); } while (0)
+#define cop2_restore(r)		do { (void)(r); } while (0)
 
 #else
 
 #define cop2_present		0
 #define cop2_lazy_restore	0
-#define cop2_save(r)		do { (r); } while (0)
-#define cop2_restore(r)		do { (r); } while (0)
+#define cop2_save(r)		do { (void)(r); } while (0)
+#define cop2_restore(r)		do { (void)(r); } while (0)
 #endif
 
 enum cu2_ops {
-- 
2.0.4
