Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 03:32:36 +0100 (CET)
Received: from szxga01-in.huawei.com ([119.145.14.64]:17799 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012000AbbAUCccxjqir (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 03:32:32 +0100
Received: from 172.24.2.119 (EHLO szxeml433-hub.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CIF99702;
        Wed, 21 Jan 2015 10:32:16 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml433-hub.china.huawei.com (10.82.67.210) with Microsoft SMTP Server id
 14.3.158.1; Wed, 21 Jan 2015 10:32:01 +0800
From:   Yijing Wang <wangyijing@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Jiang Liu <jiang.liu@linux.intel.com>, <linux-pci@vger.kernel.org>,
        Yinghai Lu <yinghai@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Guan Xuetao" <gxt@mprc.pku.edu.cn>, <linux-alpha@vger.kernel.org>,
        <linux-m68k@lists.linux-m68k.org>, Liviu Dudau <liviu@dudau.co.uk>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Yijing Wang" <wangyijing@huawei.com>,
        Richard Henderson <rth@twiddle.net>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Michal Simek <monstr@monstr.eu>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        "Chris Zankel" <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, <linux-mips@linux-mips.org>,
        <linux-am33-list@redhat.com>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-xtensa@linux-xtensa.org>
Subject: [PATCH v2 02/30] PCI: Rip out pci_bus_add_devices() from pci_scan_root_bus()
Date:   Wed, 21 Jan 2015 08:29:57 +0800
Message-ID: <1421800225-26230-3-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
References: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangyijing@huawei.com
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

Just like pci_scan_bus(), we also should rip out
pci_bus_add_devices() from pci_scan_root_bus().
Lots platforms first call pci_scan_root_bus(), but
after that, they call pci_bus_size_bridges() and
pci_bus_assign_resources(). Place pci_bus_add_devices()
in pci_scan_root_bus() hurts PCI scan logic.
For arm hw_pci->scan() functions which call
pci_scan_root_bus(), it's no need to change anything,
because pci_bus_add_devices() will be called later
in pci_common_init_dev().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Matt Turner <mattst88@gmail.com>
CC: David Howells <dhowells@redhat.com>
CC: Tony Luck <tony.luck@intel.com>
CC: Michal Simek <monstr@monstr.eu>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: Chris Metcalf <cmetcalf@ezchip.com>
CC: Chris Zankel <chris@zankel.net>
CC: Max Filippov <jcmvbkbc@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: linux-alpha@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-mips@linux-mips.org
CC: linux-am33-list@redhat.com
CC: linux-s390@vger.kernel.org
CC: linux-sh@vger.kernel.org
CC: sparclinux@vger.kernel.org
CC: linux-xtensa@linux-xtensa.org
---
 arch/alpha/kernel/pci.c          |    2 ++
 arch/frv/mb93090-mb00/pci-vdk.c  |    6 ++++--
 arch/ia64/sn/kernel/io_init.c    |    1 +
 arch/microblaze/pci/pci-common.c |    1 +
 arch/mips/pci/pci.c              |    1 +
 arch/mn10300/unit-asb2305/pci.c  |    5 ++++-
 arch/s390/pci/pci.c              |    2 +-
 arch/sh/drivers/pci/pci.c        |    1 +
 arch/sparc/kernel/leon_pci.c     |    1 +
 arch/tile/kernel/pci.c           |    2 ++
 arch/tile/kernel/pci_gx.c        |    2 ++
 arch/x86/pci/common.c            |    1 +
 arch/xtensa/kernel/pci.c         |    2 ++
 drivers/pci/probe.c              |    1 -
 14 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 076c35c..97f9730 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -334,6 +334,8 @@ common_init_pci(void)
 
 		bus = pci_scan_root_bus(NULL, next_busno, alpha_mv.pci_ops,
 					hose, &resources);
+		if (bus)
+			pci_bus_add_devices(bus);
 		hose->bus = bus;
 		hose->need_domain_info = need_domain_info;
 		next_busno = bus->busn_res.end + 1;
diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index efa5d65..2b36044 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -316,6 +316,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 
 int __init pcibios_init(void)
 {
+	struct pci_bus *bus;
 	struct pci_ops *dir = NULL;
 	LIST_HEAD(resources);
 
@@ -383,12 +384,13 @@ int __init pcibios_init(void)
 	printk("PCI: Probing PCI hardware\n");
 	pci_add_resource(&resources, &pci_ioport_resource);
 	pci_add_resource(&resources, &pci_iomem_resource);
-	pci_scan_root_bus(NULL, 0, pci_root_ops, NULL, &resources);
+	bus = pci_scan_root_bus(NULL, 0, pci_root_ops, NULL, &resources);
 
 	pcibios_irq_init();
 	pcibios_fixup_irqs();
 	pcibios_resource_survey();
-
+	if (bus)
+		pci_bus_add_devices(bus);
 	return 0;
 }
 
diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
index 0b5ce82..63b43a6 100644
--- a/arch/ia64/sn/kernel/io_init.c
+++ b/arch/ia64/sn/kernel/io_init.c
@@ -272,6 +272,7 @@ sn_pci_controller_fixup(int segment, int busnum, struct pci_bus *bus)
 		kfree(res);
 		kfree(controller);
 	}
+	pci_bus_add_devices(bus);
 }
 
 /*
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index b30e41c..009b271 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1351,6 +1351,7 @@ static void pcibios_scan_phb(struct pci_controller *hose)
 	hose->bus = bus;
 
 	hose->last_busno = bus->busn_res.end;
+	pci_bus_add_devices(bus);
 }
 
 static int __init pcibios_init(void)
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 1bf60b1..9eb54b5 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -114,6 +114,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
 			pci_bus_size_bridges(bus);
 			pci_bus_assign_resources(bus);
 		}
+		pci_bus_add_devices(bus);
 	}
 }
 
diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index 6b4339f..860aa35 100644
--- a/arch/mn10300/unit-asb2305/pci.c
+++ b/arch/mn10300/unit-asb2305/pci.c
@@ -345,6 +345,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
  */
 static int __init pcibios_init(void)
 {
+	struct pci_bus *bus;
 	resource_size_t io_offset, mem_offset;
 	LIST_HEAD(resources);
 
@@ -376,11 +377,13 @@ static int __init pcibios_init(void)
 
 	pci_add_resource_offset(&resources, &pci_ioport_resource, io_offset);
 	pci_add_resource_offset(&resources, &pci_iomem_resource, mem_offset);
-	pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL, &resources);
+	bus = pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL, &resources);
 
 	pcibios_irq_init();
 	pcibios_fixup_irqs();
 	pcibios_resource_survey();
