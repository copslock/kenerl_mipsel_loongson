Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Aug 2009 18:09:56 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:33132 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492936AbZHVQJb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Aug 2009 18:09:31 +0200
Received: by mail-bw0-f208.google.com with SMTP id 4so1099359bwz.0
        for <multiple recipients>; Sat, 22 Aug 2009 09:09:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=qqU5iqOJkK0Gmre35ek6u5BE2JR47l/oCVlvrZz9R58=;
        b=n9w4Iv1qpUyKSJQQqQJwEHTndI54SneCnLKGh75xaOBdTsc4av0dlWuMaJI5ApmlR1
         7rAl0KOVVwGM83B3g1kvfjPBGtLVhE3ZFcT9GKn/Rkfg6RHz+8qsLridNptOGyLcz9o1
         3+0bTy7oQf+3Zj8OE9IV88JZvw/PNkd/gmpDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hezOs9/NSjsf7PwEAzF9D43SWArry/TZAqhMF7YC2UfT7NwT7fP+I/fnmLpmfje6iJ
         hFpNDlZ+Obe+KdoWGYjS3NApyul7/EcJ+Vr4a7wtPRsSSmzeTnkqehxaMI/rSkk4Dd+v
         HfjCC397EIyMay9Cs+k6GN0USXCrEWV27Gw7o=
Received: by 10.223.132.204 with SMTP id c12mr1608416fat.32.1250957370753;
        Sat, 22 Aug 2009 09:09:30 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id p17sm4088378fka.42.2009.08.22.09.09.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Aug 2009 09:09:29 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] Alchemy: get rid of allow_au1k_wait
Date:	Sat, 22 Aug 2009 18:09:27 +0200
Message-Id: <1250957367-14389-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Eliminate the 'allow_au1k_wait' variable.  MIPS kernel installs the
Alchemy-specific wait code before timer initialization;  if the C0
timer must be used for timekeeping the wait function is set to NULL
which means no wait implementation is available.

As a sideeffect, the 'wait instruction available' output in
/proc/cpuinfo now correctly indicates whether 'wait' is usable.

Run-tested on DB1200.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/time.c |   14 ++++++++------
 arch/mips/kernel/cpu-probe.c    |   10 +++-------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 33fbae7..9fc0d44 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -36,14 +36,13 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 
+#include <asm/processor.h>
 #include <asm/time.h>
 #include <asm/mach-au1x00/au1000.h>
 
 /* 32kHz clock enabled and detected */
 #define CNTR_OK (SYS_CNTRL_E0 | SYS_CNTRL_32S)
 
-extern int allow_au1k_wait; /* default off for CP0 Counter */
-
 static cycle_t au1x_counter1_read(struct clocksource *cs)
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
+	 * the C0 timekeeping code is installed and use of the 'wait'
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
1.6.3.1
