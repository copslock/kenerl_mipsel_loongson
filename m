Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 15:08:19 +0000 (GMT)
Received: from ozlabs.org ([203.10.76.45]:60038 "EHLO ozlabs.org")
	by ftp.linux-mips.org with ESMTP id S20021391AbXCFPIP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2007 15:08:15 +0000
Received: by ozlabs.org (Postfix, from userid 1034)
	id 68D97DDF36; Wed,  7 Mar 2007 02:07:25 +1100 (EST)
To:	Greg Kroah-Hartman <greg@kroah.com>
CC:	linux-pci@atrey.karlin.mff.cuni.cz, <linuxppc-dev@ozlabs.org>,
	<dev-etrax@axis.com>, <ink@jurassic.park.msu.ru>,
	<rth@twiddle.net>, <kernel@wantstofly.org>,
	<linux-ia64@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
	<gerg@uclinux.org>, <linux-mips@linux-mips.org>,
	<parisc-linux@parisc-linux.org>, <sparclinux@vger.kernel.org>,
	<uclinux-v850@lsi.nec.co.jp>, <discuss@x86-64.org>,
	<chris@zankel.net>, <dhowells@redhat.com>
From:	Michael Ellerman <michael@ellerman.id.au>
Date:	Tue, 06 Mar 2007 16:06:49 +0100
Subject: [PATCH 2/2] Make pcibios_add_platform_entries() return errors
In-Reply-To: <1173193568.89821.610708199943.qpush@concordia>
Message-Id: <20070306150725.68D97DDF36@ozlabs.org>
Return-Path: <michael@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@ellerman.id.au
Precedence: bulk
X-list: linux-mips

Currently pcibios_add_platform_entries() returns void, but could fail,
so instead have it return an int and propagate errors up to
pci_create_sysfs_dev_files().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/pci_32.c |    4 ++--
 arch/powerpc/kernel/pci_64.c |    4 ++--
 drivers/pci/pci-sysfs.c      |    9 ++++++---
 include/linux/pci.h          |    2 +-
 4 files changed, 11 insertions(+), 8 deletions(-)

Index: msi-new/arch/powerpc/kernel/pci_32.c
===================================================================
--- msi-new.orig/arch/powerpc/kernel/pci_32.c
+++ msi-new/arch/powerpc/kernel/pci_32.c
@@ -1037,10 +1037,10 @@ void pcibios_make_OF_bus_map(void)
 #endif /* CONFIG_PPC_OF */
 
 /* Add sysfs properties */
-void pcibios_add_platform_entries(struct pci_dev *pdev)
+int pcibios_add_platform_entries(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PPC_OF
-	device_create_file(&pdev->dev, &dev_attr_devspec);
+	return device_create_file(&pdev->dev, &dev_attr_devspec);
 #endif /* CONFIG_PPC_OF */
 }
 
Index: msi-new/arch/powerpc/kernel/pci_64.c
===================================================================
--- msi-new.orig/arch/powerpc/kernel/pci_64.c
+++ msi-new/arch/powerpc/kernel/pci_64.c
@@ -863,9 +863,9 @@ static ssize_t pci_show_devspec(struct d
 }
 static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
 
-void pcibios_add_platform_entries(struct pci_dev *pdev)
+int pcibios_add_platform_entries(struct pci_dev *pdev)
 {
-	device_create_file(&pdev->dev, &dev_attr_devspec);
+	return device_create_file(&pdev->dev, &dev_attr_devspec);
 }
 
 #define ISA_SPACE_MASK 0x1
Index: msi-new/drivers/pci/pci-sysfs.c
===================================================================
--- msi-new.orig/drivers/pci/pci-sysfs.c
+++ msi-new/drivers/pci/pci-sysfs.c
@@ -600,9 +600,9 @@ static struct bin_attribute pcie_config_
 	.write = pci_write_config,
 };
 
-void __attribute__ ((weak)) pcibios_add_platform_entries(struct pci_dev *dev)
+int __attribute__ ((weak)) pcibios_add_platform_entries(struct pci_dev *dev)
 {
-	return;
+	return 0;
 }
 
 int __must_check pci_create_sysfs_dev_files (struct pci_dev *pdev)
@@ -644,10 +644,13 @@ int __must_check pci_create_sysfs_dev_fi
 		}
 	}
 	/* add platform-specific attributes */
-	pcibios_add_platform_entries(pdev);
+	if (pcibios_add_platform_entries(pdev))
+		goto err_rom_attr;
 
 	return 0;
 
+err_rom_attr:
+	sysfs_remove_bin_file(&pdev->dev.kobj, rom_attr);
 err_rom:
 	kfree(rom_attr);
 err_bin_file:
Index: msi-new/include/linux/pci.h
===================================================================
--- msi-new.orig/include/linux/pci.h
+++ msi-new/include/linux/pci.h
@@ -857,7 +857,7 @@ extern int pci_pci_problems;
 extern unsigned long pci_cardbus_io_size;
 extern unsigned long pci_cardbus_mem_size;
 
-extern void pcibios_add_platform_entries(struct pci_dev *dev);
+extern int pcibios_add_platform_entries(struct pci_dev *dev);
 
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
