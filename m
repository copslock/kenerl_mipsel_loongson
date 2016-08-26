Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:43:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61383 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992500AbcHZPlNlL4PI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:41:13 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9A45B5BDAF063;
        Fri, 26 Aug 2016 16:40:53 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:40:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/26] MIPS: CPC: Provide a default mips_cpc_default_phys_base
Date:   Fri, 26 Aug 2016 16:37:11 +0100
Message-ID: <20160826153725.11629-13-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54796
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

Provide a weak default implementation of mips_cpc_default_phys_base
which reads the base address of the CPC from the device tree if
possible, and failing that returns the existing physical address of the
CPC as read from CPC base address GCR. This allows for platforms to make
use of the CPC without requiring platform code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/mips-cpc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 566b8d2..b188787 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -9,6 +9,8 @@
  */
 
 #include <linux/errno.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 
@@ -21,6 +23,22 @@ static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
 
 static DEFINE_PER_CPU_ALIGNED(unsigned long, cpc_core_lock_flags);
 
+__weak phys_addr_t mips_cpc_default_phys_base(void)
+{
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
+	return read_gcr_cpc_base() & CM_GCR_CPC_BASE_CPCBASE_MSK;
+}
+
 /**
  * mips_cpc_phys_base - retrieve the physical base address of the CPC
  *
-- 
2.9.3
