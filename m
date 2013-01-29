Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jan 2013 10:27:13 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53426 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824767Ab3A2J1LyPG74 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jan 2013 10:27:11 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id C2D6D25C697;
        Tue, 29 Jan 2013 10:27:06 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ogzEUgeSx+jS; Tue, 29 Jan 2013 10:27:06 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 7C66C25C693;
        Tue, 29 Jan 2013 10:27:06 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 1/2] MIPS: pci-ar724x: fix AR724X_PCI_MEM_SIZE
Date:   Tue, 29 Jan 2013 10:27:03 +0100
Message-Id: <1359451624-13759-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35614
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

The base address of the PCI memory is
0x10000000 and the base address of the
PCI configuration space is 0x14000000
on the AR724x SoCs.

The AR724X_PCI_MEM_SIZE is defined as
0x08000000 which is wrong because that
overlaps  with the configuration space.

The patch fixes the value of the
AR724X_PCI_MEM_SIZE constant, in order
to avoid this resource conflicts.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/pci/pci-ar724x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 86d77a6..c11c75b 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -21,7 +21,7 @@
 #define AR724X_PCI_CTRL_SIZE	0x100
 
 #define AR724X_PCI_MEM_BASE	0x10000000
-#define AR724X_PCI_MEM_SIZE	0x08000000
+#define AR724X_PCI_MEM_SIZE	0x04000000
 
 #define AR724X_PCI_REG_RESET		0x18
 #define AR724X_PCI_REG_INT_STATUS	0x4c
-- 
1.7.10
