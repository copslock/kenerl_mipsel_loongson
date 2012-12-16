Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Dec 2012 20:41:49 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:44580 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823059Ab2LPTlry0hwJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Dec 2012 20:41:47 +0100
Received: by mail-bk0-f49.google.com with SMTP id jm19so2353786bkc.36
        for <multiple recipients>; Sun, 16 Dec 2012 11:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gBlJZw82KRibjIa9dMuttcVeP6JODlfrzAPmbcwhwtE=;
        b=SSULHaDmsbKqhjBK8jYV8hfoBusXDbnJPeH0DmJgngzr87OGxeKeVYIUYEZHOGFjRQ
         hdl+he6l0Vn8QBGs7RD7aSpdeo/pvMel/UdNnnFr9tZ7zZkkW1idZgo+Ur51nhhmSv2N
         4qglPJMutX3D4kQgtbfCN4gClOiDPZFgpaYdBUks9SjCFkHWTZXPWwe75Q1n5awIYC4H
         6/OrLst6aNOEKkanCsp9QXHYt7WPJa9AX22AnXHwJ3JxKdkJBQWwRPU+0c4FECj+Op3d
         MXLCncHh8ckZEDGxhoNevQn1ttJizbys8d3shg+tdE20RgvuHjVenS8Jht/DjGleTSk3
         U/cQ==
Received: by 10.204.151.21 with SMTP id a21mr5141023bkw.124.1355686902381;
        Sun, 16 Dec 2012 11:41:42 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-154-9.adsl.highway.telekom.at. [188.22.154.9])
        by mx.google.com with ESMTPS id v8sm7861031bku.6.2012.12.16.11.41.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 11:41:41 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: make 32kHz and r4k timer coexist peacefully
Date:   Sun, 16 Dec 2012 20:41:36 +0100
Message-Id: <1355686896-26001-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.8.0.2
X-archive-position: 35297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Manuel Lauss <manuel.lauss@gmail.com>

Now that the r4k timer is registered no matter what, bump the rating of
the Alchemy 32kHz timer so that it gets used when it is working,
and fall back on the r4k when it isn't.

This fixes a timer-related hang on platform with a working 32kHz timer
(the better rated c0 timer stops while executing 'wait' leading to (almost) 
eternal sleep) and an oops on boot on platforms without a working 32kHz timer
(due to double registration of the r4k timer).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
For what is to become 3.8.

This is a quick fix; it's far less invasive than my preferred solution:
having each platform register the r4k clocksource explicitly.
It should be enough until Alchemy variants with speeds >= 1.3GHz appear
(which is very unlikely).

 arch/mips/alchemy/common/time.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index a7193ae..12589d0 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -53,7 +53,7 @@ static struct clocksource au1x_counter1_clocksource = {
 	.read		= au1x_counter1_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-	.rating		= 100,
+	.rating		= 1500,
 };
 
 static int au1x_rtcmatch2_set_next_event(unsigned long delta,
@@ -84,7 +84,7 @@ static irqreturn_t au1x_rtcmatch2_irq(int irq, void *dev_id)
 static struct clock_event_device au1x_rtcmatch2_clockdev = {
 	.name		= "rtcmatch2",
 	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 100,
+	.rating		= 1500,
 	.set_next_event	= au1x_rtcmatch2_set_next_event,
 	.set_mode	= au1x_rtcmatch2_set_mode,
 	.cpumask	= cpu_all_mask,
@@ -158,20 +158,6 @@ cntr_err:
 	return -1;
 }
 
-static void __init alchemy_setup_c0timer(void)
-{
-	/*
-	 * MIPS kernel assigns 'au1k_wait' to 'cpu_wait' before this
-	 * function is called.  Because the Alchemy counters are unusable
-	 * the C0 timekeeping code is installed and use of the 'wait'
-	 * instruction must be prohibited, which is done most easily by
-	 * assigning NULL to cpu_wait.
-	 */
-	cpu_wait = NULL;
-	r4k_clockevent_init();
-	init_r4k_clocksource();
-}
-
 static int alchemy_m2inttab[] __initdata = {
 	AU1000_RTC_MATCH2_INT,
 	AU1500_RTC_MATCH2_INT,
@@ -183,11 +169,8 @@ static int alchemy_m2inttab[] __initdata = {
 
 void __init plat_time_init(void)
 {
-	int t;
-
-	t = alchemy_get_cputype();
-	if (t == ALCHEMY_CPU_UNKNOWN)
-		alchemy_setup_c0timer();
-	else if (alchemy_time_init(alchemy_m2inttab[t]))
-		alchemy_setup_c0timer();
+	int t = alchemy_get_cputype();
+	if ((t == ALCHEMY_CPU_UNKNOWN) ||
+	    (alchemy_time_init(alchemy_m2inttab[t])))
+		cpu_wait = NULL;	/* wait doesn't work with r4k timer */
 }
-- 
1.8.0.2
