Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jul 2013 13:26:05 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1259 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823064Ab3GQLZlwbwM7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Jul 2013 13:25:41 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 17 Jul 2013 04:21:39 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 17 Jul 2013 04:25:25 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 17 Jul 2013 04:25:25 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 35FDFF2D73; Wed, 17
 Jul 2013 04:25:23 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 2/2] MIPS: Netlogic: Add XLP PIC irqdomain
Date:   Wed, 17 Jul 2013 16:57:26 +0530
Message-ID: <1374060446-25902-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374060446-25902-1-git-send-email-jchandra@broadcom.com>
References: <1374060446-25902-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DF8A1C931W52891639-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37309
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

Add a legacy irq domain for the XLP PIC interrupts. This will be used
when interrupts are assigned from the device tree. This change is required
after commit c5cdc67 "irqdomain: Remove temporary MIPS workaround code".

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/irq.c    |   68 ++++++++++++++++++++++++++++++------
 arch/mips/netlogic/dts/xlp_evp.dts |    3 +-
 arch/mips/netlogic/dts/xlp_svp.dts |    3 +-
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index 73facb2..bfb2e25 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -40,6 +40,10 @@
 #include <linux/slab.h>
 #include <linux/irq.h>
 
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
 #include <asm/errno.h>
 #include <asm/signal.h>
 #include <asm/ptrace.h>
@@ -223,17 +227,6 @@ static void nlm_init_node_irqs(int node)
 	nodep->irqmask = irqmask;
 }
 
-void __init arch_init_irq(void)
-{
-	/* Initialize the irq descriptors */
-	nlm_init_percpu_irqs();
-	nlm_init_node_irqs(0);
-	write_c0_eimr(nlm_current_node()->irqmask);
-#if defined(CONFIG_CPU_XLR)
-	nlm_setup_fmn_irq();
-#endif
-}
-
 void nlm_smp_irq_init(int hwcpuid)
 {
 	int node, cpu;
@@ -266,3 +259,56 @@ asmlinkage void plat_irq_dispatch(void)
 	/* top level irq handling */
 	do_IRQ(nlm_irq_to_xirq(node, i));
 }
+
+#ifdef CONFIG_OF
+static struct irq_domain *xlp_pic_domain;
+
+static const struct irq_domain_ops xlp_pic_irq_domain_ops = {
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+static int __init xlp_of_pic_init(struct device_node *node,
+					struct device_node *parent)
+{
+	const int n_picirqs = PIC_IRT_LAST_IRQ - PIC_IRQ_BASE + 1;
+	struct resource res;
+	int socid, ret;
+
+	/* we need a hack to get the PIC's SoC chip id */
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret < 0) {
+		pr_err("PIC %s: reg property not found!\n", node->name);
+		return -EINVAL;
+	}
+	socid = (res.start >> 18) & 0x3;
+	xlp_pic_domain = irq_domain_add_legacy(node, n_picirqs,
+		nlm_irq_to_xirq(socid, PIC_IRQ_BASE), PIC_IRQ_BASE,
+		&xlp_pic_irq_domain_ops, NULL);
+	if (xlp_pic_domain == NULL) {
+		pr_err("PIC %s: Creating legacy domain failed!\n", node->name);
+		return -EINVAL;
+	}
+	pr_info("Node %d: IRQ domain created for PIC@%pa\n", socid,
+							&res.start);
+	return 0;
+}
+	
+static struct of_device_id __initdata xlp_pic_irq_ids[] = {
+	{ .compatible = "netlogic,xlp-pic", .data = xlp_of_pic_init },
+	{},
+};
+#endif
+
+void __init arch_init_irq(void)
+{
+	/* Initialize the irq descriptors */
+	nlm_init_percpu_irqs();
+	nlm_init_node_irqs(0);
+	write_c0_eimr(nlm_current_node()->irqmask);
+#if defined(CONFIG_CPU_XLR)
+	nlm_setup_fmn_irq();
+#endif
+#if defined(CONFIG_OF)
+	of_irq_init(xlp_pic_irq_ids);
+#endif
+}
diff --git a/arch/mips/netlogic/dts/xlp_evp.dts b/arch/mips/netlogic/dts/xlp_evp.dts
index e14f423..0640703 100644
--- a/arch/mips/netlogic/dts/xlp_evp.dts
+++ b/arch/mips/netlogic/dts/xlp_evp.dts
@@ -76,10 +76,11 @@
 			};
 		};
 		pic: pic@4000 {
-			interrupt-controller;
+			compatible = "netlogic,xlp-pic";
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			reg = <0 0x4000 0x200>;
+			interrupt-controller;
 		};
 
 		nor_flash@1,0 {
diff --git a/arch/mips/netlogic/dts/xlp_svp.dts b/arch/mips/netlogic/dts/xlp_svp.dts
index 8af4bdb..9c5db10 100644
--- a/arch/mips/netlogic/dts/xlp_svp.dts
+++ b/arch/mips/netlogic/dts/xlp_svp.dts
@@ -76,10 +76,11 @@
 			};
 		};
 		pic: pic@4000 {
-			interrupt-controller;
+			compatible = "netlogic,xlp-pic";
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			reg = <0 0x4000 0x200>;
+			interrupt-controller;
 		};
 
 		nor_flash@1,0 {
-- 
1.7.9.5
