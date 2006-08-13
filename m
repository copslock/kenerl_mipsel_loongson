Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2006 14:37:15 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:987 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037540AbWHMNhO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2006 14:37:14 +0100
Received: from localhost (p4112-ipad28funabasi.chiba.ocn.ne.jp [220.107.203.112])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3A5D0A2C9; Sun, 13 Aug 2006 22:37:07 +0900 (JST)
Date:	Sun, 13 Aug 2006 22:38:48 +0900 (JST)
Message-Id: <20060813.223848.25910859.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20037882AbWHMBM6/20060813011258Z+2870@ftp.linux-mips.org>
References: <S20037882AbWHMBM6/20060813011258Z+2870@ftp.linux-mips.org>
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
X-archive-position: 12326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

One more.

[MIPS] missing bits for "Retire flush_icache_page from mm use."

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index cdb1942..932a09d 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -408,7 +408,7 @@ void __init tx39_cache_init(void)
 		flush_cache_mm = tx39_flush_cache_mm;
 		flush_cache_range = tx39_flush_cache_range;
 		flush_cache_page = tx39_flush_cache_page;
-		flush_icache_page = tx39_flush_icache_page;
+		__flush_icache_page = tx39_flush_icache_page;
 		flush_icache_range = tx39_flush_icache_range;
 
 		flush_cache_sigtramp = tx39_flush_cache_sigtramp;
