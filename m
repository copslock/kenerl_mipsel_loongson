Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2003 16:53:49 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:4326 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225319AbTLDQxs>;
	Thu, 4 Dec 2003 16:53:48 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1ARwjJ-0001Ds-RT; Thu, 04 Dec 2003 11:53:29 -0500
Date: Thu, 4 Dec 2003 11:53:29 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: MIPS64 syscall trace patch
Message-ID: <20031204165329.GA4655@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

You need this do use PTRACE_SYSCALL on a 64-bit process.  Otherwise mmap()'s
last argument gets corrupted by syscall_trace().  Strace itself doesn't work
yet, but I'm making progress...

This is for 2.4.  2.6 patch will follow in a sec.

Index: arch/mips64/kernel/scall_64.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/Attic/scall_64.S,v
retrieving revision 1.20.2.18
diff -u -p -r1.20.2.18 scall_64.S
--- arch/mips64/kernel/scall_64.S	28 Oct 2003 13:39:37 -0000	1.20.2.18
+++ arch/mips64/kernel/scall_64.S	4 Dec 2003 16:51:01 -0000
@@ -108,6 +108,8 @@ trace_a_syscall:
 	ld	a1, PT_R5(sp)
 	ld	a2, PT_R6(sp)
 	ld	a3, PT_R7(sp)
+	ld	a4, PT_R8(sp)
+	ld	a5, PT_R9(sp)
 	jalr	t2
 
 	li	t0, -EMAXERRNO - 1	# error?
Index: arch/mips64/kernel/scall_n32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/Attic/scall_n32.S,v
retrieving revision 1.2.2.14
diff -u -p -r1.2.2.14 scall_n32.S
--- arch/mips64/kernel/scall_n32.S	9 Oct 2003 15:42:33 -0000	1.2.2.14
+++ arch/mips64/kernel/scall_n32.S	4 Dec 2003 16:51:01 -0000
@@ -111,6 +111,8 @@ trace_a_syscall:
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
