Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2012 08:14:20 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:35914 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816900Ab2LQHOTFHVZD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Dec 2012 08:14:19 +0100
Received: by mail-bk0-f49.google.com with SMTP id jm19so2462281bkc.36
        for <multiple recipients>; Sun, 16 Dec 2012 23:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=iO6xG+psKnJMxYSfQTrK9dy3/w2pnIx5NwyLEm7/nsE=;
        b=tOMpTMoHmQxb5RrfhyyvsEXsh+USinSzLB0ezo/M/kavUz6gHgnuHeArsEUq6v3LxN
         jnA7yhrbjzdVuDDVjoCJb0aRn7HjSKQZeF/4u/4FWwcEhiXkIeCJDevENK0g+wvKHsed
         SXy+WeoQ6u/JwvoYGsKTPJ3BxLsqkh+F4PPQKmWMPX9IsyM5ZXLAjp+XKISdzVIIF6Pl
         1ggH48PS4Zjc7xf1nA2IZgRSgQDOPoA7u5TXPk1cf8nWUKScO0Gkkp2UgyoCyCf5+BG7
         1k6u4QcJjtou3uudhxlHfTw4JlRvfZo0a6gIaCAioe2wPRaeOhdM+WPNu6iZO10FD/Yg
         rp3A==
Received: by 10.204.149.149 with SMTP id t21mr5382838bkv.85.1355728453634;
        Sun, 16 Dec 2012 23:14:13 -0800 (PST)
Received: from flagship.roarinelk.net (178-191-3-232.adsl.highway.telekom.at. [178.191.3.232])
        by mx.google.com with ESMTPS id 18sm8349777bkv.0.2012.12.16.23.14.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 23:14:12 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2] MIPS: Alchemy: make 32kHz and r4k timer coexist peacefully
Date:   Mon, 17 Dec 2012 08:14:08 +0100
Message-Id: <1355728448-24220-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.0.2
X-archive-position: 35299
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

Now that the r4k timer is registered no matter what, bump the rating of
the Alchemy 32kHz timer so that it gets used when it is working,
and fall back on the r4k when it isn't.

This fixes a timer-related hang on platform with a working 32kHz timer
(the better rated c0 timer stops while executing 'wait' leading to (almost)
eternal sleep) and an oops on boot on platforms without a working 32kHz timer
(due to double registration of the r4k timer).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: address Sergey's comments.

On top of Linus' latest -git.

This is a quick fix, it's far less invasive than my preferred solution:
having each platform register the r4k clocksource explicitly.
It should be enough until Alchemy variants with speeds >= 1.3GHz appear
(which I believe is _very_ unlikely).

 arch/mips/alchemy/common/time.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index a7193ae..b67930d 100644
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
@@ -186,8 +172,7 @@ void __init plat_time_init(void)
 	int t;
 
 	t = alchemy_get_cputype();
-	if (t == ALCHEMY_CPU_UNKNOWN)
-		alchemy_setup_c0timer();
-	else if (alchemy_time_init(alchemy_m2inttab[t]))
-		alchemy_setup_c0timer();
+	if (t == ALCHEMY_CPU_UNKNOWN ||
+	    alchemy_time_init(alchemy_m2inttab[t]))
+		cpu_wait = NULL;	/* wait doesn't work with r4k timer */
 }
-- 
1.8.0.2
