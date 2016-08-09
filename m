Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 14:39:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9555 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992695AbcHIMiOgrtN4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 14:38:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5E43949E7C7B4;
        Tue,  9 Aug 2016 13:37:55 +0100 (IST)
Received: from localhost (10.100.200.230) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 9 Aug
 2016 13:37:58 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/20] usb: host: ehci-sead3: Remove non-DT probe code
Date:   Tue, 9 Aug 2016 13:35:33 +0100
Message-ID: <20160809123546.10190-9-paul.burton@imgtec.com>
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
X-archive-position: 54444
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

Now that the SEAD3 board is probing the EHCI controller using device
tree, remove the non-DT support from the probe function.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/usb/host/ehci-sead3.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/ehci-sead3.c b/drivers/usb/host/ehci-sead3.c
index 05db1ae..b88ecfe 100644
--- a/drivers/usb/host/ehci-sead3.c
+++ b/drivers/usb/host/ehci-sead3.c
@@ -102,18 +102,10 @@ static int ehci_hcd_sead3_drv_probe(struct platform_device *pdev)
 	if (usb_disabled())
 		return -ENODEV;
 
-	if (pdev->dev.of_node) {
-		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-		if (!irq) {
-			dev_err(&pdev->dev, "failed to map IRQ\n");
-			return -ENODEV;
-		}
-	} else {
-		if (pdev->resource[1].flags != IORESOURCE_IRQ) {
-			pr_debug("resource[1] is not IORESOURCE_IRQ");
-			return -ENOMEM;
-		}
-		irq = pdev->resource[1].start;
+	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	if (!irq) {
+		dev_err(&pdev->dev, "failed to map IRQ\n");
+		return -ENODEV;
 	}
 
 	hcd = usb_create_hcd(&ehci_sead3_hc_driver, &pdev->dev, "SEAD-3");
-- 
2.9.2
