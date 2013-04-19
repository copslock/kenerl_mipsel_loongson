Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Apr 2013 09:39:17 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:49366 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823036Ab3DSHjQUq1uF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Apr 2013 09:39:16 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aqC_-XeFHoku; Fri, 19 Apr 2013 09:38:25 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 0EFBB28008D;
        Fri, 19 Apr 2013 09:38:25 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Andrew Murray <Andrew.Murray@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Gabor Juhos <juhosg@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: pci: fix build errors in pci_load_of_ranges
Date:   Fri, 19 Apr 2013 09:39:12 +0200
Message-Id: <1366357152-28812-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

The 'pci_load_of_ranges' function has been converted to use
the common 'of_pci_range_parser' helper by the following commit:
"of/pci: mips: convert to common of_pci_range_parser".

That change causes build error because the type of the 'range'
variable is defined as 'struct pci_of_range_range' instead of
the corect 'struct pci_of_range':

  arch/mips/pci/pci.c: In function 'pci_load_of_ranges':
  arch/mips/pci/pci.c:124:28: error: storage size of 'range' isn't known

Furthermore, the code uses non-existent fields:

  arch/mips/pci/pci.c: In function 'pci_load_of_ranges':
  arch/mips/pci/pci.c:139:4: error: 'struct of_pci_range' has no member named 'addr'
  arch/mips/pci/pci.c:139:4: error: 'struct of_pci_range' has no member named 'addr'
  arch/mips/pci/pci.c:142:20: error: 'struct of_pci_range' has no member named 'addr'
  arch/mips/pci/pci.c:145:4: error: 'struct of_pci_range' has no member named 'addr'
  arch/mips/pci/pci.c:145:4: error: 'struct of_pci_range' has no member named 'addr'

Use the correct structure and field names to fix the errors.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Note:

Although this is a MIPS specific patch, it should be merged via
the arm-soc tree, because the offending commit exist only in that.

The patch is based on the next/drivers branch of the arm-soc tree.
---
 arch/mips/pci/pci.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index bee49a4..9c15061 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -122,7 +122,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
 #ifdef CONFIG_OF
 void pci_load_of_ranges(struct pci_controller *hose, struct device_node *node)
 {
-	struct of_pci_range_range range;
+	struct of_pci_range range;
 	struct of_pci_range_parser parser;
 	u32 res_type;
 
@@ -138,13 +138,16 @@ void pci_load_of_ranges(struct pci_controller *hose, struct device_node *node)
 		res_type = range.flags & IORESOURCE_TYPE_BITS;
 		if (res_type == IORESOURCE_IO) {
 			pr_info("  IO 0x%016llx..0x%016llx\n",
-				range.addr, range.addr + range.size - 1);
+				range.cpu_addr,
+				range.cpu_addr + range.size - 1);
 			hose->io_map_base =
-				(unsigned long)ioremap(range.addr, range.size);
+				(unsigned long)ioremap(range.cpu_addr,
+						       range.size);
 			res = hose->io_resource;
 		} else if (res_type == IORESOURCE_MEM) {
 			pr_info(" MEM 0x%016llx..0x%016llx\n",
-				range.addr, range.addr + range.size - 1);
+				range.cpu_addr,
+				range.cpu_addr + range.size - 1);
 			res = hose->mem_resource;
 		}
 		if (res != NULL)
-- 
1.7.10
