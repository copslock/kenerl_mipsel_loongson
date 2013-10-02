Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 19:30:53 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:26229 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868567Ab3JBRavW8lKJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 19:30:51 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92AxXdN002735;
        Wed, 2 Oct 2013 12:59:33 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92AxWjO002734;
        Wed, 2 Oct 2013 12:59:32 +0200
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
Subject: [PATCH RFC 64/77] qlcnic: Make MSI-X initialization routine bit more readable
Date:   Wed,  2 Oct 2013 12:49:20 +0200
Message-Id: <685e235adcdeafb5e72b5fe1efe63f8f03a8f035.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38131
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

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c |  112 +++++++++++-----------
 1 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index a137c14..8510457 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -568,7 +568,7 @@ int qlcnic_enable_msix(struct qlcnic_adapter *adapter, u32 num_msix)
 {
 	struct pci_dev *pdev = adapter->pdev;
 	int max_tx_rings, max_sds_rings, tx_vector;
-	int err = -EINVAL, i;
+	int err, i;
 
 	if (adapter->flags & QLCNIC_TX_INTR_SHARED) {
 		max_tx_rings = 0;
@@ -589,68 +589,68 @@ int qlcnic_enable_msix(struct qlcnic_adapter *adapter, u32 num_msix)
 	adapter->max_sds_rings = 1;
 	adapter->flags &= ~(QLCNIC_MSI_ENABLED | QLCNIC_MSIX_ENABLED);
 
-	if (adapter->ahw->msix_supported) {
-		err = pci_msix_table_size(pdev);
-		if (err < 0)
+	if (!adapter->ahw->msix_supported)
+		return -EINVAL;
+
+	err = pci_msix_table_size(pdev);
+	if (err < 0)
+		goto fail;
+
+	if (err < num_msix) {
+		dev_info(&pdev->dev,
+			 "Unable to allocate %d MSI-X interrupt vectors\n",
+			 num_msix);
+		if (qlcnic_83xx_check(adapter)) {
+			if (err < (QLC_83XX_MINIMUM_VECTOR - tx_vector))
+				return -ENOSPC;
+			err -= (max_tx_rings + 1);
+			num_msix = rounddown_pow_of_two(err);
+			num_msix += (max_tx_rings + 1);
+		} else {
+			num_msix = rounddown_pow_of_two(err);
+			if (qlcnic_check_multi_tx(adapter))
+				num_msix += max_tx_rings;
+		}
+
+		if (!num_msix) {
+			err = -ENOSPC;
 			goto fail;
+		}
 
-		if (err < num_msix) {
-			dev_info(&pdev->dev,
-				 "Unable to allocate %d MSI-X interrupt vectors\n",
-				 num_msix);
-			if (qlcnic_83xx_check(adapter)) {
-				if (err < (QLC_83XX_MINIMUM_VECTOR - tx_vector))
-					return -ENOSPC;
-				err -= (max_tx_rings + 1);
-				num_msix = rounddown_pow_of_two(err);
-				num_msix += (max_tx_rings + 1);
-			} else {
-				num_msix = rounddown_pow_of_two(err);
-				if (qlcnic_check_multi_tx(adapter))
-					num_msix += max_tx_rings;
-			}
+		dev_info(&pdev->dev,
+			 "Trying to allocate %d MSI-X interrupt vectors\n",
+			 num_msix);
+	}
 
-			if (!num_msix) {
-				err = -ENOSPC;
-				goto fail;
-			}
+	for (i = 0; i < num_msix; i++)
+		adapter->msix_entries[i].entry = i;
 
-			dev_info(&pdev->dev,
-				 "Trying to allocate %d MSI-X interrupt vectors\n",
-				 num_msix);
-			}
-		}
+	err = pci_enable_msix(pdev, adapter->msix_entries, num_msix);
+	if (err)
+		goto fail;
 
-		for (i = 0; i < num_msix; i++)
-			adapter->msix_entries[i].entry = i;
-		err = pci_enable_msix(pdev, adapter->msix_entries, num_msix);
-		if (err == 0) {
-			adapter->flags |= QLCNIC_MSIX_ENABLED;
-			if (qlcnic_83xx_check(adapter)) {
-				adapter->ahw->num_msix = num_msix;
-				/* subtract mail box and tx ring vectors */
-				adapter->max_sds_rings = num_msix -
-							 max_tx_rings - 1;
-			} else {
-				adapter->ahw->num_msix = num_msix;
-				if (qlcnic_check_multi_tx(adapter) &&
-				    !adapter->ahw->diag_test &&
-				    (adapter->max_drv_tx_rings > 1))
-					max_sds_rings = num_msix - max_tx_rings;
-				else
-					max_sds_rings = num_msix;
-
-				adapter->max_sds_rings = max_sds_rings;
-			}
-			dev_info(&pdev->dev, "using msi-x interrupts\n");
-		} else {
-fail:
-			dev_info(&pdev->dev,
-				 "Unable to allocate %d MSI-X interrupt vectors\n",
-				 num_msix);
-		}
+	adapter->flags |= QLCNIC_MSIX_ENABLED;
+	if (qlcnic_83xx_check(adapter)) {
+		adapter->ahw->num_msix = num_msix;
+		/* subtract mail box and tx ring vectors */
+		adapter->max_sds_rings = num_msix - max_tx_rings - 1;
+	} else {
+		adapter->ahw->num_msix = num_msix;
+		if (qlcnic_check_multi_tx(adapter) &&
+		    !adapter->ahw->diag_test && (adapter->max_drv_tx_rings > 1))
+			max_sds_rings = num_msix - max_tx_rings;
+		else
+			max_sds_rings = num_msix;
+
+		adapter->max_sds_rings = max_sds_rings;
 	}
 
+	dev_info(&pdev->dev, "using msi-x interrupts\n");
+	return 0;
+
+fail:
+	dev_info(&pdev->dev,
+		 "Unable to allocate %d MSI-X interrupt vectors\n", num_msix);
 	return err;
 }
 
-- 
1.7.7.6
