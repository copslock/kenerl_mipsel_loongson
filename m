Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 15:05:57 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:55033 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022866AbZFCOCj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 15:02:39 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id EA5D5112408B; Wed,  3 Jun 2009 16:02:27 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 7/8] bcm63xx: fix bcm63xx_pcmcia device removal.
Date:	Wed,  3 Jun 2009 16:02:26 +0200
Message-Id: <1244037747-27144-8-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
References: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

Add missing platform_set_drvdata(pdev, NULL) before releasing private
data.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/pcmcia/bcm63xx_pcmcia.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
index 48928b8..2981aff 100644
--- a/drivers/pcmcia/bcm63xx_pcmcia.c
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -455,6 +455,7 @@ static int bcm63xx_drv_pcmcia_remove(struct platform_device *pdev)
 	res = skt->reg_res;
 	release_mem_region(res->start, res->end - res->start + 1);
 	gpio_free(skt->pd->ready_gpio);
+	platform_set_drvdata(pdev, NULL);
 	kfree(skt);
 	return 0;
 }
-- 
1.6.0.4
