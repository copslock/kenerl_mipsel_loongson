Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 19:27:05 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:26124 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868651Ab3JBR1C1VMPq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 19:27:02 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92B0aPO002793;
        Wed, 2 Oct 2013 13:00:36 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92B0YUN002792;
        Wed, 2 Oct 2013 13:00:34 +0200
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
Subject: [PATCH RFC 75/77] vmxnet3: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:49:31 +0200
Message-Id: <6714315cab9b5eea79e6516caeb712362992bcc5.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38126
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
 drivers/net/vmxnet3/vmxnet3_drv.c |   68 ++++++++++++++++++-------------------
 1 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 00dc0d0..8d3321b 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2724,49 +2724,47 @@ vmxnet3_read_mac_addr(struct vmxnet3_adapter *adapter, u8 *mac)
 
 #ifdef CONFIG_PCI_MSI
 
-/*
- * Enable MSIx vectors.
- * Returns :
- *	0 on successful enabling of required vectors,
- *	VMXNET3_LINUX_MIN_MSIX_VECT when only minimum number of vectors required
- *	 could be enabled.
- *	number of vectors which can be enabled otherwise (this number is smaller
- *	 than VMXNET3_LINUX_MIN_MSIX_VECT)
- */
-
 static int
 vmxnet3_acquire_msix_vectors(struct vmxnet3_adapter *adapter,
 			     int vectors)
 {
-	int err = -EINVAL, vector_threshold;
+	int err, vector_threshold;
+
 	vector_threshold = VMXNET3_LINUX_MIN_MSIX_VECT;
+	if (vectors < vector_threshold)
+		return -EINVAL;
 
-	while (vectors >= vector_threshold) {
-		err = pci_enable_msix(adapter->pdev, adapter->intr.msix_entries,
-				      vectors);
-		if (!err) {
-			adapter->intr.num_intrs = vectors;
-			return 0;
-		} else if (err < 0) {
-			dev_err(&adapter->netdev->dev,
-				   "Failed to enable MSI-X, error: %d\n", err);
-			return err;
-		} else if (err < vector_threshold) {
-			dev_info(&adapter->pdev->dev,
-				 "Number of MSI-Xs which can be allocated "
-				 "is lower than min threshold required.\n");
-			return -ENOSPC;
-		} else {
-			/* If fails to enable required number of MSI-x vectors
-			 * try enabling minimum number of vectors required.
-			 */
-			dev_err(&adapter->netdev->dev,
-				"Failed to enable %d MSI-X, trying %d instead\n",
-				    vectors, vector_threshold);
-			vectors = vector_threshold;
-		}
+	err = pci_msix_table_size(adapter->pdev);
+	if (err < 0)
+		goto err_msix;
+	if (err < vector_threshold) {
+		dev_info(&adapter->pdev->dev,
+			 "Number of MSI-X interrupts which can be allocated "
+			 "is lower than min threshold required.\n");
+		return -ENOSPC;
+	}
+	if (err < vectors) {
+		/*
+		 * If fails to enable required number of MSI-x vectors
+		 * try enabling minimum number of vectors required.
+		 */
+		dev_err(&adapter->netdev->dev,
+			"Failed to enable %d MSI-X, trying %d instead\n",
+			vectors, vector_threshold);
+		vectors = vector_threshold;
 	}
 
+	err = pci_enable_msix(adapter->pdev, adapter->intr.msix_entries,
+			      vectors);
+	if (err)
+		goto err_msix;
+
+	adapter->intr.num_intrs = vectors;
+	return 0;
+
+err_msix:
+	dev_err(&adapter->netdev->dev,
+		"Failed to enable MSI-X, error: %d\n", err);
 	return err;
 }
 
-- 
1.7.7.6
