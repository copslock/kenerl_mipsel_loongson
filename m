Received:  by oss.sgi.com id <S42255AbQGEBNh>;
	Tue, 4 Jul 2000 18:13:37 -0700
Received: from u-179.karlsruhe.ipdial.viaginterkom.de ([62.180.18.179]:47367
        "EHLO u-179.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42250AbQGEBNV>; Tue, 4 Jul 2000 18:13:21 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1405870AbQGEBNS>;
        Wed, 5 Jul 2000 03:13:18 +0200
Date:   Wed, 5 Jul 2000 03:13:18 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Andreas Jaeger <aj@suse.de>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: FPU Control Word: Initial Value looks wrong
Message-ID: <20000705031318.A7627@bacchus.dhis.org>
References: <u8sntrm88t.fsf@gromit.rhein-neckar.de> <20000704003232.A2112@bacchus.dhis.org> <u8g0pqjfaf.fsf@gromit.rhein-neckar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <u8g0pqjfaf.fsf@gromit.rhein-neckar.de>; from aj@suse.de on Tue, Jul 04, 2000 at 01:39:04PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Looking at the fcr31 bug I found some other bug which probably isn't causing
what you observe but is a bug anyway - fpu_control_t was a 16-bit type
but should be a 32-bit type.  Patch below.

Is _FPU_IEEE used at all and is it's definition right?

I asked more people to run your test program.  The result is that glibc
2.0.6 (both shared and static tried) and 2.2 print ``0 0'' while glibc
2.0.7 prints a non-zero value.

Can you check if the variable __fpu_control, is it's value non-zero?

  Ralf

2000-07-05  Ralf Baechle  <ralf@gnu.org>

	* sysdeps/mips/fpu_control.h: Make fpu_control_t a 32-bit type.

--- libc/sysdeps/mips/fpu_control.h.orig	Wed Jul  5 02:51:54 2000
+++ libc/sysdeps/mips/fpu_control.h	Wed Jul  5 02:52:58 2000
@@ -1,5 +1,5 @@
 /* FPU control word bits.  Mips version.
-   Copyright (C) 1996, 1997, 1998, 1999 Free Software Foundation, Inc.
+   Copyright (C) 1996, 1997, 1998, 1999, 2000 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Olaf Flebbe and Ralf Baechle.
 
@@ -86,10 +86,10 @@
 #define _FPU_IEEE     0x00000F80
 
 /* Type of the control word.  */
-typedef unsigned int fpu_control_t __attribute__ ((__mode__ (__HI__)));
+typedef unsigned int fpu_control_t __attribute__ ((__mode__ (__SI__)));
 
 /* Macros for accessing the hardware control word.  */
-#define _FPU_GETCW(cw) __asm__ ("cfc1 %0,$31" : "=r" (cw) : )
+#define _FPU_GETCW(cw) __asm__ ("cfc1 %0,$31" : "=r" (cw))
 #define _FPU_SETCW(cw) __asm__ ("ctc1 %0,$31" : : "r" (cw))
 
 /* Default control word set at startup.  */
