Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2003 16:54:10 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:4582 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225327AbTLDQx7>;
	Thu, 4 Dec 2003 16:53:59 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1ARwjg-0001EG-SR; Thu, 04 Dec 2003 11:53:52 -0500
Date: Thu, 4 Dec 2003 11:53:52 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: MIPS64 syscall trace for 2.6
Message-ID: <20031204165352.GA4708@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

As promised.  Not any different, really.

Index: arch/mips/kernel/scall64-64.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/scall64-64.S,v
retrieving revision 1.9
diff -u -p -r1.9 scall64-64.S
--- arch/mips/kernel/scall64-64.S	10 Oct 2003 22:58:55 -0000	1.9
+++ arch/mips/kernel/scall64-64.S	4 Dec 2003 16:49:22 -0000
@@ -92,6 +92,8 @@ syscall_trace_entry:
 	ld	a1, PT_R5(sp)
 	ld	a2, PT_R6(sp)
 	ld	a3, PT_R7(sp)
+	ld	a4, PT_R8(sp)
+	ld	a5, PT_R9(sp)
 	jalr	t2
 
 	li	t0, -EMAXERRNO - 1	# error?
Index: arch/mips/kernel/scall64-n32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/scall64-n32.S,v
retrieving revision 1.6
diff -u -p -r1.6 scall64-n32.S
--- arch/mips/kernel/scall64-n32.S	10 Oct 2003 22:58:55 -0000	1.6
+++ arch/mips/kernel/scall64-n32.S	4 Dec 2003 16:49:24 -0000
@@ -89,6 +89,8 @@ n32_syscall_trace_entry:
 	ld	a1, PT_R5(sp)
 	ld	a2, PT_R6(sp)
 	ld	a3, PT_R7(sp)
+	ld	a4, PT_R8(sp)
+	ld	a5, PT_R9(sp)
 	jalr	t2
 
 	li	t0, -EMAXERRNO - 1	# error?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
