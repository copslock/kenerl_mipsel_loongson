Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2013 11:59:10 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37407 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816288Ab3BCK6wJNJR0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Feb 2013 11:58:52 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id CA82225D403;
        Sun,  3 Feb 2013 11:58:45 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QxI4b2OINsIN; Sun,  3 Feb 2013 11:58:45 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id E08F725D3E0;
        Sun,  3 Feb 2013 11:58:44 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 1/4] MIPS: ath79: allow to specify bus number in PCI IRQ maps
Date:   Sun,  3 Feb 2013 11:58:37 +0100
Message-Id: <1359889120-15699-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35690
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This is needed for multiple PCI bus support.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/pci.c |    4 +++-
 arch/mips/ath79/pci.h |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index c94bcec..d90e071 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -75,7 +75,9 @@ int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
 		const struct ath79_pci_irq *entry;
 
 		entry = &ath79_pci_irq_map[i];
-		if (entry->slot == slot && entry->pin == pin) {
+		if (entry->bus == dev->bus->number &&
+		    entry->slot == slot &&
+		    entry->pin == pin) {
 			irq = entry->irq;
 			break;
 		}
diff --git a/arch/mips/ath79/pci.h b/arch/mips/ath79/pci.h
index 51c6625..1d00a38 100644
--- a/arch/mips/ath79/pci.h
+++ b/arch/mips/ath79/pci.h
@@ -14,6 +14,7 @@
 #define _ATH79_PCI_H
 
 struct ath79_pci_irq {
+	int	bus;
 	u8	slot;
 	u8	pin;
 	int	irq;
-- 
1.7.10
