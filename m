Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Oct 2010 14:03:35 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:62991 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491205Ab0JIMDc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Oct 2010 14:03:32 +0200
Received: by iwn2 with SMTP id 2so1220904iwn.36
        for <multiple recipients>; Sat, 09 Oct 2010 05:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=OkDLex9C9cQcM3JFDjktjKBwxOMp2QDyfGMuPIjBvqA=;
        b=YXD1hYsuva0pnTVkZqIAs1fi65uBFGX1gZp5hBE8z8UzC1Vd/H/Nl+sSVfmq3jpqnM
         Oz9bLtlgrLv1ZLQ6W/97Cg0G/spR387HvrWZ0tb75xUdLj4SUz/WqciA8hJzn9SrA9KF
         qO0+N1I1dEHnq/E0OPnBeb7LqfexpoVf4e1GM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=LhfZ9V4ixXRAnWH0oYCF0JN7aniFDejnDqd75rmiG5wnHvv93jNxv8DtXx9EBrtuAk
         hH6xbbCsYJ/tXr+NWoJrCrx6e1CcyYDQbFvWcxqGWgdcFyd5OZpEERrRxELK+SCWxMp5
         DmHsadmH/sxoPsyZQdGl8Cp2kjawCftSp4MD0=
Received: by 10.231.155.206 with SMTP id t14mr3163004ibw.34.1286625808928;
 Sat, 09 Oct 2010 05:03:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.130.132 with HTTP; Sat, 9 Oct 2010 05:03:08 -0700 (PDT)
From:   Dragos Tatulea <dragos.tatulea@gmail.com>
Date:   Sat, 9 Oct 2010 14:03:08 +0200
Message-ID: <AANLkTimhn4JFN+kPsm36qJ6Pu=P0GcNM9RLO3LaN+x0V@mail.gmail.com>
Subject: RFC: add code to dump the kernel page tables for visual inspection by
 kernel developers
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dragos.tatulea@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dragos.tatulea@gmail.com
Precedence: bulk
X-list: linux-mips

On the linux-mips.org TODO list, there's the $SUBJ item. Ralf B.
hinted that a good starting point would be the dump_list_process
function which was removed in 2.6.23 (during lib-32 & lib-64 merge?).
This patch is just a copy paste from the lib-64 version of this
function (with small modifications for 32 bit compatibility).

Any other interesting "features" that should get in?

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 3f69725..7d705c8 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -6,6 +6,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/sched.h>

 #include <asm/mipsregs.h>
 #include <asm/page.h>
@@ -109,3 +110,71 @@ void dump_tlb_all(void)
 {
 	dump_tlb(0, current_cpu_data.tlbsize - 1);
 }
+
+void dump_list_process(struct task_struct *t, void *address)
+{
+	pgd_t	*page_dir, *pgd;
+	pud_t	*pud;
+	pmd_t	*pmd;
+	pte_t	*pte, page;
+	unsigned long addr, val;
+	int width;
+
+#if defined(CONFIG_64BIT)
+	width = 16;
+#else
+	width = 8;
+#endif
+
+	addr = (unsigned long) address;
+
+	printk("Addr                 == %0*lx\n", width, addr);
+	printk("tasks->mm.pgd        == %0*lx\n", width,
+	       (unsigned long) t->mm->pgd);
+
+	page_dir = pgd_offset(t->mm, 0UL);
+	printk("page_dir == %0*lx\n", width, (unsigned long) page_dir);
+
+	pgd = pgd_offset(t->mm, addr);
+	printk("pgd == %0*lx\n", width, (unsigned long) pgd);
+
+	pud = pud_offset(pgd, addr);
+	printk("pud == %0*lx\n", width, (unsigned long) pud);
+
+	pmd = pmd_offset(pud, addr);
+	printk("pmd == %0*lx\n", width, (unsigned long) pmd);
+
+	pte = pte_offset(pmd, addr);
+	printk("pte == %0*lx\n", width, (long) pte);
+
+	page = *pte;
+	printk("page == %08lx\n", pte_val(page));
+
+	val = pte_val(page);
+	if (val & _PAGE_PRESENT)
+		printk("present ");
+	if (val & _PAGE_READ)
+		printk("read ");
+	if (val & _PAGE_WRITE)
+		printk("write ");
+	if (val & _PAGE_ACCESSED)
+		printk("accessed ");
+	if (val & _PAGE_MODIFIED)
+		printk("modified ");
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+	if (val & _PAGE_R4KBUG)
+		printk("r4kbug ");
+#endif
+	if (val & _PAGE_GLOBAL)
+		printk("global ");
+	if (val & _PAGE_VALID)
+		printk("valid ");
+	if (val & _PAGE_DIRTY)
+		printk("dirty ");
+	printk("\n");
+}
+
+void dump_list_current(void *address)
+{
+	dump_list_process(current, address);
+}
