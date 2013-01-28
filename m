Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:12:32 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33226 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833267Ab3A1TJ1LStCE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 986C6BF5198;
        Mon, 28 Jan 2013 20:09:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y0dOQ3EumMl2; Mon, 28 Jan 2013 20:09:26 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id CAE52BF5181;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 11/13] USB: EHCI: add ignore_oc flag to disable overcurrent checking
Date:   Mon, 28 Jan 2013 20:06:29 +0100
Message-Id: <1359399991-2236-12-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359399991-2236-1-git-send-email-florian@openwrt.org>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-archive-position: 35593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch adds an ignore_oc flag which can be set by EHCI controller
not supporting or wanting to disable overcurrent checking. The EHCI
platform data in include/linux/usb/ehci_pdriver.h is also augmented to
take advantage of this new flag.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/usb/host/ehci-hcd.c      |    2 +-
 drivers/usb/host/ehci-hub.c      |    4 ++--
 drivers/usb/host/ehci.h          |    1 +
 include/linux/usb/ehci_pdriver.h |    1 +
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index c97503b..bd435ac 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -634,7 +634,7 @@ static int ehci_run (struct usb_hcd *hcd)
 		"USB %x.%x started, EHCI %x.%02x%s\n",
 		((ehci->sbrn & 0xf0)>>4), (ehci->sbrn & 0x0f),
 		temp >> 8, temp & 0xff,
-		ignore_oc ? ", overcurrent ignored" : "");
+		(ignore_oc || ehci->ignore_oc) ? ", overcurrent ignored" : "");
 
 	ehci_writel(ehci, INTR_MASK,
 		    &ehci->regs->intr_enable); /* Turn On Interrupts */
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 4ccb97c..c18d4e4 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -611,7 +611,7 @@ ehci_hub_status_data (struct usb_hcd *hcd, char *buf)
 	 * always set, seem to clear PORT_OCC and PORT_CSC when writing to
 	 * PORT_POWER; that's surprising, but maybe within-spec.
 	 */
-	if (!ignore_oc)
+	if (!ignore_oc && !ehci->ignore_oc)
 		mask = PORT_CSC | PORT_PEC | PORT_OCC;
 	else
 		mask = PORT_CSC | PORT_PEC;
@@ -825,7 +825,7 @@ static int ehci_hub_control (
 		if (temp & PORT_PEC)
 			status |= USB_PORT_STAT_C_ENABLE << 16;
 
-		if ((temp & PORT_OCC) && !ignore_oc){
+		if ((temp & PORT_OCC) && (!ignore_oc && !ehci->ignore_oc)){
 			status |= USB_PORT_STAT_C_OVERCURRENT << 16;
 
 			/*
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 9dadc71..2136479 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -196,6 +196,7 @@ struct ehci_hcd {			/* one per controller */
 	unsigned		use_dummy_qh:1;	/* AMD Frame List table quirk*/
 	unsigned		has_synopsys_hc_bug:1; /* Synopsys HC */
 	unsigned		frame_index_bug:1; /* MosChip (AKA NetMos) */
+	unsigned		ignore_oc:1;
 
 	/* required for usb32 quirk */
 	#define OHCI_CTRL_HCFS          (3 << 6)
diff --git a/include/linux/usb/ehci_pdriver.h b/include/linux/usb/ehci_pdriver.h
index 99238b0..e2a77d3 100644
--- a/include/linux/usb/ehci_pdriver.h
+++ b/include/linux/usb/ehci_pdriver.h
@@ -42,6 +42,7 @@ struct usb_ehci_pdata {
 	unsigned	big_endian_desc:1;
 	unsigned	big_endian_mmio:1;
 	unsigned	no_io_watchdog:1;
+	unsigned	ignore_oc:1;
 
 	/* Turn on all power and clocks */
 	int (*power_on)(struct platform_device *pdev);
-- 
1.7.10.4
