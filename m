Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 14:49:48 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:43999 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038835AbXBLOtq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2007 14:49:46 +0000
Received: from localhost (p7240-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BD5D2B6B9; Mon, 12 Feb 2007 23:48:26 +0900 (JST)
Date:	Mon, 12 Feb 2007 23:48:26 +0900 (JST)
Message-Id: <20070212.234826.59032634.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, vagabon.xyz@gmail.com
Subject: [PATCH] fix irq handling of DECstations
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

It looks 2.6.19 or 2.6.20 does not work on DECStations.

When I post a patch (commit f431baa55abf8adeed0c718b51deacbc151f58f1),
I just tried to not change behavior of existing codes, but it seems
dec/int-handler.S had been broken since its previous commit
937a801576f954bd030d7c4a5a94571710d87c0b.

The caller of plat_irq_dispatch do setup/restore TI_REGS($28), so
dec's plat_irq_dispatch should not do it, and there is no need to
adjust RA.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/dec/int-handler.S b/arch/mips/dec/int-handler.S
index b251ef8..00cecdc 100644
--- a/arch/mips/dec/int-handler.S
+++ b/arch/mips/dec/int-handler.S
@@ -264,9 +264,6 @@
 		 srlv	t3,t1,t2
 
 handle_it:
-		LONG_L	s0, TI_REGS($28)
-		LONG_S	sp, TI_REGS($28)
-		PTR_LA	ra, ret_from_irq
 		j	dec_irq_dispatch
 		 nop
 
@@ -277,7 +274,6 @@ fpu:
 #endif
 
 spurious:
-		PTR_LA	ra, _ret_from_irq
 		j	spurious_interrupt
 		 nop
 		END(plat_irq_dispatch)
