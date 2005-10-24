Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2005 15:21:29 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:6892 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3465796AbVJXOVC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Oct 2005 15:21:02 +0100
Received: from localhost (p3191-ipad01funabasi.chiba.ocn.ne.jp [61.207.77.191])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D40BEA6A9; Mon, 24 Oct 2005 23:20:58 +0900 (JST)
Date:	Mon, 24 Oct 2005 23:19:53 +0900 (JST)
Message-Id: <20051024.231953.25910234.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] add __user tag to csum_partial_copy_from_user
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
X-archive-position: 9346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add __user tag to csum_partial_copy_from_user to fix some sparse
warnings.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/lib/csum_partial_copy.c b/arch/mips/lib/csum_partial_copy.c
--- a/arch/mips/lib/csum_partial_copy.c
+++ b/arch/mips/lib/csum_partial_copy.c
@@ -33,7 +33,7 @@ unsigned int csum_partial_copy_nocheck(c
  * Copy from userspace and compute checksum.  If we catch an exception
  * then zero the rest of the buffer.
  */
-unsigned int csum_partial_copy_from_user (const unsigned char *src,
+unsigned int csum_partial_copy_from_user (const unsigned char __user *src,
 	unsigned char *dst, int len, unsigned int sum, int *err_ptr)
 {
 	int missing;
diff --git a/include/asm-mips/checksum.h b/include/asm-mips/checksum.h
--- a/include/asm-mips/checksum.h
+++ b/include/asm-mips/checksum.h
@@ -34,8 +34,9 @@ unsigned int csum_partial(const unsigned
  * this is a new version of the above that records errors it finds in *errp,
  * but continues and zeros the rest of the buffer.
  */
-unsigned int csum_partial_copy_from_user(const unsigned char *src, unsigned char *dst, int len,
-                                         unsigned int sum, int *errp);
+unsigned int csum_partial_copy_from_user(const unsigned char __user *src,
+					 unsigned char *dst, int len,
+					 unsigned int sum, int *errp);
 
 /*
  * Copy and checksum to user
