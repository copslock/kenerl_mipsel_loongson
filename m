Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 18:37:08 +0200 (CEST)
Received: from 221-186-24-89.in-addr.arpa ([89.24.186.221]:24672 "EHLO
        dhcp-26-207.brq.redhat.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6868563Ab3JBQgya2uGq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 18:36:54 +0200
Received: from dhcp-26-207.brq.redhat.com (localhost [127.0.0.1])
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5) with ESMTP id r92B062B002767;
        Wed, 2 Oct 2013 13:00:06 +0200
Received: (from agordeev@localhost)
        by dhcp-26-207.brq.redhat.com (8.14.5/8.14.5/Submit) id r92B046C002766;
        Wed, 2 Oct 2013 13:00:04 +0200
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
Subject: [PATCH RFC 70/77] vmci: Update MSI/MSI-X interrupts enablement code
Date:   Wed,  2 Oct 2013 12:49:26 +0200
Message-Id: <654a7884b9ad6fbe777d00bb0a226010e421b3b9.1380703263.git.agordeev@redhat.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38097
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
 drivers/misc/vmw_vmci/vmci_guest.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index b3a2b76..af5caf8 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -377,19 +377,27 @@ static int vmci_enable_msix(struct pci_dev *pdev,
 {
 	int i;
 	int result;
+	int nvec;
 
-	for (i = 0; i < VMCI_MAX_INTRS; ++i) {
+	result = pci_msix_table_size(pdev);
+	if (result < 0)
+		return result;
+
+	nvec = min(result, VMCI_MAX_INTRS);
+	if (nvec < VMCI_MAX_INTRS)
+		nvec = 1;
+
+	for (i = 0; i < nvec; ++i) {
 		vmci_dev->msix_entries[i].entry = i;
 		vmci_dev->msix_entries[i].vector = i;
 	}
 
-	result = pci_enable_msix(pdev, vmci_dev->msix_entries, VMCI_MAX_INTRS);
-	if (result == 0)
-		vmci_dev->exclusive_vectors = true;
-	else if (result > 0)
-		result = pci_enable_msix(pdev, vmci_dev->msix_entries, 1);
+	result = pci_enable_msix(pdev, vmci_dev->msix_entries, nvec);
+	if (result)
+		return result;
 
-	return result;
+	vmci_dev->exclusive_vectors = true;
+	return 0;
 }
 
 /*
-- 
1.7.7.6
