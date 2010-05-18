Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 00:11:56 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15289 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492247Ab0ERWLw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 May 2010 00:11:52 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bf310b50002>; Tue, 18 May 2010 15:12:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 18 May 2010 15:11:24 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 18 May 2010 15:11:24 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o4IMBMmh004607;
        Tue, 18 May 2010 15:11:22 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o4IMBKHx004597;
        Tue, 18 May 2010 15:11:20 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] MIPS: Don't overflow cevt-r4k.c calculations at high clock rates.
Date:   Tue, 18 May 2010 15:11:16 -0700
Message-Id: <1274220676-4562-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 18 May 2010 22:11:24.0599 (UTC) FILETIME=[0DF43470:01CAF6D7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The 'mult' element of struct clock_event_device must never be wider
than 32-bits.  If it were, it would get truncated when used by
clockevent_delta2ns() when this calls do_div().

We meet the requirement by ensuring that the relationship:

 (mips_hpt_frequency >> (32 - shift)) < NSEC_PER_SEC

Always holds.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/cevt-r4k.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 0b2450c..4495158 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -163,10 +163,11 @@ int c0_compare_int_usable(void)
 
 int __cpuinit r4k_clockevent_init(void)
 {
-	uint64_t mips_freq = mips_hpt_frequency;
+	uint64_t scaled_freq = mips_hpt_frequency;
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *cd;
 	unsigned int irq;
+	int shift;
 
 	if (!cpu_has_counter || !mips_hpt_frequency)
 		return -ENXIO;
@@ -189,8 +190,17 @@ int __cpuinit r4k_clockevent_init(void)
 	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
 
 	/* Calculate the min / max delta */
-	cd->mult	= div_sc((unsigned long) mips_freq, NSEC_PER_SEC, 32);
-	cd->shift		= 32;
+	shift = 32;
+	while (scaled_freq >= NSEC_PER_SEC && shift) {
+		scaled_freq = scaled_freq >> 1;
+		shift--;
+	}
+	BUG_ON(shift == 0);
+
+	cd->mult		= div_sc((unsigned long) mips_hpt_frequency,
+					 NSEC_PER_SEC, shift);
+	cd->shift		= shift;
+
 	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
 	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
 
-- 
1.6.6.1
