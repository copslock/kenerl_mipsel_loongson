Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jul 2015 14:10:27 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:57808 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011640AbbGTMKE0EpQy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jul 2015 14:10:04 +0200
Received: from 172.24.1.49 (EHLO szxeml432-hub.china.huawei.com) ([172.24.1.49])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id COZ21641;
        Mon, 20 Jul 2015 20:05:28 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml432-hub.china.huawei.com (10.82.67.209) with Microsoft SMTP Server id
 14.3.158.1; Mon, 20 Jul 2015 20:05:14 +0800
From:   Yijing Wang <wangyijing@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>, <dja@axtens.net>,
        <linux-xtensa@linux-xtensa.org>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        <linux-alpha@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-am33-list@redhat.com>, Liviu Dudau <liviu@dudau.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH part3 v12 01/10] PCI: Save domain in pci_host_bridge
Date:   Mon, 20 Jul 2015 20:01:09 +0800
Message-ID: <1437393678-4077-2-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1437393678-4077-1-git-send-email-wangyijing@huawei.com>
References: <1437393678-4077-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48359
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

Save domain in pci_host_bridge, so we could get domain
from pci_host_bridge, and at the end of series, we could
clean up the arch specific pci_domain_nr(). For arm/arm64,
the domain argument is pointless, because they enable
CONFIG_PCI_DOMAINS_GENERIC, PCI core would assign domain
number for them, so introduce pci_create_root_bus_generic
and pci_scan_root_bus_generic() which simply assign domain
number to -1.

Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com> #mvebu part
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/alpha/kernel/pci.c            |    4 ++--
 arch/alpha/kernel/sys_nautilus.c   |    2 +-
 arch/arm/kernel/bios32.c           |    2 +-
 arch/arm/mach-dove/pcie.c          |    2 +-
 arch/arm/mach-iop13xx/pci.c        |    4 ++--
 arch/arm/mach-mv78xx0/pcie.c       |    2 +-
 arch/arm/mach-orion5x/pci.c        |    4 ++--
 arch/frv/mb93090-mb00/pci-vdk.c    |    3 ++-
 arch/ia64/pci/pci.c                |    4 ++--
 arch/ia64/sn/kernel/io_init.c      |    4 ++--
 arch/m68k/coldfire/pci.c           |    2 +-
 arch/microblaze/pci/pci-common.c   |    4 ++--
 arch/mips/pci/pci.c                |    4 ++--
 arch/mn10300/unit-asb2305/pci.c    |    3 ++-
 arch/powerpc/kernel/pci-common.c   |    4 ++--
 arch/s390/pci/pci.c                |    4 ++--
 arch/sh/drivers/pci/pci.c          |    4 ++--
 arch/sparc/kernel/leon_pci.c       |    2 +-
 arch/sparc/kernel/pci.c            |    4 ++--
 arch/sparc/kernel/pcic.c           |    2 +-
 arch/tile/kernel/pci.c             |    4 ++--
 arch/tile/kernel/pci_gx.c          |    4 ++--
 arch/unicore32/kernel/pci.c        |    2 +-
 arch/x86/pci/acpi.c                |    4 ++--
 arch/x86/pci/common.c              |    2 +-
 arch/xtensa/kernel/pci.c           |    2 +-
 drivers/parisc/dino.c              |    2 +-
 drivers/parisc/lba_pci.c           |    2 +-
 drivers/pci/host/pci-versatile.c   |    3 ++-
 drivers/pci/host/pci-xgene.c       |    2 +-
 drivers/pci/host/pcie-designware.c |    2 +-
 drivers/pci/host/pcie-iproc.c      |    2 +-
 drivers/pci/host/pcie-xilinx.c     |    2 +-
 drivers/pci/hotplug/ibmphp_core.c  |    2 +-
 drivers/pci/probe.c                |   21 +++++++++++++--------
 drivers/pci/xen-pcifront.c         |    2 +-
 include/linux/pci.h                |   20 +++++++++++++++++---
 37 files changed, 82 insertions(+), 60 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 82f738e..2b0bce9 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -336,8 +336,8 @@ common_init_pci(void)
 		pci_add_resource_offset(&resources, hose->mem_space,
 					hose->mem_space->start);
 
