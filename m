Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 00:16:17 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47754 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903836Ab1KVXO7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2011 00:14:59 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 59927140588;
        Wed, 23 Nov 2011 00:14:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XkWOYFNUkp46; Wed, 23 Nov 2011 00:14:53 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id E0650140581;
        Wed, 23 Nov 2011 00:14:51 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 03/12] MIPS: ath79: add a workaround for a PCI controller bug in AR724X SoCs
Date:   Wed, 23 Nov 2011 00:14:21 +0100
Message-Id: <1322003670-8797-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19228

The PCI controller of the AR724X SoCs has a hardware
bag. If the BAR0 register of the PCI device is set to
the proper base address, the memory address space of
the device is not accessible.

When the device driver tries to access the memory
address space of the PCI device, it leads to data
bus error, similiar to this:

Data bus error, epc == 801f69a0, ra == 801f698c
Oops[#1]:
Cpu 0
$ 0   : 00000000 00000061 deadbeef 000000ff
$ 4   : 00000000 000000ff 00000014 00000000
$ 8   : ff000000 fffffffc 00000000 00000000
$12   : 000001f5 00000006 00000000 6e637920
$16   : 81ca4000 81ca0260 81ca4000 804d70f0
$20   : fffffff4 0000002b 803ad4c4 00000000
$24   : 00000003 00000000
$28   : 81c20000 81c21c60 00000000 801f698c
Hi    : 00000000
Lo    : 00000000
epc   : 801f69a0 ath9k_hw_init+0xd0/0xa70
    Not tainted
ra    : 801f698c ath9k_hw_init+0xbc/0xa70
Status: 1000c103    KERNEL EXL IE
Cause : 1080001c
PrId  : 00019374 (MIPS 24Kc)
Modules linked in:
Process swapper (pid: 1, threadinfo=81c20000, task=81c18000, tls=00000000)
Stack : 00000000 00000000 00000000 00000000 81c21c78 81ca0260 00000000 804d70f0
        81ca0260 81c21cc0 81ca0e80 81ca0260 81ca4000 804d70f0 fffffff4 0000002b
        803ad4c4 00000000 00000000 801e3ae8 81c9d080 81ca0e80 b0000000 800b9b9c
        00000008 81c9d000 8031aeb0 802d38a0 00000000 81c14c00 81c14c60 00000000
        81ca0e80 81ca0260 b0000000 801f08a4 81c9c820 81c21d48 81c9c820 80144320
        ...
Call Trace:
[<801f69a0>] ath9k_hw_init+0xd0/0xa70
[<801e3ae8>] ath9k_init_device+0x174/0x680
[<801f08a4>] ath_pci_probe+0x27c/0x380
[<8019e490>] pci_device_probe+0x74/0x9c
[<801bfadc>] driver_probe_device+0x9c/0x1b4
[<801bfcb0>] __driver_attach+0xbc/0xc4
[<801bea0c>] bus_for_each_dev+0x5c/0x98
[<801bf394>] bus_add_driver+0x1d0/0x2a4
[<801c0364>] driver_register+0x8c/0x16c
[<8019e72c>] __pci_register_driver+0x4c/0xe4
[<803d3d40>] ath9k_init+0x3c/0x88
[<80060930>] do_one_initcall+0x3c/0x1cc
[<803c297c>] kernel_init+0xa4/0x138
[<80063c04>] kernel_thread_helper+0x10/0x18

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/pci/pci-ar724x.c |   47 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index bb4f216..cef6519 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/pci.h>
+#include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/pci.h>
 
 #define AR724X_PCI_CFG_BASE	0x14000000
@@ -16,9 +17,22 @@
 #define AR724X_PCI_MEM_BASE	0x10000000
 #define AR724X_PCI_MEM_SIZE	0x08000000
 
+#define AR724X_PCI_REG_INT_STATUS	0x4c
+#define AR724X_PCI_REG_INT_MASK		0x50
+
+#define AR724X_PCI_INT_DEV0		BIT(14)
+
+#define AR724X_PCI_IRQ_COUNT	1
+
+#define AR7240_BAR0_WAR_VALUE	0xffff
+#define AR724X_BAR0_WAR_VALUE	0x1000ffff
+
 static DEFINE_SPINLOCK(ar724x_pci_lock);
 static void __iomem *ar724x_pci_devcfg_base;
 
+static u32 ar724x_pci_bar0_value;
+static bool ar724x_pci_bar0_is_cached;
+
 static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 			    int size, uint32_t *value)
 {
@@ -56,7 +70,14 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 	}
 
 	spin_unlock_irqrestore(&ar724x_pci_lock, flags);
-	*value = data;
+
+	if (where == PCI_BASE_ADDRESS_0 && size == 4 &&
+	    ar724x_pci_bar0_is_cached) {
+		/* use the cached value */
+		*value = ar724x_pci_bar0_value;
+	} else {
+		*value = data;
+	}
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -72,6 +93,30 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	if (where == PCI_BASE_ADDRESS_0 && size == 4) {
+		if (value != 0xffffffff) {
+			/*
+			 * WAR for a hw issue. If the BAR0 register of the
+			 * device is set to the proper base address, the
+			 * memory space of the device is not accessible.
+			 *
+			 * Cache the intended value so it can be read back,
+			 * and write a SoC specific constant value to the
+			 * BAR0 register in order to make the device memory
+			 * accessible.
+			 */
+			ar724x_pci_bar0_is_cached = true;
+			ar724x_pci_bar0_value = value;
+
+			if (soc_is_ar7240())
+				value = AR7240_BAR0_WAR_VALUE;
+			else
+				value = AR724X_BAR0_WAR_VALUE;
+		} else {
+			ar724x_pci_bar0_is_cached = false;
+		}
+	}
+
 	base = ar724x_pci_devcfg_base;
 
 	spin_lock_irqsave(&ar724x_pci_lock, flags);
-- 
1.7.2.1
