Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 12:32:52 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:47229 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823911Ab3JGKcucY-SC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 12:32:50 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Always register R4K clock when selected
Date:   Mon, 7 Oct 2013 11:32:54 +0100
Message-ID: <1381141974-16018-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_07_11_32_45
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Always register the R4K clocksource when CONFIG_CSRC_R4K is selected,
regardless of selected support for other clocksources. The kernel will
select the best clocksource based on their ratings, making it safe to
register R4K unconditionally and use it as a fallback should the
kernel be run on a system where other selected clocksources are
inoperable.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/time.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 2d7b9df..24f534a 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -75,7 +75,7 @@ extern int init_r4k_clocksource(void);
 
 static inline int init_mips_clocksource(void)
 {
-#if defined(CONFIG_CSRC_R4K) && !defined(CONFIG_CSRC_GIC)
+#ifdef CONFIG_CSRC_R4K
 	return init_r4k_clocksource();
 #else
 	return 0;
-- 
1.8.3.2
