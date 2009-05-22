Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 21:24:48 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.152]:32772 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022517AbZEVUYj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2009 21:24:39 +0100
Received: by fg-out-1718.google.com with SMTP id 22so767795fge.9
        for <linux-mips@linux-mips.org>; Fri, 22 May 2009 13:24:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=AblUFA2zqk3ke9hoTLAS28H94kKcPmVEw/4lPvq/caU=;
        b=gxeI8PIHuJ80xl3mGyu7oE7lGGfvmJ8JiCD4muWdvWtCYk+/4EBVinwVzXr6nPQfOW
         bf5cdSZSuA1ZE2oGwoZOGy2kkusIYtcoP9YIfH8frm4jwndBKtrzm1qdHHx2HmFQ3uS9
         MMTmPoy1Vj6DYT+aON9zegsA80jXDUNQbRqq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=RXPv0uN5cOYj09D78lEboCq15ohLwJOSyicGXCvE0sYUWJgU99b8warUMntADgyok5
         L7JY9nOrtpbShEx1WqknE2Hdehl8YW4doUixTiKqLzgcS4AbAcYJ6Dyxl8CFLY8r+bM5
         uWk/Y7W7bA8lRg1DEM2yEiD9UXD+ae92G3g/Q=
Received: by 10.86.82.17 with SMTP id f17mr3451394fgb.65.1243023878848;
        Fri, 22 May 2009 13:24:38 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 4sm1527278fge.13.2009.05.22.13.24.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 May 2009 13:24:37 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] Alchemy: get rid of allow_au1k_wait
Date:	Fri, 22 May 2009 22:24:18 +0200
Message-Id: <1243023858-10286-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22928
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
