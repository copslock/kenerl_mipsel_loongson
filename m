Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Oct 2004 05:08:19 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:46854 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224830AbUJWEIN>; Sat, 23 Oct 2004 05:08:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 42976F59EF; Sat, 23 Oct 2004 06:08:10 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24658-05; Sat, 23 Oct 2004 06:08:10 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D28B9F5946; Sat, 23 Oct 2004 06:08:09 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id i9N48BHY025518;
	Sat, 23 Oct 2004 06:08:12 +0200
Date: Sat, 23 Oct 2004 05:08:09 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: kernel_thread creation bug?
In-Reply-To: <20041022.212503.39150495.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.58L.0410230457000.8265@blysk.ds.pg.gda.pl>
References: <20041022.170758.48799763.nemoto@toshiba-tops.co.jp>
 <20041022121647.GA27961@linux-mips.org> <20041022.212503.39150495.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/538/Tue Oct 19 12:04:13 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 22 Oct 2004, Atsushi Nemoto wrote:

> >>>>> On Fri, 22 Oct 2004 14:16:48 +0200, Ralf Baechle <ralf@linux-mips.org> said:
> >> With recent change in kernel_thread(), initial cp0_status value
> >> comes from current C0_STATUS (which does not include EXL bit).  Is
> >> this correct?  The initial value should contain EXL bit to start
> >> the thread up safely, shouldn't it?
> 
> ralf> Yes ...
> 
> I see the fix in CVS.  Thank you.

 Thanks for tracking down this problem -- I think we want the following
fix on top of yours to handle the R3k style of exception handling.  I
don't have a way to test it ATM (I'd appreciate feedback if anyone could
do that for me), but it should be obvious.

 Ralf, do you agree?

  Maciej

patch-mips-2.6.9-20041023-kernel_thread-r3k-0
diff -up --recursive --new-file linux-mips-2.6.9-20041023.macro/arch/mips/kernel/process.c linux-mips-2.6.9-20041023/arch/mips/kernel/process.c
--- linux-mips-2.6.9-20041023.macro/arch/mips/kernel/process.c	Sat Oct 23 03:30:46 2004
+++ linux-mips-2.6.9-20041023/arch/mips/kernel/process.c	Sat Oct 23 03:43:16 2004
@@ -175,7 +175,10 @@ long kernel_thread(int (*fn)(void *), vo
 	regs.regs[5] = (unsigned long) fn;
 	regs.cp0_epc = (unsigned long) kernel_thread_helper;
 	regs.cp0_status = read_c0_status();
-#if !(defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX))
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+	regs.cp0_status &= ~ST0_KUP;
+	regs.cp0_status |= ST0_IEP;
+#else
 	regs.cp0_status |= ST0_EXL;
 #endif
 
