Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 09:16:08 +0100 (CET)
Received: from szxga03-in.huawei.com ([119.145.14.66]:34663 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007404AbbBZIQEFAouB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 09:16:04 +0100
Received: from 172.24.2.119 (EHLO szxeml433-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id BCI60988;
        Thu, 26 Feb 2015 16:15:32 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml433-hub.china.huawei.com (10.82.67.210) with Microsoft SMTP Server id
 14.3.158.1; Thu, 26 Feb 2015 16:15:04 +0800
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
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <linux-mips@linux-mips.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <xen-devel@lists.xenproject.org>
Subject: [PATCH v4 07/30] PCI: Pass PCI domain number combined with root bus number
Date:   Thu, 26 Feb 2015 16:12:01 +0800
Message-ID: <1424938344-4017-8-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020202.54EED626.0076,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: 57b76344ae5d30330744eb44f031a490
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45987
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

Now we could pass PCI domain combined with bus number
in u32 argu. Because in arm/arm64, PCI domain number
is assigned by pci_bus_assign_domain_nr(). So we leave
pci_scan_root_bus() and pci_create_root_bus() in arm/arm64
unchanged. A new function pci_host_assign_domain_nr()
will be introduced for arm/arm64 to assign domain number
in later patch.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Matt Turner <mattst88@gmail.com>
CC: Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>
CC: Michal Simek <monstr@monstr.eu>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>
CC: Gerald Schaefer <gerald.schaefer@de.ibm.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: Chris Metcalf <cmetcalf@ezchip.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: linux-alpha@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-ia64@vger.kernel.org
CC: linux-mips@linux-mips.org
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-s390@vger.kernel.org
CC: linux-sh@vger.kernel.org
CC: sparclinux@vger.kernel.org
CC: xen-devel@lists.xenproject.org
---
 arch/alpha/kernel/pci.c          |    5 +++--
 arch/alpha/kernel/sys_nautilus.c |    3 ++-
 arch/ia64/pci/pci.c              |    4 ++--
 arch/ia64/sn/kernel/io_init.c    |    5 +++--
 arch/microblaze/pci/pci-common.c |    5 +++--
 arch/mips/pci/pci.c              |    4 ++--
 arch/powerpc/kernel/pci-common.c |    5 +++--
 arch/s390/pci/pci.c              |    5 +++--
 arch/sh/drivers/pci/pci.c        |    5 +++--
 arch/sparc/kernel/pci.c          |    5 +++--
 arch/tile/kernel/pci.c           |    4 ++--
 arch/tile/kernel/pci_gx.c        |    5 +++--
 arch/x86/pci/acpi.c              |    6 +++---
 arch/x86/pci/common.c            |    3 ++-
 drivers/pci/xen-pcifront.c       |    5 +++--
 15 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 518b767..b053888 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -336,8 +336,9 @@ common_init_pci(void)
 		pci_add_resource_offset(&resources, hose->mem_space,
 					hose->mem_space->start);
 
-		bus = pci_scan_root_bus(NULL, next_busno, alpha_mv.pci_ops,
-					hose, &resources);
+		bus = pci_scan_root_bus(NULL, 
+				PCI_DOMBUS(hose->index, next_busno), alpha_mv.pci_ops,
+				hose, &resources);
 		if (bus)
 			pci_bus_add_devices(bus);
 		hose->bus = bus;
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 2c864bb..f7bfdf3 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -206,7 +206,8 @@ nautilus_init_pci(void)
 	unsigned long memtop = max_low_pfn << PAGE_SHIFT;
 
 	/* Scan our single hose.  */
-	bus = pci_scan_bus_legacy(0, alpha_mv.pci_ops, hose);
+	bus = pci_scan_bus_legacy(PCI_DOMBUS(hose->index, 0), 
+			alpha_mv.pci_ops, hose);
 	hose->bus = bus;
 	pcibios_claim_one_bus(bus);
 
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 48cc657..e4cda61 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -465,8 +465,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	 * should handle the case here, but it appears that IA64 hasn't
 	 * such quirk. So we just ignore the case now.
 	 */
-	pbus = pci_create_root_bus(NULL, bus, &pci_root_ops, controller,
-				   &info->resources);
+	pbus = pci_create_root_bus(NULL, PCI_DOMBUS(domain, bus), 
+			&pci_root_ops, controller, &info->resources);
 	if (!pbus) {
 		pci_free_resource_list(&info->resources);
 		__release_pci_root_info(info);
diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
index 63b43a6..bcdc5b8 100644
--- a/arch/ia64/sn/kernel/io_init.c
+++ b/arch/ia64/sn/kernel/io_init.c
@@ -266,8 +266,9 @@ sn_pci_controller_fixup(int segment, int busnum, struct pci_bus *bus)
 	pci_add_resource_offset(&resources,	&res[1],
 			prom_bussoft_ptr->bs_legacy_mem);
 
-	bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, controller,
-				&resources);
+	bus = pci_scan_root_bus(NULL, 
+			PCI_DOMBUS(controller->segment, busnum), 
+			&pci_root_ops, controller, &resources);
  	if (bus == NULL) {
 		kfree(res);
 		kfree(controller);
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index d8bbad9..5c332c0 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1350,8 +1350,9 @@ static void pcibios_scan_phb(struct pci_controller *hose)
 
 	pcibios_setup_phb_resources(hose, &resources);
 
-	bus = pci_scan_root_bus(hose->parent, hose->first_busno,
-				hose->ops, hose, &resources);
+	bus = pci_scan_root_bus(hose->parent, 
+			PCI_DOMBUS(hose->global_number, hose->first_busno),
+			hose->ops, hose, &resources);
 	if (bus == NULL) {
 		pr_err("Failed to create bus for PCI domain %04x\n",
 		       hose->global_number);
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 9eb54b5..980755a 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -92,8 +92,8 @@ static void pcibios_scanbus(struct pci_controller *hose)
 	pci_add_resource_offset(&resources,
 				hose->mem_resource, hose->mem_offset);
 	pci_add_resource_offset(&resources, hose->io_resource, hose->io_offset);
-	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
-				&resources);
+	bus = pci_scan_root_bus(NULL, PCI_DOMBUS(hose->index, next_busno), 
+			hose->pci_ops, hose, &resources);
 	if (!bus)
 		pci_free_resource_list(&resources);
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 2a525c9..78cd41b 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1612,8 +1612,9 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	pci_add_resource(&resources, &hose->busn);
 
 	/* Create an empty bus for the toplevel */
-	bus = pci_create_root_bus(hose->parent, hose->first_busno,
-				  hose->ops, hose, &resources);
+	bus = pci_create_root_bus(hose->parent, 
+			PCI_DOMBUS(hose->global_number, hose->first_busno),
+			hose->ops, hose, &resources);
 	if (bus == NULL) {
 		pr_err("Failed to create bus for PCI domain %04x\n",
 			hose->global_number);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 1534e5a..f9c6800 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -770,8 +770,9 @@ static int zpci_scan_bus(struct zpci_dev *zdev)
 	if (ret)
 		return ret;
 
-	zdev->bus = pci_scan_root_bus(NULL, ZPCI_BUS_NR, &pci_root_ops,
-				      zdev, &resources);
+	zdev->bus = pci_scan_root_bus(NULL, 
+			PCI_DOMBUS(zdev->domain, ZPCI_BUS_NR), &pci_root_ops,
+			zdev, &resources);
 	if (!zdev->bus) {
 		zpci_cleanup_bus_resources(zdev);
 		return -EIO;
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index efc1051..7ee0772 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -52,8 +52,9 @@ static void pcibios_scanbus(struct pci_channel *hose)
 		pci_add_resource_offset(&resources, res, offset);
 	}
 
-	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
-				&resources);
+	bus = pci_scan_root_bus(NULL, 
+			PCI_DOMBUS(hose->index, next_busno), 
+			hose->pci_ops, hose, &resources);
 	hose->bus = bus;
 
 	need_domain_info = need_domain_info || hose->index;
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 9ce5afe..0af7c58 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -667,8 +667,9 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	pbm->busn.end	= pbm->pci_last_busno;
 	pbm->busn.flags	= IORESOURCE_BUS;
 	pci_add_resource(&resources, &pbm->busn);
-	bus = pci_create_root_bus(parent, pbm->pci_first_busno, pbm->pci_ops,
-				  pbm, &resources);
+	bus = pci_create_root_bus(parent, 
+			PCI_DOMBUS(pbm->index, pbm->pci_first_busno), 
+			pbm->pci_ops, pbm, &resources);
 	if (!bus) {
 		printk(KERN_ERR "Failed to create bus for %s\n",
 		       node->full_name);
diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
index 9475a74..2111d71 100644
--- a/arch/tile/kernel/pci.c
+++ b/arch/tile/kernel/pci.c
@@ -306,8 +306,8 @@ int __init pcibios_init(void)
 
 			pci_add_resource(&resources, &ioport_resource);
 			pci_add_resource(&resources, &iomem_resource);
-			bus = pci_scan_root_bus(NULL, 0, controller->ops,
-						controller, &resources);
+			bus = pci_scan_root_bus(NULL, PCI_DOMBUS(controller->index, 0), 
+					controller->ops, controller, &resources);
 			controller->root_bus = bus;
 			controller->last_busno = bus->busn_res.end;
 		}
diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index d7a0729..1e6ff84 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -881,8 +881,9 @@ int __init pcibios_init(void)
 					controller->mem_offset);
 		pci_add_resource(&resources, &controller->io_space);
 		controller->first_busno = next_busno;
-		bus = pci_scan_root_bus(NULL, next_busno, controller->ops,
-					controller, &resources);
+		bus = pci_scan_root_bus(NULL, 
+				PCI_DOMBUS(controller->index, next_busno), 
+				controller->ops, controller, &resources);
 		controller->root_bus = bus;
 		next_busno = bus->busn_res.end + 1;
 	}
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 6ac2738..5bfe983 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -424,9 +424,9 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		}
 
 		if (!setup_mcfg_map(info, domain, (u8)root->secondary.start,
-				    (u8)root->secondary.end, root->mcfg_addr))
-			bus = pci_create_root_bus(NULL, busnum, &pci_root_ops,
-						  sd, &resources);
+					(u8)root->secondary.end, root->mcfg_addr)) 
+			bus = pci_create_root_bus(NULL, PCI_DOMBUS(domain, busnum), 
+					&pci_root_ops, sd, &resources);
 
 		if (bus) {
 			pci_scan_child_bus(bus);
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 0cbc723..56f78bd 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -486,7 +486,8 @@ void pcibios_scan_root(int busnum)
 	sd->node = x86_pci_root_bus_node(busnum);
 	x86_pci_root_bus_resources(busnum, &resources);
 	printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
-	bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, sd, &resources);
+	bus = pci_scan_root_bus(NULL, PCI_DOMBUS(0, busnum), 
+			&pci_root_ops, sd, &resources);
 	if (!bus) {
 		pci_free_resource_list(&resources);
 		kfree(sd);
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 240ddbc..a010dfa 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -477,8 +477,9 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 
 	pci_lock_rescan_remove();
 
-	b = pci_scan_root_bus(&pdev->xdev->dev, bus,
-				  &pcifront_bus_ops, sd, &resources);
+	b = pci_scan_root_bus(&pdev->xdev->dev, 
+			PCI_DOMBUS(sd->domain, bus),
+			&pcifront_bus_ops, sd, &resources);
 	if (!b) {
 		dev_err(&pdev->xdev->dev,
 			"Error creating PCI Frontend Bus!\n");
-- 
1.7.1
