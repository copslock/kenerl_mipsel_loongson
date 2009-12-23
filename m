Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Dec 2009 22:19:46 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4184 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493125AbZLWVTm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Dec 2009 22:19:42 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b3289620000>; Wed, 23 Dec 2009 13:19:30 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 23 Dec 2009 13:19:01 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 23 Dec 2009 13:19:00 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id nBNLIuvv027336;
        Wed, 23 Dec 2009 13:18:56 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id nBNLIsCW027334;
        Wed, 23 Dec 2009 13:18:54 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Add sched_clock() to csrc-octeon.c
Date:   Wed, 23 Dec 2009 13:18:54 -0800
Message-Id: <1261603134-27310-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 23 Dec 2009 21:19:01.0003 (UTC) FILETIME=[8BEA05B0:01CA8415]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

With the advent of function graph tracing on MIPS, Octeon needs a high
precision sched_clock() implementation.  Without it, most timing
numbers are reported as 0.000.

This new sched_clock just uses the 64-bit cycle counter appropriately
scaled.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/csrc-octeon.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index 96110f2..96df821 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -50,6 +50,13 @@ static struct clocksource clocksource_mips = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+unsigned long long notrace sched_clock(void)
+{
+	return clocksource_cyc2ns(read_c0_cvmcount(),
+				  clocksource_mips.mult,
+				  clocksource_mips.shift);
+}
+
 void __init plat_time_init(void)
 {
 	clocksource_mips.rating = 300;
-- 
1.6.0.6
