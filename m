Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2012 22:45:15 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.187]:52360 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903398Ab2INUpE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2012 22:45:04 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
        id 0MEWGP-1TIyOz1EbJ-00Fhy5; Fri, 14 Sep 2012 22:44:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 065972A28302;
        Fri, 14 Sep 2012 22:44:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MvSH9u6EVoyS; Fri, 14 Sep 2012 22:44:17 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 2E0F92A28267;
        Fri, 14 Sep 2012 22:44:17 +0200 (CEST)
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
        Greg Ungerer <gerg@uclinux.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: Annotate pci_fixup_irqs with __devinit
Date:   Fri, 14 Sep 2012 22:44:15 +0200
Message-Id: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
X-Mailer: git-send-email 1.7.12
X-Provags-ID: V02:K0:Nom7qgQWtfUTmgDSmVNYlmmvP9AxgzwH/qrwOy7eCMz
 patGWO1MF3YdfI0U6+I20HshBj73o08NLfjOhLOZF6OYJkflk2
 42y+hd/25nIP+6K3/YROuzb5xFlOeXsUEVmlHdPpGyG7M7EIJu
 R5qG+Ri5cXdRiYMcLXqHRljqpottpzl4LL1dJWtYeGB6FJ0wsF
 UItkdTl0SPIMC6Pwq1C0a7OJKkXufei6XKpZc6hDfNsmBERfRy
 FaqxiCgx8ud7GlKEiPVMLCt0Gp3Ap9+M73Oa9Nmhv/X4W5PHJk
 /JcZTM7ywLVAwgRvy5cCM2h9n6HaOnWmR4rNTBEZYVJpurQy7j
 hL7szTDcDTp5JgX2CDK50J7R+kgG78RZEWWLS7n0mMJYl6EoAh
 1nkMHQRPdyfq79Q0NQ7GHuWCj/Ioel0Imsa9ZF/8cLlDtsTr+O
 CqWKh
X-archive-position: 34506
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

In order to keep pci_fixup_irqs() around after init (e.g. for hotplug),
mark it __devinit instead of __init. This requires the same change for
the implementation of the pcibios_update_irq() function on all
architectures.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Note: Ideally these annotations should go away completely in order to
be independent of the HOTPLUG symbol. However, there is work underway
to get rid of HOTPLUG altogether, so I've kept the __devinit for now.

 arch/alpha/kernel/pci.c   | 2 +-
 arch/mips/pci/pci.c       | 2 +-
 arch/sh/drivers/pci/pci.c | 2 +-
 arch/x86/pci/visws.c      | 2 +-
 arch/xtensa/kernel/pci.c  | 2 +-
 drivers/pci/setup-irq.c   | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 9816d5a..6192b35 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -256,7 +256,7 @@ pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-void __init
+void __devinit
 pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 6903568..af3dc05 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -313,7 +313,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-void __init
+void __devinit
 pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 40db2d0..d16fabe 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -192,7 +192,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
-void __init pcibios_update_irq(struct pci_dev *dev, int irq)
+void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
diff --git a/arch/x86/pci/visws.c b/arch/x86/pci/visws.c
index 6f2f8ee..15bdfbf 100644
--- a/arch/x86/pci/visws.c
+++ b/arch/x86/pci/visws.c
@@ -62,7 +62,7 @@ out:
 	return irq;
 }
 
-void __init pcibios_update_irq(struct pci_dev *dev, int irq)
+void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 69759e9..efc3369 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -212,7 +212,7 @@ void pcibios_set_master(struct pci_dev *dev)
 
 /* the next one is stolen from the alpha port... */
 
-void __init
+void __devinit
 pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index eb219a1..f0bcd56 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -18,7 +18,7 @@
 #include <linux/cache.h>
 
 
-static void __init
+static void __devinit
 pdev_fixup_irq(struct pci_dev *dev,
 	       u8 (*swizzle)(struct pci_dev *, u8 *),
 	       int (*map_irq)(const struct pci_dev *, u8, u8))
@@ -54,7 +54,7 @@ pdev_fixup_irq(struct pci_dev *dev,
 	pcibios_update_irq(dev, irq);
 }
 
-void __init
+void __devinit
 pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
 	       int (*map_irq)(const struct pci_dev *, u8, u8))
 {
-- 
1.7.12
