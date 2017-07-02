Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jul 2017 18:34:06 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:43132 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993179AbdGBQahum1uq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jul 2017 18:30:37 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 15/18] MIPS: JZ4770: Work around config2 misreporting associativity
Date:   Sun,  2 Jul 2017 18:30:13 +0200
Message-Id: <20170702163016.6714-16-paul@crapouillou.net>
In-Reply-To: <20170702163016.6714-1-paul@crapouillou.net>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170702163016.6714-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1499013037; bh=hy9Qdh6ZRVQZrImDd/0PbzNkMGf5D2+terPO5rZ/fqk=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EHPvczjAC6l3DsiaztSb9DdsPFe6TGqFYpqfGPwE0zK3n2cNDFldKsI5MFBf/qDhjG3uqX63E2g1KYsRi65we50Cz5bID4WFyXyQRvJ7cYTFnnhsT7/Tx5m5nDNzUaea/5elWajRgtqp+MiIhMWLpL2YemKC96fV7tUVLaf03Ek=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58952
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

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index c909c3342729..67a3b4d88580 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -15,6 +15,7 @@
 #include <asm/mmu_context.h>
 #include <asm/r4kcache.h>
 #include <asm/mips-cm.h>
+#include <asm/bootinfo.h>
 
 /*
  * MIPS32/MIPS64 L2 cache handling
@@ -228,6 +229,14 @@ static inline int __init mips_sc_probe(void)
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
