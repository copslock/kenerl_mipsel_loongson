Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 00:15:54 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47750 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903835Ab1KVXO6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2011 00:14:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 80135140586;
        Wed, 23 Nov 2011 00:14:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ABkN6M916zMF; Wed, 23 Nov 2011 00:14:51 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 541DA14057B;
        Wed, 23 Nov 2011 00:14:51 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 01/12] MIPS: ath79: remove superfluous alignment checks from pci-ar724x.c
Date:   Wed, 23 Nov 2011 00:14:19 +0100
Message-Id: <1322003670-8797-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19226

The alignment of the 'where' parameters are checked
in the core PCI code already.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
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
