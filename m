Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2009 10:01:25 +0000 (GMT)
Received: from xylophone.i-cable.com ([203.83.115.99]:39649 "HELO
	xylophone.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20808465AbZCLKBT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Mar 2009 10:01:19 +0000
Received: (qmail 2049 invoked by uid 508); 12 Mar 2009 10:01:12 -0000
Received: from 203.83.114.121 by xylophone (envelope-from <r0bertz@gentoo.org>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7737.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.18152 secs); 12 Mar 2009 10:01:12 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 12 Mar 2009 10:01:12 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n2CA10tK023953;
	Thu, 12 Mar 2009 18:01:12 +0800 (HKT)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH] MIPS: fix TIF_32BIT undefined problem when seccomp is disabled
Date:	Thu, 12 Mar 2009 18:00:50 +0800
Message-Id: <1236852050-22266-1-git-send-email-r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.2
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 arch/mips/include/asm/seccomp.h     |    4 ----
 arch/mips/include/asm/thread_info.h |    6 ++++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/seccomp.h b/arch/mips/include/asm/seccomp.h
index a6772e9..ae6306e 100644
--- a/arch/mips/include/asm/seccomp.h
+++ b/arch/mips/include/asm/seccomp.h
@@ -15,8 +15,6 @@
  */
 #ifdef CONFIG_MIPS32_O32
 
-#define TIF_32BIT TIF_32BIT_REGS
-
 #define __NR_seccomp_read_32		4003
 #define __NR_seccomp_write_32		4004
 #define __NR_seccomp_exit_32		4001
@@ -24,8 +22,6 @@
 
 #elif defined(CONFIG_MIPS32_N32)
 
-#define TIF_32BIT _TIF_32BIT_ADDR
-
 #define __NR_seccomp_read_32		6000
 #define __NR_seccomp_write_32		6001
 #define __NR_seccomp_exit_32		6058
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 3f76de7..676aa2a 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -127,6 +127,12 @@ register struct thread_info *__current_thread_info __asm__("$28");
 #define TIF_LOAD_WATCH		25	/* If set, load watch registers */
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
+#ifdef CONFIG_MIPS32_O32
+#define TIF_32BIT TIF_32BIT_REGS
+#elif defined(CONFIG_MIPS32_N32)
+#define TIF_32BIT _TIF_32BIT_ADDR
+#endif /* CONFIG_MIPS32_O32 */
+
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
-- 
1.6.2
