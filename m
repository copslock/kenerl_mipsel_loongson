Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 14:38:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44637 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992663AbcHIMhp6F1f4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 14:37:45 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 79358DCCD1EDF;
        Tue,  9 Aug 2016 13:37:26 +0100 (IST)
Received: from localhost (10.100.200.230) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 9 Aug
 2016 13:37:29 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/20] usb: host: ehci-sead3: Support probing using device tree
Date:   Tue, 9 Aug 2016 13:35:31 +0100
Message-ID: <20160809123546.10190-7-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160809123546.10190-1-paul.burton@imgtec.com>
References: <20160809123546.10190-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.230]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Introduce support for probing the SEAD3 EHCI driver using device tree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/usb/host/ehci-sead3.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ehci-sead3.c b/drivers/usb/host/ehci-sead3.c
index 3d86cc2..05db1ae 100644
--- a/drivers/usb/host/ehci-sead3.c
+++ b/drivers/usb/host/ehci-sead3.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
 static int ehci_sead3_setup(struct usb_hcd *hcd)
@@ -96,15 +97,25 @@ static int ehci_hcd_sead3_drv_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 	struct resource *res;
-	int ret;
+	int ret, irq;
 
 	if (usb_disabled())
 		return -ENODEV;
 
-	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
-		pr_debug("resource[1] is not IORESOURCE_IRQ");
-		return -ENOMEM;
+	if (pdev->dev.of_node) {
+		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+		if (!irq) {
+			dev_err(&pdev->dev, "failed to map IRQ\n");
+			return -ENODEV;
+		}
+	} else {
+		if (pdev->resource[1].flags != IORESOURCE_IRQ) {
+			pr_debug("resource[1] is not IORESOURCE_IRQ");
+			return -ENOMEM;
+		}
+		irq = pdev->resource[1].start;
 	}
+
 	hcd = usb_create_hcd(&ehci_sead3_hc_driver, &pdev->dev, "SEAD-3");
 	if (!hcd)
 		return -ENOMEM;
@@ -121,8 +132,7 @@ static int ehci_hcd_sead3_drv_probe(struct platform_device *pdev)
 	/* Root hub has integrated TT. */
 	hcd->has_tt = 1;
 
-	ret = usb_add_hcd(hcd, pdev->resource[1].start,
-			  IRQF_SHARED);
+	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret == 0) {
 		platform_set_drvdata(pdev, hcd);
 		device_wakeup_enable(hcd->self.controller);
@@ -172,12 +182,19 @@ static const struct dev_pm_ops sead3_ehci_pmops = {
 #define SEAD3_EHCI_PMOPS NULL
 #endif
 
+static const struct of_device_id sead3_ehci_of_match[] = {
+	{ .compatible = "mti,sead3-ehci" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sead3_ehci_of_match);
+
 static struct platform_driver ehci_hcd_sead3_driver = {
 	.probe		= ehci_hcd_sead3_drv_probe,
 	.remove		= ehci_hcd_sead3_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver = {
 		.name	= "sead3-ehci",
+		.of_match_table = sead3_ehci_of_match,
 		.pm	= SEAD3_EHCI_PMOPS,
 	}
 };
-- 
2.9.2
