Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA503904 for <linux-archive@neteng.engr.sgi.com>; Fri, 14 Nov 1997 13:19:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA13423 for linux-list; Fri, 14 Nov 1997 13:17:26 -0800
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA13408 for <linux@engr.sgi.com>; Fri, 14 Nov 1997 13:17:25 -0800
Received: (from ariel@localhost) by oz.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) id NAA27890 for linux@engr.sgi.com; Fri, 14 Nov 1997 13:17:25 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199711142117.NAA27890@oz.engr.sgi.com>
Subject: Pentium F00F bug Linux workaround
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Fri, 14 Nov 1997 13:17:24 -0800 (PST)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[Just forwarding from linux-dev since I thought some people
 may be interested.  Ingo Molnar has found a way to workaround
 the latest Pentium/Pentium-MMX F00F bug. Linus then improved on it.

 I'm impressed by the repeatedly demonstrated ability of the Linux
 community to beat Microsoft.  It remains to be seen how long it'll
 take Microsoft to respond to this serious bug that can crash any
 Windows/WindowsNT machine from user mode (incl. any remotely loaded
 Captive-X control)]

-------------------------------------------------------------------------

>From Linus:

Ingo, Alan, others,
 I have a quick cleanup of 2.1.63 that looks a bit better wrt the F0 0F
bug, and also avoids the double SMP unlock that somebody noticed (sorry
for not giving attribution, I've been pretty rushed today trying to get
the stuff out quickly to people to test). 

I still don't have any pentium closeby to actually test this, so I'm
appending patches relative to 2.1.63. Does this still work for people with
the bug?

		Linus

-----
diff -u --recursive --new-file v2.1.63/linux/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- v2.1.63/linux/arch/i386/mm/fault.c	Wed Nov 12 13:34:25 1997
+++ linux/arch/i386/mm/fault.c	Wed Nov 12 13:33:48 1997
@@ -74,14 +74,6 @@
 	return 0;
 }
 
-asmlinkage void divide_error(void);
-asmlinkage void debug(void);
-asmlinkage void nmi(void);
-asmlinkage void int3(void);
-asmlinkage void overflow(void);
-asmlinkage void bounds(void);
-asmlinkage void invalid_op(void);
-
 asmlinkage void do_divide_error (struct pt_regs *, unsigned long);
 asmlinkage void do_debug (struct pt_regs *, unsigned long);
 asmlinkage void do_nmi (struct pt_regs *, unsigned long);
@@ -189,44 +181,27 @@
 		goto out;
 	}
 
-	printk(&quot;&lt;%p/%p&gt;\n&quot;, idt2, (void *)address);
 	/*
 	 * Pentium F0 0F C7 C8 bug workaround:
 	 */
-	if ( pentium_f00f_bug &amp;&amp; (address &gt;= (unsigned long)idt2) &amp;&amp;
-			(address &lt; (unsigned long)idt2+256*8) ) {
-
-		void (*handler) (void);
-		int nr = (address-(unsigned long)idt2)/8;
-		unsigned long low, high;
-
-		low = idt[nr].a;
-		high = idt[nr].b;
-
-		handler = (void (*) (void)) ((low&amp;0x0000ffff) | (high&amp;0xffff0000));
-		printk(&quot;&lt;handler %p... &quot;, handler);
-		unlock_kernel();
-
-		if (handler==divide_error)
-			do_divide_error(regs,error_code);
-		else if (handler==debug)
-			do_debug(regs,error_code);
-		else if (handler==nmi)
-			do_nmi(regs,error_code);
-		else if (handler==int3)
-			do_int3(regs,error_code);
-		else if (handler==overflow)
-			do_overflow(regs,error_code);
-		else if (handler==bounds)
-			do_bounds(regs,error_code);
-		else if (handler==invalid_op)
-			do_invalid_op(regs,error_code);
-		else {
-			printk(&quot;INVALID HANDLER!\n&quot;);
-			for (;;) __cli();
+	if ( pentium_f00f_bug ) {
+		unsigned long nr;
+		
+		nr = (address - (unsigned long) idt2) &gt;&gt; 3;
+
+		if (nr &lt; 7) {
+			static void (*handler[])(struct pt_regs *, unsigned long) = {
+				do_divide_error,	/* 0 - divide overflow */
+				do_debug,		/* 1 - debug trap */
+				do_nmi,			/* 2 - NMI */
+				do_int3,		/* 3 - int 3 */
+				do_overflow,		/* 4 - overflow */
+				do_bounds,		/* 5 - bound range */
+				do_invalid_op };	/* 6 - invalid opcode */
+			unlock_kernel();
+			handler[nr](regs, error_code);
+			return;
 		}
-		printk(&quot;... done&gt;\n&quot;);
-		goto out;
 	}
 
 	/* Are we prepared to handle this kernel fault?  */


-- 
Peace, Ariel
