Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 15:41:38 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:41421 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037629AbWIZOlg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2006 15:41:36 +0100
Received: from localhost (p5240-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4DD9EB50E; Tue, 26 Sep 2006 23:41:32 +0900 (JST)
Date:	Tue, 26 Sep 2006 23:43:40 +0900 (JST)
Message-Id: <20060926.234340.07643315.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, mingo@redhat.com
Subject: [PATCH 1/3] [MIPS] lockdep: fix TRACE_IRQFLAGS_SUPPORT
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
X-archive-position: 12673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

In handle_sys and its variants, we must reload some registers which
might be clobbered by trace_hardirqs_on().
Also we must make sure trace_hardirqs_on() called in kernel level (not
exception level).

This is a patch againt linux-mips.org git tree.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/kernel/scall32-o32.S |   13 +------------
 arch/mips/kernel/scall64-64.S  |    2 +-
 arch/mips/kernel/scall64-n32.S |    2 +-
 arch/mips/kernel/scall64-o32.S |    2 +-
 include/asm-mips/irqflags.h    |   25 +++++++++++++++++++++++++
 5 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index e717851..61362e6 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -28,18 +28,7 @@ #define MAX_SYSCALL_NO	__NR_O32_Linux + 
 NESTED(handle_sys, PT_SIZE, sp)
 	.set	noat
 	SAVE_SOME
-#ifdef CONFIG_TRACE_IRQFLAGS
-	TRACE_IRQS_ON
-#ifdef CONFIG_64BIT
-	LONG_L	$8, PT_R8(sp)
-	LONG_L	$9, PT_R9(sp)
-#endif
-	LONG_L	$7, PT_R7(sp)
-	LONG_L	$6, PT_R6(sp)
-	LONG_L	$5, PT_R5(sp)
-	LONG_L	$4, PT_R4(sp)
-	LONG_L	$2, PT_R2(sp)
-#endif
+	TRACE_IRQS_ON_RELOAD
 	STI
 	.set	at
 
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 4c22d0b..6c7b5ed 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -34,7 +34,7 @@ #if !defined(CONFIG_MIPS32_O32) && !defi
 	 */
 	.set	noat
 	SAVE_SOME
-	TRACE_IRQS_ON
+	TRACE_IRQS_ON_RELOAD
 	STI
 	.set	at
 #endif
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index f25c2a2..6d9f187 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -33,7 +33,7 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 #ifndef CONFIG_MIPS32_O32
 	.set	noat
 	SAVE_SOME
-	TRACE_IRQS_ON
+	TRACE_IRQS_ON_RELOAD
 	STI
 	.set	at
 #endif
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 288ee4a..2e6d067 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -28,7 +28,7 @@ #include <asm/sysmips.h>
 NESTED(handle_sys, PT_SIZE, sp)
 	.set	noat
 	SAVE_SOME
-	TRACE_IRQS_ON
+	TRACE_IRQS_ON_RELOAD
 	STI
 	.set	at
 	ld	t1, PT_EPC(sp)		# skip syscall on return
diff --git a/include/asm-mips/irqflags.h b/include/asm-mips/irqflags.h
index 43ca09a..46bf5de 100644
--- a/include/asm-mips/irqflags.h
+++ b/include/asm-mips/irqflags.h
@@ -213,12 +213,37 @@ #endif
  * Do the CPU's IRQ-state tracing from assembly code.
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
+/* Reload some registers clobbered by trace_hardirqs_on */
+#ifdef CONFIG_64BIT
+# define TRACE_IRQS_RELOAD_REGS						\
+	LONG_L	$11, PT_R11(sp);					\
+	LONG_L	$10, PT_R10(sp);					\
+	LONG_L	$9, PT_R9(sp);						\
+	LONG_L	$8, PT_R8(sp);						\
+	LONG_L	$7, PT_R7(sp);						\
+	LONG_L	$6, PT_R6(sp);						\
+	LONG_L	$5, PT_R5(sp);						\
+	LONG_L	$4, PT_R4(sp);						\
+	LONG_L	$2, PT_R2(sp)
+#else
+# define TRACE_IRQS_RELOAD_REGS						\
+	LONG_L	$7, PT_R7(sp);						\
+	LONG_L	$6, PT_R6(sp);						\
+	LONG_L	$5, PT_R5(sp);						\
+	LONG_L	$4, PT_R4(sp);						\
+	LONG_L	$2, PT_R2(sp)
+#endif
 # define TRACE_IRQS_ON							\
+	CLI;	/* make sure trace_hardirqs_on() is called in kernel level */ \
 	jal	trace_hardirqs_on
+# define TRACE_IRQS_ON_RELOAD						\
+	TRACE_IRQS_ON;							\
+	TRACE_IRQS_RELOAD_REGS
 # define TRACE_IRQS_OFF							\
 	jal	trace_hardirqs_off
 #else
 # define TRACE_IRQS_ON
+# define TRACE_IRQS_ON_RELOAD
 # define TRACE_IRQS_OFF
 #endif
 
