Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2004 17:51:13 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:43792 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224930AbUKORvH>;
	Mon, 15 Nov 2004 17:51:07 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CTl8C-0000no-00; Mon, 15 Nov 2004 17:59:12 +0000
Received: from perivale.mips.com ([192.168.192.200])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CTkzo-00083t-00; Mon, 15 Nov 2004 17:50:32 +0000
Received: from macro (helo=localhost)
	by perivale.mips.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1CTkzo-00027G-00; Mon, 15 Nov 2004 17:50:32 +0000
Date: Mon, 15 Nov 2004 17:50:32 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: libc-alpha@sources.redhat.com,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Nigel Stephens <nigel@mips.com>
Subject: Re: [PATCH] MIPS/Linux: Kernel vs libc struct siginfo discrepancy
In-Reply-To: <20041110180050.GK7235@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.61.0411151534360.22526@perivale.mips.com>
References: <Pine.LNX.4.61.0411101657420.11408@perivale.mips.com>
 <20041110180050.GK7235@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.81, required 4, AWL,
	BAYES_00)
Return-Path: <macro@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
X-list: linux-mips

On Wed, 10 Nov 2004, Thiemo Seufer wrote:

> I prefer to bring the 2.4 kernel in line with the rest of the system.

 This is what is now in effect (Ralf, thanks for looking into it) and all 
that is left to be done is to fix padding done in glibc as this is 
incorrect for 64-bit MIPS.  Here is a patch based on the current Linux 
<asm-mips/siginfo.h> header and sysdeps/unix/sysv/linux/bits/siginfo.h.  
It seems to work for me for the mips-linux host.

2004-11-15  Maciej W. Rozycki  <macro@mips.com>

	* sysdeps/unix/sysv/linux/mips/bits/siginfo.h (__SI_MAX_SIZE): 
	Define appropriately based on __WORDSIZE.
	[struct siginfo] (__pad0): Add for explicit padding.

	* sysdeps/unix/sysv/linux/mips/bits/siginfo.h: Formatting fixes 
	throughout.

 Please apply.

  Maciej

glibc-2.3.3-20041018-mips-siginfo-pad-3.patch
diff -up --recursive --new-file glibc-2.3.3-20041018.macro/sysdeps/unix/sysv/linux/mips/bits/siginfo.h glibc-2.3.3-20041018/sysdeps/unix/sysv/linux/mips/bits/siginfo.h
--- glibc-2.3.3-20041018.macro/sysdeps/unix/sysv/linux/mips/bits/siginfo.h	Fri May 23 02:26:20 2003
+++ glibc-2.3.3-20041018/sysdeps/unix/sysv/linux/mips/bits/siginfo.h	Mon Nov 15 15:44:49 2004
@@ -1,5 +1,6 @@
 /* siginfo_t, sigevent and constants.  Linux/MIPS version.
-   Copyright (C) 1997, 1998, 2000, 2001, 2002, 2003 Free Software Foundation, Inc.
+   Copyright (C) 1997, 1998, 2000, 2001, 2002, 2003, 2004
+	Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
    The GNU C Library is free software; you can redistribute it and/or
@@ -22,6 +23,8 @@
 # error "Never include this file directly.  Use <signal.h> instead"
 #endif
 
+#include <bits/wordsize.h>
+
 #if (!defined __have_sigval_t \
      && (defined _SIGNAL_H || defined __need_siginfo_t \
 	 || defined __need_sigevent_t))
@@ -39,8 +42,13 @@ typedef union sigval
      && (defined _SIGNAL_H || defined __need_siginfo_t))
 # define __have_siginfo_t	1
 
-# define __SI_MAX_SIZE     128
-# define __SI_PAD_SIZE     ((__SI_MAX_SIZE / sizeof (int)) - 3)
+# define __SI_MAX_SIZE		128
+# if __WORDSIZE == 64
+#  define __SI_PAD_SIZE		((__SI_MAX_SIZE / sizeof (int)) - 4)
+# else
+#  define __SI_PAD_SIZE		((__SI_MAX_SIZE / sizeof (int)) - 3)
+# endif
+
 
 typedef struct siginfo
   {
@@ -48,6 +56,8 @@ typedef struct siginfo
     int si_code;		/* Signal code.  */
     int si_errno;		/* If non-zero, an errno value associated with
 				   this signal, as defined in <errno.h>.  */
+    int __pad0[__SI_MAX_SIZE / sizeof (int) - __SI_PAD_SIZE - 3];
+				/* Explicit padding.  */
 
     union
       {
@@ -121,9 +131,9 @@ enum
 {
   SI_ASYNCNL = -60,		/* Sent by asynch name lookup completion.  */
 # define SI_ASYNCNL	SI_ASYNCNL
-  SI_TKILL = -6,		/* Sent by tkill. */
+  SI_TKILL = -6,		/* Sent by tkill.  */
 # define SI_TKILL	SI_TKILL
-  SI_SIGIO,			/* Sent by queued SIGIO. */
+  SI_SIGIO,			/* Sent by queued SIGIO.  */
 # define SI_SIGIO	SI_SIGIO
   SI_MESGQ,			/* Sent by real time mesq state change.  */
 # define SI_MESGQ	SI_MESGQ
@@ -149,7 +159,7 @@ enum
 # define ILL_ILLOPN	ILL_ILLOPN
   ILL_ILLADR,			/* Illegal addressing mode.  */
 # define ILL_ILLADR	ILL_ILLADR
-  ILL_ILLTRP,			/* Illegal trap. */
+  ILL_ILLTRP,			/* Illegal trap.  */
 # define ILL_ILLTRP	ILL_ILLTRP
   ILL_PRVOPC,			/* Privileged opcode.  */
 # define ILL_PRVOPC	ILL_PRVOPC
