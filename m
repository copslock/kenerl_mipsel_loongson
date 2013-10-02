Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 19:28:49 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:26168 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868652Ab3JBR2hxfrnV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 19:28:37 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92AqE71002388;
        Wed, 2 Oct 2013 12:52:14 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92Aq7si002387;
        Wed, 2 Oct 2013 12:52:07 +0200
From:   Alexander Gordeev <agordeev@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux390@de.ibm.com,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: [PATCH RFC 06/77] PCI/MSI: Factor out pci_get_msi_cap() interface
Date:   Wed,  2 Oct 2013 12:48:22 +0200
Message-Id: <9c282c4ab92731c719d161d2db6fc54ce33891d9.1380703262.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38129
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

This update is needed to facilitate a forthcoming re-design
MSI/MSI-X interrupts enabling pattern.

Device drivers will use this interface to obtain maximum number
of MSI interrupts the device supports and use that value in the
following call to pci_enable_msi_block() interface.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 Documentation/PCI/MSI-HOWTO.txt |   15 +++++++++++++++
 drivers/pci/msi.c               |   33 +++++++++++++++++++++------------
 include/linux/pci.h             |    6 ++++++
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
index 35b2d64..1f37ce2 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/MSI-HOWTO.txt
@@ -169,6 +169,21 @@ on any interrupt for which it previously called request_irq().
 Failure to do so results in a BUG_ON(), leaving the device with
 MSI enabled and thus leaking its vector.
 
+4.2.5 pci_get_msi_cap
+
+int pci_get_msi_cap(struct pci_dev *dev)
+
+This function could be used to retrieve the number of MSI vectors the
+device requested (via the Multiple Message Capable register). The MSI
+specification only allows the returned value to be a power of two,
+up to a maximum of 2^5 (32).
+
+If this function returns a negative number, it indicates the device is
+not capable of sending MSIs.
+
+If this function returns a positive number, it indicates the maximum
+number of MSI interrupt vectors that could be allocated.
+
 4.3 Using MSI-X
 
 The MSI-X capability is much more flexible than the MSI capability.
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 875c353..ca59bfc 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -812,6 +812,21 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	return 0;
 }
 
+int pci_get_msi_cap(struct pci_dev *dev)
+{
+	int ret;
+	u16 msgctl;
+
+	if (!dev->msi_cap)
+		return -EINVAL;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
+	ret = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
+
+	return ret;
+}
+EXPORT_SYMBOL(pci_get_msi_cap);
+
 /**
  * pci_enable_msi_block - configure device's MSI capability structure
  * @dev: device to configure
@@ -828,13 +843,10 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
 int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
 {
 	int status, maxvec;
-	u16 msgctl;
 
-	if (!dev->msi_cap)
-		return -EINVAL;
-
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
-	maxvec = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
+	maxvec = pci_get_msi_cap(dev);
+	if (maxvec < 0)
+		return maxvec;
 	if (nvec > maxvec)
 		return maxvec;
 
@@ -859,13 +871,10 @@ EXPORT_SYMBOL(pci_enable_msi_block);
 int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec)
 {
 	int ret, nvec;
-	u16 msgctl;
 
-	if (!dev->msi_cap)
-		return -EINVAL;
-
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
-	ret = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
+	ret = pci_get_msi_cap(dev);
+	if (ret < 0)
+		return ret;
 
 	if (maxvec)
 		*maxvec = ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index da172f9..2fa92ef 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1144,6 +1144,11 @@ struct msix_entry {
 
 
 #ifndef CONFIG_PCI_MSI
+static inline int pci_get_msi_cap(struct pci_dev *dev)
+{
+	return -1;
+}
+
 static inline int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
 {
 	return -1;
@@ -1185,6 +1190,7 @@ static inline int pci_msi_enabled(void)
 	return 0;
 }
 #else
+int pci_get_msi_cap(struct pci_dev *dev);
 int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
 int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec);
 void pci_msi_shutdown(struct pci_dev *dev);
-- 
1.7.7.6
