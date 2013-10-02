Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 19:13:40 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:25845 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868572Ab3JBRNh4ewIF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 19:13:37 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92ArCXL002425;
        Wed, 2 Oct 2013 12:53:13 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92Ar7RL002424;
        Wed, 2 Oct 2013 12:53:07 +0200
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
Subject: [PATCH RFC 12/77] benet: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:48:28 +0200
Message-Id: <4a8384c64f822aaed962169532bde927ac382ca0.1380703262.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38117
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
 drivers/net/ethernet/emulex/benet/be_main.c |   38 ++++++++++++++------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 3e2c834..84d560d 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -2366,29 +2366,23 @@ static int be_msix_enable(struct be_adapter *adapter)
 	else
 		num_vec = adapter->cfg_num_qs;
 
-	for (i = 0; i < num_vec; i++)
-		adapter->msix_entries[i].entry = i;
+	status = pci_msix_table_size(adapter->pdev);
+	if (status < 0)
+		goto fail;
 
-	status = pci_enable_msix(adapter->pdev, adapter->msix_entries, num_vec);
-	if (status == 0) {
-		goto done;
-	} else if (status >= MIN_MSIX_VECTORS) {
-		num_vec = status;
-		status = pci_enable_msix(adapter->pdev, adapter->msix_entries,
-					 num_vec);
-		if (!status)
-			goto done;
-	} else (status > 0) {
+	num_vec = min(num_vec, status);
+	if (num_vec < MIN_MSIX_VECTORS) {
 		status = -ENOSPC;
+		goto fail;
 	}
 
-	dev_warn(dev, "MSIx enable failed\n");
+	for (i = 0; i < num_vec; i++)
+		adapter->msix_entries[i].entry = i;
+
+	status = pci_enable_msix(adapter->pdev, adapter->msix_entries, num_vec);
+	if (status)
+		goto fail;
 
-	/* INTx is not supported in VFs, so fail probe if enable_msix fails */
-	if (!be_physfn(adapter))
-		return status;
-	return 0;
-done:
 	if (be_roce_supported(adapter) && num_vec > MIN_MSIX_VECTORS) {
 		adapter->num_msix_roce_vec = num_vec / 2;
 		dev_info(dev, "enabled %d MSI-x vector(s) for RoCE\n",
@@ -2400,6 +2394,14 @@ done:
 	dev_info(dev, "enabled %d MSI-x vector(s) for NIC\n",
 		 adapter->num_msix_vec);
 	return 0;
+
+fail:
+	dev_warn(dev, "MSIx enable failed\n");
+
+	/* INTx is not supported in VFs, so fail probe if enable_msix fails */
+	if (!be_physfn(adapter))
+		return status;
+	return 0;
 }
 
 static inline int be_msix_vec_get(struct be_adapter *adapter,
-- 
1.7.7.6
