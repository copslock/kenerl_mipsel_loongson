Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2007 15:44:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:61424 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022376AbXGVOom (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Jul 2007 15:44:42 +0100
Received: from localhost (p4196-ipad02funabasi.chiba.ocn.ne.jp [61.207.151.196])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9EEEFAE34; Sun, 22 Jul 2007 23:43:19 +0900 (JST)
Date:	Sun, 22 Jul 2007 23:44:20 +0900 (JST)
Message-Id: <20070722.234420.25908731.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] fix section mismatch prom_free_prom_memory()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070722130046.085e0f8d.yoichi_yuasa@tripeaks.co.jp>
References: <20070722130046.085e0f8d.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 15851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 22 Jul 2007 13:00:46 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> Fix section mismatch prom_free_prom_memory().
> 
> WARNING: vmlinux.o(.text+0xbf20): Section mismatch: reference to
> .init.text:prom_free_prom_memory (between 'free_initmem' and 'copy_from_user_page')

prom_free_prom_memory() is called _before_ freeing init sections, so
it is false positive.  __init_refok can be used for such cases.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 4c80528..b8cb0dd 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -484,7 +484,7 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 }
 #endif
 
-void free_initmem(void)
+void __init_refok free_initmem(void)
 {
 	prom_free_prom_memory();
 	free_init_pages("unused kernel memory",
