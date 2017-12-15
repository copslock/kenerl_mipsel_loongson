Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 17:53:38 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:52417 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992866AbdLOQxJ2dhaR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Dec 2017 17:53:09 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 27CFB1A4F25;
        Fri, 15 Dec 2017 17:53:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.43])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 0B2641A4E98;
        Fri, 15 Dec 2017 17:53:04 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/2] MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()
Date:   Fri, 15 Dec 2017 17:52:00 +0100
Message-Id: <1513356723-7393-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513356723-7393-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1513356723-7393-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Paul Burton <paul.burton@mips.com>

Reading mips_cpc_base value from the DT allows each platform
to define it according to its needs. This is especially
convenient for MIPS_GENERIC kernel where this kind of information
should be determined in runtime.

Use mti,mips-cpc compatible string with just a reg property to
specify the register mappings for your platform.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 arch/mips/kernel/mips-cpc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 19c88d7..fcf9af4 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -10,6 +10,8 @@
 
 #include <linux/errno.h>
 #include <linux/percpu.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/spinlock.h>
 
 #include <asm/mips-cps.h>
@@ -22,6 +24,17 @@ static DEFINE_PER_CPU_ALIGNED(unsigned long, cpc_core_lock_flags);
 
 phys_addr_t __weak mips_cpc_default_phys_base(void)
 {
+	struct device_node *cpc_node;
+	struct resource res;
+	int err;
+
+	cpc_node = of_find_compatible_node(of_root, NULL, "mti,mips-cpc");
+	if (cpc_node) {
+		err = of_address_to_resource(cpc_node, 0, &res);
+		if (!err)
+			return res.start;
+	}
+
 	return 0;
 }
 
-- 
2.7.4
