Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2005 09:50:08 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:2312
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224945AbVBIJtx>; Wed, 9 Feb 2005 09:49:53 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 9 Feb 2005 09:49:51 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 3DA2F239E2C; Wed,  9 Feb 2005 18:49:48 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j199nlRm056467;
	Wed, 9 Feb 2005 18:49:48 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 09 Feb 2005 18:49:47 +0900 (JST)
Message-Id: <20050209.184947.30439119.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: copy_from_user_page/copy_to_user_page fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Yet another dcache aliasing problem.

Since access_process_vm() in kernel 2.6 does not call
flush_cache_page(), it seems copy_to_user_page()/copy_from_user_page()
should flush data cache to resolve aliasing.

Without this fix, gdb will not work correctly.  Could you apply?

diff -u linux-mips/include/asm-mips/cacheflush.h linux/include/asm-mips/cacheflush.h
--- linux-mips/include/asm-mips/cacheflush.h	2004-08-14 19:55:59.000000000 +0900
+++ linux/include/asm-mips/cacheflush.h	2005-02-09 17:55:39.402702039 +0900
@@ -56,11 +56,17 @@
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len)		\
 do {									\
+	if (cpu_has_dc_aliases)						\
+		flush_cache_page(vma, vaddr);				\
 	memcpy(dst, (void *) src, len);					\
 	flush_icache_page(vma, page);					\
 } while (0)
 #define copy_from_user_page(vma, page, vaddr, dst, src, len)		\
-	memcpy(dst, src, len)
+do {									\
+	if (cpu_has_dc_aliases)						\
+		flush_cache_page(vma, vaddr);				\
+	memcpy(dst, src, len);						\
+} while (0)
 
 extern void (*flush_cache_sigtramp)(unsigned long addr);
 extern void (*flush_icache_all)(void);

---
Atsushi Nemoto
