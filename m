Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 12:16:33 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:1142 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815753Ab3LULLKOsGjp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Dec 2013 12:11:10 +0100
X-IronPort-AV: E=Sophos;i="4.95,527,1384329600"; 
   d="scan'208";a="4363740"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 21 Dec 2013 03:13:02 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Sat, 21 Dec 2013 03:11:09 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.1.438.0; Sat, 21 Dec 2013 03:11:09 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 5743D246A6;    Sat, 21 Dec 2013 03:11:07 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 17/18] MIPS: Netlogic: XLP9XX PIC OF support
Date:   Sat, 21 Dec 2013 16:52:29 +0530
Message-ID: <1387624950-31297-18-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Support for adding legacy IRQ domain for XLP9XX. The node id of the
PIC has to be calulated differently for XLP9XX.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/irq.c |   37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index 8092bb3..42d9ea0 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -274,8 +274,6 @@ asmlinkage void plat_irq_dispatch(void)
 }
 
 #ifdef CONFIG_OF
-static struct irq_domain *xlp_pic_domain;
-
 static const struct irq_domain_ops xlp_pic_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
@@ -284,8 +282,9 @@ static int __init xlp_of_pic_init(struct device_node *node,
 					struct device_node *parent)
 {
 	const int n_picirqs = PIC_IRT_LAST_IRQ - PIC_IRQ_BASE + 1;
+	struct irq_domain *xlp_pic_domain;
 	struct resource res;
-	int socid, ret;
+	int socid, ret, bus;
 
 	/* we need a hack to get the PIC's SoC chip id */
 	ret = of_address_to_resource(node, 0, &res);
@@ -293,7 +292,34 @@ static int __init xlp_of_pic_init(struct device_node *node,
 		pr_err("PIC %s: reg property not found!\n", node->name);
 		return -EINVAL;
 	}
-	socid = (res.start >> 18) & 0x3;
+
+	if (cpu_is_xlp9xx()) {
+		bus = (res.start >> 20) & 0xf;
+		for (socid = 0; socid < NLM_NR_NODES; socid++) {
+			if (!nlm_node_present(socid))
+				continue;
+			if (nlm_get_node(socid)->socbus == bus)
+				break;
+		}
+		if (socid == NLM_NR_NODES) {
+			pr_err("PIC %s: Node mapping for bus %d not found!\n",
+					node->name, bus);
+			return -EINVAL;
+		}
+	} else {
+		socid = (res.start >> 18) & 0x3;
+		if (!nlm_node_present(socid)) {
+			pr_err("PIC %s: node %d does not exist!\n",
+							node->name, socid);
+			return -EINVAL;
+		}
+	}
+
+	if (!nlm_node_present(socid)) {
+		pr_err("PIC %s: node %d does not exist!\n", node->name, socid);
+		return -EINVAL;
+	}
+
 	xlp_pic_domain = irq_domain_add_legacy(node, n_picirqs,
 		nlm_irq_to_xirq(socid, PIC_IRQ_BASE), PIC_IRQ_BASE,
 		&xlp_pic_irq_domain_ops, NULL);
@@ -301,8 +327,7 @@ static int __init xlp_of_pic_init(struct device_node *node,
 		pr_err("PIC %s: Creating legacy domain failed!\n", node->name);
 		return -EINVAL;
 	}
-	pr_info("Node %d: IRQ domain created for PIC@%pa\n", socid,
-							&res.start);
+	pr_info("Node %d: IRQ domain created for PIC@%pR\n", socid, &res);
 	return 0;
 }
 
-- 
1.7.9.5
