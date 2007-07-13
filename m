Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 16:07:12 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:30185 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023700AbXGMPHK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2007 16:07:10 +0100
Received: from localhost (p3184-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.184])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1C9EA72A4; Sat, 14 Jul 2007 00:05:49 +0900 (JST)
Date:	Sat, 14 Jul 2007 00:06:44 +0900 (JST)
Message-Id: <20070714.000644.11621589.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Workaround for a sparse warning in
 include/asm-mips/mach-tx4927/ioremap.h
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
X-archive-position: 15777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

include2/asm/mach-tx49xx/ioremap.h:39:52: warning: cast truncates bits from constant value (fff000000 becomes ff000000)

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/mach-tx49xx/ioremap.h b/include/asm-mips/mach-tx49xx/ioremap.h
index 88cf546..1e7beae 100644
--- a/include/asm-mips/mach-tx49xx/ioremap.h
+++ b/include/asm-mips/mach-tx49xx/ioremap.h
@@ -36,7 +36,8 @@ static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
 
 static inline int plat_iounmap(const volatile void __iomem *addr)
 {
-	return (unsigned long)addr >= (unsigned long)(int)TXX9_DIRECTMAP_BASE;
+	return (unsigned long)addr >=
+		(unsigned long)(int)(TXX9_DIRECTMAP_BASE & 0xffffffff);
 }
 
 #endif /* __ASM_MACH_TX49XX_IOREMAP_H */
