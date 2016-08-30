Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 19:35:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63320 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992257AbcH3RdqaK1o0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 19:33:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1119F20851683;
        Tue, 30 Aug 2016 18:33:27 +0100 (IST)
Received: from localhost (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 18:33:30 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH v2 14/26] MIPS: CDMM: Allow CDMM base address to be specified via DT
Date:   Tue, 30 Aug 2016 18:29:17 +0100
Message-ID: <20160830172929.16948-15-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160830172929.16948-1-paul.burton@imgtec.com>
References: <20160830172929.16948-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54855
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

Allow systems to specify the base address for the CDMM using device
tree. This removes the need for it to be specified by platform specific
code, preparing for generic kernels which can run without any.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 drivers/bus/mips_cdmm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bus/mips_cdmm.c b/drivers/bus/mips_cdmm.c
index cad49bc..311ce54 100644
--- a/drivers/bus/mips_cdmm.c
+++ b/drivers/bus/mips_cdmm.c
@@ -13,6 +13,8 @@
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -340,6 +342,17 @@ static phys_addr_t mips_cdmm_cur_base(void)
  */
 phys_addr_t __weak mips_cdmm_phys_base(void)
 {
+	struct device_node *cdmm_node;
+	struct resource res;
+	int err;
+
+	cdmm_node = of_find_compatible_node(of_root, NULL, "mti,mips-cdmm");
+	if (cdmm_node) {
+		err = of_address_to_resource(cdmm_node, 0, &res);
+		if (!err)
+			return res.start;
+	}
+
 	return 0;
 }
 
-- 
2.9.3
