Received:  by oss.sgi.com id <S42277AbQEXSyo>;
	Wed, 24 May 2000 11:54:44 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:61192 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42287AbQEXSyQ>; Wed, 24 May 2000 11:54:16 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA09360; Wed, 24 May 2000 11:58:55 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA35222
	for linux-list;
	Wed, 24 May 2000 11:43:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from virgil.engr.sgi.com (virgil.engr.sgi.com [163.154.5.20])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA60092
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 May 2000 11:43:35 -0700 (PDT)
	mail_from (bigham@cthulhu.engr.sgi.com)
Received: from engr.sgi.com (localhost [127.0.0.1]) by virgil.engr.sgi.com (980427.SGI.8.8.8/960327.SGI.AUTOCF) via ESMTP id LAA23127 for <linux@engr.sgi.com>; Wed, 24 May 2000 11:43:34 -0700 (PDT)
Message-ID: <392C22D6.E4D56B4D@engr.sgi.com>
Date:   Wed, 24 May 2000 11:43:34 -0700
From:   Nancy Bigham <bigham@cthulhu.engr.sgi.com>
Organization: Linux
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com
Subject: [Fwd: BOUNCE linux@relay.engr.sgi.com:    Non-member submission from 
 [Jun Sun <jsun@mvista.com>]]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



-------- Original Message --------
Subject: BOUNCE linux@relay.engr.sgi.com:    Non-member submission from
[Jun Sun <jsun@mvista.com>]
Date: Tue, 23 May 2000 16:48:51 -0700 (PDT)
From: owner-linux@cthulhu
To: owner-linux@cthulhu

>From owner-linux  Tue May 23 16:48:50 2000
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA62223
	for <linux@engr.sgi.com>;
	Tue, 23 May 2000 16:48:42 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04698
	for <linux@engr.sgi.com>; Tue, 23 May 2000 16:48:37 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id QAA03052;
	Tue, 23 May 2000 16:48:38 -0700
Sender: jsun@hermes.mvista.com
Message-ID: <392B18D6.F4B11BED@mvista.com>
Date: Tue, 23 May 2000 16:48:38 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@engr.sgi.com, linux-mips@fnet.fr
Subject: gdbserver for MIPS
Content-Type: multipart/mixed;
 boundary="------------732E7D3674406CC64CF16CED"

This is a multi-part message in MIME format.
--------------732E7D3674406CC64CF16CED
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


I finally got gdbserver working on MIPS.  Who should I submit the
patches to?

There are three patches/changes made :

1. in kernel, arch/mips/ptrace.c - I did not generate patch file as my
kernel version is probably outdated.  Basically if  CONFIG_CPU_NO_FPU is
defined, return -1 for reading FPC_EIR register, instead of actually
reading the hardware.

2. a patch for gdbserver - see attached gdb-4.17-mips-gdbserver.patch

3. I need an additional patch for my particular board to work.  I am not
sure if they are generically applicable.  This patch overcomes a VERY
SLOW getprotobyname() problem and sending a virtual FP register value
problem.  See the second attached file.

There is still one annoyance - stepping through a glibc function would
generate a unknown address warning.  Other than that, everything seems
to work fine - with my limited tests, that it.


Jun
--------------732E7D3674406CC64CF16CED
Content-Type: text/plain; charset=us-ascii;
 name="gdb-4.17-mips-gdbserver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gdb-4.17-mips-gdbserver.patch"

--- gdb-4.17/gdb/config/mips/mipsel-linux.mh.orig	Mon May 22 18:39:07
2000
+++ gdb-4.17/gdb/config/mips/mipsel-linux.mh	Mon May 22 18:39:07 2000
@@ -3,6 +3,8 @@
 XM_FILE= xm-llinux.h
 NAT_FILE= nm-linux.h
 NATDEPFILES= infptrace.o inftarg.o mipslinux-nat.o corelow.o
core-regset.o fork-child.o solib.o
+GDBSERVER_DEPFILES= low-linux.o
+GDBSERVER_LIBS=
 
 MMALLOC =
 MMALLOC_CFLAGS = -DNO_MMALLOC
--- gdb-4.17/gdb/config/mips/xm-llinux.h.orig	Mon May 22 18:39:07 2000
+++ gdb-4.17/gdb/config/mips/xm-llinux.h	Mon May 22 18:41:36 2000
@@ -31,3 +31,6 @@
 #define HAVE_TERMIOS
 #define HAVE_SIGSETMASK 1
 #define USG
