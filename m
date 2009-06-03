Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 15:05:33 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:55034 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022867AbZFCOCj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 15:02:39 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id E71A4112408C; Wed,  3 Jun 2009 16:02:27 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 5/8] bcm63xx: request gpio before using it in bcm63xx_pcmcia.
Date:	Wed,  3 Jun 2009 16:02:24 +0200
Message-Id: <1244037747-27144-6-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
References: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

Make sure the gpio is requested and its direction set to input before
using it.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/pcmcia/bcm63xx_pcmcia.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
index 3a0b7fc..6c7f20c 100644
--- a/drivers/pcmcia/bcm63xx_pcmcia.c
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -409,9 +409,18 @@ static int bcm63xx_drv_pcmcia_probe(struct platform_device *pdev)
 	val |= 3 << PCMCIA_C2_HOLD_SHIFT;
 	pcmcia_writel(skt, val, PCMCIA_C2_REG);
 
+	/* request and setup ready gpio */
+	ret = gpio_request(skt->pd->ready_gpio, "bcm63xx_pcmcia");
+	if (ret < 0)
+		goto err;
+
+	ret = gpio_direction_input(skt->pd->ready_gpio);
+	if (ret < 0)
+		goto err_gpio;
+
 	ret = pcmcia_register_socket(sock);
 	if (ret)
-		goto err;
+		goto err_gpio;
 
 	/* start polling socket */
 	mod_timer(&skt->timer,
@@ -420,6 +429,9 @@ static int bcm63xx_drv_pcmcia_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, skt);
 	return 0;
 
+err_gpio:
+	gpio_free(skt->pd->ready_gpio);
+
 err:
 	if (skt->io_base)
 		iounmap(skt->io_base);
@@ -442,6 +454,7 @@ static int bcm63xx_drv_pcmcia_remove(struct platform_device *pdev)
 	iounmap(skt->io_base);
 	res = skt->reg_res;
 	release_mem_region(res->start, res->end - res->start + 1);
+	gpio_free(skt->pd->ready_gpio);
 	kfree(skt);
 	return 0;
 }
-- 
1.6.0.4
