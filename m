Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 15:50:49 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:30926 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021821AbXGMOur (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2007 15:50:47 +0100
Received: from localhost (p3184-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.184])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5FB52B5E9; Fri, 13 Jul 2007 23:50:43 +0900 (JST)
Date:	Fri, 13 Jul 2007 23:51:38 +0900 (JST)
Message-Id: <20070713.235138.52129416.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Workaround for a sparse warning in
 include/asm-mips/compat.h
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
X-archive-position: 15773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Cast to a __user pointer via "unsigned long" to get rid of this warning:

include2/asm/compat.h:135:10: warning: cast adds address space to expression (<asn:1>)

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/compat.h b/include/asm-mips/compat.h
index 432653d..67c3f8e 100644
--- a/include/asm-mips/compat.h
+++ b/include/asm-mips/compat.h
@@ -132,7 +132,8 @@ typedef u32		compat_uptr_t;
 
 static inline void __user *compat_ptr(compat_uptr_t uptr)
 {
-	return (void __user *)(long)uptr;
+	/* cast to a __user pointer via "unsigned long" makes sparse happy */
+	return (void __user *)(unsigned long)(long)uptr;
 }
 
 static inline compat_uptr_t ptr_to_compat(void __user *uptr)
