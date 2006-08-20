Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Aug 2006 14:54:14 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:50122 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037812AbWHTNyM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 20 Aug 2006 14:54:12 +0100
Received: from localhost (p4006-ipad209funabasi.chiba.ocn.ne.jp [58.88.115.6])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4D99DA537; Sun, 20 Aug 2006 22:54:07 +0900 (JST)
Date:	Sun, 20 Aug 2006 22:55:52 +0900 (JST)
Message-Id: <20060820.225552.07643199.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	mlachwani@mvista.com
Subject: Re: [PATCH] TX49 has write buffer
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44E73DFD.5030404@ru.mvista.com>
References: <44E64687.7000704@ru.mvista.com>
	<44E73DFD.5030404@ru.mvista.com>
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
X-archive-position: 12376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 19 Aug 2006 20:36:13 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>     The uptimate reason is I think that <asm/system.h> doesn't
> include <asm/wbflush.h> if CONFIG_CPU_HAS_WB is undefined --
> although, <asm/wbflush.h> handles this situation itself. Well,
> <asm/system.h> doesn't need the wbflush() macro in that case, so
> it's in his own right to not include that header...

Yes, so I think we should include <asm/wbflush.h> if we used
wbflush().  Here is my proposal patch.


Subject: Fix build errors related to wbflush.h on tx4927/tx4938.

TX49 CPUs have a SYNC instruction so that CONFIG_CPU_HAS_WB is no
longer needed.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/tx4927/common/tx4927_setup.c b/arch/mips/tx4927/common/tx4927_setup.c
index 3ace403..4658b2a 100644
--- a/arch/mips/tx4927/common/tx4927_setup.c
+++ b/arch/mips/tx4927/common/tx4927_setup.c
@@ -53,19 +53,9 @@ void __init tx4927_time_init(void);
 void dump_cp0(char *key);
 
 
-void (*__wbflush) (void);
-
-static void tx4927_write_buffer_flush(void)
-{
-	__asm__ __volatile__
-	    ("sync\n\t" "nop\n\t" "loop: bc0f loop\n\t" "nop\n\t");
-}
-
-
 void __init plat_mem_setup(void)
 {
 	board_time_init = tx4927_time_init;
-	__wbflush = tx4927_write_buffer_flush;
 
 #ifdef CONFIG_TOSHIBA_RBTX4927
 	{
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
index b0f021f..1b7cde1 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -130,6 +130,7 @@ #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
+#include <asm/wbflush.h>
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #ifdef CONFIG_RTC_DS1742
diff --git a/arch/mips/tx4938/common/irq.c b/arch/mips/tx4938/common/irq.c
index dc30d66..f2be0ea 100644
--- a/arch/mips/tx4938/common/irq.c
+++ b/arch/mips/tx4938/common/irq.c
@@ -30,6 +30,7 @@ #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/mipsregs.h>
 #include <asm/system.h>
+#include <asm/wbflush.h>
 #include <asm/tx4938/rbtx4938.h>
 
 /**********************************************************************************/
diff --git a/arch/mips/tx4938/common/setup.c b/arch/mips/tx4938/common/setup.c
index 71859c4..f415a1f 100644
--- a/arch/mips/tx4938/common/setup.c
+++ b/arch/mips/tx4938/common/setup.c
@@ -41,29 +41,10 @@ void __init tx4938_setup(void);
 void __init tx4938_time_init(void);
 void dump_cp0(char *key);
 
-void (*__wbflush) (void);
-
-static void
-tx4938_write_buffer_flush(void)
-{
-	mmiowb();
-
-	__asm__ __volatile__(
-		".set	push\n\t"
-		".set	noreorder\n\t"
-		"lw	$0,%0\n\t"
-		"nop\n\t"
-		".set	pop"
-		: /* no output */
-		: "m" (*(int *)KSEG1)
-		: "memory");
-}
-
 void __init
 plat_mem_setup(void)
 {
 	board_time_init = tx4938_time_init;
-	__wbflush = tx4938_write_buffer_flush;
 	toshiba_rbtx4938_setup();
 }
 
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/irq.c b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
index 83f2750..8ef8c4e 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
@@ -84,6 +84,7 @@ #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
+#include <asm/wbflush.h>
 #include <linux/bootmem.h>
 #include <asm/tx4938/rbtx4938.h>
 
