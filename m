Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6QHoFF17673
	for linux-mips-outgoing; Thu, 26 Jul 2001 10:50:15 -0700
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6QHoEV17667
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 10:50:14 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA01154
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 10:49:57 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 15Pp6Y-0001jp-00; Thu, 26 Jul 2001 10:39:22 -0700
Date: Thu, 26 Jul 2001 10:39:22 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: [patch] fix profiling in glibc for Linux/MIPS
Message-ID: <20010726103922.A6643@nevyn.them.org>
Mail-Followup-To: libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

_mcount was doing awful things to its caller's stack frame.

Theoretically, we can get by with 16 bytes less of stack than I now
allocate, but GCC still considers functions that call _mcount to be leaf
functions, so that doesn't work.  I think this is close enough; it only adds
one instruction.  Is this OK?  Do I need a "nop" after the subu?  My MIPS
assembly knowledge is not that thorough.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

--- glibc-2.2.3/sysdeps/mips/machine-gmon.h.orig	Wed Jul 25 20:09:20 2001
+++ glibc-2.2.3/sysdeps/mips/machine-gmon.h	Wed Jul 25 21:14:09 2001
@@ -35,22 +35,23 @@
         ".set noreorder;" \
         ".set noat;" \
         CPLOAD \
-        "sw $4,8($29);" \
-        "sw $5,12($29);" \
-        "sw $6,16($29);" \
-        "sw $7,20($29);" \
-        "sw $1,0($29);" \
-        "sw $31,4($29);" \
+	"subu $29,$29,40;" \
+        "sw $4,24($29);" \
+        "sw $5,28($29);" \
+        "sw $6,32($29);" \
+        "sw $7,36($29);" \
+        "sw $1,16($29);" \
+        "sw $31,20($29);" \
         "move $5,$31;" \
         "jal __mcount;" \
         "move $4,$1;" \
-        "lw $4,8($29);" \
-        "lw $5,12($29);" \
-        "lw $6,16($29);" \
-        "lw $7,20($29);" \
-        "lw $31,4($29);" \
-        "lw $1,0($29);" \
-        "addu $29,$29,8;" \
+        "lw $4,24($29);" \
+        "lw $5,28($29);" \
+        "lw $6,32($29);" \
+        "lw $7,36($29);" \
+        "lw $31,20($29);" \
+        "lw $1,16($29);" \
+        "addu $29,$29,48;" \
         "j $31;" \
         "move $31,$1;" \
         ".set reorder;" \
