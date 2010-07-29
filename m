Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jul 2010 22:43:24 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14912 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490986Ab0G2UnU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jul 2010 22:43:20 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c51e8010000>; Thu, 29 Jul 2010 13:43:45 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 29 Jul 2010 13:43:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 29 Jul 2010 13:43:17 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6TKh96W024125;
        Thu, 29 Jul 2010 13:43:09 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6TKh6XB024124;
        Thu, 29 Jul 2010 13:43:06 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Fix n32 syscall number comments.
Date:   Thu, 29 Jul 2010 13:43:04 -0700
Message-Id: <1280436184-24092-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 29 Jul 2010 20:43:17.0253 (UTC) FILETIME=[AC313B50:01CB2F5E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/scall64-n32.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index a4facee..a3d6613 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -400,22 +400,22 @@ EXPORT(sysn32_call_table)
 	PTR	sys_ioprio_set
 	PTR	sys_ioprio_get
 	PTR	compat_sys_utimensat
-	PTR	compat_sys_signalfd		/* 5280 */
+	PTR	compat_sys_signalfd		/* 6280 */
 	PTR	sys_ni_syscall
 	PTR	sys_eventfd
 	PTR	sys_fallocate
 	PTR	sys_timerfd_create
-	PTR	compat_sys_timerfd_gettime	/* 5285 */
+	PTR	compat_sys_timerfd_gettime	/* 6285 */
 	PTR	compat_sys_timerfd_settime
 	PTR	sys_signalfd4
 	PTR	sys_eventfd2
 	PTR	sys_epoll_create1
-	PTR	sys_dup3			/* 5290 */
+	PTR	sys_dup3			/* 6290 */
 	PTR	sys_pipe2
 	PTR	sys_inotify_init1
 	PTR	sys_preadv
 	PTR	sys_pwritev
-	PTR	compat_sys_rt_tgsigqueueinfo	/* 5295 */
+	PTR	compat_sys_rt_tgsigqueueinfo	/* 6295 */
 	PTR	sys_perf_event_open
 	PTR	sys_accept4
 	PTR     compat_sys_recvmmsg
-- 
1.7.1.1
