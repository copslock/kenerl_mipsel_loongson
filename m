Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3PHjBC09934
	for linux-mips-outgoing; Wed, 25 Apr 2001 10:45:11 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3PHjAM09924
	for <linux-mips@oss.sgi.com>; Wed, 25 Apr 2001 10:45:10 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f3PHeW030661;
	Wed, 25 Apr 2001 10:40:32 -0700
Message-ID: <3AE70BBA.2BD8B387@mvista.com>
Date: Wed, 25 Apr 2001 10:39:06 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Soanes <ians@lineo.com>
CC: Michael Shmulevich <michaels@jungo.com>,
   Linux/MIPS <linux-mips@oss.sgi.com>
Subject: Re: usermode gdb / remote gdb
References: <3AE67CBA.4060606@jungo.com> <3AE69AAA.76A20F08@lineo.com> <3AE6A795.1080004@jungo.com> <3AE6B14F.B5844932@lineo.com>
Content-Type: multipart/mixed;
 boundary="------------AEBE6AF5F67A9630EAEB3882"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------AEBE6AF5F67A9630EAEB3882
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ian Soanes wrote:
> 
> Michael Shmulevich wrote:
> >
> > Ian Soanes wrote:
> >
> > > The (host side) gdb I've been using was configured with ./configure
> > > --target=mipsel-linux-elf (my target is an IDT MIPS 79S334 evaluation
> > > board). I too am using an x86 host. I used a development version of
> > > gdb-5.0 (I found the 'official' 5.0 had problems with the
> > > add-symbol-file command that I use for kernel module debugging, and more
> > > importantly for you... breakpoints didn't work) These problems are gone
> > > in the later version.
> >
> > To start with, mips-linux-elf is not supported by gdbserver either with
> > out-of-the-box 5.0:
> >
> 
> Hi Michael,
> 
> No, I meant configuring the 'cross-debugging' gdb that I use on the x86
> host. I think standard 5.0 will support the mipsel-linux-elf target also
> (but something later is better). As for gdbserver... yes, you'll be out
> of luck... that's why I have to hand build (cross compile) it (pending
> getting the config stuff sorted out).
> 

Hmm, I added linux-mips target for gdbserver in gdb 4.17.  And I thought Ralf
sent the patch back to FSF (as I had to fill out some copyright forms). 
Perhaps it is lost somewhere?

Anyhow, here is the patch that I submitted.  Hopefully it helps.

Jun
--------------AEBE6AF5F67A9630EAEB3882
Content-Type: text/plain; charset=us-ascii;
 name="gdb-4.17-mips-gdbserver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gdb-4.17-mips-gdbserver.patch"

--- gdb-4.17/gdb/config/mips/mipsel-linux.mh.orig	Mon May 22 18:39:07 2000
+++ gdb-4.17/gdb/config/mips/mipsel-linux.mh	Mon May 22 18:39:07 2000
@@ -3,6 +3,8 @@
 XM_FILE= xm-llinux.h
 NAT_FILE= nm-linux.h
 NATDEPFILES= infptrace.o inftarg.o mipslinux-nat.o corelow.o core-regset.o fork-child.o solib.o
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

--------------AEBE6AF5F67A9630EAEB3882--
