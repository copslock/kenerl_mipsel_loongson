Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 17:26:14 +0200 (CEST)
Received: from isis.lip6.fr ([132.227.60.2]:55289 "EHLO isis.lip6.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859949AbaGRP0JKeVRl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Jul 2014 17:26:09 +0200
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.14.7/lip6) with ESMTP id s6IFQ7Vx017616
          ; Fri, 18 Jul 2014 17:26:07 +0200 (CEST)
X-pt:   isis.lip6.fr
Received: from localhost.localdomain (AMontsouris-651-1-237-186.w86-212.abo.wanadoo.fr [86.212.100.186])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by systeme.lip6.fr (Postfix) with ESMTPSA id C8DA96317;
        Fri, 18 Jul 2014 17:26:07 +0200 (CEST)
From:   Benoit Taine <benoit.taine@lip6.fr>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     benoit.taine@lip6.fr, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/25] net/ethernet/sgi/ioc3-eth: Replace DEFINE_PCI_DEVICE_TABLE macro use
Date:   Fri, 18 Jul 2014 17:26:52 +0200
Message-Id: <1405697232-11785-6-git-send-email-benoit.taine@lip6.fr>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 18 Jul 2014 17:26:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.74 on 132.227.60.2
Return-Path: <benoit.taine@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benoit.taine@lip6.fr
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

We should prefer `struct pci_device_id` over `DEFINE_PCI_DEVICE_TABLE` to meet
kernel coding style guidelines. This issue was reported by checkpatch.

Signed-off-by: Benoit Taine <benoit.taine@lip6.fr>

---
Not tested.

 drivers/net/ethernet/sgi/ioc3-eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 7984ad0..7a254da 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -1384,7 +1384,7 @@ static void ioc3_remove_one(struct pci_dev *pdev)
 	 */
 }
 
-static DEFINE_PCI_DEVICE_TABLE(ioc3_pci_tbl) = {
+static const struct pci_device_id ioc3_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, PCI_ANY_ID, PCI_ANY_ID },
 	{ 0 }
 };
