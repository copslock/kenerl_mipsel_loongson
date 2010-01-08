Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jan 2010 23:47:59 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18222 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492890Ab0AHWrz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jan 2010 23:47:55 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b47b6110000>; Fri, 08 Jan 2010 14:47:45 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 8 Jan 2010 14:47:42 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 8 Jan 2010 14:47:41 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o08Mlb2F008326;
        Fri, 8 Jan 2010 14:47:37 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o08MlaJY008324;
        Fri, 8 Jan 2010 14:47:36 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Use non-overflowing arithmetic in sched_clock
Date:   Fri,  8 Jan 2010 14:47:36 -0800
Message-Id: <1262990856-8300-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 08 Jan 2010 22:47:42.0028 (UTC) FILETIME=[961A00C0:01CA90B4]
X-archive-position: 25548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5917

With typical mult and shift values, the calculation for Octeon's
sched_clock overflows when using 64-bit arithmetic.  Use 128-bit
calculations instead.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/csrc-octeon.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index 96df821..0bf4bbe 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -52,9 +52,34 @@ static struct clocksource clocksource_mips = {
 
 unsigned long long notrace sched_clock(void)
 {
-	return clocksource_cyc2ns(read_c0_cvmcount(),
-				  clocksource_mips.mult,
-				  clocksource_mips.shift);
+	/* 64-bit arithmatic can overflow, so use 128-bit.  */
+#if (__GNUC__ < 4) || ((__GNUC__ == 4) && (__GNUC_MINOR__ <= 3))
+	u64 t1, t2, t3;
+	unsigned long long rv;
+	u64 mult = clocksource_mips.mult;
+	u64 shift = clocksource_mips.shift;
+	u64 cnt = read_c0_cvmcount();
+
+	asm (
+		"dmultu\t%[cnt],%[mult]\n\t"
+		"nor\t%[t1],$0,%[shift]\n\t"
+		"mfhi\t%[t2]\n\t"
+		"mflo\t%[t3]\n\t"
+		"dsll\t%[t2],%[t2],1\n\t"
+		"dsrlv\t%[rv],%[t3],%[shift]\n\t"
+		"dsllv\t%[t1],%[t2],%[t1]\n\t"
+		"or\t%[rv],%[t1],%[rv]\n\t"
+		: [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2), [t3] "=&r" (t3)
+		: [cnt] "r" (cnt), [mult] "r" (mult), [shift] "r" (shift)
+		: "hi", "lo");
+	return rv;
+#else
+	/* GCC > 4.3 do it the easy way.  */
+	unsigned int __attribute__((mode(TI))) t;
+	t = read_c0_cvmcount();
+	t = t * clocksource_mips.mult;
+	return (unsigned long long)(t >> clocksource_mips.shift);
+#endif
 }
 
 void __init plat_time_init(void)
-- 
1.6.0.6
