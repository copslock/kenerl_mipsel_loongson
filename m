Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 16:00:07 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:4071 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903662Ab1KHPAC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Nov 2011 16:00:02 +0100
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Tue, 08 Nov 2011 07:07:24 -0800
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 8 Nov 2011 06:59:40 -0800
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 05BE4BC395; Tue, 8
 Nov 2011 06:59:39 -0800 (PST)
From:   "Al Cooper" <alcooperx@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
cc:     "Al Cooper" <alcooperx@gmail.com>
Subject: [PATCH] MIPS: Kernel hangs occasionally during boot.
Date:   Tue, 8 Nov 2011 09:59:01 -0500
Message-ID: <1320764341-4275-1-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
X-WSS-ID: 62A79A233JW15441453-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 31424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6790

The Kernel hangs occasionally during boot after
"Calibrating delay loop..". This is caused by the
c0_compare_int_usable() routine in cevt-r4k.c returning false which
causes the system to disable the timer and hang later. The false
return happens because the routine is using a series of four calls to
irq_disable_hazard() as a delay while it waits for the timer changes
to propagate to the cp0 cause register. On newer MIPS cores, like the 74K,
the series of irq_disable_hazard() calls turn into ehb instructions and
can take as little as a few clock ticks for all 4 instructions. This
is not enough of a delay, so the routine thinks the timer is not working.
This fix uses up to a max number of cycle counter ticks for the delay
and uses back_to_back_c0_hazard() instead of irq_disable_hazard() to
handle the hazard condition between cp0 writes and cp0 reads.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 arch/mips/kernel/cevt-r4k.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 98c5a97..e2d8e19 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -103,19 +103,10 @@ static int c0_compare_int_pending(void)
 
 /*
  * Compare interrupt can be routed and latched outside the core,
- * so a single execution hazard barrier may not be enough to give
- * it time to clear as seen in the Cause register.  4 time the
- * pipeline depth seems reasonably conservative, and empirically
- * works better in configurations with high CPU/bus clock ratios.
+ * so wait up to worst case number of cycle counter ticks for timer interrupt
+ * changes to propagate to the cause register.
  */
-
-#define compare_change_hazard() \
-	do { \
-		irq_disable_hazard(); \
-		irq_disable_hazard(); \
-		irq_disable_hazard(); \
-		irq_disable_hazard(); \
-	} while (0)
+#define COMPARE_INT_SEEN_TICKS 50
 
 int c0_compare_int_usable(void)
 {
@@ -126,8 +117,12 @@ int c0_compare_int_usable(void)
 	 * IP7 already pending?  Try to clear it by acking the timer.
 	 */
 	if (c0_compare_int_pending()) {
-		write_c0_compare(read_c0_count());
-		compare_change_hazard();
+		cnt = read_c0_count();
+		write_c0_compare(cnt);
+		back_to_back_c0_hazard();
+		while (read_c0_count() < (cnt  + COMPARE_INT_SEEN_TICKS))
+			if (!c0_compare_int_pending())
+				break;
 		if (c0_compare_int_pending())
 			return 0;
 	}
@@ -136,7 +131,7 @@ int c0_compare_int_usable(void)
 		cnt = read_c0_count();
 		cnt += delta;
 		write_c0_compare(cnt);
-		compare_change_hazard();
+		back_to_back_c0_hazard();
 		if ((int)(read_c0_count() - cnt) < 0)
 		    break;
 		/* increase delta if the timer was already expired */
@@ -145,12 +140,17 @@ int c0_compare_int_usable(void)
 	while ((int)(read_c0_count() - cnt) <= 0)
 		;	/* Wait for expiry  */
 
-	compare_change_hazard();
+	while (read_c0_count() < (cnt + COMPARE_INT_SEEN_TICKS))
+		if (c0_compare_int_pending())
+			break;
 	if (!c0_compare_int_pending())
 		return 0;
-
-	write_c0_compare(read_c0_count());
-	compare_change_hazard();
+	cnt = read_c0_count();
+	write_c0_compare(cnt);
+	back_to_back_c0_hazard();
+	while (read_c0_count() < (cnt + COMPARE_INT_SEEN_TICKS))
+		if (!c0_compare_int_pending())
+			break;
 	if (c0_compare_int_pending())
 		return 0;
 
-- 
1.7.6
