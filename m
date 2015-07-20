Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jul 2015 14:08:39 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:57034 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011345AbbGTMIgmGzFy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jul 2015 14:08:36 +0200
Received: from 172.24.1.47 (EHLO szxeml432-hub.china.huawei.com) ([172.24.1.47])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id COZ21655;
        Mon, 20 Jul 2015 20:05:32 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml432-hub.china.huawei.com (10.82.67.209) with Microsoft SMTP Server id
 14.3.158.1; Mon, 20 Jul 2015 20:05:22 +0800
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
Subject: [PATCH part3 v12 07/10] PCI: Create pci host bridge prior to root bus
Date:   Mon, 20 Jul 2015 20:01:15 +0800
Message-ID: <1437393678-4077-8-git-send-email-wangyijing@huawei.com>
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
X-archive-position: 48353
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

Pci_host_bridge hold the domain number, we need
to assign domain number prior to root bus creation,
because root bus need to know the domain number
to check whether it's alreay exist. Also it's
preparation for separating pci_host_bridge creation
from pci_create_root_bus().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |   58 +++++++++++++++++++++++++++-----------------------
 1 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0ae8bf2..cb525aa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -515,7 +515,7 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
-static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
+static struct pci_host_bridge *pci_alloc_host_bridge(void)
 {
 	struct pci_host_bridge *bridge;
 
@@ -524,7 +524,6 @@ static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
-	bridge->bus = b;
 	return bridge;
 }
 
@@ -1938,48 +1937,53 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int domain,
 {
 	int error;
 	struct pci_host_bridge *bridge;
-	struct pci_bus *b, *b2;
+	struct pci_bus *b;
 	struct resource_entry *window, *n;
 	struct resource *res;
 	resource_size_t offset;
 	char bus_addr[64];
 	char *fmt;
 
-	b = pci_alloc_bus(NULL);
-	if (!b)
+	bridge = pci_alloc_host_bridge();
+	if (!bridge)
 		return NULL;
 
-	b->sysdata = sysdata;
-	b->ops = ops;
-	b->number = b->busn_res.start = bus;
-	pci_bus_assign_domain_nr(b, parent);
-	b2 = pci_find_bus(pci_domain_nr(b), bus);
-	if (b2) {
+	bridge->dev.parent = parent;
+	pci_host_assign_domain_nr(bridge, domain);
+
+	b = pci_find_bus(bridge->domain, bus);
+	if (b) {
 		/* If we already got to this bus through a different bridge, ignore it */
-		dev_dbg(&b2->dev, "bus already known\n");
-		goto err_out;
+		dev_dbg(&b->dev, "bus already known\n");
+		kfree(bridge);
+		return NULL;
 	}
 
-	bridge = pci_alloc_host_bridge(b);
-	if (!bridge)
-		goto err_out;
-
-	bridge->domain = domain;
-	bridge->dev.parent = parent;
 	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_drvdata(&bridge->dev, sysdata);
-	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
+	dev_set_name(&bridge->dev, "pci%04x:%02x", bridge->domain, bus);
 	error = pcibios_root_bridge_prepare(bridge);
 	if (error) {
 		kfree(bridge);
-		goto err_out;
+		return NULL;
 	}
 
 	error = device_register(&bridge->dev);
 	if (error) {
 		put_device(&bridge->dev);
-		goto err_out;
+		return NULL;
 	}
+
+	b = pci_alloc_bus(NULL);
+	if (!b)
+		goto unregister_host;
+
+	bridge->bus = b;
+	b->sysdata = sysdata;
+	b->ops = ops;
+	b->number = b->busn_res.start = bus;
+	pci_bus_assign_domain_nr(b, parent);
+
 	b->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(b->bridge);
 	pci_set_bus_of_node(b);
@@ -1992,11 +1996,11 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int domain,
 	dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), bus);
 	error = pcibios_root_bus_prepare(bridge);
 	if (error)
-		goto class_dev_reg_err;
+		goto free_bus;
 
 	error = device_register(&b->dev);
 	if (error)
-		goto class_dev_reg_err;
+		goto free_bus;
 
 	pcibios_add_bus(b);
 
@@ -2036,11 +2040,11 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int domain,
 
 	return b;
 
-class_dev_reg_err:
+free_bus:
+	kfree(b);
 	put_device(&bridge->dev);
+unregister_host:
 	device_unregister(&bridge->dev);
-err_out:
-	kfree(b);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(pci_create_root_bus);
-- 
1.7.1
