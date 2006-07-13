Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2006 15:00:47 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:6852 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133523AbWGMOAi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2006 15:00:38 +0100
Received: from localhost (p7138-ipad202funabasi.chiba.ocn.ne.jp [222.146.78.138])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6D140A9CD; Thu, 13 Jul 2006 23:00:30 +0900 (JST)
Date:	Thu, 13 Jul 2006 23:01:50 +0900 (JST)
Message-Id: <20060713.230150.07642847.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, vagabon.xyz@gmail.com
Subject: [PATCH] sparsemem: fix crash in show_mem
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
X-archive-position: 11989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Resend with proper subject. (old subject was "do not count pages in
holes with sparsemem"


With sparsemem, pfn should be checked by pfn_valid() before pfn_to_page().

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/pgtable.c b/arch/mips/mm/pgtable.c
index 792c6eb..c93aa6c 100644
--- a/arch/mips/mm/pgtable.c
+++ b/arch/mips/mm/pgtable.c
@@ -15,6 +15,8 @@ #ifndef CONFIG_NEED_MULTIPLE_NODES  /* X
 	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
 	pfn = max_mapnr;
 	while (pfn-- > 0) {
+		if (!pfn_valid(pfn))
+			continue;
 		page = pfn_to_page(pfn);
 		total++;
 		if (PageHighMem(page))
