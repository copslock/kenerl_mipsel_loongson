Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DFDH317144
	for linux-mips-outgoing; Fri, 13 Jul 2001 08:13:17 -0700
Received: from dvmwest.gt.owl.de (postfix@dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DFDFV17140
	for <linux-mips@oss.sgi.com>; Fri, 13 Jul 2001 08:13:15 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id AC106C4FE; Fri, 13 Jul 2001 17:13:13 +0200 (CEST)
Date: Fri, 13 Jul 2001 17:13:13 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>
Subject: Patch to ptrace.c
Message-ID: <20010713171313.E22543@lug-owl.de>
Mail-Followup-To: SGI MIPS list <linux-mips@oss.sgi.com>,
	Debian MIPS list <debian-mips@lists.debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux mail 2.4.5
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi!

Fixing a little typo preventing proper compiling... Ralf? Would you please
apply it?


Index: ptrace.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/ptrace.c,v
retrieving revision 1.28
diff -u -r1.28 ptrace.c
--- ptrace.c	2001/07/12 00:16:53	1.28
+++ ptrace.c	2001/07/13 12:10:36
@@ -155,7 +155,7 @@
 				 * registers - unless we're using r2k_switch.S.
 				 */
 #ifdef CONFIG_CPU_R3000
-				if (mips_cpu_options & MIPS_CPU_FPU)
+				if (mips_cpu.options & MIPS_CPU_FPU)
 					tmp = *(unsigned long *)(fregs + addr);
 				else
 #endif
@@ -252,7 +252,7 @@
 			 * we're using r2k_switch.S.
 			 */
 #ifdef CONFIG_CPU_R3000
-			if (mips_cpu_options & MIPS_CPU_FPU)
+			if (mips_cpu.options & MIPS_CPU_FPU)
 				*(unsigned long *)(fregs + addr) = data;
 			else
 #endif



MfG, JBG
