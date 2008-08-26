Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 14:30:47 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:64227 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031026AbYHZNap (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 14:30:45 +0100
Received: from localhost (p1241-ipad305funabasi.chiba.ocn.ne.jp [123.217.163.241])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8F3B4BE9C; Tue, 26 Aug 2008 22:30:40 +0900 (JST)
Date:	Tue, 26 Aug 2008 22:30:41 +0900 (JST)
Message-Id: <20080826.223041.51865296.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Add missing local_flush_icache_range initialization for
 TX39
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
X-archive-position: 20359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The commmit 59e39ecd933ba49eb6efe84cbfa5597a6c9ef18a ("Fix WARNING: at
kernel/smp.c:290") introduced local_flush_icache_range but lacks
initialization for some TX39 case.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 39c8182..f7c8f9c 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -391,6 +391,7 @@ void __cpuinit tx39_cache_init(void)
 		flush_cache_range = tx39_flush_cache_range;
 		flush_cache_page = tx39_flush_cache_page;
 		flush_icache_range = tx39_flush_icache_range;
+		local_flush_icache_range = tx39_flush_icache_range;
 
 		flush_cache_sigtramp = tx39_flush_cache_sigtramp;
 		local_flush_data_cache_page = local_tx39_flush_data_cache_page;
