Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 07:36:16 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:32799 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133381AbWBNHf7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 07:35:59 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 14 Feb 2006 16:42:19 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 6D06B20356;
	Tue, 14 Feb 2006 16:42:17 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 6267E1FFEB;
	Tue, 14 Feb 2006 16:42:17 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1E7gG4D075294;
	Tue, 14 Feb 2006 16:42:16 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 14 Feb 2006 16:42:16 +0900 (JST)
Message-Id: <20060214.164216.48797359.nemoto@toshiba-tops.co.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200602140707.k1E77Tah013064@mbox00.po.2iij.net>
References: <20060214112653.25ed3e05.yoichi_yuasa@tripeaks.co.jp>
	<20060214.120846.15248106.nemoto@toshiba-tops.co.jp>
	<200602140707.k1E77Tah013064@mbox00.po.2iij.net>
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
X-archive-position: 10450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 14 Feb 2006 16:07:29 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> said:
yuasa> I added the patch and tested it.  It has same problem.

Thank you.  I realize the reason just now.  VR41XX's PTE format is a
bit different from others.  I should use mk_pte() to wrap these
difference.

Could you try this patch?  64BIT_PHYS_ADDR + MIPS32_R1 part are not
tested ;-)

--- linux-mips/arch/mips/mm/init.c	2006-02-14 15:30:58.000000000 +0900
+++ linux/arch/mips/mm/init.c	2006-02-14 16:29:51.000000000 +0900
@@ -95,6 +95,7 @@ static inline void *kmap_coherent(struct
 	unsigned long asid;
 	unsigned int vpflags;
 	unsigned int wired;
+	pte_t pte;
 
 	if (!cpu_has_dc_aliases)
 		return page_address(page);
@@ -111,8 +112,13 @@ static inline void *kmap_coherent(struct
 	wired = read_c0_wired();
 	write_c0_wired(wired + 1);
 	write_c0_index(wired);
-	write_c0_entryhi(vaddr & ~0x1fffUL);
-	entrylo = (page_to_pfn(page) << 6) | (pgprot_val(PAGE_KERNEL) >> 6);
+	write_c0_entryhi(vaddr & (PAGE_MASK << 1));
+	pte = mk_pte(page, PAGE_KERNEL);
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
+	entrylo = pte.pte_high;
+#else
+	entrylo = pte_val(pte) >> 6;
+#endif
 	write_c0_entrylo0(entrylo);
 	write_c0_entrylo1(entrylo);
 	mtc0_tlbw_hazard();
