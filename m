Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2013 15:20:04 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1333 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824811Ab3JNNPuTIrel (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Oct 2013 15:15:50 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Oct 2013 06:15:32 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 14 Oct 2013 06:15:33 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 14 Oct 2013 06:15:33 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 43900246AB; Mon, 14
 Oct 2013 06:15:32 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>, ralf@linux-mips.org
Subject: [PATCH 17/18] MIPS: Netlogic: XLP9XX PIC OF support
Date:   Mon, 14 Oct 2013 18:51:13 +0530
Message-ID: <1381756874-22616-18-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
References: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E4531FE4FK1415320-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38333
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
 arch/mips/netlogic/common/irq.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index 8092bb3..34be9bb 100644
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
@@ -293,7 +292,28 @@ static int __init xlp_of_pic_init(struct device_node *node,
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
+	} else
+		socid = (res.start >> 18) & 0x3;
+
+	if (!nlm_node_present(socid)) {
+		pr_err("PIC %s: node %d does not exist!\n", node->name, socid);
+		return -EINVAL;
+	}
+
 	xlp_pic_domain = irq_domain_add_legacy(node, n_picirqs,
 		nlm_irq_to_xirq(socid, PIC_IRQ_BASE), PIC_IRQ_BASE,
 		&xlp_pic_irq_domain_ops, NULL);
-- 
1.7.9.5
