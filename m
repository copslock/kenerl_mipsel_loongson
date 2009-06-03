Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 18:04:23 +0100 (WEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:54891 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022411AbZFCRDF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 18:03:05 +0100
Received: by bwz25 with SMTP id 25so145420bwz.0
        for <multiple recipients>; Wed, 03 Jun 2009 10:02:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jEwyiyWr733dMBcCUvFqr99XZNSj02w2fbxgn6jSYPM=;
        b=NRDQhfXkSdxS39Wx0FlNBuJnAf52sVoFedv5wSu1e4EXesThLkuYVwmyU/FjuOlF/7
         517XBN0nrymUr027i5p2R3CNjToP3pjhk4t8uss3Sd1MHMGheZMQgmJJOQYVhB7PxYHD
         NvjuRJrM5isSmVxmF3Fog2hp97l+5L2rpCMAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n8mm/XA7BKymd9y8MLuG9tMcu9cEiD/xQlUL6jTJ/HxvevI1vB/bDCATZIqU+gqiC4
         dyTx1t4X8iUwJW2Xfezjboov2lmrqkG0uELE3kb1LPBBT+isEeltmJqQR5yquUTEYnba
         lDyseebFrbptDLhFnAEBd7EL0ldGNS34sJmTk=
Received: by 10.204.55.199 with SMTP id v7mr1069074bkg.141.1244048578844;
        Wed, 03 Jun 2009 10:02:58 -0700 (PDT)
Received: from localhost.localdomain (p5496DB58.dip.t-dialin.net [84.150.219.88])
        by mx.google.com with ESMTPS id 18sm2452543fks.10.2009.06.03.10.02.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 10:02:58 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/5] Alchemy: get rid of allow_au1k_wait
Date:	Wed,  3 Jun 2009 19:02:45 +0200
Message-Id: <1244048568-18006-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244048568-18006-2-git-send-email-manuel.lauss@gmail.com>
References: <1244048568-18006-1-git-send-email-manuel.lauss@gmail.com>
 <1244048568-18006-2-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23230
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

This also corrects the 'wait instruction available' output in cpuinfo.

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
