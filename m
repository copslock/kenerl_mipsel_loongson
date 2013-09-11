Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2013 21:51:55 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:53257 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823097Ab3IKTvxViCx1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Sep 2013 21:51:53 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VJqS2-00010L-Ox; Wed, 11 Sep 2013 14:51:46 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ralf@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH v2] MIPS: GIC: Select R4K counter as fallback.
Date:   Wed, 11 Sep 2013 14:51:41 -0500
Message-Id: <1378929101-7021-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

If CONFIG_CSRC_GIC is selected and the GIC is not found during
boot, then fallback to the R4K counter gracefully.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/time.h |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 2d7b9df..6ff85e6 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -18,6 +18,7 @@
 #include <linux/spinlock.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
+#include <asm/gic.h>
 
 extern spinlock_t rtc_lock;
 
@@ -75,11 +76,13 @@ extern int init_r4k_clocksource(void);
 
 static inline int init_mips_clocksource(void)
 {
-#if defined(CONFIG_CSRC_R4K) && !defined(CONFIG_CSRC_GIC)
-	return init_r4k_clocksource();
-#else
-	return 0;
+#ifdef CONFIG_CSRC_R4K
+#ifdef CONFIG_CSRC_GIC
+	if (!gic_present)
 #endif
+		return init_r4k_clocksource();
+#endif
+	return 0;
 }
 
 static inline void clockevent_set_clock(struct clock_event_device *cd,
-- 
1.7.9.5
