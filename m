Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 18:12:29 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:42524 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025627AbZFARIY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 18:08:24 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 2C9B0112406C; Mon,  1 Jun 2009 19:08:15 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] bcm63xx: remove duplicate init fields.
Date:	Mon,  1 Jun 2009 19:08:07 +0200
Message-Id: <1243876095-8987-2-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
References: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

This patch removes duplicate init fields in resource.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/dev-enet.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
index 51c2e5a..188fa66 100644
--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -42,12 +42,10 @@ static struct resource enet0_res[] = {
 	},
 	{
 		.start		= -1, /* filled at runtime */
-		.start		= IRQ_ENET0_RXDMA,
 		.flags		= IORESOURCE_IRQ,
 	},
 	{
 		.start		= -1, /* filled at runtime */
-		.start		= IRQ_ENET0_TXDMA,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
-- 
1.6.0.4
