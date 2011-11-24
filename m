Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 18:57:27 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:42048 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904613Ab1KXR4a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Nov 2011 18:56:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 53221140605;
        Thu, 24 Nov 2011 18:56:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pxvdQhEGoV+V; Thu, 24 Nov 2011 18:56:21 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 9EE5A140510;
        Thu, 24 Nov 2011 18:56:21 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 01/12] MIPS: ath79: remove superfluous alignment checks from pci-ar724x.c
Date:   Thu, 24 Nov 2011 18:55:56 +0100
Message-Id: <1322157367-31089-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1322157367-31089-1-git-send-email-juhosg@openwrt.org>
References: <1322157367-31089-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21009

The alignment of the 'where' parameters are checked
in the core PCI code already.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
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
