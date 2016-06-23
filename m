Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2016 00:17:12 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:35912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008315AbcFWWQ7rNY2p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Jun 2016 00:16:59 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 2A3E2201CE;
        Thu, 23 Jun 2016 22:16:58 +0000 (UTC)
Received: from localhost (unknown [69.71.1.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57BBC2017D;
        Thu, 23 Jun 2016 22:16:57 +0000 (UTC)
Subject: [PATCH] MIPS/PCI: Claim bus resources on PCI_PROBE_ONLY set-ups
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-mips@linux-mips.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jayachandran C <jchandra@broadcom.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        David Daney <david.daney@cavium.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Isaacson <adi@hexapodia.org>,
        Yinghai Lu <yinghai@kernel.org>
Date:   Thu, 23 Jun 2016 17:16:55 -0500
Message-ID: <20160623221655.3154.89258.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

We claim PCI BAR and bridge window resources in pci_bus_assign_resources(),
but when PCI_PROBE_ONLY is set, we treat those resources as immutable and
don't call pci_bus_assign_resources(), so the resources aren't put in the
resource tree.

When the resources aren't in the tree, they don't show up in /proc/iomem,
we can't detect conflicts, and we need special cases elsewhere for
PCI_PROBE_ONLY or resources without a parent pointer.

Claim all PCI BAR and window resources in the PCI_PROBE_ONLY case.

If a PCI_PROBE_ONLY platform assigns conflicting resources, Linux can't fix
the conflicts.  Previously we didn't notice the conflicts, but now we will,
which may expose new failures.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/pci.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 5717384..b4c02f2 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -112,7 +112,14 @@ static void pcibios_scanbus(struct pci_controller *hose)
 		need_domain_info = 1;
 	}
 
-	if (!pci_has_flag(PCI_PROBE_ONLY)) {
+	/*
+	 * We insert PCI resources into the iomem_resource and
+	 * ioport_resource trees in either pci_bus_claim_resources()
+	 * or pci_bus_assign_resources().
+	 */
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_claim_resources(bus);
+	} else {
 		pci_bus_size_bridges(bus);
 		pci_bus_assign_resources(bus);
 	}
