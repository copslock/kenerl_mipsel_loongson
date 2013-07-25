Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jul 2013 18:14:40 +0200 (CEST)
Received: from mail-wg0-f54.google.com ([74.125.82.54]:60794 "EHLO
        mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827441Ab3GYQOiWs3q9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Jul 2013 18:14:38 +0200
Received: by mail-wg0-f54.google.com with SMTP id n12so1817951wgh.21
        for <linux-mips@linux-mips.org>; Thu, 25 Jul 2013 09:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=nPASqlh82n6ekLjHgSRC+0KioVg3+SfECVxbprXRgLo=;
        b=FxZuAmWx2Pvwtjog0BNjz87m9RdVZjbgQa+3RtLRzw5mx23Rmz5zVFXL/zAJzkW71X
         Nxxr22WvpNYzet/Pce4bo1yxExyBWAe89sFRZhqbRFww4AGiWnHM9vtFNamzOemKQTf9
         77rEM6YwrVr9KUycWfXsiRCNpyWRngqAC8UXYWEjlbzSTISFTJGCRdfla58KkblaA/Qg
         bUASf3rq+DP+6P5a3uvJFVj20hhomwwdIhpRYaVDgP1BDdJSagxmpFl0QygfmO//y949
         4N9KSpO31FLQ3NzEl72AjeGFwAINrvavPrpO8PyDb88JhGx/Pm7zV6HIVQVP402coJTL
         OAqg==
X-Received: by 10.194.158.130 with SMTP id wu2mr31682090wjb.12.1374768872807;
        Thu, 25 Jul 2013 09:14:32 -0700 (PDT)
Received: from localhost.localdomain (host-89-242-62-51.as13285.net. [89.242.62.51])
        by mx.google.com with ESMTPSA id i1sm4770580wiz.6.2013.07.25.09.14.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Jul 2013 09:14:31 -0700 (PDT)
From:   Andrew Murray <amurray@embedded-bits.co.uk>
To:     linux-mips@linux-mips.org
Cc:     jason@lakedaemon.net, ralf@linux-mips.org,
        Andrew Murray <amurray@embedded-bits.co.uk>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] of/pci: Use of_pci_range_parser
Date:   Thu, 25 Jul 2013 17:14:25 +0100
Message-Id: <1374768865-23619-1-git-send-email-amurray@embedded-bits.co.uk>
X-Mailer: git-send-email 1.7.9.5
X-Gm-Message-State: ALoCoQmfvSQe272IPOplFmA+kv3leK740+mKrb9N3iUSKrz+VEIPWdN2TL4IWIOfsJJdNclGeuGy
Return-Path: <amurray@embedded-bits.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amurray@embedded-bits.co.uk
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

This patch converts the pci_load_of_ranges function to use the new common
of_pci_range_parser.

Signed-off-by: Andrew Murray <amurray@embedded-bits.co.uk>
Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Reviewed-by: Rob Herring <rob.herring@calxeda.com>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
---
This is a resend of the second patch in the of_pci_range_parser patch
series [1] rebased for 3.11-rc2. The first patch in the series which
this depends on [2] is now in 3.11-rc1.

[1] http://patchwork.linux-mips.org/patch/5217/
[2] http://patchwork.linux-mips.org/patch/5218/
---
 arch/mips/pci/pci.c |   50 ++++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 594e60d..4f2e17d 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -121,51 +121,37 @@ static void pcibios_scanbus(struct pci_controller *hose)
 #ifdef CONFIG_OF
 void pci_load_of_ranges(struct pci_controller *hose, struct device_node *node)
 {
-	const __be32 *ranges;
-	int rlen;
-	int pna = of_n_addr_cells(node);
-	int np = pna + 5;
+	struct of_pci_range range;
+	struct of_pci_range_parser parser;
 
 	pr_info("PCI host bridge %s ranges:\n", node->full_name);
-	ranges = of_get_property(node, "ranges", &rlen);
-	if (ranges == NULL)
-		return;
 	hose->of_node = node;
 
-	while ((rlen -= np * 4) >= 0) {
-		u32 pci_space;
+	if (of_pci_range_parser_init(&parser, node))
+		return;
+
+	for_each_of_pci_range(&parser, &range) {
 		struct resource *res = NULL;
-		u64 addr, size;
-
-		pci_space = be32_to_cpup(&ranges[0]);
-		addr = of_translate_address(node, ranges + 3);
-		size = of_read_number(ranges + pna + 3, 2);
-		ranges += np;
-		switch ((pci_space >> 24) & 0x3) {
-		case 1:		/* PCI IO space */
+
+		switch (range.flags & IORESOURCE_TYPE_BITS) {
+		case IORESOURCE_IO:
 			pr_info("  IO 0x%016llx..0x%016llx\n",
-					addr, addr + size - 1);
+				range.cpu_addr,
+				range.cpu_addr + range.size - 1);
 			hose->io_map_base =
-				(unsigned long)ioremap(addr, size);
+				(unsigned long)ioremap(range.cpu_addr,
+						       range.size);
 			res = hose->io_resource;
-			res->flags = IORESOURCE_IO;
 			break;
-		case 2:		/* PCI Memory space */
-		case 3:		/* PCI 64 bits Memory space */
+		case IORESOURCE_MEM:
 			pr_info(" MEM 0x%016llx..0x%016llx\n",
-					addr, addr + size - 1);
+				range.cpu_addr,
+				range.cpu_addr + range.size - 1);
 			res = hose->mem_resource;
-			res->flags = IORESOURCE_MEM;
 			break;
 		}
-		if (res != NULL) {
-			res->start = addr;
-			res->name = node->full_name;
-			res->end = res->start + size - 1;
-			res->parent = NULL;
-			res->sibling = NULL;
-			res->child = NULL;
-		}
+		if (res != NULL)
+			of_pci_range_to_resource(&range, node, res);
 	}
 }
 
-- 
1.7.9.5
