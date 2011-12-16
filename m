Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2011 23:31:56 +0100 (CET)
Received: from mail-ey0-f201.google.com ([209.85.215.201]:64524 "EHLO
        mail-ey0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903680Ab1LPWbq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Dec 2011 23:31:46 +0100
Received: by eaan10 with SMTP id n10so101569eaa.0
        for <linux-mips@linux-mips.org>; Fri, 16 Dec 2011 14:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=4BxWnxDCJAZNF60EvREE2vUxAkMHsb8UoQ9rAhp2sW4=;
        b=bgGahfAY1fTpFrxW61aWR2nqd63KVZ4B7gOAQUkqBnbKn5ZQUD8lAEUzwd6FJrNFA9
         1NYrzvmQgl9Imhmi4yiQ==
Received: by 10.213.34.72 with SMTP id k8mr958198ebd.9.1324074700903;
        Fri, 16 Dec 2011 14:31:40 -0800 (PST)
Received: by 10.213.34.72 with SMTP id k8mr958185ebd.9.1324074700454;
        Fri, 16 Dec 2011 14:31:40 -0800 (PST)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a53si446722eeg.1.2011.12.16.14.31.40
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 16 Dec 2011 14:31:40 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
        by hpza9.eem.corp.google.com (Postfix) with ESMTP id 4335B5C0050;
        Fri, 16 Dec 2011 14:31:40 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
        by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id A644418273A;
        Fri, 16 Dec 2011 14:31:39 -0800 (PST)
Subject: [PATCH 2/6] MIPS: PCI: use list_for_each_entry() for bus->devices
        traversal
To:     Jesse Barnes <jbarnes@virtuousgeek.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Date:   Fri, 16 Dec 2011 15:31:39 -0700
Message-ID: <20111216223139.5963.51460.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-archive-position: 32112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13791

Replace open-coded list traversal with list_for_each_entry().

CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/pci.c                    |    5 +----
 arch/mips/pmc-sierra/yosemite/ht-irq.c |   10 ----------
 2 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 934862c..ae5e423 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -273,7 +273,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	/* Propagate hose info into the subordinate devices.  */
 
-	struct list_head *ln;
 	struct pci_dev *dev = bus->self;
 
 	if (pci_probe_only && dev &&
@@ -282,9 +281,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 		pcibios_fixup_device_resources(dev, bus);
 	}
 
-	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-		dev = pci_dev_b(ln);
-
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 			pcibios_fixup_device_resources(dev, bus);
 	}
diff --git a/arch/mips/pmc-sierra/yosemite/ht-irq.c b/arch/mips/pmc-sierra/yosemite/ht-irq.c
index 86b98e9..62ead66 100644
--- a/arch/mips/pmc-sierra/yosemite/ht-irq.c
+++ b/arch/mips/pmc-sierra/yosemite/ht-irq.c
@@ -35,16 +35,6 @@
  */
 void __init titan_ht_pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_bus *current_bus = bus;
-	struct pci_dev *devices;
-	struct list_head *devices_link;
-
-	list_for_each(devices_link, &(current_bus->devices)) {
-		devices = pci_dev_b(devices_link);
-		if (devices == NULL)
-			continue;
-	}
-
 	/*
 	 * PLX and SPKT related changes go here
 	 */
