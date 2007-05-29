Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 May 2007 15:29:47 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:23031 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022730AbXE2O3m (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 May 2007 15:29:42 +0100
Received: from localhost (p1139-ipad32funabasi.chiba.ocn.ne.jp [221.189.133.139])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DCAF7B7B5; Tue, 29 May 2007 23:29:38 +0900 (JST)
Date:	Tue, 29 May 2007 23:30:04 +0900 (JST)
Message-Id: <20070529.233004.07457066.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Add whitelists for checksyscalls.sh
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
X-archive-position: 15186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/unistd.h b/include/asm-mips/unistd.h
index 91c306f..4aab8f9 100644
--- a/include/asm-mips/unistd.h
+++ b/include/asm-mips/unistd.h
@@ -977,6 +977,22 @@
 #  define __ARCH_WANT_COMPAT_SYS_TIME
 # endif
 
+/* whitelists for checksyscalls */
+#define __IGNORE_select
+#define __IGNORE_vfork
+#define __IGNORE_time
+#define __IGNORE_uselib
+#define __IGNORE_fadvise64_64
+#define __IGNORE_getdents64
+#if _MIPS_SIM == _MIPS_SIM_NABI32
+#define __IGNORE_truncate64
+#define __IGNORE_ftruncate64
+#define __IGNORE_stat64
+#define __IGNORE_lstat64
+#define __IGNORE_fstat64
+#define __IGNORE_fstatat64
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 /*
