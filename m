Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2013 18:07:46 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:51756 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826484Ab3K2RH1AC9iR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Nov 2013 18:07:27 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/2] MIPS: sead3: remove unused cpu_khz variable
Date:   Fri, 29 Nov 2013 17:07:14 +0000
Message-ID: <1385744834-18115-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1385744834-18115-1-git-send-email-paul.burton@imgtec.com>
References: <1385744834-18115-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_11_29_17_07_21
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This variable seems to have been copied from Malta when SEAD3 support
was introduced, but is likewise unused. Remove it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/mti-sead3/sead3-time.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
index 552d26c..678d03d 100644
--- a/arch/mips/mti-sead3/sead3-time.c
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -13,8 +13,6 @@
 #include <asm/irq.h>
 #include <asm/mips-boards/generic.h>
 
-unsigned long cpu_khz;
-
 static int mips_cpu_timer_irq;
 static int mips_cpu_perf_irq;
 
@@ -109,8 +107,6 @@ void __init plat_time_init(void)
 	pr_debug("CPU frequency %d.%02d MHz\n", (est_freq / 1000000),
 		(est_freq % 1000000) * 100 / 1000000);
 
-	cpu_khz = est_freq / 1000;
-
 	mips_scroll_message();
 
 	plat_perf_setup();
-- 
1.8.4.2
