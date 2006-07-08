Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jul 2006 17:02:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:11731 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133540AbWGHQCE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 8 Jul 2006 17:02:04 +0100
Received: from localhost (p5177-ipad202funabasi.chiba.ocn.ne.jp [222.146.76.177])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3425CB258; Sun,  9 Jul 2006 01:01:59 +0900 (JST)
Date:	Sun, 09 Jul 2006 01:03:16 +0900 (JST)
Message-Id: <20060709.010316.126574153.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80607080739i772d439dqc4e06a8b275e03ee@mail.gmail.com>
References: <cda58cb80607060805yc656114p53516b904188c20f@mail.gmail.com>
	<20060707.002602.75184460.anemo@mba.ocn.ne.jp>
	<cda58cb80607080739i772d439dqc4e06a8b275e03ee@mail.gmail.com>
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
X-archive-position: 11945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 8 Jul 2006 16:39:44 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> Did you check that show_mem() still works ? I'm not sure about that point.

It should work, but this patch would make the output a bit better.

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
