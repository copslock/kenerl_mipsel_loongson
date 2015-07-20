Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jul 2015 14:18:37 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:60904 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011275AbbGTMSeVxzRy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jul 2015 14:18:34 +0200
Received: from 172.24.1.49 (EHLO szxeml432-hub.china.huawei.com) ([172.24.1.49])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id COZ21651;
        Mon, 20 Jul 2015 20:05:30 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml432-hub.china.huawei.com (10.82.67.209) with Microsoft SMTP Server id
 14.3.158.1; Mon, 20 Jul 2015 20:05:20 +0800
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
Subject: [PATCH part3 v12 05/10] powerpc/PCI: Rename pcibios_root_bridge_prepare() to pcibios_root_bus_prepare()
Date:   Mon, 20 Jul 2015 20:01:13 +0800
Message-ID: <1437393678-4077-6-git-send-email-wangyijing@huawei.com>
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
X-archive-position: 48362
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

Pcibios_root_bridge_prepare() in powerpc set root bus
speed, it's not the preparation for pci host bridge.
For better separation of host bridge and root bus creation,
It's need to rename it to another weak function.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/powerpc/include/asm/machdep.h       |    2 +-
 arch/powerpc/kernel/pci-common.c         |    6 +++---
 arch/powerpc/platforms/pseries/pci.c     |    2 +-
 arch/powerpc/platforms/pseries/pseries.h |    2 +-
 arch/powerpc/platforms/pseries/setup.c   |    2 +-
 drivers/pci/probe.c                      |    9 +++++++++
 6 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 952579f..dbd5e8b 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -100,7 +100,7 @@ struct machdep_calls {
 	/* Called after allocating resources */
 	void		(*pcibios_fixup)(void);
 	void		(*pci_irq_fixup)(struct pci_dev *dev);
-	int		(*pcibios_root_bridge_prepare)(struct pci_host_bridge
+	int		(*pcibios_root_bus_prepare)(struct pci_host_bridge
 				*bridge);
 
 	/* To setup PHBs when using automatic OF platform driver for PCI */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index df7f018..3e398c8 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -782,10 +782,10 @@ int pci_proc_domain(struct pci_bus *bus)
 	return 1;
 }
 
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+int pcibios_root_bus_prepare(struct pci_host_bridge *bridge)
 {
-	if (ppc_md.pcibios_root_bridge_prepare)
-		return ppc_md.pcibios_root_bridge_prepare(bridge);
+	if (ppc_md.pcibios_root_bus_prepare)
+		return ppc_md.pcibios_root_bus_prepare(bridge);
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index fe16a50..885f9ff 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -110,7 +110,7 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
 			 fixup_winbond_82c105);
 
-int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
+int pseries_root_bus_prepare(struct pci_host_bridge *bridge)
 {
 	struct device_node *dn, *pdn;
 	struct pci_bus *bus;
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 8411c27..41310dc 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -75,7 +75,7 @@ static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 
 /* PCI root bridge prepare function override for pseries */
 struct pci_host_bridge;
-int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
+int pseries_root_bus_prepare(struct pci_host_bridge *bridge);
 
 extern struct pci_controller_ops pseries_pci_controller_ops;
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index df6a704..2815309 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -537,7 +537,7 @@ static void __init pSeries_setup_arch(void)
 		ppc_md.enable_pmcs = power4_enable_pmcs;
 	}
 
-	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
+	ppc_md.pcibios_root_bus_prepare = pseries_root_bus_prepare;
 
 	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
 		long rc;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b49deb8..0eba126 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1919,6 +1919,11 @@ int __weak pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	return 0;
 }
 
+int __weak pcibios_root_bus_prepare(struct pci_host_bridge *bridge)
+{
+	return 0;
+}
+
 void __weak pcibios_add_bus(struct pci_bus *bus)
 {
 }
@@ -1984,6 +1989,10 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int domain,
 	b->dev.class = &pcibus_class;
 	b->dev.parent = b->bridge;
 	dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), bus);
+	error = pcibios_root_bus_prepare(bridge);
+	if (error)
+		goto class_dev_reg_err;
+
 	error = device_register(&b->dev);
 	if (error)
 		goto class_dev_reg_err;
-- 
1.7.1
