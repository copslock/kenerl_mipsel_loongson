Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2006 16:58:35 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:448 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037849AbWIFP6d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2006 16:58:33 +0100
Received: from localhost (p4200-ipad31funabasi.chiba.ocn.ne.jp [221.189.128.200])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 15843AAA0; Thu,  7 Sep 2006 00:58:27 +0900 (JST)
Date:	Thu, 07 Sep 2006 01:00:22 +0900 (JST)
Message-Id: <20060907.010022.126141861.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix errors detected by "make headers_check"
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* export asm/sgidefs.h
* include asm/isadep.h only if in kernel
* do not export contents of asm/timex.h and asm/user.h

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 Kbuild   |    2 ++
 ptrace.h |    3 +--
 timex.h  |    4 ++++
 user.h   |    4 ++++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/asm-mips/Kbuild b/include/asm-mips/Kbuild
index c68e168..01ea3e0 100644
--- a/include/asm-mips/Kbuild
+++ b/include/asm-mips/Kbuild
@@ -1 +1,3 @@
 include include/asm-generic/Kbuild.asm
+
+header-y += sgidefs.h
diff --git a/include/asm-mips/ptrace.h b/include/asm-mips/ptrace.h
index 4113316..4fb0fc4 100644
--- a/include/asm-mips/ptrace.h
+++ b/include/asm-mips/ptrace.h
@@ -10,8 +10,6 @@ #ifndef _ASM_PTRACE_H
 #define _ASM_PTRACE_H
 
 
-#include <asm/isadep.h>
-
 /* 0 - 31 are integer registers, 32 - 63 are fp registers.  */
 #define FPR_BASE	32
 #define PC		64
@@ -73,6 +71,7 @@ #define PTRACE_GET_THREAD_AREA_3264	0xc4
 #ifdef __KERNEL__
 
 #include <linux/linkage.h>
+#include <asm/isadep.h>
 
 /*
  * Does the process account for user or for system time?
diff --git a/include/asm-mips/timex.h b/include/asm-mips/timex.h
index 98aa737..b80de8e 100644
--- a/include/asm-mips/timex.h
+++ b/include/asm-mips/timex.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_TIMEX_H
 #define _ASM_TIMEX_H
 
+#ifdef __KERNEL__
+
 #include <asm/mipsregs.h>
 
 /*
@@ -51,4 +53,6 @@ static inline cycles_t get_cycles (void)
 	return read_c0_count();
 }
 
+#endif /* __KERNEL__ */
+
 #endif /*  _ASM_TIMEX_H */
diff --git a/include/asm-mips/user.h b/include/asm-mips/user.h
index 89bf8b4..61f2a09 100644
--- a/include/asm-mips/user.h
+++ b/include/asm-mips/user.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_USER_H
 #define _ASM_USER_H
 
+#ifdef __KERNEL__
+
 #include <asm/page.h>
 #include <asm/reg.h>
 
@@ -55,4 +57,6 @@ #define HOST_TEXT_START_ADDR	(u.start_co
 #define HOST_DATA_START_ADDR	(u.start_data)
 #define HOST_STACK_END_ADDR	(u.start_stack + u.u_ssize * NBPG)
 
+#endif /* __KERNEL__ */
+
 #endif /* _ASM_USER_H */
