Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 19:24:15 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:26037 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868562Ab3JBRYIdPYek (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 19:24:08 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92AtXY2002536;
        Wed, 2 Oct 2013 12:55:34 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92AtOQB002535;
        Wed, 2 Oct 2013 12:55:24 +0200
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
Subject: [PATCH RFC 29/77] cxgb4vf: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:48:45 +0200
Message-Id: <e4d21d117874dbbe4aac4618b3cc3e3d9d0cbeb6.1380703262.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38122
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
 .../net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c    |   49 ++++++++++++--------
 1 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index 11cbce1..48bb33b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -2437,13 +2437,10 @@ static void reduce_ethqs(struct adapter *adapter, int n)
  */
 static int enable_msix(struct adapter *adapter)
 {
-	int i, err, want, need;
+	int i, err, want, need, nqsets;
 	struct msix_entry entries[MSIX_ENTRIES];
 	struct sge *s = &adapter->sge;
 
-	for (i = 0; i < MSIX_ENTRIES; ++i)
-		entries[i].entry = i;
-
 	/*
 	 * We _want_ enough MSI-X interrupts to cover all of our "Queue Sets"
 	 * plus those needed for our "extras" (for example, the firmware
@@ -2453,26 +2450,38 @@ static int enable_msix(struct adapter *adapter)
 	 */
 	want = s->max_ethqsets + MSIX_EXTRAS;
 	need = adapter->params.nports + MSIX_EXTRAS;
-	while ((err = pci_enable_msix(adapter->pdev, entries, want)) >= need)
-		want = err;
 
-	if (err == 0) {
-		int nqsets = want - MSIX_EXTRAS;
-		if (nqsets < s->max_ethqsets) {
-			dev_warn(adapter->pdev_dev, "only enough MSI-X vectors"
-				 " for %d Queue Sets\n", nqsets);
-			s->max_ethqsets = nqsets;
-			if (nqsets < s->ethqsets)
-				reduce_ethqs(adapter, nqsets);
-		}
-		for (i = 0; i < want; ++i)
-			adapter->msix_info[i].vec = entries[i].vector;
-	} else if (err > 0) {
+	err = pci_msix_table_size(adapter->pdev);
+	if (err < 0)
+		return err;
+
+	want = min(want, err);
+	if (want < need) {
 		dev_info(adapter->pdev_dev, "only %d MSI-X vectors left,"
 			 " not using MSI-X\n", err);
-		err = -ENOSPC;
+		return -ENOSPC;
 	}
-	return err;
+
+	BUG_ON(want > ARRAY_SIZE(entries));
+	for (i = 0; i < want; ++i)
+		entries[i].entry = i;
+
+	err = pci_enable_msix(adapter->pdev, entries, want);
+	if (err)
+		return err;
+
+	nqsets = want - MSIX_EXTRAS;
+	if (nqsets < s->max_ethqsets) {
+		dev_warn(adapter->pdev_dev, "only enough MSI-X vectors"
+			 " for %d Queue Sets\n", nqsets);
+		s->max_ethqsets = nqsets;
+		if (nqsets < s->ethqsets)
+			reduce_ethqs(adapter, nqsets);
+	}
+	for (i = 0; i < want; ++i)
+		adapter->msix_info[i].vec = entries[i].vector;
+
+	return 0;
 }
 
 static const struct net_device_ops cxgb4vf_netdev_ops	= {
-- 
1.7.7.6
