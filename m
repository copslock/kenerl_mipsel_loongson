Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:30:38 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:42599 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903713Ab2CNJae (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:30:34 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 1640423C00CA;
        Wed, 14 Mar 2012 10:00:08 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org
Subject: [PATCH v3 01/12] MIPS: ath79: remove superfluous alignment checks from pci-ar724x.c
Date:   Wed, 14 Mar 2012 11:36:03 +0100
Message-Id: <1331721374-4144-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
References: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The alignment of the 'where' parameters are checked
in the core PCI code already.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v3: - no changes
v2: - no changes

 arch/mips/pci/pci-ar724x.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 22f5e5b..342bf4a 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -28,9 +28,6 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (where & (size - 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
 	base = ar724x_pci_devcfg_base;
 
 	spin_lock_irqsave(&ar724x_pci_lock, flags);
@@ -73,9 +70,6 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (where & (size - 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
 	base = ar724x_pci_devcfg_base;
 
 	spin_lock_irqsave(&ar724x_pci_lock, flags);
-- 
1.7.2.1
