Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 18:38:32 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:24689 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868563Ab3JBQiZx3QJs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 18:38:25 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92AxGuu002714;
        Wed, 2 Oct 2013 12:59:16 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92AxFne002707;
        Wed, 2 Oct 2013 12:59:15 +0200
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
Subject: [PATCH RFC 59/77] qla2xxx: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:49:15 +0200
Message-Id: <54f6b89372f51cd27a6adf6ecc91b8bf6bb5ba74.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38098
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
 drivers/scsi/qla2xxx/qla_isr.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index df1b30b..6c11ab9 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2836,16 +2836,20 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct rsp_que *rsp)
 	for (i = 0; i < ha->msix_count; i++)
 		entries[i].entry = i;
 
-	ret = pci_enable_msix(ha->pdev, entries, ha->msix_count);
-	if (ret) {
+	ret = pci_msix_table_size(ha->pdev);
+	if (ret < 0) {
+		goto msix_failed;
+	} else {
 		if (ret < MIN_MSIX_COUNT)
 			goto msix_failed;
 
-		ql_log(ql_log_warn, vha, 0x00c6,
-		    "MSI-X: Failed to enable support "
-		    "-- %d/%d\n Retry with %d vectors.\n",
-		    ha->msix_count, ret, ret);
-		ha->msix_count = ret;
+		if (ret < ha->msix_count) {
+			ql_log(ql_log_warn, vha, 0x00c6,
+			    "MSI-X: Failed to enable support "
+			    "-- %d/%d\n Retry with %d vectors.\n",
+			    ha->msix_count, ret, ret);
+			ha->msix_count = ret;
+		}
 		ret = pci_enable_msix(ha->pdev, entries, ha->msix_count);
 		if (ret) {
 msix_failed:
-- 
1.7.7.6
