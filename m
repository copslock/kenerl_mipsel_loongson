Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2010 21:36:17 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37540 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491098Ab0LVUb2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Dec 2010 21:31:28 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id B674C80EC;
        Wed, 22 Dec 2010 21:31:23 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id BF40A1F0001;
        Wed, 22 Dec 2010 21:31:22 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        David Brownell <dbrownell@users.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
Subject: [PATCH v2 11/16] USB: ehci: add workaround for Synopsys HC bug
Date:   Wed, 22 Dec 2010 21:30:56 +0100
Message-Id: <1293049861-28913-12-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1293049861-28913-1-git-send-email-juhosg@openwrt.org>
References: <1293049861-28913-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A10F5977879 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28695
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
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-usb@vger.kernel.org
---

Changes since RFC: ---

Changes since v1:
    - rebased against 2.6.37-rc7

 drivers/usb/host/ehci-q.c |    3 +++
 drivers/usb/host/ehci.h   |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 233c288..343b8de 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -1193,6 +1193,9 @@ static void end_unlink_async (struct ehci_hcd *ehci)
 		ehci->reclaim = NULL;
 		start_unlink_async (ehci, next);
 	}
+
+	if (ehci->has_synopsys_hc_bug)
+		writel((u32)ehci->async->qh_dma, &ehci->regs->async_next);
 }
 
 /* makes sure the async qh will become idle */
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index ba8eab3..6da85b2 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -133,6 +133,7 @@ struct ehci_hcd {			/* one per controller */
 	unsigned		broken_periodic:1;
 	unsigned		fs_i_thresh:1;	/* Intel iso scheduling */
 	unsigned		use_dummy_qh:1;	/* AMD Frame List table quirk*/
+	unsigned		has_synopsys_hc_bug:1; /* Synopsys HC */
 
 	/* required for usb32 quirk */
 	#define OHCI_CTRL_HCFS          (3 << 6)
-- 
1.7.2.1
