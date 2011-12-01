Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Dec 2011 18:51:35 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:35639 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903715Ab1LARva (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Dec 2011 18:51:30 +0100
Received: by ggki1 with SMTP id i1so2485863ggk.36
        for <multiple recipients>; Thu, 01 Dec 2011 09:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=bOQaYvlKPp1eDt9+Cu4uXN0qAtG/eZ4/BqmeZgxxF7o=;
        b=QSjVEpU3qBQeQpAw+5HE++bPvSaZEnDg3+wf5+UPBq8rF7Ub2EKmU+fK2eNF17vplU
         +tTAfDriGpSsnhy+HbE2uBDmjpwUPVyaxaXLxoq7mLto8OMZtRdR7xLjv/bCHhq6FmDh
         4gaW/ymSnCl0Gj49d4Zbf3ia9TGyUOkuC4NaQ=
Received: by 10.50.196.137 with SMTP id im9mr9560615igc.32.1322761883798;
        Thu, 01 Dec 2011 09:51:23 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ew6sm12919716igc.4.2011.12.01.09.51.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Dec 2011 09:51:23 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pB1HpLIh030253;
        Thu, 1 Dec 2011 09:51:21 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pB1HpIaw030252;
        Thu, 1 Dec 2011 09:51:18 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Octeon: Don't increase PCIe payload sizes.
Date:   Thu,  1 Dec 2011 09:51:17 -0800
Message-Id: <1322761877-30221-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 787

From: David Daney <david.daney@cavium.com>

The existing code breaks devices that are capable of large PCIe
transfers (Silicon Image SATA controllers for example).  We don't have
code to properly determine the maximum payload size on a per-bus
basis, so the easiest thing to do is just have all devices use the
default (128).

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/pci/pci-octeon.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index e2ca7de..52a1ba7 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -119,22 +119,12 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	/* Enable the PCIe normal error reporting */
 	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
 	if (pos) {
-		pci_read_config_dword(dev, pos + PCI_EXP_DEVCAP, &dconfig);
 		/* Update Device Control */
 		pci_read_config_word(dev, pos + PCI_EXP_DEVCTL, &config);
 		config |= PCI_EXP_DEVCTL_CERE; /* Correctable Error Reporting */
 		config |= PCI_EXP_DEVCTL_NFERE; /* Non-Fatal Error Reporting */
 		config |= PCI_EXP_DEVCTL_FERE;  /* Fatal Error Reporting */
 		config |= PCI_EXP_DEVCTL_URRE;  /* Unsupported Request */
-		/*
-		 * Octeon's max payload is 256 bytes. Set the device's
-		 * to that unless it can't go that big
-		 */
-		if ((dconfig & PCI_EXP_DEVCAP_PAYLOAD) >= 1)
-			config = (config & ~PCI_EXP_DEVCTL_PAYLOAD) | (1 << 5);
-		/* Set the max read size to 4KB, Octeon's max */
-		config = (config & ~PCI_EXP_DEVCTL_READRQ) | (5 << 12);
-
 		pci_write_config_word(dev, pos + PCI_EXP_DEVCTL, config);
 	}
 
-- 
1.7.2.3
