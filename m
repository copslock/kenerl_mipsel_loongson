Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 16:43:41 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:50429 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039104AbXB0QnO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Feb 2007 16:43:14 +0000
Received: from localhost (p6238-ipad203funabasi.chiba.ocn.ne.jp [222.146.85.238])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 16862BDB5; Wed, 28 Feb 2007 01:41:54 +0900 (JST)
Date:	Wed, 28 Feb 2007 01:41:53 +0900 (JST)
Message-Id: <20070228.014153.71085781.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: [PATCH] jmr3927: do not call tc35815_killall()
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
X-archive-position: 14259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

No need to stop tc35815 before resetting the board.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index 7ca3d6d..ecabe5b 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -137,10 +137,6 @@ int jmr3927_ccfg_toeon = 0;
 
 static inline void do_reset(void)
 {
-#ifdef CONFIG_TC35815
-	extern void tc35815_killall(void);
-	tc35815_killall();
-#endif
 #if 1	/* Resetting PCI bus */
 	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
 	jmr3927_ioc_reg_out(JMR3927_IOC_RESET_PCI, JMR3927_IOC_RESET_ADDR);
