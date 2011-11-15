Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 00:49:11 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:35932 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903749Ab1KOXqf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 00:46:35 +0100
Received: by yenl9 with SMTP id l9so8428452yen.36
        for <multiple recipients>; Tue, 15 Nov 2011 15:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QkaJB3lRWdPgapbA10rTyIlUcMZKnL20g5VFeLvVhfw=;
        b=alAt9DDiXasZLMku0zxLsv9uUVWGpQGWoApjk7hEI3chmAYH3g65GW60+UdYzXjCm8
         fhDeEKWWfQ4KV3YP+ubSg/ysgNZfApv2M2PrSp2fDgiPbF07pK1l1JglyF3ELcnMx+O1
         u9avVqi0oR3pe+cuX7tuHM+PsNi63mqDXVXuk=
Received: by 10.101.155.27 with SMTP id h27mr2485906ano.56.1321400789675;
        Tue, 15 Nov 2011 15:46:29 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id u19sm78916677ank.11.2011.11.15.15.46.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 15:46:28 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAFNkIXW032406;
        Tue, 15 Nov 2011 15:46:18 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAFNkItW032405;
        Tue, 15 Nov 2011 15:46:18 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/5] MIPS: Octeon: Update PCI Latency timer, PCIe payload, and PCIe max read to allow larger transactions
Date:   Tue, 15 Nov 2011 15:46:14 -0800
Message-Id: <1321400775-32353-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1321400775-32353-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321400775-32353-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12949

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/pci/pci-octeon.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index ed1c542..e2ca7de 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -99,7 +99,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	 */
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 64 / 4);
 	/* Set latency timers for all devices */
-	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 48);
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
 
 	/* Enable reporting System errors and parity errors on all devices */
 	/* Enable parity checking and error reporting */
@@ -109,7 +109,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 
 	if (dev->subordinate) {
 		/* Set latency timers on sub bridges */
-		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER, 48);
+		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER, 64);
 		/* More bridge error detection */
 		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &config);
 		config |= PCI_BRIDGE_CTL_PARITY | PCI_BRIDGE_CTL_SERR;
@@ -119,16 +119,22 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	/* Enable the PCIe normal error reporting */
 	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
 	if (pos) {
+		pci_read_config_dword(dev, pos + PCI_EXP_DEVCAP, &dconfig);
 		/* Update Device Control */
 		pci_read_config_word(dev, pos + PCI_EXP_DEVCTL, &config);
-		/* Correctable Error Reporting */
-		config |= PCI_EXP_DEVCTL_CERE;
-		/* Non-Fatal Error Reporting */
-		config |= PCI_EXP_DEVCTL_NFERE;
-		/* Fatal Error Reporting */
-		config |= PCI_EXP_DEVCTL_FERE;
-		/* Unsupported Request */
-		config |= PCI_EXP_DEVCTL_URRE;
+		config |= PCI_EXP_DEVCTL_CERE; /* Correctable Error Reporting */
+		config |= PCI_EXP_DEVCTL_NFERE; /* Non-Fatal Error Reporting */
+		config |= PCI_EXP_DEVCTL_FERE;  /* Fatal Error Reporting */
+		config |= PCI_EXP_DEVCTL_URRE;  /* Unsupported Request */
+		/*
+		 * Octeon's max payload is 256 bytes. Set the device's
+		 * to that unless it can't go that big
+		 */
+		if ((dconfig & PCI_EXP_DEVCAP_PAYLOAD) >= 1)
+			config = (config & ~PCI_EXP_DEVCTL_PAYLOAD) | (1 << 5);
+		/* Set the max read size to 4KB, Octeon's max */
+		config = (config & ~PCI_EXP_DEVCTL_READRQ) | (5 << 12);
+
 		pci_write_config_word(dev, pos + PCI_EXP_DEVCTL, config);
 	}
 
-- 
1.7.2.3