-		bus = pci_scan_root_bus(NULL, next_busno, alpha_mv.pci_ops,
-					hose, &resources);
+		bus = pci_scan_root_bus(NULL, hose->index, next_busno,
+				alpha_mv.pci_ops, hose, &resources);
 		if (!bus)
 			continue;
 		hose->bus = bus;
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 2cfaa0e..5d4f56f 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -205,7 +205,7 @@ nautilus_init_pci(void)
 	unsigned long memtop = max_low_pfn << PAGE_SHIFT;
 
 	/* Scan our single hose.  */
-	bus = pci_scan_bus(0, alpha_mv.pci_ops, hose);
+	bus = pci_scan_bus(hose->index, 0, alpha_mv.pci_ops, hose);
 	if (!bus)
 		return;
 
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index fcbbbb1..c7919c5 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -486,7 +486,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 			if (hw->scan)
 				sys->bus = hw->scan(nr, sys);
 			else
-				sys->bus = pci_scan_root_bus(parent, sys->busnr,
+				sys->bus = pci_scan_root_bus_generic(parent, sys->busnr,
 						hw->ops, sys, &sys->resources);
 
 			if (!sys->bus)
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 91fe971..2bbdd3f 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -160,7 +160,7 @@ dove_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 		return NULL;
 	}
 
-	return pci_scan_root_bus(NULL, sys->busnr, &pcie_ops, sys,
+	return pci_scan_root_bus_generic(NULL, sys->busnr, &pcie_ops, sys,
 				 &sys->resources);
 }
 
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 9082b84..0b60464 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -535,12 +535,12 @@ struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *sys)
 			while(time_before(jiffies, atux_trhfa_timeout))
 				udelay(100);
 
