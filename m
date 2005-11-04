Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2005 17:03:43 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:31979 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3466428AbVKDRDE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2005 17:03:04 +0000
Received: from localhost (p8154-ipad32funabasi.chiba.ocn.ne.jp [221.189.140.154])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 87250A499; Sat,  5 Nov 2005 02:03:54 +0900 (JST)
Date:	Sat, 05 Nov 2005 02:02:54 +0900 (JST)
Message-Id: <20051105.020254.41196576.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] define MAX_UDELAY_MS
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
X-archive-position: 9422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

If HZ was 1000, mdelay(2) cause overflow on multiplication in
__udelay.  We should define MAX_UDELAY_MS properly to prevent this.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/delay.h b/include/asm-mips/delay.h
--- a/include/asm-mips/delay.h
+++ b/include/asm-mips/delay.h
@@ -84,4 +84,13 @@ static inline void __udelay(unsigned lon
 
 #define udelay(usecs) __udelay((usecs),__udelay_val)
 
+/* make sure "usecs *= ..." in udelay do not overflow. */
+#if HZ >= 1000
+#define MAX_UDELAY_MS	1
+#elif HZ <= 200
+#define MAX_UDELAY_MS	5
+#else
+#define MAX_UDELAY_MS	(1000 / HZ)
+#endif
+
 #endif /* _ASM_DELAY_H */
