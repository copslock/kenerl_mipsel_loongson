Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 14:15:48 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:17977 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014610AbbAONOH6DBXP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2015 14:14:07 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 15 Jan
 2015 16:14:01 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 14/15] MIPS: OCTEON: Don't do acknowledge operations for level triggered irqs.
Date:   Thu, 15 Jan 2015 16:11:18 +0300
Message-ID: <1421327487-28679-15-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1421327487-28679-1-git-send-email-aleksey.makarov@auriga.com>
References: <1421327487-28679-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

From: David Daney <david.daney@cavium.com>

The acknowledge bits don't exist for level triggered irqs, so setting
them causes the simulator to terminate.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/cavium-octeon/octeon-irq.c | 45 ++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 01bb01c..1b25998 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -752,6 +752,18 @@ static struct irq_chip octeon_irq_chip_ciu_v2 = {
 	.name = "CIU",
 	.irq_enable = octeon_irq_ciu_enable_v2,
 	.irq_disable = octeon_irq_ciu_disable_all_v2,
+	.irq_mask = octeon_irq_ciu_disable_local_v2,
+	.irq_unmask = octeon_irq_ciu_enable_v2,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
+	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+#endif
+};
+
+static struct irq_chip octeon_irq_chip_ciu_v2_edge = {
+	.name = "CIU",
+	.irq_enable = octeon_irq_ciu_enable_v2,
+	.irq_disable = octeon_irq_ciu_disable_all_v2,
 	.irq_ack = octeon_irq_ciu_ack,
 	.irq_mask = octeon_irq_ciu_disable_local_v2,
 	.irq_unmask = octeon_irq_ciu_enable_v2,
@@ -765,6 +777,18 @@ static struct irq_chip octeon_irq_chip_ciu = {
 	.name = "CIU",
 	.irq_enable = octeon_irq_ciu_enable,
 	.irq_disable = octeon_irq_ciu_disable_all,
+	.irq_mask = octeon_irq_ciu_disable_local,
+	.irq_unmask = octeon_irq_ciu_enable,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = octeon_irq_ciu_set_affinity,
+	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+#endif
+};
+
+static struct irq_chip octeon_irq_chip_ciu_edge = {
+	.name = "CIU",
+	.irq_enable = octeon_irq_ciu_enable,
+	.irq_disable = octeon_irq_ciu_disable_all,
 	.irq_ack = octeon_irq_ciu_ack,
 	.irq_mask = octeon_irq_ciu_disable_local,
 	.irq_unmask = octeon_irq_ciu_enable,
@@ -984,6 +1008,7 @@ static int octeon_irq_ciu_xlat(struct irq_domain *d,
 }
 
 static struct irq_chip *octeon_irq_ciu_chip;
+static struct irq_chip *octeon_irq_ciu_chip_edge;
 static struct irq_chip *octeon_irq_gpio_chip;
 
 static bool octeon_irq_virq_in_range(unsigned int virq)
@@ -1014,7 +1039,7 @@ static int octeon_irq_ciu_map(struct irq_domain *d,
 
 	if (octeon_irq_ciu_is_edge(line, bit))
 		octeon_irq_set_ciu_mapping(virq, line, bit, 0,
-					   octeon_irq_ciu_chip,
+					   octeon_irq_ciu_chip_edge,
 					   handle_edge_irq);
 	else
 		octeon_irq_set_ciu_mapping(virq, line, bit, 0,
@@ -1196,6 +1221,7 @@ static void __init octeon_irq_init_ciu(void)
 {
 	unsigned int i;
 	struct irq_chip *chip;
+	struct irq_chip *chip_edge;
 	struct irq_chip *chip_mbox;
 	struct irq_chip *chip_wd;
 	struct device_node *gpio_node;
@@ -1212,16 +1238,19 @@ static void __init octeon_irq_init_ciu(void)
 	    OCTEON_IS_MODEL(OCTEON_CN52XX_PASS2_X) ||
 	    OCTEON_IS_OCTEON2() || OCTEON_IS_OCTEON3()) {
 		chip = &octeon_irq_chip_ciu_v2;
+		chip_edge = &octeon_irq_chip_ciu_v2_edge;
 		chip_mbox = &octeon_irq_chip_ciu_mbox_v2;
 		chip_wd = &octeon_irq_chip_ciu_wd_v2;
 		octeon_irq_gpio_chip = &octeon_irq_chip_ciu_gpio_v2;
 	} else {
 		chip = &octeon_irq_chip_ciu;
+		chip_edge = &octeon_irq_chip_ciu_edge;
 		chip_mbox = &octeon_irq_chip_ciu_mbox;
 		chip_wd = &octeon_irq_chip_ciu_wd;
 		octeon_irq_gpio_chip = &octeon_irq_chip_ciu_gpio;
 	}
 	octeon_irq_ciu_chip = chip;
+	octeon_irq_ciu_chip_edge = chip_edge;
 	octeon_irq_ip4 = octeon_irq_ip4_mask;
 
 	/* Mips internal */
@@ -1473,6 +1502,18 @@ static struct irq_chip octeon_irq_chip_ciu2 = {
 	.name = "CIU2-E",
 	.irq_enable = octeon_irq_ciu2_enable,
 	.irq_disable = octeon_irq_ciu2_disable_all,
+	.irq_mask = octeon_irq_ciu2_disable_local,
+	.irq_unmask = octeon_irq_ciu2_enable,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = octeon_irq_ciu2_set_affinity,
+	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+#endif
+};
+
+static struct irq_chip octeon_irq_chip_ciu2_edge = {
+	.name = "CIU2-E",
+	.irq_enable = octeon_irq_ciu2_enable,
+	.irq_disable = octeon_irq_ciu2_disable_all,
 	.irq_ack = octeon_irq_ciu2_ack,
 	.irq_mask = octeon_irq_ciu2_disable_local,
 	.irq_unmask = octeon_irq_ciu2_enable,
@@ -1582,7 +1623,7 @@ static int octeon_irq_ciu2_map(struct irq_domain *d,
 
 	if (octeon_irq_ciu2_is_edge(line, bit))
 		octeon_irq_set_ciu_mapping(virq, line, bit, 0,
-					   &octeon_irq_chip_ciu2,
+					   &octeon_irq_chip_ciu2_edge,
 					   handle_edge_irq);
 	else
 		octeon_irq_set_ciu_mapping(virq, line, bit, 0,
-- 
2.2.2
