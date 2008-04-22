Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2008 15:58:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:9209 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28578514AbYDVO6l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2008 15:58:41 +0100
Received: from localhost (p7186-ipad207funabasi.chiba.ocn.ne.jp [222.145.89.186])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 78A1AC1DA; Tue, 22 Apr 2008 23:58:30 +0900 (JST)
Date:	Tue, 22 Apr 2008 23:59:30 +0900 (JST)
Message-Id: <20080422.235930.75184305.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] rbtx4938: minor cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Do not initialize res->parent for platform device.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Patch against linux-queue tree.

 arch/mips/tx4938/toshiba_rbtx4938/setup.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index 2fbf7d4..3a3659e 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -1026,7 +1026,6 @@ static void __init txx9_spi_init(unsigned long base, int irq)
 			.start	= base,
 			.end	= base + 0x20 - 1,
 			.flags	= IORESOURCE_MEM,
-			.parent	= &tx4938_reg_resource,
 		}, {
 			.start	= irq,
 			.flags	= IORESOURCE_IRQ,
@@ -1078,7 +1077,6 @@ static int __init txx9_wdt_init(unsigned long base)
 		.start	= base,
 		.end	= base + 0x100 - 1,
 		.flags	= IORESOURCE_MEM,
-		.parent	= &tx4938_reg_resource,
 	};
 	struct platform_device *dev =
 		platform_device_register_simple("txx9wdt", -1, &res, 1);
