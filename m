Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:30:59 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:36773
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011132AbaJJW3Rcye12 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:29:17 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 06/10] MIPS: lantiq: move eiu init after irq_domain register
Date:   Sat, 11 Oct 2014 00:02:30 +0200
Message-Id: <1412978554-31344-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
References: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

The eiu init failed as the irq_domain was not yet available.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/irq.c |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 030568a..7bdbd2d 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -378,30 +378,6 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 			panic("Failed to remap icu memory");
 	}
 
-	/* the external interrupts are optional and xway only */
-	eiu_node = of_find_compatible_node(NULL, NULL, "lantiq,eiu-xway");
-	if (eiu_node && !of_address_to_resource(eiu_node, 0, &res)) {
-		/* find out how many external irq sources we have */
-		exin_avail = of_irq_count(eiu_node);
-
-		if (exin_avail > MAX_EIU)
-			exin_avail = MAX_EIU;
-
-		ret = of_irq_to_resource_table(eiu_node,
-						ltq_eiu_irq, exin_avail);
-		if (ret != exin_avail)
-			panic("failed to load external irq resources");
-
-		if (request_mem_region(res.start, resource_size(&res),
-							res.name) < 0)
-			pr_err("Failed to request eiu memory");
-
-		ltq_eiu_membase = ioremap_nocache(res.start,
-							resource_size(&res));
-		if (!ltq_eiu_membase)
-			panic("Failed to remap eiu memory");
-	}
-
 	/* turn off all irqs by default */
 	for (i = 0; i < MAX_IM; i++) {
 		/* make sure all irqs are turned off by default */
@@ -458,6 +434,30 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	if (MIPS_CPU_TIMER_IRQ != 7)
 		irq_create_mapping(ltq_domain, MIPS_CPU_TIMER_IRQ);
 
+	/* the external interrupts are optional and xway only */
+	eiu_node = of_find_compatible_node(NULL, NULL, "lantiq,eiu-xway");
+	if (eiu_node && !of_address_to_resource(eiu_node, 0, &res)) {
+		/* find out how many external irq sources we have */
+		exin_avail = of_irq_count(eiu_node);
+
+		if (exin_avail > MAX_EIU)
+			exin_avail = MAX_EIU;
+
+		ret = of_irq_to_resource_table(eiu_node,
+						ltq_eiu_irq, exin_avail);
+		if (ret != exin_avail)
+			panic("failed to load external irq resources");
+
+		if (request_mem_region(res.start, resource_size(&res),
+							res.name) < 0)
+			pr_err("Failed to request eiu memory");
+
+		ltq_eiu_membase = ioremap_nocache(res.start,
+							resource_size(&res));
+		if (!ltq_eiu_membase)
+			panic("Failed to remap eiu memory");
+	}
+
 	return 0;
 }
 
-- 
1.7.10.4
