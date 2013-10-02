Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 18:59:36 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:25325 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868567Ab3JBQ7bMCn5Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 18:59:31 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92Axja7002747;
        Wed, 2 Oct 2013 12:59:45 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92Axh79002746;
        Wed, 2 Oct 2013 12:59:43 +0200
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
Subject: [PATCH RFC 67/77] rapidio: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:49:23 +0200
Message-Id: <d73f825db39f969247aa80380da2a9c41c101f09.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38110
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
 drivers/rapidio/devices/tsi721.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index ff7cbf2..5edd920 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -734,6 +734,16 @@ static int tsi721_enable_msix(struct tsi721_device *priv)
 	int err;
 	int i;
 
+	err = pci_msix_table_size(priv->pdev);
+	if (err < 0)
+		goto err_out;
+	if (err < ARRAY_SIZE(entries)) {
+		dev_info(&priv->pdev->dev,
+			 "Only %d MSI-X vectors available, not using MSI-X\n",
+			 err);
+		return -ENOSPC;
+	}
+
 	entries[TSI721_VECT_IDB].entry = TSI721_MSIX_SR2PC_IDBQ_RCV(IDB_QUEUE);
 	entries[TSI721_VECT_PWRX].entry = TSI721_MSIX_SRIO_MAC_INT;
 
@@ -769,16 +779,8 @@ static int tsi721_enable_msix(struct tsi721_device *priv)
 #endif /* CONFIG_RAPIDIO_DMA_ENGINE */
 
 	err = pci_enable_msix(priv->pdev, entries, ARRAY_SIZE(entries));
-	if (err) {
-		if (err > 0)
-			dev_info(&priv->pdev->dev,
-				 "Only %d MSI-X vectors available, "
-				 "not using MSI-X\n", err);
-		else
-			dev_err(&priv->pdev->dev,
-				"Failed to enable MSI-X (err=%d)\n", err);
-		return err;
-	}
+	if (err)
+		goto err_out;
 
 	/*
 	 * Copy MSI-X vector information into tsi721 private structure
@@ -833,6 +835,11 @@ static int tsi721_enable_msix(struct tsi721_device *priv)
 #endif /* CONFIG_RAPIDIO_DMA_ENGINE */
 
 	return 0;
+
+err_out:
+	dev_err(&priv->pdev->dev,
+		"Failed to enable MSI-X (err=%d)\n", err);
+	return err;
 }
 #endif /* CONFIG_PCI_MSI */
 
-- 
1.7.7.6
