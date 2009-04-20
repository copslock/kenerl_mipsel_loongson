Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 19:56:57 +0100 (BST)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:38360 "EHLO
	mail-fx0-f175.google.com") by ftp.linux-mips.org with ESMTP
	id S29032551AbZDTSzB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Apr 2009 19:55:01 +0100
Received: by fxm23 with SMTP id 23so2288445fxm.0
        for <linux-mips@linux-mips.org>; Mon, 20 Apr 2009 11:54:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=EZ8OXQ8enfvxktifDdII2j3nXFgRWxRANF4/u5Xhp4w=;
        b=Y/VDbILvqlkKZ4cpzPPzuYftR5iqcwpxWJbkLUscPzZJhWuuMIwM35xG4eNmfnkv2H
         vgBtSYTVhyTHcpB9aNT189yAK3/Ll+nwZGDNjFJChMoRpOSXpJJ415576CJ/KBVNsf96
         9agdLtDg6k+Dd/M/ErArZ6tOJ+qzsAV7za3Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=JLAmqht2yANRT3hER48vdj0NQ/Ai+AiLlvrvySncZr652jS6gLgMV8nMYnqA2HSMHo
         3bWT7bqiJKlg1pmUZND+6V2FdVUk4Ln196N7ZtU565bL8byKbt0HevfKwyUm1dgnosVR
         VR3lc+HADybVbtCXSCZGYcj3RjKKvJspW1uEM=
Received: by 10.103.24.11 with SMTP id b11mr3279727muj.76.1240253694668;
        Mon, 20 Apr 2009 11:54:54 -0700 (PDT)
Received: from localhost.localdomain (p5496DEF2.dip.t-dialin.net [84.150.222.242])
        by mx.google.com with ESMTPS id s10sm14757680mue.16.2009.04.20.11.54.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 11:54:53 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] Alchemy: get rid of 'allow_au1k_wait'
Date:	Mon, 20 Apr 2009 20:54:33 +0200
Message-Id: <1240253673-29695-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2.3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Eliminate the 'allow_au1k_wait' variable.  MIPS kernel installs the
Alchemy-specific wait code before timer initialization;  if the C0
timer must be used for timekeeping the wait function is set to NULL
which means no wait implementation is available.

This also corrects the 'wait instruction available' output in cpuinfo.

Run-tested on DB1200.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/time.c |   14 ++++++++------
 arch/mips/kernel/cpu-probe.c    |   10 +++-------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index f58d4ff..562bfbd 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -36,14 +36,13 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 
+#include <asm/processor.h>	/* for cpu_wait */
 #include <asm/time.h>
 #include <asm/mach-au1x00/au1000.h>
 
 /* 32kHz clock enabled and detected */
 #define CNTR_OK (SYS_CNTRL_E0 | SYS_CNTRL_32S)
 
-extern int allow_au1k_wait; /* default off for CP0 Counter */
-
 static cycle_t au1x_counter1_read(void)
 {
 	return au_readl(SYS_RTCREAD);
@@ -153,13 +152,16 @@ void __init plat_time_init(void)
 
 	printk(KERN_INFO "Alchemy clocksource installed\n");
 
-	/* can now use 'wait' */
-	allow_au1k_wait = 1;
 	return;
 
 cntr_err:
-	/* counters unusable, use C0 counter */
+	/* MIPS kernel assigns 'au1k_wait' to 'cpu_wait' before this
+	 * function is called.  Because the Alchemy counters are unusable
+	 * the C0 timekeeping code is installed and the use of the 'wait'
+	 * instruction must be prohibited, which is done most easily by
+	 * assigning NULL to cpu_wait.
+	 */
+	cpu_wait = NULL;
 	r4k_clockevent_init();
 	init_r4k_clocksource();
-	allow_au1k_wait = 0;
 }
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b13b8eb..262ea9c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -91,15 +91,11 @@ static void rm7k_wait_irqoff(void)
 }
 
 /* The Au1xxx wait is available only if using 32khz counter or
- * external timer source, but specifically not CP0 Counter. */
-int allow_au1k_wait;
-
+ * external timer source, but specifically not CP0 Counter.
+ * alchemy/common/time.c may override cpu_wait!
+ */
 static void au1k_wait(void)
 {
-	if (!allow_au1k_wait)
-		return;
-
-	/* using the wait instruction makes CP0 counter unusable */
 	__asm__("	.set	mips3			\n"
 		"	cache	0x14, 0(%0)		\n"
 		"	cache	0x14, 32(%0)		\n"
-- 
1.6.2.3
