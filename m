Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 May 2007 15:47:41 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:27388 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022866AbXEJOri (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 May 2007 15:47:38 +0100
Received: from localhost (p2187-ipad03funabasi.chiba.ocn.ne.jp [219.160.82.187])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D3DDAB6BC; Thu, 10 May 2007 23:47:33 +0900 (JST)
Date:	Thu, 10 May 2007 23:47:45 +0900 (JST)
Message-Id: <20070510.234745.39152979.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix build error in atomic64_cmpxchg
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
X-archive-position: 15017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/atomic.h b/include/asm-mips/atomic.h
index 62daa74..1b60624 100644
--- a/include/asm-mips/atomic.h
+++ b/include/asm-mips/atomic.h
@@ -689,7 +689,7 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 }
 
 #define atomic64_cmpxchg(v, o, n) \
-	(((__typeof__((v)->counter)))cmpxchg(&((v)->counter), (o), (n)))
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), (new)))
 
 /**
