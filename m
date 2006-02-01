Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 16:24:51 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:16094 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3458481AbWBAQYd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2006 16:24:33 +0000
Received: from localhost (p6192-ipad212funabasi.chiba.ocn.ne.jp [58.91.170.192])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 95CAFA3E4; Thu,  2 Feb 2006 01:29:34 +0900 (JST)
Date:	Thu, 02 Feb 2006 01:29:14 +0900 (JST)
Message-Id: <20060202.012914.63131159.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix dump_tlb.c warning and cleanup
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
X-archive-position: 10283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/lib-32/dump_tlb.c b/arch/mips/lib-32/dump_tlb.c
index 47d7229..7d4c318 100644
--- a/arch/mips/lib-32/dump_tlb.c
+++ b/arch/mips/lib-32/dump_tlb.c
@@ -156,29 +156,26 @@ void dump_list_process(struct task_struc
 	printk("task->mm             == %8p\n", t->mm);
 	//printk("tasks->mm.pgd        == %08x\n", (unsigned int) t->mm->pgd);
 
-	if (addr > KSEG0)
+	if (addr > KSEG0) {
 		page_dir = pgd_offset_k(0);
-	else if (t->mm) {
-		page_dir = pgd_offset(t->mm, 0);
-		printk("page_dir == %08x\n", (unsigned int) page_dir);
-	} else
-		printk("Current thread has no mm\n");
-
-	if (addr > KSEG0)
 		pgd = pgd_offset_k(addr);
-	else if (t->mm) {
+	} else if (t->mm) {
+		page_dir = pgd_offset(t->mm, 0);
 		pgd = pgd_offset(t->mm, addr);
-		printk("pgd == %08x, ", (unsigned int) pgd);
-		pud = pud_offset(pgd, addr);
-		printk("pud == %08x, ", (unsigned int) pud);
-
-		pmd = pmd_offset(pud, addr);
-		printk("pmd == %08x, ", (unsigned int) pmd);
-
-		pte = pte_offset(pmd, addr);
-		printk("pte == %08x, ", (unsigned int) pte);
-	} else
+	} else {
 		printk("Current thread has no mm\n");
+		return;
+	}
+	printk("page_dir == %08x\n", (unsigned int) page_dir);
+	printk("pgd == %08x, ", (unsigned int) pgd);
+	pud = pud_offset(pgd, addr);
+	printk("pud == %08x, ", (unsigned int) pud);
+
+	pmd = pmd_offset(pud, addr);
+	printk("pmd == %08x, ", (unsigned int) pmd);
+
+	pte = pte_offset(pmd, addr);
+	printk("pte == %08x, ", (unsigned int) pte);
 
 	page = *pte;
 #ifdef CONFIG_64BIT_PHYS_ADDR
