Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Apr 2009 17:21:07 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:52007 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20030327AbZDPQVB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Apr 2009 17:21:01 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49e75add0000>; Thu, 16 Apr 2009 12:20:45 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 16 Apr 2009 09:20:27 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 16 Apr 2009 09:20:27 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n3GGKJl6003469;
	Thu, 16 Apr 2009 09:20:20 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n3GGKH3N003467;
	Thu, 16 Apr 2009 09:20:18 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Use 32-bit compatibility wrapers for sys_timerfd_{g,s}ettime
Date:	Thu, 16 Apr 2009 09:20:17 -0700
Message-Id: <1239898817-3443-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 16 Apr 2009 16:20:27.0189 (UTC) FILETIME=[40C3AE50:01C9BEAF]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The LTP timerfd01 test is failing (blocking forever) on the 32-bit
ABIs. We need to use the compat_* wrappers for these system calls.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/scall64-n32.S |    4 ++--
 arch/mips/kernel/scall64-o32.S |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index c2c16ef..93cc672 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -405,8 +405,8 @@ EXPORT(sysn32_call_table)
 	PTR	sys_eventfd
 	PTR	sys_fallocate
 	PTR	sys_timerfd_create
-	PTR	sys_timerfd_gettime		/* 5285 */
-	PTR	sys_timerfd_settime
+	PTR	compat_sys_timerfd_gettime	/* 5285 */
+	PTR	compat_sys_timerfd_settime
 	PTR	sys_signalfd4
 	PTR	sys_eventfd2
 	PTR	sys_epoll_create1
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 002fac2..a5598b2 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -525,8 +525,8 @@ sys_call_table:
 	PTR	sys_eventfd
 	PTR	sys32_fallocate			/* 4320 */
 	PTR	sys_timerfd_create
-	PTR	sys_timerfd_gettime
-	PTR	sys_timerfd_settime
+	PTR	compat_sys_timerfd_gettime
+	PTR	compat_sys_timerfd_settime
 	PTR	compat_sys_signalfd4
 	PTR	sys_eventfd2			/* 4325 */
 	PTR	sys_epoll_create1
-- 
1.6.0.6
