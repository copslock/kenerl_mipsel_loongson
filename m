Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 16:49:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:28118 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133677AbWEXOtS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2006 16:49:18 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4OEnHrZ025391;
	Wed, 24 May 2006 15:49:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4OEnHqJ025390;
	Wed, 24 May 2006 15:49:17 +0100
Date:	Wed, 24 May 2006 15:49:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	art <art@sigrand.ru>, linux-mips@linux-mips.org
Subject: Re: Problem with TLB mcheck!
Message-ID: <20060524144917.GA11657@linux-mips.org>
References: <19691.060524@sigrand.ru> <Pine.LNX.4.64N.0605241304090.7887@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0605241304090.7887@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 24, 2006 at 01:45:26PM +0100, Maciej W. Rozycki wrote:

j  The "linux-mips" mailing list (as cc-ed in this response) is a better 
> place to ask such questions.
> 
>  You haven't included some important information, such as the version 
> number of your Linux kernel and where you got your sources from.  Without 
> that bit all I can say is there is something wrong with handling of the 
> TLB.
> 
>  Ralf, BTW -- shouldn't we report the Index, EntryHi and possibly EntryLo* 
> registers in show_regs() if the cause is a machine check?  I think it 
> would be useful and these registers shouldn't have been corrupted since 
> the triggering tlbw* instruction.  A call to show_code() could be useful 
> too, to determine which kind of TLB exception has been taken originally.  

Depends on when exactly a CPU will raise the machine check.  On some cores
the information in registers is totally useless if not even missloading.
But generally a good idea, patch below.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 35cb08d..44a30e6 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -819,8 +819,19 @@ asmlinkage void do_watch(struct pt_regs 
 
 asmlinkage void do_mcheck(struct pt_regs *regs)
 {
+	const int field = 2 * sizeof(unsigned long);
+
 	show_regs(regs);
+
+	printk("Hi    : %0*lx\n", field, regs->hi);
+	printk("Pagemask: %0*x\n", read_c0_pagemask());
+	printk("EntryHi : %0*lx\n", field, read_c0_entryhi());
+	printk("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
+	printk("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
+	printk("\n");
 	dump_tlb_all();
+	show_code((unsigned int *) regs->cp0_epc);
+
 	/*
 	 * Some chips may have other causes of machine check (e.g. SB1
 	 * graduation timer)
