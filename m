Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 16:23:35 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:51432 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28577884AbYGWPXd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2008 16:23:33 +0100
Received: from localhost.localdomain (p3049-ipad205funabasi.chiba.ocn.ne.jp [222.146.98.49])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 59A65A8DC; Thu, 24 Jul 2008 00:23:28 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 03/10] Introduce pcibios_plat_setup
Date:	Thu, 24 Jul 2008 00:25:14 +0900
Message-Id: <1216826721-28259-3-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.5.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Introduce pcibios_plat_setup for platform-specific pcibios_setup.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/pci.c    |    6 +++++-
 include/asm-mips/pci.h |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 77bd5b6..c7fe6ec 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -328,7 +328,11 @@ EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 #endif
 
-char *pcibios_setup(char *str)
+char * (*pcibios_plat_setup)(char *str) __devinitdata;
+
+char *__devinit pcibios_setup(char *str)
 {
+	if (pcibios_plat_setup)
+		return pcibios_plat_setup(str);
 	return str;
 }
diff --git a/include/asm-mips/pci.h b/include/asm-mips/pci.h
index c205875..5510c53 100644
--- a/include/asm-mips/pci.h
+++ b/include/asm-mips/pci.h
@@ -174,4 +174,6 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 
 extern int pci_probe_only;
 
+extern char * (*pcibios_plat_setup)(char *str);
+
 #endif /* _ASM_PCI_H */
-- 
1.5.5.5
