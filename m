Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JLUrRw029255
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 14:30:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JLUqMM029254
	for linux-mips-outgoing; Fri, 19 Jul 2002 14:30:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JLUjRw029245
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 14:30:45 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA09343
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 14:31:24 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA02643;
	Fri, 19 Jul 2002 14:26:18 -0700
Message-ID: <3D388211.1030509@mvista.com>
Date: Fri, 19 Jul 2002 14:18:09 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com, Ralf Baechle <ralf@uni-koblenz.de>
Subject: [PATCH] Let us die more gracefully
Content-Type: multipart/mixed;
 boundary="------------030107050804000506040108"
X-Spam-Status: No, hits=-3.7 required=5.0 tests=MAY_BE_FORGED,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------030107050804000506040108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This patch dumps the offending code context rather than dumping the context of 
do_ri() function call itself.

Apply to both branches.  (Same is true with the previous patch)

Jun


--------------030107050804000506040108
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
+	die_if_kernel("no ll/sc emulation for kernel code", regs);
 
 #ifndef CONFIG_CPU_HAS_LLSC
 

--------------030107050804000506040108--
