Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 19:17:03 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:25883 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868572Ab3JBRP4WEQW9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 19:15:56 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92AugjV002582;
        Wed, 2 Oct 2013 12:56:42 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92AucOr002581;
        Wed, 2 Oct 2013 12:56:38 +0200
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
Subject: [PATCH RFC 37/77] ipr: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:48:53 +0200
Message-Id: <5bc4414bf44d7ded72c38333225b9057b3427869.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38118
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
 drivers/scsi/ipr.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 762a93e..86ed0a2 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -9247,45 +9247,45 @@ static int ipr_enable_msix(struct ipr_ioa_cfg *ioa_cfg)
 	struct msix_entry entries[IPR_MAX_MSIX_VECTORS];
 	int i, err, vectors;
 
-	for (i = 0; i < ARRAY_SIZE(entries); ++i)
-		entries[i].entry = i;
+	err = pci_msix_table_size(ioa_cfg->pdev);
+	if (err < 0)
+		return err;
 
-	vectors = ipr_number_of_msix;
+	vectors = min_t(int, err, ipr_number_of_msix);
 
-	while ((err = pci_enable_msix(ioa_cfg->pdev, entries, vectors)) > 0)
-			vectors = err;
+	BUG_ON(vectors > ARRAY_SIZE(entries));
+	for (i = 0; i < vectors; ++i)
+		entries[i].entry = i;
 
-	if (err < 0)
+	err = pci_enable_msix(ioa_cfg->pdev, entries, vectors);
+	if (err)
 		return err;
 
-	if (!err) {
-		for (i = 0; i < vectors; i++)
-			ioa_cfg->vectors_info[i].vec = entries[i].vector;
-		ioa_cfg->nvectors = vectors;
-	}
+	for (i = 0; i < vectors; i++)
+		ioa_cfg->vectors_info[i].vec = entries[i].vector;
+	ioa_cfg->nvectors = vectors;
 
-	return err;
+	return 0;
 }
 
 static int ipr_enable_msi(struct ipr_ioa_cfg *ioa_cfg)
 {
 	int i, err, vectors;
 
-	vectors = ipr_number_of_msix;
-
-	while ((err = pci_enable_msi_block(ioa_cfg->pdev, vectors)) > 0)
-			vectors = err;
-
+	err = pci_get_msi_cap(ioa_cfg->pdev);
 	if (err < 0)
 		return err;
 
-	if (!err) {
-		for (i = 0; i < vectors; i++)
-			ioa_cfg->vectors_info[i].vec = ioa_cfg->pdev->irq + i;
-		ioa_cfg->nvectors = vectors;
-	}
+	vectors = min_t(int, err, ipr_number_of_msix);
+	err = pci_enable_msi_block(ioa_cfg->pdev, vectors);
+	if (err)
+		return err;
+
+	for (i = 0; i < vectors; i++)
+		ioa_cfg->vectors_info[i].vec = ioa_cfg->pdev->irq + i;
+	ioa_cfg->nvectors = vectors;
 
-	return err;
+	return 0;
 }
 
 static void name_msi_vectors(struct ipr_ioa_cfg *ioa_cfg)
-- 
1.7.7.6
