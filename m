Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 19:25:45 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:26083 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868642Ab3JBRZnBp200 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 19:25:43 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92At2jZ002518;
        Wed, 2 Oct 2013 12:55:03 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92At11F002517;
        Wed, 2 Oct 2013 12:55:01 +0200
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
Subject: [PATCH RFC 26/77] cxgb4: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:48:42 +0200
Message-Id: <384501214b90270df2f9414e3ddcffbe0335ddff.1380703262.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38124
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
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |   62 +++++++++++++----------
 1 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 9425bc6..e5fbbd3 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5699,9 +5699,6 @@ static int enable_msix(struct adapter *adap)
 	unsigned int nchan = adap->params.nports;
 	struct msix_entry entries[MAX_INGQ + 1];
 
-	for (i = 0; i < ARRAY_SIZE(entries); ++i)
-		entries[i].entry = i;
-
 	want = s->max_ethqsets + EXTRA_VECS;
 	if (is_offload(adap)) {
 		want += s->rdmaqs + s->ofldqsets;
@@ -5710,34 +5707,45 @@ static int enable_msix(struct adapter *adap)
 	}
 	need = adap->params.nports + EXTRA_VECS + ofld_need;
 
-	while ((err = pci_enable_msix(adap->pdev, entries, want)) >= need)
-		want = err;
+	err = pci_msix_table_size(adap->pdev);
+	if (err < 0)
+		return err;
 
-	if (!err) {
-		/*
-		 * Distribute available vectors to the various queue groups.
-		 * Every group gets its minimum requirement and NIC gets top
-		 * priority for leftovers.
-		 */
-		i = want - EXTRA_VECS - ofld_need;
-		if (i < s->max_ethqsets) {
-			s->max_ethqsets = i;
-			if (i < s->ethqsets)
-				reduce_ethqs(adap, i);
-		}
-		if (is_offload(adap)) {
-			i = want - EXTRA_VECS - s->max_ethqsets;
-			i -= ofld_need - nchan;
-			s->ofldqsets = (i / nchan) * nchan;  /* round down */
-		}
-		for (i = 0; i < want; ++i)
-			adap->msix_info[i].vec = entries[i].vector;
-	} else if (err > 0) {
+	want = min(want, err);
+	if (want < need) {
 		dev_info(adap->pdev_dev,
 			 "only %d MSI-X vectors left, not using MSI-X\n", err);
-		err = -ENOSPC;
+		return -ENOSPC;
 	}
-	return err;
+
+	BUG_ON(want > ARRAY_SIZE(entries));
+	for (i = 0; i < want; ++i)
+		entries[i].entry = i;
+
+	err = pci_enable_msix(adap->pdev, entries, want);
+	if (err)
+		return err;
+
+	/*
+	 * Distribute available vectors to the various queue groups.
+	 * Every group gets its minimum requirement and NIC gets top
+	 * priority for leftovers.
+	 */
+	i = want - EXTRA_VECS - ofld_need;
+	if (i < s->max_ethqsets) {
+		s->max_ethqsets = i;
+		if (i < s->ethqsets)
+			reduce_ethqs(adap, i);
+	}
+	if (is_offload(adap)) {
+		i = want - EXTRA_VECS - s->max_ethqsets;
+		i -= ofld_need - nchan;
+		s->ofldqsets = (i / nchan) * nchan;  /* round down */
+	}
+	for (i = 0; i < want; ++i)
+		adap->msix_info[i].vec = entries[i].vector;
+
+	return 0;
 }
 
 #undef EXTRA_VECS
-- 
1.7.7.6
