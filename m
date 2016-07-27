Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2016 17:08:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26854 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992316AbcG0PIQ7WzL3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jul 2016 17:08:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8FB55AB939704;
        Wed, 27 Jul 2016 16:07:57 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 27 Jul 2016 16:08:00 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Print segment physical address when EU=1
Date:   Wed, 27 Jul 2016 16:07:54 +0100
Message-ID: <1469632074-1554-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Currently the debugfs interface to print the segment configuration
refuses to print the physical address of mapped segments. However if the
EU bit is set these become unmapped at error level (when
CP0_Status.ERL=1), so the physical address is still relevant.

Update the logic to print the physical address of mapped segments when
the EU bit is set, while still hiding the Cache Coherency Attribute
(since EU overrides that to uncached when ERL=1 too).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/segment.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/segment.c b/arch/mips/kernel/segment.c
index 87bc74a5a518..2703f218202e 100644
--- a/arch/mips/kernel/segment.c
+++ b/arch/mips/kernel/segment.c
@@ -26,17 +26,20 @@ static void build_segment_config(char *str, unsigned int cfg)
 
 	/*
 	 * Access modes MK, MSK and MUSK are mapped segments. Therefore
-	 * there is no direct physical address mapping.
+	 * there is no direct physical address mapping unless it becomes
+	 * unmapped uncached at error level due to EU.
 	 */
-	if ((am == 0) || (am > 3)) {
+	if ((am == 0) || (am > 3) || (cfg & MIPS_SEGCFG_EU))
 		str += sprintf(str, "         %03lx",
 			((cfg & MIPS_SEGCFG_PA) >> MIPS_SEGCFG_PA_SHIFT));
+	else
+		str += sprintf(str, "         UND");
+
+	if ((am == 0) || (am > 3))
 		str += sprintf(str, "         %01ld",
 			((cfg & MIPS_SEGCFG_C) >> MIPS_SEGCFG_C_SHIFT));
-	} else {
-		str += sprintf(str, "         UND");
+	else
 		str += sprintf(str, "         U");
-	}
 
 	/* Exception configuration. */
 	str += sprintf(str, "       %01ld\n",
-- 
2.7.3
