Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g47Ag0wJ006396
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 03:42:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g47Ag0Ss006395
	for linux-mips-outgoing; Tue, 7 May 2002 03:42:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from guest (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g47AftwJ006392
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 03:41:55 -0700
Received: (from ralf@localhost)
	by guest (8.11.6/8.11.6) id g46Jid632458;
	Tue, 7 May 2002 03:44:39 +0800
Date: Tue, 7 May 2002 03:44:38 +0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: what is the right behavior of copy_to_user(0x0, ..., ...)?
Message-ID: <20020507034438.B14268@guest.intrengr>
References: <3CD3052B.1050400@mvista.com> <20020503162337.A27366@dea.linux-mips.net> <3CD32044.9040109@mvista.com> <20020503184000.A1238@dea.linux-mips.net> <3CD794BC.43264E9E@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3CD794BC.43264E9E@mips.com>; from carstenl@mips.com on Tue, May 07, 2002 at 10:47:56AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 07, 2002 at 10:47:56AM +0200, Carsten Langgaard wrote:

> I have fixed it locally by removing the SW from the delay-slot, but obviously
> your fix is the right one.
> But I guess we need the same fix in arch/mips/kernel/unaligned.c.

Smoke this:

Index: arch/mips64/kernel/unaligned.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips64/kernel/unaligned.c,v
retrieving revision 1.6.2.3
diff -u -r1.6.2.3 unaligned.c
--- arch/mips64/kernel/unaligned.c	24 Apr 2002 07:58:54 -0000	1.6.2.3
+++ arch/mips64/kernel/unaligned.c	7 May 2002 10:29:05 -0000
@@ -351,7 +351,7 @@
 
 fault:
 	/* Did we have an exception handler installed? */
-	fixup = search_exception_table(regs->cp0_epc);
+	fixup = search_exception_table(exception_epc(regs));
 	if (fixup) {
 		long new_epc;
 		new_epc = fixup_exception(dpf_reg, fixup, regs->cp0_epc);
Index: arch/mips/kernel/unaligned.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/kernel/unaligned.c,v
retrieving revision 1.15.2.4
diff -u -r1.15.2.4 unaligned.c
--- arch/mips/kernel/unaligned.c	24 Apr 2002 07:50:26 -0000	1.15.2.4
+++ arch/mips/kernel/unaligned.c	7 May 2002 10:29:05 -0000
@@ -332,7 +332,7 @@
 
 fault:
 	/* Did we have an exception handler installed? */
-	fixup = search_exception_table(regs->cp0_epc);
+	fixup = search_exception_table(exception_epc(regs));
 	if (fixup) {
 		long new_epc;
 		new_epc = fixup_exception(dpf_reg, fixup, regs->cp0_epc);

  Ralf
