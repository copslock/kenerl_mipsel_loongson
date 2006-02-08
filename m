Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2006 15:52:33 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:6634 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3467572AbWBHPwS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2006 15:52:18 +0000
Received: from localhost (p8063-ipad01funabasi.chiba.ocn.ne.jp [61.207.82.63])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 82DB3A4B0; Thu,  9 Feb 2006 00:58:02 +0900 (JST)
Date:	Thu, 09 Feb 2006 00:57:44 +0900 (JST)
Message-Id: <20060209.005744.130846941.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] add 'const' to readb and friends
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
X-archive-position: 10371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index c16d54f..0ec40f9 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -342,7 +342,7 @@ static inline void pfx##write##bwlq(type
 		BUG();							\
 }									\
 									\
-static inline type pfx##read##bwlq(volatile void __iomem *mem)		\
+static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 {									\
 	volatile type *__mem;						\
 	type __val;							\
