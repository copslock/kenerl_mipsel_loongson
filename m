Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 18:57:51 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:25203 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868568Ab3JBQ5qStBDl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 18:57:46 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92Av5QI002599;
        Wed, 2 Oct 2013 12:57:05 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92Av2qT002597;
        Wed, 2 Oct 2013 12:57:02 +0200
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
Subject: [PATCH RFC 40/77] ixgbevf: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:48:56 +0200
Message-Id: <338c9012577acf694eb23622902185584987bd8f.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38109
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
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index fa0537a..d506a01 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1749,8 +1749,7 @@ void ixgbevf_reset(struct ixgbevf_adapter *adapter)
 static int ixgbevf_acquire_msix_vectors(struct ixgbevf_adapter *adapter,
 					int vectors)
 {
-	int err = 0;
-	int vector_threshold;
+	int err, vector_threshold;
 
 	/* We'll want at least 2 (vector_threshold):
 	 * 1) TxQ[0] + RxQ[0] handler
@@ -1763,18 +1762,15 @@ static int ixgbevf_acquire_msix_vectors(struct ixgbevf_adapter *adapter,
 	 * Right now, we simply care about how many we'll get; we'll
 	 * set them up later while requesting irq's.
 	 */
-	while (vectors >= vector_threshold) {
-		err = pci_enable_msix(adapter->pdev, adapter->msix_entries,
-				      vectors);
-		if (!err || err < 0) /* Success or a nasty failure. */
-			break;
-		else /* err == number of vectors we should try again with */
-			vectors = err;
-	}
+	err = pci_msix_table_size(adapter->pdev);
+	if (err < 0)
+		return err;
 
+	vectors = min(vectors, err);
 	if (vectors < vector_threshold)
-		err = -ENOSPC;
+		return -ENOSPC;
 
+	err = pci_enable_msix(adapter->pdev, adapter->msix_entries, vectors);
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"Unable to allocate MSI-X interrupts\n");
-- 
1.7.7.6
