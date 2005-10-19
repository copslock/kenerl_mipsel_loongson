Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 11:56:25 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:43530 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S3465576AbVJSK4J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Oct 2005 11:56:09 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 19 Oct 2005 10:57:17 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id F0EBB1FEE3;
	Wed, 19 Oct 2005 19:57:14 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id DE8A41FECA;
	Wed, 19 Oct 2005 19:57:14 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j9JAvEA9003155;
	Wed, 19 Oct 2005 19:57:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 19 Oct 2005 19:57:14 +0900 (JST)
Message-Id: <20051019.195714.89066462.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Fix zero length sys_cacheflush
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
X-archive-position: 9267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found cacheflush(0, 0, 0) will crash the system.

This is because flush_icache_range(start, end) tries to flushing whole
address space (0 - ffffffff) if both start and end are zero (at least
in c-r4k.c).

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -56,6 +56,8 @@ EXPORT_SYMBOL(_dma_cache_inv);
 asmlinkage int sys_cacheflush(unsigned long __user addr,
 	unsigned long bytes, unsigned int cache)
 {
+	if (bytes == 0)
+		return 0;
 	if (!access_ok(VERIFY_WRITE, (void __user *) addr, bytes))
 		return -EFAULT;
 
