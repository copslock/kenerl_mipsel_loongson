Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MGm3Rw027207
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 09:48:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MGm35F027206
	for linux-mips-outgoing; Mon, 22 Jul 2002 09:48:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MGltRw027193
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 09:47:56 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA14862;
	Mon, 22 Jul 2002 09:48:39 -0700
Message-ID: <3D3C3572.40807@mvista.com>
Date: Mon, 22 Jul 2002 09:40:18 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@oss.sgi.com, Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: [PATCH] Let us die more gracefully
References: <Pine.GSO.3.96.1020722154730.2373E-100000@delta.ds2.pg.gda.pl>
Content-Type: multipart/mixed;
 boundary="------------010605000503070205030605"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------010605000503070205030605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Maciej W. Rozycki wrote:
> On Fri, 19 Jul 2002, Jun Sun wrote:
> 
> 
>>This patch dumps the offending code context rather than dumping the context of 
>>do_ri() function call itself.
> 
> 
>  The message is misleading -- the reason may be any illegal opcode.
> 

That is true.  Here is the revised one.

Jun

--------------010605000503070205030605
Content-Type: text/plain;
 name="020719.b.graceful-death-in-do_ri.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="020719.b.graceful-death-in-do_ri.patch"

diff -Nru linux/arch/mips/kernel/traps.c.orig linux/arch/mips/kernel/traps.c
--- linux/arch/mips/kernel/traps.c.orig	Thu Jul 18 15:39:50 2002
+++ linux/arch/mips/kernel/traps.c	Thu Jul 18 16:49:32 2002
@@ -614,8 +614,7 @@
  */
 asmlinkage void do_ri(struct pt_regs *regs)
 {
-	if (!user_mode(regs))
-		BUG();
+	die_if_kernel("Reserved instruction in kernel code", regs);
 
 #ifndef CONFIG_CPU_HAS_LLSC
 

--------------010605000503070205030605--
