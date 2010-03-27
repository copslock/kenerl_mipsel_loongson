Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Mar 2010 15:06:47 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:33810 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491957Ab0C0OGn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Mar 2010 15:06:43 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 954CD3E5A15;
        Sat, 27 Mar 2010 15:06:38 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 27016370003;
        Sat, 27 Mar 2010 15:06:38 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: use compare_change_hazard in mips_next_event
Date:   Sat, 27 Mar 2010 15:06:37 +0100
Message-Id: <1269698797-5004-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.5.3.2
X-Antivirus: avast! (VPS 100326-0, 2010.03.26), Outbound message
X-Antivirus-Status: Clean
X-VBMS: A128977009D | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

The compare_change_hazard() is used between write_c0_compare() and
read_c0_count() in c0_compare_int_usable(). The mips_next_event() uses
the same code sequence but without the compare_change_hazard call.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/kernel/cevt-r4k.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 0b2450c..16cd116 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -16,6 +16,22 @@
 #include <asm/cevt-r4k.h>
 
 /*
+ * Compare interrupt can be routed and latched outside the core,
+ * so a single execution hazard barrier may not be enough to give
+ * it time to clear as seen in the Cause register.  4 time the
+ * pipeline depth seems reasonably conservative, and empirically
+ * works better in configurations with high CPU/bus clock ratios.
+ */
+
+#define compare_change_hazard() \
+	do { \
+		irq_disable_hazard(); \
+		irq_disable_hazard(); \
+		irq_disable_hazard(); \
+		irq_disable_hazard(); \
+	} while (0)
+
+/*
  * The SMTC Kernel for the 34K, 1004K, et. al. replaces several
  * of these routines with SMTC-specific variants.
  */
@@ -31,6 +47,7 @@ static int mips_next_event(unsigned long delta,
 	cnt = read_c0_count();
 	cnt += delta;
 	write_c0_compare(cnt);
+	compare_change_hazard();
 	res = ((int)(read_c0_count() - cnt) > 0) ? -ETIME : 0;
 	return res;
 }
@@ -100,22 +117,6 @@ static int c0_compare_int_pending(void)
 	return (read_c0_cause() >> cp0_compare_irq_shift) & (1ul << CAUSEB_IP);
 }
 
-/*
- * Compare interrupt can be routed and latched outside the core,
- * so a single execution hazard barrier may not be enough to give
- * it time to clear as seen in the Cause register.  4 time the
- * pipeline depth seems reasonably conservative, and empirically
- * works better in configurations with high CPU/bus clock ratios.
- */
-
-#define compare_change_hazard() \
-	do { \
-		irq_disable_hazard(); \
-		irq_disable_hazard(); \
-		irq_disable_hazard(); \
-		irq_disable_hazard(); \
-	} while (0)
-
 int c0_compare_int_usable(void)
 {
 	unsigned int delta;
-- 
1.5.3.2
