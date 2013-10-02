Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 18:32:59 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:24624 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6865325Ab3JBQc4z2oxT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 18:32:56 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92Awjjr002676;
        Wed, 2 Oct 2013 12:58:45 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92AwiWN002673;
        Wed, 2 Oct 2013 12:58:44 +0200
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
Subject: [PATCH RFC 52/77] niu: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:49:08 +0200
Message-Id: <9808b7b5600043632fab8fa19f5b8e7845637de0.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38095
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
 drivers/net/ethernet/sun/niu.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index f28460c..54c41b9 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -9051,26 +9051,28 @@ static void niu_try_msix(struct niu *np, u8 *ldg_num_map)
 		    (np->port == 0 ? 3 : 1));
 	BUG_ON(num_irqs > (NIU_NUM_LDG / parent->num_ports));
 
-retry:
+	err = pci_msix_table_size(pdev);
+	if (err < 0)
+		goto fail;
+
+	num_irqs = min(num_irqs, err);
 	for (i = 0; i < num_irqs; i++) {
 		msi_vec[i].vector = 0;
 		msi_vec[i].entry = i;
 	}
 
 	err = pci_enable_msix(pdev, msi_vec, num_irqs);
-	if (err < 0) {
-		np->flags &= ~NIU_FLAGS_MSIX;
-		return;
-	}
-	if (err > 0) {
-		num_irqs = err;
-		goto retry;
-	}
+	if (err)
+		goto fail;
 
 	np->flags |= NIU_FLAGS_MSIX;
 	for (i = 0; i < num_irqs; i++)
 		np->ldg[i].irq = msi_vec[i].vector;
 	np->num_ldg = num_irqs;
+	return;
+
+fail:
+	np->flags &= ~NIU_FLAGS_MSIX;
 }
 
 static int niu_n2_irq_init(struct niu *np, u8 *ldg_num_map)
-- 
1.7.7.6