+
+#define REGISTER_U_ADDR(addr, blockend, regno)          \
+	addr = regno
--- gdb-4.17/gdb/gdbserver/utils.c.orig	Fri Aug  8 21:49:48 1997
+++ gdb-4.17/gdb/gdbserver/utils.c	Mon May 22 18:39:07 2000
@@ -32,7 +32,7 @@
      char *string;
 {
   extern int sys_nerr;
-  extern char *sys_errlist[];
+  extern const char * const sys_errlist[];
   extern int errno;
   char *err;
   char *combined;
--- gdb-4.17/gdb/gdbserver/low-linux.c.orig	Fri Oct 11 12:26:04 1996
+++ gdb-4.17/gdb/gdbserver/low-linux.c	Mon May 22 18:44:37 2000
@@ -44,11 +44,17 @@
 char buf2[MAX_REGISTER_RAW_SIZE];
 /***************End MY defs*********************/
 
-#include <sys/ptrace.h>
+#include <asm/ptrace.h>
 #if 0
+#include <sys/ptrace.h>
 #include <machine/reg.h>
 #endif
 
+/* [jsun] if NUM_FREGS is not defined, it probably should be 0 */
+#if !defined(NUM_FREGS)
+#define		NUM_FREGS		0
+#endif
+
 extern char **environ;
 extern int errno;
 extern int inferior_pid;
@@ -72,7 +78,7 @@
 
   if (pid == 0)
     {
-      ptrace (PTRACE_TRACEME, 0, 0, 0);
+      ptrace (PTRACE_TRACEME, 0, 0, 0); 
 
       execv (program, allargs);
 
@@ -165,6 +171,7 @@
     - KERNEL_U_ADDR
 #endif
 
+#if defined(__i386)
 /* this table must line up with REGISTER_NAMES in tm-i386v.h */
 /* symbols like 'EAX' come from <sys/reg.h> */
 static int regmap[] = 
@@ -198,6 +205,8 @@
     return (blockend + 4 * regmap[regnum]);
   
 }
+#endif		/* defined(__i386) */
+
 
 CORE_ADDR
 register_addr (regno, blockend)
@@ -215,7 +224,6 @@
 }
 
 /* Fetch one register.  */
-
 static void
 fetch_register (regno)
      int regno;
@@ -257,7 +265,7 @@
 {
   if (regno == -1 || regno == 0)
     for (regno = 0; regno < NUM_REGS-NUM_FREGS; regno++)
-      fetch_register (regno);
+	  fetch_register (regno);
   else
     fetch_register (regno);
 }
--- gdb-4.17/gdb/gdbserver/gdbreplay.c.orig	Fri Oct 11 12:26:03 1996
+++ gdb-4.17/gdb/gdbserver/gdbreplay.c	Mon May 22 18:39:07 2000
@@ -41,7 +41,7 @@
      char *string;
 {
   extern int sys_nerr;
-  extern char *sys_errlist[];
+  extern const char *const sys_errlist[];
   extern int errno;
   char *err;
   char *combined;

--------------732E7D3674406CC64CF16CED
Content-Type: text/plain; charset=us-ascii;
 name="gdb-4.17-mips-gdbserver-hhl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gdb-4.17-mips-gdbserver-hhl.patch"

--- gdb-4.17/gdb/gdbserver/remote-utils.c.orig	Tue Mar 11 07:49:17 1997
+++ gdb-4.17/gdb/gdbserver/remote-utils.c	Tue May 23 11:12:12 2000
@@ -127,9 +127,12 @@
       if (remote_desc == -1)
 	perror_with_name ("Accept failed");
 
+/* [jsun] getprotobyname() hangs on mips - we just use number 6
directly */
+/*
       protoent = getprotobyname ("tcp");
       if (!protoent)
 	perror_with_name ("getprotobyname");
+ */
 
       /* Enable TCP keep alive process. */
       tmp = 1;
@@ -138,7 +141,10 @@
       /* Tell TCP not to delay small packets.  This greatly speeds up
 	 interactive response. */
       tmp = 1;
+/*
       setsockopt (remote_desc, protoent->p_proto, TCP_NODELAY,
+ */
+      setsockopt (remote_desc, 6, TCP_NODELAY,
 		  (char *)&tmp, sizeof(tmp));
 
       close (tmp_desc);		/* No longer need this */
@@ -447,7 +453,8 @@
   if (status == 'T')
     {
       buf = outreg (PC_REGNUM, buf);
-      buf = outreg (FP_REGNUM, buf);
+      /* [jsun] this causes client to complain */
+      /* buf = outreg (FP_REGNUM, buf); */
       buf = outreg (SP_REGNUM, buf);
 #ifdef NPC_REGNUM
       buf = outreg (NPC_REGNUM, buf);

--------------732E7D3674406CC64CF16CED--
