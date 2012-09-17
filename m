Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2012 13:24:03 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.187]:64590 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903256Ab2IQLXy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Sep 2012 13:23:54 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
        id 0Ln0mX-1TjLSh1cfV-00hJbE; Mon, 17 Sep 2012 13:22:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 6A0412A282F7;
        Mon, 17 Sep 2012 13:22:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7VWzLCc5bZ-r; Mon, 17 Sep 2012 13:22:55 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 68D9E2A2817A;
        Mon, 17 Sep 2012 13:22:55 +0200 (CEST)
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Greg Ungerer <gerg@uclinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: Keep pci_fixup_irqs() around after init
Date:   Mon, 17 Sep 2012 13:22:53 +0200
Message-Id: <1347880974-13615-1-git-send-email-thierry.reding@avionic-design.de>
X-Mailer: git-send-email 1.7.12
X-Provags-ID: V02:K0:UNn0Y9Uxpibd86Z8HLmLW1v1HhxUZwWTQQydDy8lfMW
 RPzJEAlPkuH/B384PhRysvdLiElSbxmn3chQ6bs2amUuGMdMjG
 sho+YaOZXH5/F87wiJT5Om3fGGEWd5/Zrj5lM+98XEf1BZEHMs
 2gUZSZlSn1giVHfmSrjAzBODog/uS+PmQWTe++rqUwcEZgoc6c
 ngDyo0LlTCzHdkFjCPspIbadCUj3Y4udWy+I7k7L0LI30vwUBZ
 Ufb6mqb87nKvFYN70okAnoNwKw9ixkWV7AA4tLTakR7FjpnOCq
 uRypqZONIM4KYXgu4iacR1xBJuQhK6Fu8a9GxLWfMfE+nkHCqY
 AmqgtDhyGle3koRwVvdb2d8CgZ87oJbB4V9tkKHUECGhnY9wxR
 Q5qA/X5/g7QJqq/BaORdmmKVB0vzbddkNQTOgawD0sKo1mUudn
 2gfXz
X-archive-position: 34520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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

Remove the __init annotations in order to keep pci_fixup_irqs() around
after init (e.g. for hotplug). This requires the same change for the
implementation of pcibios_update_irq() on all architectures. While at
it, all __devinit annotations are removed as well, since they will be
useless now that HOTPLUG is always on.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v2:
- remove __init and __devinit annotations altogether

 arch/alpha/kernel/pci.c      | 2 +-
 arch/arm/kernel/bios32.c     | 2 +-
 arch/ia64/pci/pci.c          | 2 +-
 arch/mips/pci/pci.c          | 2 +-
 arch/sh/drivers/pci/pci.c    | 2 +-
 arch/sparc/kernel/leon_pci.c | 2 +-
 arch/tile/kernel/pci.c       | 2 +-
 arch/tile/kernel/pci_gx.c    | 2 +-
 arch/unicore32/kernel/pci.c  | 2 +-
 arch/x86/pci/visws.c         | 2 +-
 arch/xtensa/kernel/pci.c     | 2 +-
 drivers/pci/setup-irq.c      | 4 ++--
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 9816d5a..920392f 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -256,7 +256,7 @@ pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-void __init
+void
 pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 2b2f25e..0174fe6 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -272,7 +272,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8152, pci_fixup_it
 
 
 
-void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
+void pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	if (debug_pci)
 		printk("PCI: Assigning IRQ %02d to %s\n", irq, pci_name(dev));
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 81acc7a..27db6a8 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -461,7 +461,7 @@ void pcibios_set_master (struct pci_dev *dev)
 	/* No special bus mastering setup handling */
 }
 
-void __devinit
+void
 pcibios_update_irq (struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 6903568..64f0419 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -313,7 +313,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-void __init
+void
 pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 40db2d0..1bd3e08 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -192,7 +192,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
-void __init pcibios_update_irq(struct pci_dev *dev, int irq)
+void pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index 21dcda7..404621b 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -102,7 +102,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
-void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
+void pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 #ifdef CONFIG_PCI_DEBUG
 	printk(KERN_DEBUG "LEONPCI: Assigning IRQ %02d to %s\n", irq,
diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
index 33c1086..6245bba 100644
--- a/arch/tile/kernel/pci.c
+++ b/arch/tile/kernel/pci.c
@@ -406,7 +406,7 @@ void pcibios_set_master(struct pci_dev *dev)
 /*
  * This is called from the generic Linux layer.
  */
-void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
+void pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index 0e213e3..5faad0b 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -1036,7 +1036,7 @@ char __devinit *pcibios_setup(char *str)
 /*
  * This is called from the generic Linux layer.
  */
-void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
+void pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index 46cb6c9..c07ecc5 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -154,7 +154,7 @@ void __init puv3_pci_adjust_zones(unsigned long *zone_size,
 	zhole_size[0] = 0;
 }
 
-void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
+void pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	if (debug_pci)
 		printk(KERN_DEBUG "PCI: Assigning IRQ %02d to %s\n",
diff --git a/arch/x86/pci/visws.c b/arch/x86/pci/visws.c
index 6f2f8ee..9d736e7 100644
--- a/arch/x86/pci/visws.c
+++ b/arch/x86/pci/visws.c
@@ -62,7 +62,7 @@ out:
 	return irq;
 }
 
-void __init pcibios_update_irq(struct pci_dev *dev, int irq)
+void pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 69759e9..6f9b40c 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -212,7 +212,7 @@ void pcibios_set_master(struct pci_dev *dev)
 
 /* the next one is stolen from the alpha port... */
 
-void __init
+void
 pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index eb219a1..270ae7b 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -18,7 +18,7 @@
 #include <linux/cache.h>
 
 
-static void __init
+static void
 pdev_fixup_irq(struct pci_dev *dev,
 	       u8 (*swizzle)(struct pci_dev *, u8 *),
 	       int (*map_irq)(const struct pci_dev *, u8, u8))
@@ -54,7 +54,7 @@ pdev_fixup_irq(struct pci_dev *dev,
 	pcibios_update_irq(dev, irq);
 }
 
-void __init
+void
 pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
 	       int (*map_irq)(const struct pci_dev *, u8, u8))
 {
-- 
1.7.12
