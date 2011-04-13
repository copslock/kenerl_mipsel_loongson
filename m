Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2011 10:55:28 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:60092 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491106Ab1DMIyg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Apr 2011 10:54:36 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id A8873140151;
        Wed, 13 Apr 2011 10:54:31 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 26334140119;
        Wed, 13 Apr 2011 10:54:31 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 2/3] USB: ehci: add workaround for Synopsys HC bug
Date:   Wed, 13 Apr 2011 10:54:23 +0200
Message-Id: <1302684864-12484-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1302684864-12484-1-git-send-email-juhosg@openwrt.org>
References: <1302684864-12484-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A11A244AF47 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

A Synopsys USB core used in various SoCs has a bug which might cause
that the host controller not issuing ping.

When software uses the Doorbell mechanism to remove queue heads, the
host controller still has references to the removed queue head even
after indicating an Interrupt on Async Advance. This happens if the last
executed queue head's Next Link queue head is removed.

Consequences of the defect:
The Host controller fetches the removed queue head, using memory that
would otherwise be deallocated.This results in incorrect transactions on
both the USB and system memory. This may result in undefined behavior.

Workarounds:

1) If no queue head is active (no Status field's Active bit is set)
after removing the queue heads, the software can write one of the valid
queue head addresses to the ASYNCLISTADDR register and deallocate the
removed queue head's memory after 2 microframes.

If one or more of the queue heads is active (the Active bit is set in
the Status field) after removing the queue heads, the software can delay
memory deallocation after time X, where X is the time required for the
Host Controller to go through all the queue heads once. X varies with
the number of queue heads and the time required to process periodic
transactions: if more periodic transactions must be performed, the Host
Controller has less time to process asynchronous transaction processing.

2) Do not use the Doorbell mechanism to remove the queue heads. Disable
the Asynchronous Schedule Enable bit instead.

The bug has been discussed on the linux-usb-devel mailing-list
four years ago, the original thread can be found here:
http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg45345.html

This patch implements the first workaround as suggested by David Brownell.

The built-in USB host controller of the Atheros AR7130/AR7141/AR7161 SoCs
requires this to work properly.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
---
Changes since v1:
* use ehci_writel instead of writel

 drivers/usb/host/ehci-ath79.c |    2 ++
 drivers/usb/host/ehci-q.c     |    4 ++++
 drivers/usb/host/ehci.h       |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-ath79.c b/drivers/usb/host/ehci-ath79.c
index 74325b8..7ea23b5 100644
--- a/drivers/usb/host/ehci-ath79.c
+++ b/drivers/usb/host/ehci-ath79.c
@@ -54,6 +54,8 @@ static int ehci_ath79_init(struct usb_hcd *hcd)
 
 	switch (id->driver_data) {
 	case EHCI_ATH79_IP_V1:
+		ehci->has_synopsys_hc_bug = 1;
+
 		ehci->caps = hcd->regs;
 		ehci->regs = hcd->regs +
 			HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 98ded66..6582aea 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -1183,6 +1183,10 @@ static void end_unlink_async (struct ehci_hcd *ehci)
 		ehci->reclaim = NULL;
 		start_unlink_async (ehci, next);
 	}
+
+	if (ehci->has_synopsys_hc_bug)
+		ehci_writel(ehci, (u32) ehci->async->qh_dma,
+			    &ehci->regs->async_next);
 }
 
 /* makes sure the async qh will become idle */
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index f86d3fa..28ef8ca 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -134,6 +134,7 @@ struct ehci_hcd {			/* one per controller */
 	unsigned		amd_pll_fix:1;
 	unsigned		fs_i_thresh:1;	/* Intel iso scheduling */
 	unsigned		use_dummy_qh:1;	/* AMD Frame List table quirk*/
+	unsigned		has_synopsys_hc_bug:1; /* Synopsys HC */
 
 	/* required for usb32 quirk */
 	#define OHCI_CTRL_HCFS          (3 << 6)
-- 
1.7.2.1
