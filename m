Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 16:13:13 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:59064 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993195AbeABPJKUiLu9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 16:09:10 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 12/15] MIPS: JZ4770: Work around config2 misreporting associativity
Date:   Tue,  2 Jan 2018 16:08:45 +0100
Message-Id: <20180102150848.11314-12-paul@crapouillou.net>
In-Reply-To: <20180102150848.11314-1-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514905749; bh=Kb2hiAmJOBSgJS7Kc/cbgugkNs/f2hx26PmQfJ3SaJU=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hLAYRbwg7aHq2yZGMcjhB9OatZDel8MvNJtw6ghR+h1jXp56JEfG7oapep9RroTwakGvbzK5j0JfaZKLyeRua1ThwfMBuosqD7xJ1Da8Ik/9oWr7BXcPYmVjm+j16A/PZoTBwPmnoX/87h86686dNi2rDVo0ngAUodRgbBvEOoo=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

From: Maarten ter Huurne <maarten@treewalker.org>

According to config2, the associativity would be 5-ways, but the
documentation states 4-ways, which also matches the documented
L2 cache size of 256 kB.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/mm/sc-mips.c | 9 +++++++++
 1 file changed, 9 insertions(+)

 v2: No change
 v3: No change
 v4: Rebased on top of Linux 4.15-rc5
 v5: No change

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 548acb7f8557..394673991bab 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -16,6 +16,7 @@
 #include <asm/mmu_context.h>
 #include <asm/r4kcache.h>
 #include <asm/mips-cps.h>
+#include <asm/bootinfo.h>
 
 /*
  * MIPS32/MIPS64 L2 cache handling
@@ -220,6 +221,14 @@ static inline int __init mips_sc_probe(void)
 	else
 		return 0;
 
+	/*
+	 * According to config2 it would be 5-ways, but that is contradicted
+	 * by all documentation.
+	 */
+	if (current_cpu_type() == CPU_JZRISC &&
+				mips_machtype == MACH_INGENIC_JZ4770)
+		c->scache.ways = 4;
+
 	c->scache.waysize = c->scache.sets * c->scache.linesz;
 	c->scache.waybit = __ffs(c->scache.waysize);
 
-- 
2.11.0
