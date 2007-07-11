Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 15:11:16 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:24804 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021499AbXGKOLN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2007 15:11:13 +0100
Received: from localhost (p7242-ipad32funabasi.chiba.ocn.ne.jp [221.189.139.242])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3D4E3B5F6; Wed, 11 Jul 2007 23:11:07 +0900 (JST)
Date:	Wed, 11 Jul 2007 23:12:00 +0900 (JST)
Message-Id: <20070711.231200.05599385.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Workaround for a sparse warning in include/asm-mips/io.h
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
X-archive-position: 15690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

CKSEG1ADDR() returns unsigned int value on 32bit kernel.  Cast it to
unsigned long to get rid of this warning:

include2/asm/io.h:215:12: warning: cast adds address space to expression (<asn:2>)

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index 12bcc1f..7ba9289 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -212,7 +212,8 @@ static inline void __iomem * __ioremap_mode(phys_t offset, unsigned long size,
 		 */
 		if (__IS_LOW512(phys_addr) && __IS_LOW512(last_addr) &&
 		    flags == _CACHE_UNCACHED)
-			return (void __iomem *)CKSEG1ADDR(phys_addr);
+			return (void __iomem *)
+				(unsigned long)CKSEG1ADDR(phys_addr);
 	}
 
 	return __ioremap(offset, size, flags);
