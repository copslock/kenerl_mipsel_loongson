Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2015 22:36:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:57994 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010614AbbJYVfodusWR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2015 22:35:44 +0100
X-IronPort-AV: E=Sophos;i="5.20,198,1444687200"; 
   d="scan'208";a="184387752"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 25 Oct 2015 22:35:38 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 1/1] MIPS: pci-rt3883: drop unneeded of_node_get
Date:   Sun, 25 Oct 2015 22:24:25 +0100
Message-Id: <1445808265-10394-2-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1445808265-10394-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1445808265-10394-1-git-send-email-Julia.Lawall@lip6.fr>
Return-Path: <Julia.Lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Julia.Lawall@lip6.fr
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

for_each_child_of_node performs an of_node_get on each iteration, so no
of_node_get is needed on breaking out of the loop when the device_node
structure is saved in another variable.

A simplified semantic match that finds this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root;
local idexpression child;
@@

 for_each_child_of_node(root, child) {
   ...
*  of_node_get(child)
   ...
   break;
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/mips/pci/pci-rt3883.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index ed6732f..53a42b0 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -432,8 +432,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 
 	/* find the interrupt controller child node */
 	for_each_child_of_node(np, child) {
-		if (of_get_property(child, "interrupt-controller", NULL) &&
-		    of_node_get(child)) {
+		if (of_get_property(child, "interrupt-controller", NULL)) {
 			rpc->intc_of_node = child;
 			break;
 		}
@@ -449,8 +448,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 	/* find the PCI host bridge child node */
 	for_each_child_of_node(np, child) {
 		if (child->type &&
-		    of_node_cmp(child->type, "pci") == 0 &&
-		    of_node_get(child)) {
+		    of_node_cmp(child->type, "pci") == 0) {
 			rpc->pci_controller.of_node = child;
 			break;
 		}
