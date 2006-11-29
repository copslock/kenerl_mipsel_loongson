Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2006 19:31:19 +0000 (GMT)
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:45072 "EHLO
	tuxland.pl") by ftp.linux-mips.org with ESMTP id S20027650AbWK2TbO
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Nov 2006 19:31:14 +0000
Received: from [192.168.1.3] (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by tuxland.pl (Postfix) with ESMTP id 1701C6EE9A;
	Wed, 29 Nov 2006 20:30:58 +0100 (CET)
Received: from [192.168.1.3] ([192.168.1.3])
	by tuxland.pl (AISK); Wed, 29 Nov 2006 20:30:57 +0100 (CET)
From:	Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To:	ralf@linux-mips.org
Subject: [PATCH] mips tx4927 missing brace fix
Date:	Wed, 29 Nov 2006 20:30:35 +0100
User-Agent: KMail/1.9.5
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611292030.36170.m.kozlowski@tuxland.pl>
Return-Path: <m.kozlowski@tuxland.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.kozlowski@tuxland.pl
Precedence: bulk
X-list: linux-mips

Hello,

	This patch adds missing brace at the end of toshiba_rbtx4927_irq_isa_init().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2006-11-28 12:16:25.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c	2006-11-29 16:07:11.000000000 +0100
@@ -433,7 +433,7 @@ static void __init toshiba_rbtx4927_irq_
 	/* make sure we are looking at IRR (not ISR) */
 	outb(0x0A, 0x20);
 	outb(0x0A, 0xA0);
-
+}
 #endif
 
 


-- 
Regards,

	Mariusz Kozlowski
