Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HEYsG13518
	for linux-mips-outgoing; Thu, 17 Jan 2002 06:34:54 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HEYkP13510
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 06:34:46 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA25323
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 05:34:36 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA06543
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 05:34:36 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g0HDYIA16993
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 14:34:18 +0100 (MET)
Message-ID: <3C46D2ED.9BCA458A@mips.com>
Date: Thu, 17 Jan 2002 14:34:37 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Bug in the _save_fp_context.
Content-Type: multipart/mixed;
 boundary="------------13498F6F204C7733F9CE6B14"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------13498F6F204C7733F9CE6B14
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I posted the following problem on the list almost a year ago, but it
still hasn't made into the SGI CVS.
I think there is a bug in the _save_fp_context function in
arch/mips/kernel/r4k_fpu.S

The problem is the following piece of code:

 jr ra
 .set nomacro
 EX(sw t0,SC_FPC_EIR(a0))
 .set macro

We do not handle entries in the __ex_table which is located in a branch
delay.
So we need to handle the situation where we take a page fault on an
instruction which is located in a brach delay slot, or we don't put the
"potential" faulting instruction in a delay slot.

This situation probably doesn't generally hit people since it hasn't
been fix yet, but if you try run something nasty like Crashme, you will
get hit by this problem.
I suggest the following patch.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------13498F6F204C7733F9CE6B14
Content-Type: text/plain; charset=iso-8859-15;
 name="r4k_fpu.S.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="r4k_fpu.S.patch"

Index: arch/mips/kernel/r4k_fpu.S
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/r4k_fpu.S,v
retrieving revision 1.12
diff -u -r1.12 r4k_fpu.S
--- arch/mips/kernel/r4k_fpu.S	2001/04/11 05:19:46	1.12
+++ arch/mips/kernel/r4k_fpu.S	2002/01/17 14:21:09
@@ -50,11 +50,10 @@
 	EX(sdc1	$f30,(SC_FPREGS+240)(a0))
 	EX(sw	t1,SC_FPC_CSR(a0))
 	cfc1	t0,$0				# implementation/version
+	EX(sw	t0,SC_FPC_EIR(a0))
 
 	jr	ra
-	.set	nomacro
-	 EX(sw	t0,SC_FPC_EIR(a0))
-	.set	macro
+	 nop
 	END(_save_fp_context)
 
 /*

--------------13498F6F204C7733F9CE6B14--
