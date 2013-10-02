Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 18:52:10 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:24852 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6815749Ab3JBQwGzb2Rr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 18:52:06 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92Asnrp002503;
        Wed, 2 Oct 2013 12:54:49 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92AslOm002502;
        Wed, 2 Oct 2013 12:54:47 +0200
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
Subject: [PATCH RFC 24/77] cxgb3: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:48:40 +0200
Message-Id: <a23ee43c52ece3e83885caff72ae2f2cfe0de935.1380703262.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38106
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
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c |   29 ++++++++++++-----------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 915729c..bf14fd6 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -3090,25 +3090,26 @@ static int cxgb_enable_msix(struct adapter *adap)
 	int vectors;
 	int i, err;
 
-	vectors = ARRAY_SIZE(entries);
+	err = pci_msix_table_size(adap->pdev);
+	if (err < 0)
+		return err;
+
+	vectors = min_t(int, err, ARRAY_SIZE(entries));
+	if (vectors < (adap->params.nports + 1))
+		return -ENOSPC;
+
 	for (i = 0; i < vectors; ++i)
 		entries[i].entry = i;
 
-	while ((err = pci_enable_msix(adap->pdev, entries, vectors)) > 0)
-		vectors = err;
-
-	if (!err && vectors < (adap->params.nports + 1)) {
-		pci_disable_msix(adap->pdev);
-		err = -ENOSPC;
-	}
+	err = pci_enable_msix(adap->pdev, entries, vectors);
+	if (err)
+		return err;
 
-	if (!err) {
-		for (i = 0; i < vectors; ++i)
-			adap->msix_info[i].vec = entries[i].vector;
-		adap->msix_nvectors = vectors;
-	}
+	for (i = 0; i < vectors; ++i)
+		adap->msix_info[i].vec = entries[i].vector;
+	adap->msix_nvectors = vectors;
 
-	return err;
+	return 0;
 }
 
 static void print_port_info(struct adapter *adap, const struct adapter_info *ai)
-- 
1.7.7.6