+	if (bus)
+		pci_bus_add_devices(bus);
 	return 0;
 }
 
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 3290f11..0b32769 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -756,7 +756,7 @@ static int zpci_scan_bus(struct zpci_dev *zdev)
 		zpci_cleanup_bus_resources(zdev);
 		return -EIO;
 	}
-
+	pci_bus_add_devices(zdev->bus);
 	zdev->bus->max_bus_speed = zdev->max_bus_speed;
 	return 0;
 }
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 1bc09ee..efc1051 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -69,6 +69,7 @@ static void pcibios_scanbus(struct pci_channel *hose)
 
 		pci_bus_size_bridges(bus);
 		pci_bus_assign_resources(bus);
+		pci_bus_add_devices(bus);
 	} else {
 		pci_free_resource_list(&resources);
 	}
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index 899b720..2971076 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -40,6 +40,7 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 
 		/* Assign devices with resources */
 		pci_assign_unassigned_resources();
+		pci_bus_add_devices(root_bus);
 	} else {
 		pci_free_resource_list(&resources);
 	}
diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
index f70c789..83d3e30 100644
--- a/arch/tile/kernel/pci.c
+++ b/arch/tile/kernel/pci.c
@@ -339,6 +339,8 @@ int __init pcibios_init(void)
 			struct pci_bus *next_bus;
 			struct pci_dev *dev;
 
+			pci_bus_add_devices(root_bus);
+
 			list_for_each_entry(dev, &root_bus->devices, bus_list) {
 				/*
 				 * Find the PCI host controller, ie. the 1st
diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index 2c95f37..d7a0729 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -916,6 +916,8 @@ int __init pcibios_init(void)
 		/* Configure the max_payload_size values for this domain. */
 		fixup_read_and_payload_sizes(controller);
 
+		pci_bus_add_devices(root_bus);
+
 		/* Alloc a PIO region for PCI memory access for each RC port. */
 		ret = gxio_trio_alloc_pio_regions(trio_context, 1, 0, 0);
 		if (ret < 0) {
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 7b20bcc..300d39e 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -475,6 +475,7 @@ void pcibios_scan_root(int busnum)
 		pci_free_resource_list(&resources);
 		kfree(sd);
 	}
+	pci_bus_add_devices(bus);
 }
 
 void __init pcibios_set_cache_line_size(void)
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 5b34033..f2ae64e 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -185,6 +185,8 @@ static int __init pcibios_init(void)
 		pci_controller_apertures(pci_ctrl, &resources);
 		bus = pci_scan_root_bus(NULL, pci_ctrl->first_busno,
 					pci_ctrl->ops, pci_ctrl, &resources);
+		if (bus)
+			pci_bus_add_devices(bus);
 		pci_ctrl->bus = bus;
 		pci_ctrl->last_busno = bus->busn_res.end;
 		if (next_busno <= pci_ctrl->last_busno)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 053c0f4..7cf577f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2087,7 +2087,6 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 	if (!found)
 		pci_bus_update_busn_res_end(b, max);
 
-	pci_bus_add_devices(b);
 	return b;
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
-- 
1.7.1
