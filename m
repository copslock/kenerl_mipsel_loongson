Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 20:04:19 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:27335 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868680Ab3JBSENJ0JIR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 20:04:13 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92B0VBQ002789;
        Wed, 2 Oct 2013 13:00:31 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92B0T7M002788;
        Wed, 2 Oct 2013 13:00:29 +0200
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
        stable@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux390@de.ibm.com, linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: [PATCH RFC 74/77] vmxnet3: Limit number of rx queues to 1 if per-queue MSI-Xs failed
Date:   Wed,  2 Oct 2013 12:49:30 +0200
Message-Id: <f029865a23808e2f788f90f878355fddf3b04ad2.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38165
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
 drivers/net/vmxnet3/vmxnet3_drv.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 3df7f32..00dc0d0 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2814,12 +2814,14 @@ vmxnet3_alloc_intr_resources(struct vmxnet3_adapter *adapter)
 
 		err = vmxnet3_acquire_msix_vectors(adapter,
 						   adapter->intr.num_intrs);
-		/* If we cannot allocate one MSIx vector per queue
-		 * then limit the number of rx queues to 1
-		 */
-		if (err == VMXNET3_LINUX_MIN_MSIX_VECT) {
-			if (adapter->share_intr != VMXNET3_INTR_BUDDYSHARE
-			    || adapter->num_rx_queues != 1) {
+		if (!err) {
+			/* If we cannot allocate one MSIx vector per queue
+			 * then limit the number of rx queues to 1
+			 */
+			if ((adapter->intr.num_intrs ==
+			     VMXNET3_LINUX_MIN_MSIX_VECT) &&
+			    ((adapter->share_intr != VMXNET3_INTR_BUDDYSHARE) ||
+			     (adapter->num_rx_queues != 1))) {
 				adapter->share_intr = VMXNET3_INTR_TXSHARE;
 				netdev_err(adapter->netdev,
 					   "Number of rx queues : 1\n");
@@ -2829,8 +2831,6 @@ vmxnet3_alloc_intr_resources(struct vmxnet3_adapter *adapter)
 			}
 			return;
 		}
-		if (!err)
-			return;
 
 		/* If we cannot allocate MSIx vectors use only one rx queue */
 		dev_info(&adapter->pdev->dev,
-- 
1.7.7.6
