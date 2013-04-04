Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Apr 2013 20:01:32 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:42063 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822678Ab3DDSBLTD6lt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Apr 2013 20:01:11 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id khH9TeDhy2-W; Thu,  4 Apr 2013 20:00:29 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A064C2800FA;
        Thu,  4 Apr 2013 20:00:28 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/2] MIPS: implement pcibios_get_phb_of_node
Date:   Thu,  4 Apr 2013 20:01:23 +0200
Message-Id: <1365098483-26821-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1365098483-26821-1-git-send-email-juhosg@openwrt.org>
References: <1365098483-26821-1-git-send-email-juhosg@openwrt.org>
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36018
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

The of_node field of the device assigned to a
PCI bus is used during scanning of the PCI bus.
However on MIPS, the of_node field is assigned
only after the bus has been scanned.

Implement the architecture specific version of
'pcibios_get_phb_of_node'. Which ensures that the
PCI driver core will initialize the of_node field
before starting the scan.

Also remove the local assignment of bus->dev.of_node,
it is not needed after the patch.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/pci/pci.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 0872f12..594e60d 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -115,7 +115,6 @@ static void pcibios_scanbus(struct pci_controller *hose)
 			pci_bus_assign_resources(bus);
 			pci_enable_bridges(bus);
 		}
-		bus->dev.of_node = hose->of_node;
 	}
 }
 
@@ -169,6 +168,13 @@ void pci_load_of_ranges(struct pci_controller *hose, struct device_node *node)
 		}
 	}
 }
+
+struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
+{
+	struct pci_controller *hose = bus->sysdata;
+
+	return of_node_get(hose->of_node);
+}
 #endif
 
 static DEFINE_MUTEX(pci_scan_mutex);
-- 
1.7.10
