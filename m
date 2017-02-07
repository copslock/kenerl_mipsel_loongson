Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 07:19:07 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:34062 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992562AbdBGGOSh2J3r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Feb 2017 07:14:18 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id D6EEE341698;
        Tue,  7 Feb 2017 06:14:11 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 12/12] MIPS: PCI: Fix IP27 for the PCI_PROBE_ONLY case
Date:   Tue,  7 Feb 2017 01:13:56 -0500
Message-Id: <20170207061356.8270-13-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207061356.8270-1-kumba@gentoo.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Commit 046136170a56 changed things such that setting PCI_PROBE_ONLY
will now explicitly claim PCI resources instead of skipping the sizing
of the bridges and assigning resources.  This is okay for IP30's PCI
code, which doesn't use physical address space to access I/O resources.

However, IP27 is completely different in this regard.  Instead of using
ioremapped addresses for I/O, IP27 has a dedicated address range,
0x92xxxxxxxxxxxxxx, that is used for all I/O access.  Since this is
uncached physical address space, the generic MIPS PCI code will not
probe it correctly and thus, the original behavior of PCI_PROBE_ONLY
needs to be restored only for the IP27 platform to bypass this logic
and have working PCI, at least for the IO6/IO6G board that houses the
base devices, until a better solution is found.

Fixes: 046136170a56 ("MIPS/PCI: Claim bus resources on PCI_PROBE_ONLY set-ups")
Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/pci/pci-bridge.c | 15 +++++++++++++++
 arch/mips/pci/pci-legacy.c | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/mips/pci/pci-bridge.c b/arch/mips/pci/pci-bridge.c
index 9df13ce313b5..af7073dba36b 100644
--- a/arch/mips/pci/pci-bridge.c
+++ b/arch/mips/pci/pci-bridge.c
@@ -62,6 +62,21 @@ bridge_probe(nasid_t nasid, int widget_id, int masterwid)
 	unsigned long offset = NODE_OFFSET(nasid);
 	struct bridge_controller *bc;
 
+#ifdef CONFIG_SGI_IP27
+	/*
+	 * Commit 046136170a56 changed things such that setting PCI_PROBE_ONLY
+	 * will now explicitly claim PCI resources instead of skipping the
+	 * sizing of the bridges and assigning resources.  This is okay for
+	 * the IP30's PCI code, which uses normal, ioremapped addresses to
+	 * do I/O.  IP27, however, is different and uses a hardware-specific
+	 * address range of 0x92xxxxxxxxxxxxxx for all I/O access.  As such,
+	 * the generic MIPS PCI code will not probe correctly and thus make
+	 * PCI on IP27 completely unusable.  Thus, we must restore the
+	 * original logic only for IP27 until a better solution can be found.
+	 */
+	pci_set_flags(PCI_PROBE_ONLY);
+#endif
+
 	/* XXX: Temporary until the IP27 "mega update". */
 	bc = &bridges[num_bridges];
 	if (!num_bridges)
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 68268bbb15b8..5590af4f367f 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -107,6 +107,20 @@ static void pcibios_scanbus(struct pci_controller *hose)
 		need_domain_info = 1;
 	}
 
+#ifdef CONFIG_SGI_IP27
+	/*
+	 * Commit 046136170a56 changed things such that setting PCI_PROBE_ONLY
+	 * will now explicitly claim PCI resources instead of skipping the
+	 * sizing of the bridges and assigning resources.  This is okay for
+	 * the IP30's PCI code, which uses normal, ioremapped addresses to
+	 * do I/O.  IP27, however, is different and uses a hardware-specific
+	 * address range of 0x92xxxxxxxxxxxxxx for all I/O access.  As such,
+	 * the generic MIPS PCI code will not probe correctly and thus make
+	 * PCI on IP27 completely unusable.  Thus, we must restore the
+	 * original logic only for IP27 until a better solution can be found.
+	 */
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
+#else
 	/*
 	 * We insert PCI resources into the iomem_resource and
 	 * ioport_resource trees in either pci_bus_claim_resources()
@@ -115,6 +129,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
 	if (pci_has_flag(PCI_PROBE_ONLY)) {
 		pci_bus_claim_resources(bus);
 	} else {
+#endif
 		pci_bus_size_bridges(bus);
 		pci_bus_assign_resources(bus);
 	}
-- 
2.11.1