-		bus = pci_bus_atux = pci_scan_root_bus(NULL, sys->busnr,
+		bus = pci_bus_atux = pci_scan_root_bus_generic(NULL, sys->busnr,
 						       &iop13xx_atux_ops,
 						       sys, &sys->resources);
 		break;
 	case IOP13XX_INIT_ATU_ATUE:
-		bus = pci_bus_atue = pci_scan_root_bus(NULL, sys->busnr,
+		bus = pci_bus_atue = pci_scan_root_bus_generic(NULL, sys->busnr,
 						       &iop13xx_atue_ops,
 						       sys, &sys->resources);
 		break;
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 097ea4c..d4d8718 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -202,7 +202,7 @@ mv78xx0_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 		return NULL;
 	}
 
-	return pci_scan_root_bus(NULL, sys->busnr, &pcie_ops, sys,
+	return pci_scan_root_bus_generic(NULL, sys->busnr, &pcie_ops, sys,
 				 &sys->resources);
 }
 
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index b02f394..c414059 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -558,11 +558,11 @@ int __init orion5x_pci_sys_setup(int nr, struct pci_sys_data *sys)
 struct pci_bus __init *orion5x_pci_sys_scan_bus(int nr, struct pci_sys_data *sys)
 {
 	if (nr == 0)
-		return pci_scan_root_bus(NULL, sys->busnr, &pcie_ops, sys,
+		return pci_scan_root_bus_generic(NULL, sys->busnr, &pcie_ops, sys,
 					 &sys->resources);
 
 	if (nr == 1 && !orion5x_pci_disabled)
-		return pci_scan_root_bus(NULL, sys->busnr, &pci_ops, sys,
+		return pci_scan_root_bus_generic(NULL, sys->busnr, &pci_ops, sys,
 					 &sys->resources);
 
 	BUG();
diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index f211839..719fb75 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -384,7 +384,8 @@ int __init pcibios_init(void)
 	printk("PCI: Probing PCI hardware\n");
 	pci_add_resource(&resources, &pci_ioport_resource);
 	pci_add_resource(&resources, &pci_iomem_resource);
-	bus = pci_scan_root_bus(NULL, 0, pci_root_ops, NULL, &resources);
+	bus = pci_scan_root_bus(NULL, 0, 0, pci_root_ops, NULL,
+			&resources);
 
 	pcibios_irq_init();
 	pcibios_fixup_irqs();
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 7cc3be9..67ffe1f 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -462,8 +462,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	 * should handle the case here, but it appears that IA64 hasn't
 	 * such quirk. So we just ignore the case now.
 	 */
-	pbus = pci_create_root_bus(NULL, bus, &pci_root_ops, controller,
-				   &info->resources);
+	pbus = pci_create_root_bus(NULL, domain, bus, &pci_root_ops,
+			controller, &info->resources);
 	if (!pbus) {
 		pci_free_resource_list(&info->resources);
 		__release_pci_root_info(info);
diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
index 1be65eb..d528814 100644
--- a/arch/ia64/sn/kernel/io_init.c
+++ b/arch/ia64/sn/kernel/io_init.c
@@ -266,8 +266,8 @@ sn_pci_controller_fixup(int segment, int busnum, struct pci_bus *bus)
 	pci_add_resource_offset(&resources,	&res[1],
 			prom_bussoft_ptr->bs_legacy_mem);
 
-	bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, controller,
-				&resources);
+	bus = pci_scan_root_bus(NULL, controller->segment, busnum,
+			&pci_root_ops, controller, &resources);
  	if (bus == NULL) {
 		kfree(res);
 		kfree(controller);
diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
index 821de92..63c0c2f 100644
--- a/arch/m68k/coldfire/pci.c
+++ b/arch/m68k/coldfire/pci.c
@@ -312,7 +312,7 @@ static int __init mcf_pci_init(void)
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(msecs_to_jiffies(200));
 
-	rootbus = pci_scan_bus(0, &mcf_pci_ops, NULL);
+	rootbus = pci_scan_bus(0, 0, &mcf_pci_ops, NULL);
 	if (!rootbus)
 		return -ENODEV;
 
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index ae838ed..d232c8a 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1350,8 +1350,8 @@ static void pcibios_scan_phb(struct pci_controller *hose)
 
 	pcibios_setup_phb_resources(hose, &resources);
 
-	bus = pci_scan_root_bus(hose->parent, hose->first_busno,
-				hose->ops, hose, &resources);
+	bus = pci_scan_root_bus(hose->parent, hose->global_number,
+			hose->first_busno, hose->ops, hose, &resources);
 	if (bus == NULL) {
 		pr_err("Failed to create bus for PCI domain %04x\n",
 		       hose->global_number);
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index b8a0bf5..aead9d6 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -95,8 +95,8 @@ static void pcibios_scanbus(struct pci_controller *hose)
 				hose->io_resource, hose->io_offset);
 	pci_add_resource_offset(&resources,
 				hose->busn_resource, hose->busn_offset);
-	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
-				&resources);
+	bus = pci_scan_root_bus(NULL, hose->index, next_busno,
+				hose->pci_ops, hose, &resources);
 	hose->bus = bus;
 
 	need_domain_info = need_domain_info || hose->index;
diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index 3dfe2d3..a298172 100644
--- a/arch/mn10300/unit-asb2305/pci.c
+++ b/arch/mn10300/unit-asb2305/pci.c
@@ -372,7 +372,8 @@ static int __init pcibios_init(void)
 
 	pci_add_resource_offset(&resources, &pci_ioport_resource, io_offset);
 	pci_add_resource_offset(&resources, &pci_iomem_resource, mem_offset);
-	bus = pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL, &resources);
+	bus = pci_scan_root_bus(NULL, 0, 0, &pci_direct_ampci,
+			NULL, &resources);
 	if (!bus)
 		return 0;
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index b9de34d..df7f018 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1653,8 +1653,8 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	pci_add_resource(&resources, &hose->busn);
 
 	/* Create an empty bus for the toplevel */
-	bus = pci_create_root_bus(hose->parent, hose->first_busno,
-				  hose->ops, hose, &resources);
+	bus = pci_create_root_bus(hose->parent, hose->global_number,
+			hose->first_busno, hose->ops, hose, &resources);
 	if (bus == NULL) {
 		pr_err("Failed to create bus for PCI domain %04x\n",
 			hose->global_number);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 598f023..b9ac2f5 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -779,8 +779,8 @@ static int zpci_scan_bus(struct zpci_dev *zdev)
 	if (ret)
 		return ret;
 
-	zdev->bus = pci_scan_root_bus(NULL, ZPCI_BUS_NR, &pci_root_ops,
-				      zdev, &resources);
+	zdev->bus = pci_scan_root_bus(NULL, zdev->domain, ZPCI_BUS_NR,
+			&pci_root_ops, zdev, &resources);
 	if (!zdev->bus) {
 		zpci_cleanup_bus_resources(zdev);
 		return -EIO;
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index d5462b7..293249a 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -52,8 +52,8 @@ static void pcibios_scanbus(struct pci_channel *hose)
 		pci_add_resource_offset(&resources, res, offset);
 	}
 
-	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
-				&resources);
+	bus = pci_scan_root_bus(NULL, hose->index, next_busno,
+			hose->pci_ops, hose, &resources);
 	hose->bus = bus;
 
 	need_domain_info = need_domain_info || hose->index;
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index 4371f72..36d702d 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -32,7 +32,7 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 	info->busn.flags = IORESOURCE_BUS;
 	pci_add_resource(&resources, &info->busn);
 
-	root_bus = pci_scan_root_bus(&ofdev->dev, 0, info->ops, info,
+	root_bus = pci_scan_root_bus(&ofdev->dev, 0, 0, info->ops, info,
 				     &resources);
 	if (!root_bus) {
 		pci_free_resource_list(&resources);
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index c928bc6..1e957de 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -664,8 +664,8 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	pbm->busn.end	= pbm->pci_last_busno;
 	pbm->busn.flags	= IORESOURCE_BUS;
 	pci_add_resource(&resources, &pbm->busn);
-	bus = pci_create_root_bus(parent, pbm->pci_first_busno, pbm->pci_ops,
-				  pbm, &resources);
+	bus = pci_create_root_bus(parent, pbm->index, pbm->pci_first_busno,
+			pbm->pci_ops, pbm, &resources);
 	if (!bus) {
 		printk(KERN_ERR "Failed to create bus for %s\n",
 		       node->full_name);
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 24384e1..7e86410 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -390,7 +390,7 @@ static void __init pcic_pbm_scan_bus(struct linux_pcic *pcic)
 {
 	struct linux_pbm_info *pbm = &pcic->pbm;
 
-	pbm->pci_bus = pci_scan_bus(pbm->pci_first_busno, &pcic_ops, pbm);
+	pbm->pci_bus = pci_scan_bus(0, pbm->pci_first_busno, &pcic_ops, pbm);
 	if (!pbm->pci_bus)
 		return;
 
diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
index 9475a74..6ae0871 100644
--- a/arch/tile/kernel/pci.c
+++ b/arch/tile/kernel/pci.c
@@ -306,8 +306,8 @@ int __init pcibios_init(void)
 
 			pci_add_resource(&resources, &ioport_resource);
 			pci_add_resource(&resources, &iomem_resource);
-			bus = pci_scan_root_bus(NULL, 0, controller->ops,
-						controller, &resources);
+			bus = pci_scan_root_bus(NULL, controller->index, 0,
+					controller->ops, controller, &resources);
 			controller->root_bus = bus;
 			controller->last_busno = bus->busn_res.end;
 		}
diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index b1df847..d47a698 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -881,8 +881,8 @@ int __init pcibios_init(void)
 					controller->mem_offset);
 		pci_add_resource(&resources, &controller->io_space);
 		controller->first_busno = next_busno;
-		bus = pci_scan_root_bus(NULL, next_busno, controller->ops,
-					controller, &resources);
+		bus = pci_scan_root_bus(NULL, controller->index, next_busno,
+				controller->ops, controller, &resources);
 		controller->root_bus = bus;
 		next_busno = bus->busn_res.end + 1;
 	}
diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index d45fa5f..ef9be16 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -258,7 +258,7 @@ static int __init pci_common_init(void)
 
 	pci_puv3_preinit();
 
-	puv3_bus = pci_scan_bus(0, &pci_puv3_ops, NULL);
+	puv3_bus = pci_scan_bus(0, 0, &pci_puv3_ops, NULL);
 
 	if (!puv3_bus)
 		panic("PCI: unable to scan bus!");
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index ff99117..629fc3b 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -463,8 +463,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 
 		if (!setup_mcfg_map(info, domain, (u8)root->secondary.start,
 				    (u8)root->secondary.end, root->mcfg_addr))
-			bus = pci_create_root_bus(NULL, busnum, &pci_root_ops,
-						  sd, &resources);
+			bus = pci_create_root_bus(NULL, domain, busnum,
+					&pci_root_ops, sd, &resources);
 
 		if (bus) {
 			pci_scan_child_bus(bus);
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 8fd6f44..d50ac9b 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -486,7 +486,7 @@ void pcibios_scan_root(int busnum)
 	sd->node = x86_pci_root_bus_node(busnum);
 	x86_pci_root_bus_resources(busnum, &resources);
 	printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
-	bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, sd, &resources);
+	bus = pci_scan_root_bus(NULL, 0, busnum, &pci_root_ops, sd, &resources);
 	if (!bus) {
 		pci_free_resource_list(&resources);
 		kfree(sd);
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index b848cc3..66da4c3 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -183,7 +183,7 @@ static int __init pcibios_init(void)
 		pci_ctrl->last_busno = 0xff;
 		INIT_LIST_HEAD(&resources);
 		pci_controller_apertures(pci_ctrl, &resources);
-		bus = pci_scan_root_bus(NULL, pci_ctrl->first_busno,
+		bus = pci_scan_root_bus(NULL, 0, pci_ctrl->first_busno,
 					pci_ctrl->ops, pci_ctrl, &resources);
 		if (!bus)
 			continue;
diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index a0580af..f375252 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -986,7 +986,7 @@ static int __init dino_probe(struct parisc_device *dev)
 	** with configuration accessor functions.
 	*/
 	dino_dev->hba.hba_bus = bus = pci_create_root_bus(&dev->dev,
-			 dino_current_bus, &dino_cfg_ops, NULL, &resources);
+			 0, dino_current_bus, &dino_cfg_ops, NULL, &resources);
 	if (!bus) {
 		printk(KERN_ERR "ERROR: failed to scan PCI bus on %s (duplicate bus number %d?)\n",
 		       dev_name(&dev->dev), dino_current_bus);
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index dceb9dd..2949030 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1563,7 +1563,7 @@ lba_driver_probe(struct parisc_device *dev)
 
 	dev->dev.platform_data = lba_dev;
 	lba_bus = lba_dev->hba.hba_bus =
-		pci_create_root_bus(&dev->dev, lba_dev->hba.bus_num.start,
+		pci_create_root_bus(&dev->dev, 0, lba_dev->hba.bus_num.start,
 				    cfg_ops, NULL, &resources);
 	if (!lba_bus) {
 		pci_free_resource_list(&resources);
diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 0863d9c..04388e2 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -208,7 +208,8 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
 	pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC);
 
-	bus = pci_scan_root_bus(&pdev->dev, 0, &pci_versatile_ops, &sys, &pci_res);
+	bus = pci_scan_root_bus_generic(&pdev->dev, 0, &pci_versatile_ops,
+			&sys, &pci_res);
 	if (!bus)
 		return -ENOMEM;
 
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index a9dfb70..e9436fe 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -553,7 +553,7 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	bus = pci_create_root_bus(&pdev->dev, 0,
+	bus = pci_create_root_bus_generic(&pdev->dev, 0,
 					&xgene_pcie_ops, port, &res);
 	if (!bus)
 		return -ENOMEM;
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be..28f1e67 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -708,7 +708,7 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	struct pcie_port *pp = sys_to_pcie(sys);
 
 	pp->root_bus_nr = sys->busnr;
-	bus = pci_scan_root_bus(pp->dev, sys->busnr,
+	bus = pci_scan_root_bus_generic(pp->dev, sys->busnr,
 				  &dw_pcie_ops, sys, &sys->resources);
 	if (!bus)
 		return NULL;
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index d77481e..5d0c77b 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -210,7 +210,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 
 	pcie->sysdata.private_data = pcie;
 
-	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
+	bus = pci_create_root_bus_generic(pcie->dev, 0, &iproc_pcie_ops,
 				  &pcie->sysdata, res);
 	if (!bus) {
 		dev_err(pcie->dev, "unable to create PCI root bus\n");
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index f1a06a0..81f89fb 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -647,7 +647,7 @@ static struct pci_bus *xilinx_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	struct pci_bus *bus;
 
 	port->root_busno = sys->busnr;
-	bus = pci_scan_root_bus(port->dev, sys->busnr, &xilinx_pcie_ops,
+	bus = pci_scan_root_bus_generic(port->dev, sys->busnr, &xilinx_pcie_ops,
 				sys, &sys->resources);
 
 	return bus;
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 1530247..db6240e 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -765,7 +765,7 @@ static u8 bus_structure_fixup(u8 busno)
 					(l != 0x0000) && (l != 0xffff)) {
 			debug("%s - Inside bus_structure_fixup()\n",
 							__func__);
-			b = pci_scan_bus(busno, ibmphp_pci_bus->ops, NULL);
+			b = pci_scan_bus(0, busno, ibmphp_pci_bus->ops, NULL);
 			if (!b)
 				continue;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636..b49deb8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1927,8 +1927,9 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
-struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+struct pci_bus *pci_create_root_bus(struct device *parent, int domain,
+		int bus, struct pci_ops *ops, void *sysdata,
+		struct list_head *resources)
 {
 	int error;
 	struct pci_host_bridge *bridge;
@@ -1958,6 +1959,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	if (!bridge)
 		goto err_out;
 
+	bridge->domain = domain;
 	bridge->dev.parent = parent;
 	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
@@ -2096,8 +2098,9 @@ void pci_bus_release_busn_res(struct pci_bus *b)
 			res, ret ? "can not be" : "is");
 }
 
-struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+struct pci_bus *pci_scan_root_bus(struct device *parent, int domain,
+		int bus, struct pci_ops *ops, void *sysdata,
+		struct list_head *resources)
 {
 	struct resource_entry *window;
 	bool found = false;
@@ -2110,7 +2113,8 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 			break;
 		}
 
-	b = pci_create_root_bus(parent, bus, ops, sysdata, resources);
+	b = pci_create_root_bus(parent, domain, bus, ops,
+			sysdata, resources);
 	if (!b)
 		return NULL;
 
@@ -2130,8 +2134,8 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
 
-struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
-					void *sysdata)
+struct pci_bus *pci_scan_bus(int domain, int bus,
+		struct pci_ops *ops, void *sysdata)
 {
 	LIST_HEAD(resources);
 	struct pci_bus *b;
@@ -2139,7 +2143,8 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
 	pci_add_resource(&resources, &ioport_resource);
 	pci_add_resource(&resources, &iomem_resource);
 	pci_add_resource(&resources, &busn_resource);
-	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
+	b = pci_create_root_bus(NULL, domain, bus, ops, sysdata,
+			&resources);
 	if (b) {
 		pci_scan_child_bus(b);
 	} else {
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 8b7a900..3452c42 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -481,7 +481,7 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 
 	pci_lock_rescan_remove();
 
-	b = pci_scan_root_bus(&pdev->xdev->dev, bus,
+	b = pci_scan_root_bus(&pdev->xdev->dev, sd->domain, bus,
 				  &pcifront_bus_ops, sd, &resources);
 	if (!b) {
 		dev_err(&pdev->xdev->dev,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a..50c0c47 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -402,6 +402,7 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 }
 
 struct pci_host_bridge {
+	int domain;
 	struct device dev;
 	struct pci_bus *bus;		/* root bus */
 	struct list_head windows;	/* resource_entry */
@@ -780,16 +781,29 @@ void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
-struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+struct pci_bus *pci_scan_bus(int domain, int bus, struct pci_ops *ops,
+					void *sysdata);
+struct pci_bus *pci_create_root_bus(struct device *parent, int domain, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
+static inline struct pci_bus *pci_create_root_bus_generic(
+		struct device *parent, int bus,	struct pci_ops *ops,
+		void *sysdata, struct list_head *resources)
+{
+	return pci_create_root_bus(parent, -1, bus, ops, sysdata, resources);
+}
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+struct pci_bus *pci_scan_root_bus(struct device *parent, int domain, int bus,
 					     struct pci_ops *ops, void *sysdata,
 					     struct list_head *resources);
+static inline struct pci_bus *pci_scan_root_bus_generic(
+		struct device *parent, int bus,	struct pci_ops *ops,
+		void *sysdata, struct list_head *resources)
+{
+	return pci_scan_root_bus(parent, -1, bus, ops, sysdata, resources);
+}
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
 void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
-- 
1.7.1
