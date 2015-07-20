Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jul 2015 14:08:58 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:57020 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011349AbbGTMIg6u03y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jul 2015 14:08:36 +0200
Received: from 172.24.1.49 (EHLO szxeml432-hub.china.huawei.com) ([172.24.1.49])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id COZ21649;
        Mon, 20 Jul 2015 20:05:30 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml432-hub.china.huawei.com (10.82.67.209) with Microsoft SMTP Server id
 14.3.158.1; Mon, 20 Jul 2015 20:05:17 +0800
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
Subject: [PATCH part3 v12 03/10] PCI: Remove declaration for pci_get_new_domain_nr()
Date:   Mon, 20 Jul 2015 20:01:11 +0800
Message-ID: <1437393678-4077-4-git-send-email-wangyijing@huawei.com>
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
X-archive-position: 48354
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

pci_get_new_domain_nr() is only used in drivers/pci/pci.c,
remove the declaration in include/linux/pci.h.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c   |    4 ++--
 include/linux/pci.h |    3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c95..59032e2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4476,14 +4476,14 @@ static void pci_no_domains(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
 static atomic_t __domain_nr = ATOMIC_INIT(-1);
 
-int pci_get_new_domain_nr(void)
+static int pci_get_new_domain_nr(void)
 {
 	return atomic_inc_return(&__domain_nr);
 }
 
-#ifdef CONFIG_PCI_DOMAINS_GENERIC
 void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 {
 	static int use_dt_domains = -1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f7e4204..4524592 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1319,12 +1319,10 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
  */
 #ifdef CONFIG_PCI_DOMAINS
 extern int pci_domains_supported;
-int pci_get_new_domain_nr(void);
 #else
 enum { pci_domains_supported = 0 };
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
-static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 #endif /* CONFIG_PCI_DOMAINS */
 
 /*
@@ -1445,7 +1443,6 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
-static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
-- 
1.7.1
