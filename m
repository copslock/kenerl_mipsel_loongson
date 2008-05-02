Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2008 11:11:21 +0100 (BST)
Received: from [217.169.26.28] ([217.169.26.28]:11245 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S62077927AbYEBKLS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 May 2008 11:11:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m42ABDN0002904;
	Fri, 2 May 2008 11:11:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m42ABDPh002903;
	Fri, 2 May 2008 11:11:13 +0100
Date:	Fri, 2 May 2008 11:11:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Breakage in arch/mips/kernel/traps.c for 64bit
Message-ID: <20080502101113.GA24408@linux-mips.org>
References: <20080501163314.GA9955@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080501163314.GA9955@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 01, 2008 at 06:33:14PM +0200, Thomas Bogendoerfer wrote:

> it would be nice, if people started thinking before supplying such
> crappy^Winteresting code:
> 
> arch/mips/kernel/traps.c:
> 
> #define IS_KVA01(a) ((((unsigned int)a) & 0xc0000000) == 0x80000000)
> 
> Kills every 64bit kernel build...
> 
> Why is this needed at all ?

It came as part of 39b8d5254246ac56342b72f812255c8f7a74dca9 which is a
patch amalgated from several other patches.  Below is the original patch
it came with.  I think the idea of the patch is valid but the idea needs a
bit of mending.

From: Chris Dearman <chris@mips.com>
Date: Wed, 3 Oct 2007 10:19:18 +0100
Subject: [PATCH] Skip raw backtrace for non KSEG stack addresses
 This is to avoid recursive stackdumps as the kernel kernel falls off
 of the user stack.

Signed-off-by: Chris Dearman <chris@mips.com>

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 2948b86..3d56171 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -79,19 +79,22 @@ void (*board_bind_eic_interrupt)(int irq, int regset);
 
 static void show_raw_backtrace(unsigned long reg29)
 {
-	unsigned long *sp = (unsigned long *)reg29;
+	unsigned long *sp = (unsigned long *)(reg29 & ~3);
 	unsigned long addr;
 
 	printk("Call Trace:");
 #ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
-	while (!kstack_end(sp)) {
-		addr = *sp++;
-		if (__kernel_text_address(addr))
-			print_ip_sym(addr);
+#define IS_KVA01(a) ((((unsigned int)a) & 0xc0000000) == 0x80000000)
+	if (IS_KVA01(sp)) {
+		while (!kstack_end(sp)) {
+			addr = *sp++;
+			if (__kernel_text_address(addr))
+				print_ip_sym(addr);
+		}
+		printk("\n");
 	}
-	printk("\n");
 }
 
 #ifdef CONFIG_KALLSYMS
