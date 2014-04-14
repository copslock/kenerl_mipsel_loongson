Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2014 09:13:01 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:53531 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822082AbaDNHMinR6oj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Apr 2014 09:12:38 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3E7CUSa002346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Apr 2014 03:12:31 -0400
Received: from dhcp-26-207.brq.redhat.com (dhcp-26-119.brq.redhat.com [10.34.26.119])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s3E7CMOX004048;
        Mon, 14 Apr 2014 03:12:29 -0400
From:   Alexander Gordeev <agordeev@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@redhat.com>, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI/MSI: Phase out pci_enable_msi_block()
Date:   Mon, 14 Apr 2014 09:14:07 +0200
Message-Id: <0b08613dc17cd608c1babc1f42b8919f60e1093f.1397458024.git.agordeev@redhat.com>
In-Reply-To: <cover.1397458024.git.agordeev@redhat.com>
References: <cover.1397458024.git.agordeev@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agordeev@redhat.com
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

There are no users of pci_enable_msi_block() function have
left. Obsolete it in favor of pci_enable_msi_range() and
pci_enable_msi_exact() functions.

Up until now, when enabling MSI mode for a device, a single
successful call to arch_msi_check_device() was followed by
a single call to arch_setup_msi_irqs() function.

Yet, if arch_msi_check_device() returned success we should be
able to call arch_setup_msi_irqs() multiple times - while it
returns a number of MSI vectors that could have been allocated
(a third state).

This update makes use of the assumption described above. It
could have broke things had the architectures done any pre-
allocations or switch to some state in a call to function
arch_msi_check_device(). But because arch_msi_check_device()
is expected stateless and MSI resources are allocated in a
follow-up call to arch_setup_msi_irqs() we should be fine.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/msi.c   |   79 +++++++++++++++++++++-----------------------------
 include/linux/pci.h |    5 +--
 2 files changed, 34 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 955ab79..fc669ab 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -883,50 +883,6 @@ int pci_msi_vec_count(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_msi_vec_count);
 
-/**
- * pci_enable_msi_block - configure device's MSI capability structure
- * @dev: device to configure
- * @nvec: number of interrupts to configure
- *
- * Allocate IRQs for a device with the MSI capability.
- * This function returns a negative errno if an error occurs.  If it
- * is unable to allocate the number of interrupts requested, it returns
- * the number of interrupts it might be able to allocate.  If it successfully
- * allocates at least the number of interrupts requested, it returns 0 and
- * updates the @dev's irq member to the lowest new interrupt number; the
- * other interrupt numbers allocated to this device are consecutive.
- */
-int pci_enable_msi_block(struct pci_dev *dev, int nvec)
-{
-	int status, maxvec;
-
-	if (dev->current_state != PCI_D0)
-		return -EINVAL;
-
-	maxvec = pci_msi_vec_count(dev);
-	if (maxvec < 0)
-		return maxvec;
-	if (nvec > maxvec)
-		return maxvec;
-
-	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSI);
-	if (status)
-		return status;
-
-	WARN_ON(!!dev->msi_enabled);
-
-	/* Check whether driver already requested MSI-X irqs */
-	if (dev->msix_enabled) {
-		dev_info(&dev->dev, "can't enable MSI "
-			 "(MSI-X already enabled)\n");
-		return -EINVAL;
-	}
-
-	status = msi_capability_init(dev, nvec);
-	return status;
-}
-EXPORT_SYMBOL(pci_enable_msi_block);
-
 void pci_msi_shutdown(struct pci_dev *dev)
 {
 	struct msi_desc *desc;
@@ -1132,14 +1088,45 @@ void pci_msi_init_pci_dev(struct pci_dev *dev)
  **/
 int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
 {
-	int nvec = maxvec;
+	int nvec;
 	int rc;
 
+	if (dev->current_state != PCI_D0)
+		return -EINVAL;
+
+	WARN_ON(!!dev->msi_enabled);
+
+	/* Check whether driver already requested MSI-X irqs */
+	if (dev->msix_enabled) {
+		dev_info(&dev->dev,
+			 "can't enable MSI (MSI-X already enabled)\n");
+		return -EINVAL;
+	}
+
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	nvec = pci_msi_vec_count(dev);
+	if (nvec < 0)
+		return nvec;
+	else if (nvec < minvec)
+		return -EINVAL;
+	else if (nvec > maxvec)
+		nvec = maxvec;
+
+	do {
+		rc = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSI);
+		if (rc < 0) {
+			return rc;
+		} else if (rc > 0) {
+			if (rc < minvec)
+				return -ENOSPC;
+			nvec = rc;
+		}
+	} while (rc);
+
 	do {
-		rc = pci_enable_msi_block(dev, nvec);
+		rc = msi_capability_init(dev, nvec);
 		if (rc < 0) {
 			return rc;
 		} else if (rc > 0) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aab57b4..d8104f4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1158,7 +1158,6 @@ struct msix_entry {
 
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
-int pci_enable_msi_block(struct pci_dev *dev, int nvec);
 void pci_msi_shutdown(struct pci_dev *dev);
 void pci_disable_msi(struct pci_dev *dev);
 int pci_msix_vec_count(struct pci_dev *dev);
@@ -1188,8 +1187,6 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 }
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
-static inline int pci_enable_msi_block(struct pci_dev *dev, int nvec)
-{ return -ENOSYS; }
 static inline void pci_msi_shutdown(struct pci_dev *dev) { }
 static inline void pci_disable_msi(struct pci_dev *dev) { }
 static inline int pci_msix_vec_count(struct pci_dev *dev) { return -ENOSYS; }
@@ -1244,7 +1241,7 @@ static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
 static inline void pcie_ecrc_get_policy(char *str) { }
 #endif
 
-#define pci_enable_msi(pdev)	pci_enable_msi_block(pdev, 1)
+#define pci_enable_msi(pdev)	pci_enable_msi_range(pdev, 1, 1)
 
 #ifdef CONFIG_HT_IRQ
 /* The functions a driver should call */
-- 
1.7.7.6
