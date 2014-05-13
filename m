Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2014 17:07:50 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:56779 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6854807AbaEMPHYpC3ne (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 May 2014 17:07:24 +0200
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1WkEIU-0001vh-8E; Tue, 13 May 2014 17:07:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Hua Yan <yanh@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Hongliang Tao <taohl@lemote.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] MIPS: Lemote 2F: cs5536: mfgpt: use raw locks
Date:   Tue, 13 May 2014 17:07:04 +0200
Message-Id: <1399993625-8747-1-git-send-email-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.0.0.rc0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <bigeasy@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bigeasy@linutronix.de
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

The lock is taken in the raw irq path and therefore a rawlock should be
used instead of a normal spinlock.
While here I drop the export symbol on that variable since there are no
other users.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
index c639b9d..12c75db 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
@@ -27,8 +27,7 @@
 
 #include <cs5536/cs5536_mfgpt.h>
 
-DEFINE_SPINLOCK(mfgpt_lock);
-EXPORT_SYMBOL(mfgpt_lock);
+static DEFINE_RAW_SPINLOCK(mfgpt_lock);
 
 static u32 mfgpt_base;
 
@@ -55,7 +54,7 @@ EXPORT_SYMBOL(enable_mfgpt0_counter);
 static void init_mfgpt_timer(enum clock_event_mode mode,
 			     struct clock_event_device *evt)
 {
-	spin_lock(&mfgpt_lock);
+	raw_spin_lock(&mfgpt_lock);
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -79,7 +78,7 @@ static void init_mfgpt_timer(enum clock_event_mode mode,
 		/* Nothing to do here */
 		break;
 	}
-	spin_unlock(&mfgpt_lock);
+	raw_spin_unlock(&mfgpt_lock);
 }
 
 static struct clock_event_device mfgpt_clockevent = {
@@ -157,7 +156,7 @@ static cycle_t mfgpt_read(struct clocksource *cs)
 	static int old_count;
 	static u32 old_jifs;
 
-	spin_lock_irqsave(&mfgpt_lock, flags);
+	raw_spin_lock_irqsave(&mfgpt_lock, flags);
 	/*
 	 * Although our caller may have the read side of xtime_lock,
 	 * this is now a seqlock, and we are cheating in this routine
@@ -191,7 +190,7 @@ static cycle_t mfgpt_read(struct clocksource *cs)
 	old_count = count;
 	old_jifs = jifs;
 
-	spin_unlock_irqrestore(&mfgpt_lock, flags);
+	raw_spin_unlock_irqrestore(&mfgpt_lock, flags);
 
 	return (cycle_t) (jifs * COMPARE) + count;
 }
-- 
2.0.0.rc0
