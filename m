Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8EJaln03049
	for linux-mips-outgoing; Fri, 14 Sep 2001 12:36:47 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8EJahe03046
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 12:36:43 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id C4DA7125C3; Fri, 14 Sep 2001 12:36:42 -0700 (PDT)
Date: Fri, 14 Sep 2001 12:36:42 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: The Linux binutils vs. the FSF binutils on Linux/mips
Message-ID: <20010914123642.A18552@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

FYI, the Linux binutils contains a 64bit MIPS ELF patch which doesn't
exist in the FSF binutils. At first, I thought this 64bit MIPS ELF
patch shouldn't affect the 32bit MIPS ELF. But for some reason, I
cannot get a stable 32bit Linux/mips kernel without this 64bit MIPS ELF
patch. I compared kernels generated by 2 linkers from the same input.
They are identical. Then I compared the object files generated from
2 assemblers. Some of them are different. Here is one example:

--- /tmp/2	Fri Sep 14 12:22:08 2001
+++ /tmp/1	Fri Sep 14 12:22:08 2001
@@ -1,5 +1,5 @@
 
-../linux-mips-0914/./net/socket.o:     file format elf32-tradlittlemips
+./net/socket.o:     file format elf32-tradlittlemips
 
 Disassembly of section .text:
 
@@ -2475,14 +2475,15 @@ Disassembly of section .text.init:
   60:	02002021 	move	a0,s0
   64:	3c010000 	lui	at,0x0
 			64: R_MIPS_HI16	.bss
-  68:	0c000000 	jal	0 <sock_init>
-			68: R_MIPS_26	rtnetlink_init
-  6c:	ac220084 	sw	v0,132(at)
-			6c: R_MIPS_LO16	.bss
-  70:	0c000000 	jal	0 <sock_init>
-			70: R_MIPS_26	init_netlink
-  74:	00000000 	nop
-  78:	8fbf0014 	lw	ra,20(sp)
-  7c:	8fb00010 	lw	s0,16(sp)
-  80:	03e00008 	jr	ra
-  84:	27bd0018 	addiu	sp,sp,24
+  68:	ac220084 	sw	v0,132(at)
+			68: R_MIPS_LO16	.bss
+  6c:	0c000000 	jal	0 <sock_init>
+			6c: R_MIPS_26	rtnetlink_init
+  70:	00000000 	nop
+  74:	0c000000 	jal	0 <sock_init>
+			74: R_MIPS_26	init_netlink
+  78:	00000000 	nop
+  7c:	8fbf0014 	lw	ra,20(sp)
+  80:	8fb00010 	lw	s0,16(sp)
+  84:	03e00008 	jr	ra
+  88:	27bd0018 	addiu	sp,sp,24

It seems that those small differences between 2 assemblers make a big
difference for the Linux/mips kernel. Does anyone know why?


H.J.
