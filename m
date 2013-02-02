Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Feb 2013 15:37:01 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47761 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823088Ab3BBOhAFN44u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Feb 2013 15:37:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id E4A9425D296;
        Sat,  2 Feb 2013 15:36:54 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mMZ78i9sXDLO; Sat,  2 Feb 2013 15:36:54 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 9AF9325C036;
        Sat,  2 Feb 2013 15:36:53 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: add dummy pci_load_of_ranges
Date:   Sat,  2 Feb 2013 15:36:48 +0100
Message-Id: <1359815808-7829-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35688
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

The pci_load_of_ranges function is only available if
CONFIG_OF is selected. If the function is used without
CONFIG_OF being enabled it will cause a build error.

Add a dummy inline function to avoid this.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/include/asm/pci.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index d69ea74..630645e 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -144,8 +144,13 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 
 extern char * (*pcibios_plat_setup)(char *str);
 
+#ifdef CONFIG_OF
 /* this function parses memory ranges from a device node */
 extern void pci_load_of_ranges(struct pci_controller *hose,
 			       struct device_node *node);
+#else
+static inline void pci_load_of_ranges(struct pci_controller *hose,
+				      struct device_node *node) {}
+#endif
 
 #endif /* _ASM_PCI_H */
-- 
1.7.10
