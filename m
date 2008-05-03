Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2008 23:49:25 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:18156 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28584060AbYECWtU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 May 2008 23:49:20 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JsQXe-0000Po-00; Sun, 04 May 2008 00:49:18 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 7CCC3FAB11; Sun,  4 May 2008 00:48:49 +0200 (CEST)
Date:	Sun, 4 May 2008 00:48:49 +0200
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Breakage in arch/mips/kernel/traps.c for 64bit
Message-ID: <20080503224849.GA2314@alpha.franken.de>
References: <20080501163314.GA9955@alpha.franken.de> <20080502101113.GA24408@linux-mips.org> <20080504.011647.93019265.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080504.011647.93019265.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, May 04, 2008 at 01:16:47AM +0900, Atsushi Nemoto wrote:
> On Fri, 2 May 2008 11:11:13 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > It came as part of 39b8d5254246ac56342b72f812255c8f7a74dca9 which is a
> > patch amalgated from several other patches.  Below is the original patch
> > it came with.  I think the idea of the patch is valid but the idea needs a
> > bit of mending.
> 
> Then how about this fix?

hmm, why not simply use __get_user() when accessing the stack content ?
show_stacktrace() already does it for stack dumping ? This would
avoid any work for whatever sick stack mappings. Below is a patch,
which does this.

Thomas.

The newly added check for valid stack pointer address breaks at least for
64bit kernels.  Use __get_user() for accessing stack content to avoid crashes,
when doing the backtrace.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/kernel/traps.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cb8b0e2..c9ce8d6 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -81,22 +81,22 @@ void (*board_bind_eic_interrupt)(int irq, int regset);
 
 static void show_raw_backtrace(unsigned long reg29)
 {
-	unsigned long *sp = (unsigned long *)(reg29 & ~3);
+	unsigned long __user *sp = (unsigned long __user *)(reg29 & ~3);
 	unsigned long addr;
 
 	printk("Call Trace:");
 #ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
-#define IS_KVA01(a) ((((unsigned int)a) & 0xc0000000) == 0x80000000)
-	if (IS_KVA01(sp)) {
-		while (!kstack_end(sp)) {
-			addr = *sp++;
-			if (__kernel_text_address(addr))
-				print_ip_sym(addr);
+	while (!kstack_end(sp)) {
+		if (__get_user(addr, sp++)) {
+			printk(" (Bad stack address)");
+			break;
 		}
-		printk("\n");
+		if (__kernel_text_address(addr))
+			print_ip_sym(addr);
 	}
+	printk("\n");
 }
 
 #ifdef CONFIG_KALLSYMS

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
