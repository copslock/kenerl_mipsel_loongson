Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 19:22:27 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:26012 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868643Ab3JBRWYIby1A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 19:22:24 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92Ax0Pa002692;
        Wed, 2 Oct 2013 12:59:01 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92AwvOW002691;
        Wed, 2 Oct 2013 12:58:57 +0200
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
Subject: [PATCH RFC 55/77] ntb: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:49:11 +0200
Message-Id: <49eb592e15aaec804f9c11ca132d2b85c516aefa.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38121
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

As result of recent re-design of the MSI/MSI-X interrupts enabling
pattern this driver has to be updated to use the new technique to
obtain a optimal number of MSI/MSI-X interrupts required.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/ntb/ntb_hw.c |   41 +++++++++++++----------------------------
 drivers/ntb/ntb_hw.h |    2 --
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw.c
index eccd5e5..7776429 100644
--- a/drivers/ntb/ntb_hw.c
+++ b/drivers/ntb/ntb_hw.c
@@ -1032,23 +1032,26 @@ static int ntb_setup_msix(struct ntb_device *ndev)
 	struct msix_entry *msix;
 	int msix_entries;
 	int rc, i;
-	u16 val;
 
-	if (!pdev->msix_cap) {
-		rc = -EIO;
+	rc = pci_msix_table_size(pdev);
+	if (rc < 0)
 		goto err;
-	}
 
-	rc = pci_read_config_word(pdev, pdev->msix_cap + PCI_MSIX_FLAGS, &val);
-	if (rc)
+	/*
+	 * On SNB, the link interrupt is always tied to 4th vector.  If
+	 * we can't get all 4, then we can't use MSI-X.
+	 */
+	if ((rc < SNB_MSIX_CNT) && (ndev->hw_type != BWD_HW)) {
+		rc = -ENOSPC;
 		goto err;
-
-	msix_entries = msix_table_size(val);
-	if (msix_entries > ndev->limits.msix_cnt) {
+	}
+	if (rc > ndev->limits.msix_cnt) {
 		rc = -EINVAL;
 		goto err;
 	}
 
+	msix_entries = rc;
+
 	ndev->msix_entries = kmalloc(sizeof(struct msix_entry) * msix_entries,
 				     GFP_KERNEL);
 	if (!ndev->msix_entries) {
@@ -1060,26 +1063,8 @@ static int ntb_setup_msix(struct ntb_device *ndev)
 		ndev->msix_entries[i].entry = i;
 
 	rc = pci_enable_msix(pdev, ndev->msix_entries, msix_entries);
-	if (rc < 0)
+	if (rc)
 		goto err1;
-	if (rc > 0) {
-		/* On SNB, the link interrupt is always tied to 4th vector.  If
-		 * we can't get all 4, then we can't use MSI-X.
-		 */
-		if ((rc < SNB_MSIX_CNT) && (ndev->hw_type != BWD_HW)) {
-			rc = -EIO;
-			goto err1;
-		}
-
-		dev_warn(&pdev->dev,
-			 "Only %d MSI-X vectors.  Limiting the number of queues to that number.\n",
-			 rc);
-		msix_entries = rc;
-
-		rc = pci_enable_msix(pdev, ndev->msix_entries, msix_entries);
-		if (rc)
-			goto err1;
-	}
 
 	for (i = 0; i < msix_entries; i++) {
 		msix = &ndev->msix_entries[i];
diff --git a/drivers/ntb/ntb_hw.h b/drivers/ntb/ntb_hw.h
index 0a31ced..50bd760 100644
--- a/drivers/ntb/ntb_hw.h
+++ b/drivers/ntb/ntb_hw.h
@@ -60,8 +60,6 @@
 #define PCI_DEVICE_ID_INTEL_NTB_SS_HSX		0x2F0F
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_BWD		0x0C4E
 
-#define msix_table_size(control)	((control & PCI_MSIX_FLAGS_QSIZE)+1)
-
 #ifndef readq
 static inline u64 readq(void __iomem *addr)
 {
-- 
1.7.7.6
