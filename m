Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Oct 2013 13:16:53 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1105 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825606Ab3JVLQl1BEuB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Oct 2013 13:16:41 +0200
Received: from [10.9.208.53] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 22 Oct 2013 04:16:25 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 22 Oct 2013 04:16:27 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 22 Oct 2013 04:16:27 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 953D5246A3; Tue, 22
 Oct 2013 04:16:26 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        "Jayachandran C" <jchandra@broadcom.com>, ralf@linux-mips.org
Subject: [PATCH 17/18] MIPS: Netlogic: XLP9XX PIC OF support
Date:   Tue, 22 Oct 2013 16:53:17 +0530
Message-ID: <1382440997-10976-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381756874-22616-18-git-send-email-jchandra@broadcom.com>
References: <1381756874-22616-18-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E788103150143578-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38382
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
Updates for CodingStyle compliance, suggested by
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>. Also move the
check for if (!nlm_node_present(socid)) to non XLP9XX case.

 arch/mips/netlogic/common/irq.c |   32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index 8092bb3..9ecf2df 100644
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
@@ -293,7 +292,29 @@ static int __init xlp_of_pic_init(struct device_node *node,
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
+			pr_err("PIC %s: Node mapping for bus %d not found!n",
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
 	xlp_pic_domain = irq_domain_add_legacy(node, n_picirqs,
 		nlm_irq_to_xirq(socid, PIC_IRQ_BASE), PIC_IRQ_BASE,
 		&xlp_pic_irq_domain_ops, NULL);
@@ -301,8 +322,7 @@ static int __init xlp_of_pic_init(struct device_node *node,
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
