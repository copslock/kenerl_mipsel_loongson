Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2007 17:11:40 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:6101 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038416AbXBURLe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2007 17:11:34 +0000
Received: from localhost (p7058-ipad205funabasi.chiba.ocn.ne.jp [222.146.102.58])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E1B0C82FB; Thu, 22 Feb 2007 02:10:14 +0900 (JST)
Date:	Thu, 22 Feb 2007 02:10:14 +0900 (JST)
Message-Id: <20070222.021014.85684636.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix mmiowb() for MIPS I
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
X-archive-position: 14190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The SYNC instruction is not available on MIPS I.  Use __sync() instead.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index 92ec261..855c304 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -502,8 +502,7 @@ BUILDSTRING(q, u64)
 #endif
 
 
-/* Depends on MIPS II instruction set */
-#define mmiowb() asm volatile ("sync" ::: "memory")
+#define mmiowb() __sync()
 
 static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
