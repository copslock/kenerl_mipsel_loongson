Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Nov 2005 14:58:33 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:34007 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133649AbVKFO6Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 6 Nov 2005 14:58:16 +0000
Received: from localhost (p6072-ipad209funabasi.chiba.ocn.ne.jp [58.88.117.72])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D69AEA7EC; Sun,  6 Nov 2005 23:59:19 +0900 (JST)
Date:	Sun, 06 Nov 2005 23:58:21 +0900 (JST)
Message-Id: <20051106.235821.108306460.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Redefine outs[wl] for ide_outs[wl].
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
X-archive-position: 9429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add missing bits to fix D-cache aliasing problem in the PIO IDE driver.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/mach-generic/ide.h b/include/asm-mips/mach-generic/ide.h
index 9610069..550979a 100644
--- a/include/asm-mips/mach-generic/ide.h
+++ b/include/asm-mips/mach-generic/ide.h
@@ -168,8 +168,12 @@ static inline void __ide_mm_outsl(void _
 /* ide_insw calls insw, not __ide_insw.  Why? */
 #undef insw
 #undef insl
+#undef outsw
+#undef outsl
 #define insw(port, addr, count) __ide_insw(port, addr, count)
 #define insl(port, addr, count) __ide_insl(port, addr, count)
+#define outsw(port, addr, count) __ide_outsw(port, addr, count)
+#define outsl(port, addr, count) __ide_outsl(port, addr, count)
 
 #endif /* __KERNEL__ */
 
