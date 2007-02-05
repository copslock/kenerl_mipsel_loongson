Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 14:28:28 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.233]:6055 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037721AbXBEO0d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 14:26:33 +0000
Received: by hu-out-0506.google.com with SMTP id 22so786013hug
        for <linux-mips@linux-mips.org>; Mon, 05 Feb 2007 06:25:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=l1qbL9rW2DfVR7LsikKz519btKV1MDowhmL1VXxki1e44NYPUqHkvP+pxSAoGcRyohiPx046y+y8oISq0wJOPf2B1vivLPa0EnP7csdXFfklfzCBeosRyaOHWXmGQdXcBUEfe3XOumNkGpYrekAwBCrEq2EhheNGKd2GiYtEKAY=
Received: by 10.48.204.7 with SMTP id b7mr2279060nfg.1170685531926;
        Mon, 05 Feb 2007 06:25:31 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id l21sm27165639nfc.2007.02.05.06.25.30;
        Mon, 05 Feb 2007 06:25:30 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id B307723F775; Mon,  5 Feb 2007 15:24:29 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 6/10] signal: factorize debug code
Date:	Mon,  5 Feb 2007 15:24:24 +0100
Message-Id: <11706854692156-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11706854683935-git-send-email-fbuihuu@gmail.com>
References: <11706854683935-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal-common.h |    8 ++++++++
 arch/mips/kernel/signal.c        |   14 +++++---------
 arch/mips/kernel/signal32.c      |   16 ++++++----------
 arch/mips/kernel/signal_n32.c    |    7 ++-----
 4 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index 6700bde..9a8abd6 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -11,6 +11,14 @@
 #ifndef __SIGNAL_COMMON_H
 #define __SIGNAL_COMMON_H
 
+/* #define DEBUG_SIG */
+
+#ifdef DEBUG_SIG
+#  define DEBUGP(fmt, args...) printk("%s: " fmt, __FUNCTION__ , ##args)
+#else
+#  define DEBUGP(fmt, args...)
+#endif
+
 /*
  * Horribly complicated - with the bloody RM9000 workarounds enabled
  * the signal trampolines is moving to the end of the structure so we can
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 5245135..d3f6b0a 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -34,8 +34,6 @@
 
 #include "signal-common.h"
 
-#define DEBUG_SIG 0
-
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 #if ICACHE_REFILLS_WORKAROUND_WAR == 0
@@ -424,11 +422,10 @@ int setup_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	regs->regs[31] = (unsigned long) frame->sf_code;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
-#if DEBUG_SIG
-	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
+	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
-	       frame, regs->cp0_epc, frame->regs[31]);
-#endif
+	       frame, regs->cp0_epc, regs->regs[31]);
+
         return 0;
 
 give_sigsegv:
@@ -484,11 +481,10 @@ int setup_rt_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	regs->regs[31] = (unsigned long) frame->rs_code;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
-#if DEBUG_SIG
-	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
+	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
 	       frame, regs->cp0_epc, regs->regs[31]);
-#endif
+
 	return 0;
 
 give_sigsegv:
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 5934f33..1a99a57 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -104,8 +104,6 @@ typedef struct compat_siginfo {
 #define __NR_O32_rt_sigreturn		4193
 #define __NR_O32_restart_syscall	4253
 
-#define DEBUG_SIG 0
-
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 /* 32-bit compatibility types */
@@ -640,11 +638,10 @@ int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	regs->regs[31] = (unsigned long) frame->sf_code;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
-#if DEBUG_SIG
-	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
+	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
-	       frame, regs->cp0_epc, frame->sf_code);
-#endif
+	       frame, regs->cp0_epc, regs->regs[31]);
+
 	return 0;
 
 give_sigsegv:
@@ -701,11 +698,10 @@ int setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	regs->regs[31] = (unsigned long) frame->rs_code;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
-#if DEBUG_SIG
-	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
+	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
-	       frame, regs->cp0_epc, frame->rs_code);
-#endif
+	       frame, regs->cp0_epc, regs->regs[31]);
+
 	return 0;
 
 give_sigsegv:
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index f8e1539..a6c1e67 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -47,8 +47,6 @@
 #define __NR_N32_rt_sigreturn		6211
 #define __NR_N32_restart_syscall	6214
 
-#define DEBUG_SIG 0
-
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 /* IRIX compatible stack_t  */
@@ -221,11 +219,10 @@ int setup_rt_frame_n32(struct k_sigaction * ka,
 	regs->regs[31] = (unsigned long) frame->rs_code;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ka->sa.sa_handler;
 
-#if DEBUG_SIG
-	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
+	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
 	       current->comm, current->pid,
 	       frame, regs->cp0_epc, regs->regs[31]);
-#endif
+
 	return 0;
 
 give_sigsegv:
-- 
1.4.4.3.ge6d4
