Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 19:18:41 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:25908 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868572Ab3JBRSiuqcOA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 19:18:38 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92AxfE0002743;
        Wed, 2 Oct 2013 12:59:41 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92Axdfq002742;
        Wed, 2 Oct 2013 12:59:39 +0200
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
Subject: [PATCH RFC 66/77] qlge: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:49:22 +0200
Message-Id: <5161bfdf162c8edd77d03e96312d48edb54242bc.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38119
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
 drivers/net/ethernet/qlogic/qlge/qlge_main.c |   39 +++++++++++--------------
 1 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlge/qlge_main.c b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
index ac54cb0..d6fdd93 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge_main.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
@@ -3258,45 +3258,40 @@ static void ql_enable_msix(struct ql_adapter *qdev)
 
 	/* Get the MSIX vectors. */
 	if (qlge_irq_type == MSIX_IRQ) {
+		err = pci_msix_table_size(qdev->pdev);
+		if (err < 0)
+			goto msix_fail;
+
+		qdev->intr_count = min_t(u32, qdev->intr_count, err);
+
 		/* Try to alloc space for the msix struct,
 		 * if it fails then go to MSI/legacy.
 		 */
 		qdev->msi_x_entry = kcalloc(qdev->intr_count,
 					    sizeof(struct msix_entry),
 					    GFP_KERNEL);
-		if (!qdev->msi_x_entry) {
-			qlge_irq_type = MSI_IRQ;
-			goto msi;
-		}
+		if (!qdev->msi_x_entry)
+			goto msix_fail;
 
 		for (i = 0; i < qdev->intr_count; i++)
 			qdev->msi_x_entry[i].entry = i;
 
-		/* Loop to get our vectors.  We start with
-		 * what we want and settle for what we get.
-		 */
-		do {
-			err = pci_enable_msix(qdev->pdev,
-				qdev->msi_x_entry, qdev->intr_count);
-			if (err > 0)
-				qdev->intr_count = err;
-		} while (err > 0);
-
-		if (err < 0) {
-			kfree(qdev->msi_x_entry);
-			qdev->msi_x_entry = NULL;
-			netif_warn(qdev, ifup, qdev->ndev,
-				   "MSI-X Enable failed, trying MSI.\n");
-			qlge_irq_type = MSI_IRQ;
-		} else if (err == 0) {
+		if (!pci_enable_msix(qdev->pdev,
+				     qdev->msi_x_entry, qdev->intr_count)) {
 			set_bit(QL_MSIX_ENABLED, &qdev->flags);
 			netif_info(qdev, ifup, qdev->ndev,
 				   "MSI-X Enabled, got %d vectors.\n",
 				   qdev->intr_count);
 			return;
 		}
+
+		kfree(qdev->msi_x_entry);
+		qdev->msi_x_entry = NULL;
+msix_fail:
+		netif_warn(qdev, ifup, qdev->ndev,
+			   "MSI-X Enable failed, trying MSI.\n");
+		qlge_irq_type = MSI_IRQ;
 	}
-msi:
 	qdev->intr_count = 1;
 	if (qlge_irq_type == MSI_IRQ) {
 		if (!pci_enable_msi(qdev->pdev)) {
-- 
1.7.7.6
