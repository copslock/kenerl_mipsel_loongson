Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 13:29:25 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:51487 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014076AbaKTM3YggQj2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Nov 2014 13:29:24 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 2FE042E414;
        Thu, 20 Nov 2014 13:29:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id sWogewod0kn7; Thu, 20 Nov 2014 13:29:13 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id E88BA2E438;
        Thu, 20 Nov 2014 13:29:12 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id D18B410D8;
        Thu, 20 Nov 2014 13:29:12 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id C638E10D6;
        Thu, 20 Nov 2014 13:29:12 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by thoth.se.axis.com (Postfix) with ESMTP id C3463340EF;
        Thu, 20 Nov 2014 13:29:12 +0100 (CET)
Received: from lnxniklass.se.axis.com (10.94.49.1) by xmail2.se.axis.com
 (10.0.5.74) with Microsoft SMTP Server (TLS) id 8.3.342.0; Thu, 20 Nov 2014
 13:29:12 +0100
From:   Niklas Svensson <niklas.svensson@axis.com>
To:     <ralf@linux-mips.org>, <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Niklas Svensson <niklass@axis.com>
Subject: [PATCH] MIPS: mips-cm: CM regions are disabled at boot
Date:   Thu, 20 Nov 2014 13:29:00 +0100
Message-ID: <1416486540-28681-1-git-send-email-niklass@axis.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <niklas.svensson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: niklas.svensson@axis.com
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

Each CM_REGION_TARGET is set to disabled at boot,
so there is no need to disable the matching
CM_GCR_REG explicitly.

Signed-off-by: Niklas Svensson <niklass@axis.com>
---
 arch/mips/kernel/mips-cm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index f76f7a0..a4bbfd9 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -104,16 +104,6 @@ int mips_cm_probe(void)
 	base_reg |= CM_GCR_BASE_CMDEFTGT_MEM;
 	write_gcr_base(base_reg);
 
-	/* disable CM regions */
-	write_gcr_reg0_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
-	write_gcr_reg0_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
-	write_gcr_reg1_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
-	write_gcr_reg1_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
-	write_gcr_reg2_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
-	write_gcr_reg2_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
-	write_gcr_reg3_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
-	write_gcr_reg3_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
-
 	/* probe for an L2-only sync region */
 	mips_cm_probe_l2sync();
 
-- 
2.1.3
