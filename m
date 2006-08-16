Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Aug 2006 14:30:15 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:64993 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037526AbWHPNaN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Aug 2006 14:30:13 +0100
Received: from localhost (p5040-ipad34funabasi.chiba.ocn.ne.jp [124.85.62.40])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 401418091; Wed, 16 Aug 2006 22:30:09 +0900 (JST)
Date:	Wed, 16 Aug 2006 22:31:51 +0900 (JST)
Message-Id: <20060816.223151.69412453.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060813.223848.25910859.anemo@mba.ocn.ne.jp>
References: <S20037882AbWHMBM6/20060813011258Z+2870@ftp.linux-mips.org>
	<20060813.223848.25910859.anemo@mba.ocn.ne.jp>
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
X-archive-position: 12341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Yet another build fix.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index ccd61f6..e1f35ef 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -335,8 +335,8 @@ void __init r3k_cache_init(void)
 	flush_cache_mm = r3k_flush_cache_mm;
 	flush_cache_range = r3k_flush_cache_range;
 	flush_cache_page = r3k_flush_cache_page;
-	flush_icache_page = r3k_flush_icache_page;
-	__flush_icache_range = r3k_flush_icache_range;
+	__flush_icache_page = r3k_flush_icache_page;
+	flush_icache_range = r3k_flush_icache_range;
 
 	flush_cache_sigtramp = r3k_flush_cache_sigtramp;
 	local_flush_data_cache_page = local_r3k_flush_data_cache_page;
