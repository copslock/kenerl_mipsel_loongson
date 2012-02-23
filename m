Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:08:44 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47373 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903759Ab2BWQDf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:03:35 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH V2 09/14] SERIAL: MIPS: lantiq: convert serial driver to clkdev api
Date:   Thu, 23 Feb 2012 17:03:08 +0100
Message-Id: <1330012993-13510-9-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Reference the FPI clock via its new access function.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/lantiq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 96c1cac..99fb70f 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -686,7 +686,7 @@ lqasc_probe(struct platform_device *pdev)
 	if (lqasc_port[pdev->id] != NULL)
 		return -EBUSY;
 
-	clk = clk_get(&pdev->dev, "fpi");
+	clk = clk_get_fpi();
 	if (IS_ERR(clk)) {
 		pr_err("failed to get fpi clk\n");
 		return -ENOENT;
-- 
1.7.7.1
