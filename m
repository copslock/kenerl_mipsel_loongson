Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 19:41:44 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14119 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491020Ab0ESRll (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 May 2010 19:41:41 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bf422e30002>; Wed, 19 May 2010 10:41:55 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 19 May 2010 10:40:59 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 19 May 2010 10:40:59 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o4JHeuDb016982;
        Wed, 19 May 2010 10:40:57 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o4JHetU4016981;
        Wed, 19 May 2010 10:40:55 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] MIPS: Don't overflow cevt-r4k.c calculations at high clock rates.
Date:   Wed, 19 May 2010 10:40:53 -0700
Message-Id: <1274290853-16947-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 19 May 2010 17:40:59.0138 (UTC) FILETIME=[713D1620:01CAF77A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The 'mult' element of struct clock_event_device must never be wider
than 32-bits.  If it were, it would get truncated when used by
clockevent_delta2ns() when this calls do_div().

We can meet this requirement by using clockevent_set_clock() to set
the MULT and SHIFT values.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/cevt-r4k.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 0b2450c..2a4d50f 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -163,7 +163,6 @@ int c0_compare_int_usable(void)
 
 int __cpuinit r4k_clockevent_init(void)
 {
-	uint64_t mips_freq = mips_hpt_frequency;
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *cd;
 	unsigned int irq;
@@ -188,9 +187,9 @@ int __cpuinit r4k_clockevent_init(void)
 	cd->name		= "MIPS";
 	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
 
+	clockevent_set_clock(cd, mips_hpt_frequency);
+
 	/* Calculate the min / max delta */
-	cd->mult	= div_sc((unsigned long) mips_freq, NSEC_PER_SEC, 32);
-	cd->shift		= 32;
 	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
 	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
 
-- 
1.6.6.1
