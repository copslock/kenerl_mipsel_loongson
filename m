Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:39:06 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36948 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903701Ab2BQKdk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:40 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH 7/9] SERIAL: MIPS: lantiq: convert serial driver to clkdev api
Date:   Fri, 17 Feb 2012 11:33:18 +0100
Message-Id: <1329474800-20979-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Update from old pmu_{dis,en}able() to ckldev api.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-serial@vger.kernel.org
---
This patch should go via MIPS with the rest of the series.

 drivers/tty/serial/lantiq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 96c1cac..136dae8 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -686,7 +686,7 @@ lqasc_probe(struct platform_device *pdev)
 	if (lqasc_port[pdev->id] != NULL)
 		return -EBUSY;
 
-	clk = clk_get(&pdev->dev, "fpi");
+	clk = clk_get_sys("fpi", NULL);
 	if (IS_ERR(clk)) {
 		pr_err("failed to get fpi clk\n");
 		return -ENOENT;
-- 
1.7.7.1
