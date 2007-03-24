Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 15:15:56 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:52945 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022738AbXCXPPy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Mar 2007 15:15:54 +0000
Received: from localhost (p2115-ipad205funabasi.chiba.ocn.ne.jp [222.146.97.115])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4C1D38583; Sun, 25 Mar 2007 00:14:34 +0900 (JST)
Date:	Sun, 25 Mar 2007 00:14:33 +0900 (JST)
Message-Id: <20070325.001433.108739347.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Implement flush_anon_page().
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20022532AbXCWXgp/20070323233645Z+1432@ftp.linux-mips.org>
References: <S20022532AbXCWXgp/20070323233645Z+1432@ftp.linux-mips.org>
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
X-archive-position: 14660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Move an external declaration of __flush_anon_page() to toplevel to
avoid this sparse warning:

linux/arch/mips/mm/cache.c:92:6: warning: symbol '__flush_anon_page' was not declared. Should it be static?

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/cacheflush.h b/include/asm-mips/cacheflush.h
index 78a624d..28d907d 100644
--- a/include/asm-mips/cacheflush.h
+++ b/include/asm-mips/cacheflush.h
@@ -49,11 +49,10 @@ static inline void flush_dcache_page(str
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
 #define ARCH_HAS_FLUSH_ANON_PAGE
+extern void __flush_anon_page(struct page *, unsigned long);
 static inline void flush_anon_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vmaddr)
 {
-	extern void __flush_anon_page(struct page *, unsigned long);
-
 	if (cpu_has_dc_aliases && PageAnon(page))
 		__flush_anon_page(page, vmaddr);
 }
