Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jul 2015 14:09:15 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:57105 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011397AbbGTMI4ScPZy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jul 2015 14:08:56 +0200
Received: from 172.24.1.49 (EHLO szxeml432-hub.china.huawei.com) ([172.24.1.49])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id COZ21646;
        Mon, 20 Jul 2015 20:05:29 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml432-hub.china.huawei.com (10.82.67.209) with Microsoft SMTP Server id
 14.3.158.1; Mon, 20 Jul 2015 20:05:19 +0800
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
Subject: [PATCH part3 v12 04/10] PCI: Introduce pci_host_assign_domain_nr() to assign domain
Date:   Mon, 20 Jul 2015 20:01:12 +0800
Message-ID: <1437393678-4077-5-git-send-email-wangyijing@huawei.com>
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
X-archive-position: 48355
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

Introduce pci_host_assign_domain_nr() to assign domain number
for pci_host_bridge.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c |   24 +++++++++++++++++++-----
 drivers/pci/pci.h |    1 +
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59032e2..79d01e4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4484,10 +4484,10 @@ static int pci_get_new_domain_nr(void)
 	return atomic_inc_return(&__domain_nr);
 }
 
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+static int pci_assign_domain_nr(struct device *dev)
 {
 	static int use_dt_domains = -1;
-	int domain = of_get_pci_domain_nr(parent->of_node);
+	int domain = of_get_pci_domain_nr(dev->of_node);
 
 	/*
 	 * Check DT domain and use_dt_domains values.
@@ -4521,16 +4521,30 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 		use_dt_domains = 0;
 		domain = pci_get_new_domain_nr();
 	} else {
-		dev_err(parent, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
-			parent->of_node->full_name);
+		dev_err(dev, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
+			dev->of_node->full_name);
 		domain = -1;
 	}
 
-	bus->domain_nr = domain;
+	return domain;
+}
+
+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	bus->domain_nr = pci_assign_domain_nr(parent);
 }
 #endif
 #endif
 
+void pci_host_assign_domain_nr(struct pci_host_bridge *host, int domain)
+{
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	host->domain = pci_assign_domain_nr(host->dev.parent);
+#else
+	host->domain = domain;
+#endif
+}
+
 /**
  * pci_ext_cfg_avail - can we access extended PCI config space?
  *
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 02192aa..4a815c9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -344,4 +344,5 @@ static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
 }
 #endif
 
+void pci_host_assign_domain_nr(struct pci_host_bridge *host, int domain);
 #endif /* DRIVERS_PCI_H */
-- 
1.7.1
