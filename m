Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jul 2010 03:14:37 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14060 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491983Ab0G0BOe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jul 2010 03:14:34 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4e33120001>; Mon, 26 Jul 2010 18:14:58 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Jul 2010 18:14:30 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Jul 2010 18:14:30 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6R1EQ40016347;
        Mon, 26 Jul 2010 18:14:26 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6R1EQpO016346;
        Mon, 26 Jul 2010 18:14:26 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Octeon: Disallow MSI-X interrupt and fall back to MSI interrupts.
Date:   Mon, 26 Jul 2010 18:14:16 -0700
Message-Id: <1280193256-16294-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1280193256-16294-1-git-send-email-ddaney@caviumnetworks.com>
References: <1280193256-16294-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 27 Jul 2010 01:14:30.0682 (UTC) FILETIME=[10AC2FA0:01CB2D29]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: Chandrakala Chavva <cchavva@caviumnetworks.com>

MSI-X interrupts are not supported yet for Octeon, return error if
MSI-X interrupts are requested by driver so that the driver will fall
back to use MSI interrupts.

Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/pci.h |    5 +++++
 arch/mips/pci/msi-octeon.c  |   28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 3beea14..576397c 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -140,6 +140,11 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+/* MSI arch hook for OCTEON */
+#define arch_setup_msi_irqs arch_setup_msi_irqs
+#endif
+
 extern int pci_probe_only;
 
 extern char * (*pcibios_plat_setup)(char *str);
diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index 7c75640..d808049 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -177,6 +177,34 @@ msi_irq_allocated:
 	return 0;
 }
 
+int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	struct msi_desc *entry;
+	int ret;
+
+	/*
+	 * MSI-X is not supported.
+	 */
+	if (type == PCI_CAP_ID_MSIX)
+		return -EINVAL;
+
+	/*
+	 * If an architecture wants to support multiple MSI, it needs to
+	 * override arch_setup_msi_irqs()
+	 */
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		ret = arch_setup_msi_irq(dev, entry);
+		if (ret < 0)
+			return ret;
+		if (ret > 0)
+			return -ENOSPC;
+	}
+
+	return 0;
+}
 
 /**
  * Called when a device no longer needs its MSI interrupts. All
-- 
1.7.1.1
