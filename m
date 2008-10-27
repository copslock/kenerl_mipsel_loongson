Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 01:30:40 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:58497 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S22453092AbYJ0Baf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Oct 2008 01:30:35 +0000
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id CF5F038C5FBA;
	Mon, 27 Oct 2008 02:30:29 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-Mips List <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] irq handler must disable the handled irq
Date:	Mon, 27 Oct 2008 02:30:26 +0100
Message-Id: <1225071026-32739-1-git-send-email-n0-1@freewrt.org>
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20081026103635.GA10490@linux-mips.org>
References: <20081026103635.GA10490@linux-mips.org>
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/ata/pata_rb532_cf.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index f8b3ffc..a1d44a6 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -116,6 +116,8 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
 		set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
 	}
 
+	disable_irq(irq);
+
 	return IRQ_HANDLED;
 }
 
-- 
1.5.6.4
