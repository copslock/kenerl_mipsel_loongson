Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 19:09:44 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:25790 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868572Ab3JBRJli64iQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 19:09:41 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92Atx6u002550;
        Wed, 2 Oct 2013 12:55:59 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92AtvuC002544;
        Wed, 2 Oct 2013 12:55:57 +0200
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
Subject: [PATCH RFC 31/77] hpsa: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:48:47 +0200
Message-Id: <2ebbbb417719ad6501bbe59969409c1f5c63ae48.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38115
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
 drivers/scsi/hpsa.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 393c8db..eb17b3d 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -4103,34 +4103,32 @@ static void hpsa_interrupt_mode(struct ctlr_info *h)
 	int err, i;
 	struct msix_entry hpsa_msix_entries[MAX_REPLY_QUEUES];
 
-	for (i = 0; i < MAX_REPLY_QUEUES; i++) {
-		hpsa_msix_entries[i].vector = 0;
-		hpsa_msix_entries[i].entry = i;
-	}
-
 	/* Some boards advertise MSI but don't really support it */
 	if ((h->board_id == 0x40700E11) || (h->board_id == 0x40800E11) ||
 	    (h->board_id == 0x40820E11) || (h->board_id == 0x40830E11))
 		goto default_int_mode;
 	if (pci_find_capability(h->pdev, PCI_CAP_ID_MSIX)) {
 		dev_info(&h->pdev->dev, "MSIX\n");
+
+		err = pci_msix_table_size(h->pdev);
+		if (err < ARRAY_SIZE(hpsa_msix_entries))
+			goto default_int_mode;
+
+		for (i = 0; i < ARRAY_SIZE(hpsa_msix_entries); i++) {
+			hpsa_msix_entries[i].vector = 0;
+			hpsa_msix_entries[i].entry = i;
+		}
+
 		err = pci_enable_msix(h->pdev, hpsa_msix_entries,
-						MAX_REPLY_QUEUES);
+				      ARRAY_SIZE(hpsa_msix_entries));
 		if (!err) {
 			for (i = 0; i < MAX_REPLY_QUEUES; i++)
 				h->intr[i] = hpsa_msix_entries[i].vector;
 			h->msix_vector = 1;
 			return;
 		}
-		if (err > 0) {
-			dev_warn(&h->pdev->dev, "only %d MSI-X vectors "
-			       "available\n", err);
-			goto default_int_mode;
-		} else {
-			dev_warn(&h->pdev->dev, "MSI-X init failed %d\n",
-			       err);
-			goto default_int_mode;
-		}
+		dev_warn(&h->pdev->dev, "MSI-X init failed %d\n", err);
+		goto default_int_mode;
 	}
 	if (pci_find_capability(h->pdev, PCI_CAP_ID_MSI)) {
 		dev_info(&h->pdev->dev, "MSI\n");
-- 
1.7.7.6
