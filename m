Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2004 00:54:13 +0100 (BST)
Received: from p508B75AD.dip.t-dialin.net ([IPv6:::ffff:80.139.117.173]:22544
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224829AbUFHXyJ>; Wed, 9 Jun 2004 00:54:09 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i58Ns3ux003456;
	Wed, 9 Jun 2004 01:54:03 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i58Ns0Re003455;
	Wed, 9 Jun 2004 01:54:00 +0200
Date: Wed, 9 Jun 2004 01:54:00 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-mips@linux-mips.org
Subject: Re: linux-vserver syscall ...
Message-ID: <20040608235400.GA31706@linux-mips.org>
References: <20040524182915.GA27481@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524182915.GA27481@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 24, 2004 at 08:29:15PM +0200, Herbert Poetzl wrote:

> obviously I forgot to ask you to reserve a
> syscall for linux-vserver, and I just discovered
> this as the currently used number (273) was used
> up by some other syscall (in 2.6.7-rc1) ...
> 
> so I'm asking you now, could you please reserve
> a syscall for this project, so that we do not
> need to change it on every new kernel release?
> 
> here is a list of currently reserved syscalls
> (for other archs) and some links to the project
> (in case you care)

Not really - other than the fact that I'm reluctant to reserve syscall
numbers for something that might never make it into the kernel so
usually i386 reserving a syscall is what convinces me ...

Due to the three support ABIs you actually get 3 syscall numbers even.
o32 gets 277, N64 236 and N32 240.  Patch is below.

  Ralf

Index: arch/mips/kernel/scall32-o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/scall32-o32.S,v
retrieving revision 1.8
diff -u -r1.8 scall32-o32.S
--- arch/mips/kernel/scall32-o32.S	26 Apr 2004 15:06:10 -0000	1.8
+++ arch/mips/kernel/scall32-o32.S	8 Jun 2004 23:39:44 -0000
@@ -627,6 +627,7 @@
 	sys	sys_mq_timedreceive	5
 	sys	sys_mq_notify		2	/* 4275 */
 	sys	sys_mq_getsetattr	3
+	sys	sys_ni_syscall		0	/* sys_vserver */
 
 	.endm
 
Index: arch/mips/kernel/scall64-64.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/scall64-64.S,v
retrieving revision 1.12
diff -u -r1.12 scall64-64.S
--- arch/mips/kernel/scall64-64.S	6 Jun 2004 02:12:38 -0000	1.12
+++ arch/mips/kernel/scall64-64.S	8 Jun 2004 23:39:44 -0000
@@ -447,3 +447,4 @@
 	PTR	sys_mq_timedreceive
 	PTR	sys_mq_notify
 	PTR	sys_mq_getsetattr		/* 5235 */
+	PTR	sys_ni_syscall			/* sys_vserver */
Index: arch/mips/kernel/scall64-n32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/scall64-n32.S,v
retrieving revision 1.11
diff -u -r1.11 scall64-n32.S
--- arch/mips/kernel/scall64-n32.S	6 Jun 2004 02:12:38 -0000	1.11
+++ arch/mips/kernel/scall64-n32.S	8 Jun 2004 23:39:44 -0000
@@ -357,3 +357,4 @@
 	PTR	compat_sys_mq_timedreceive
 	PTR	compat_sys_mq_notify
 	PTR	compat_sys_mq_getsetattr	/* 6239 */
+	PTR	sys_ni_syscall			/* sys_vserver */
Index: arch/mips/kernel/scall64-o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/scall64-o32.S,v
retrieving revision 1.11
diff -u -r1.11 scall64-o32.S
--- arch/mips/kernel/scall64-o32.S	6 Jun 2004 02:12:38 -0000	1.11
+++ arch/mips/kernel/scall64-o32.S	8 Jun 2004 23:39:44 -0000
@@ -535,6 +535,7 @@
 	sys	compat_sys_mq_timedreceive 5
 	sys	compat_sys_mq_notify	2	/* 4275 */
 	sys	compat_sys_mq_getsetattr 3
+	sys	sys_ni_syscall		0	/* sys_vserver */
 
 	.endm
 
Index: include/asm-mips/unistd.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/unistd.h,v
retrieving revision 1.62
diff -u -r1.62 unistd.h
--- include/asm-mips/unistd.h	6 Jun 2004 02:12:54 -0000	1.62
+++ include/asm-mips/unistd.h	8 Jun 2004 23:39:44 -0000
@@ -297,16 +297,17 @@
 #define __NR_mq_timedreceive		(__NR_Linux + 274)
 #define __NR_mq_notify			(__NR_Linux + 275)
 #define __NR_mq_getsetattr		(__NR_Linux + 276)
+#define __NR_vserver			(__NR_Linux + 277)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		276
+#define __NR_Linux_syscalls		277
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		276
+#define __NR_O32_Linux_syscalls		277
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -550,16 +551,17 @@
 #define __NR_mq_timedreceive		(__NR_Linux + 233)
 #define __NR_mq_notify			(__NR_Linux + 234)
 #define __NR_mq_getsetattr		(__NR_Linux + 235)
+#define __NR_vserver			(__NR_Linux + 236)
 
 /*
  * Offset of the last Linux flavoured syscall
  */
-#define __NR_Linux_syscalls		235
+#define __NR_Linux_syscalls		236
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		235
+#define __NR_64_Linux_syscalls		236
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -807,16 +809,17 @@
 #define __NR_mq_timedreceive		(__NR_Linux + 237)
 #define __NR_mq_notify			(__NR_Linux + 238)
 #define __NR_mq_getsetattr		(__NR_Linux + 239)
+#define __NR_vserver			(__NR_Linux + 240)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		239
+#define __NR_Linux_syscalls		240
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		239
+#define __NR_N32_Linux_syscalls		240
 
 #ifndef __ASSEMBLY__
 
