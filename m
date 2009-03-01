Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Mar 2009 00:19:58 +0000 (GMT)
Received: from mail.codesourcery.com ([65.74.133.4]:19179 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20809045AbZCAAT4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 1 Mar 2009 00:19:56 +0000
Received: (qmail 18996 invoked from network); 1 Mar 2009 00:19:53 -0000
Received: from unknown (HELO pl.orcam.me.uk) (macro@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 1 Mar 2009 00:19:53 -0000
Date:	Sun, 1 Mar 2009 00:19:36 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@codesourcery.com>
To:	libc-ports@sourceware.org
cc:	linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] MIPS: Cooked FP register for new ABIs
Message-ID: <alpine.DEB.1.10.0903010013320.4064@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
Precedence: bulk
X-list: linux-mips

Hello,

 Here is a change to <sys/fpregdef.h> to provide correct cooked FP 
register names for the MIPS n64 and n32 ABIs according to "MIPSpro 
Assembly Language Programmer's Guide" (Silicon Graphic's document number 
007-2418-004).

2009-03-01  Maciej W. Rozycki  <macro@codesourcery.com>

	* sysdeps/mips/sys/fpregdef.h: Update for new ABIs.

 Please apply.

  Maciej

glibc-ports-2.9.90-20090226-mips-fpregdef-15.patch
diff -up --recursive --new-file glibc-ports-2.9.90-20090226.macro/sysdeps/mips/sys/fpregdef.h glibc-ports-2.9.90-20090226/sysdeps/mips/sys/fpregdef.h
--- glibc-ports-2.9.90-20090226.macro/sysdeps/mips/sys/fpregdef.h	2001-07-06 04:56:01.000000000 +0000
+++ glibc-ports-2.9.90-20090226/sysdeps/mips/sys/fpregdef.h	2009-03-01 00:10:53.000000000 +0000
@@ -1,4 +1,4 @@
-/* Copyright (C) 1991, 92, 94, 95, 96, 97, 98 Free Software Foundation, Inc.
+/* Copyright (C) 1991,92,94,95,96,97,98,2009 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
    The GNU C Library is free software; you can redistribute it and/or
@@ -19,19 +19,52 @@
 #ifndef _SYS_FPREGDEF_H
 #define _SYS_FPREGDEF_H
 
-/*
- * These definitions only cover the R3000-ish 16/32 register model.
- * But we're trying to be R3000 friendly anyway ...
- */
-#define fv0	$f0      /* return value */
-#define fv0f	$f1
+#include <sgidefs.h>
+
+/* Commonalities first, individualities next...  */
+
+#define fv0	$f0	/* return value */
 #define fv1	$f2
+
+#if _MIPS_SIM == _ABIO32 || _MIPS_SIM == _ABIN32
+#define fs0	$f20	/* callee saved */
+#define fs1	$f22
+#define fs2	$f24
+#define fs3	$f26
+#define fs4	$f28
+#define fs5	$f30
+#endif /* _MIPS_SIM == _ABIO32 || _MIPS_SIM == _ABIN32 */
+
+#if _MIPS_SIM == _ABI64 || _MIPS_SIM == _ABIN32
+#define fa0	$f12	/* argument registers */
+#define fa1	$f13
+#define fa2	$f14
+#define fa3	$f15
+#define fa4	$f16
+#define fa5	$f17
+#define fa6	$f18
+#define fa7	$f19
+
+#define ft0	$f4	/* caller saved */
+#define ft1	$f5
+#define ft2	$f6
+#define ft3	$f7
+#define ft4	$f8
+#define ft5	$f9
+#define ft6	$f10
+#define ft7	$f11
+#endif /* _MIPS_SIM == _ABI64 || _MIPS_SIM == _ABIN32 */
+
+#if _MIPS_SIM == _ABIO32
+#define fv0f	$f1	/* return value, high part */
 #define fv1f	$f3
-#define fa0	$f12     /* argument registers */
+
+#define fa0	$f12	/* argument registers */
 #define fa0f	$f13
 #define fa1	$f14
 #define fa1f	$f15
-#define ft0	$f4      /* caller saved */
+
+#define ft0	$f4	/* caller saved */
 #define ft0f	$f5
 #define ft1	$f6
 #define ft1f	$f7
@@ -43,19 +76,44 @@
 #define ft4f	$f17
 #define ft5	$f18
 #define ft5f	$f19
-#define fs0	$f20     /* callee saved */
-#define fs0f	$f21
-#define fs1	$f22
+
+#define fs0f	$f21	/* callee saved, high part */
 #define fs1f	$f23
-#define fs2	$f24
 #define fs2f	$f25
-#define fs3	$f26
 #define fs3f	$f27
-#define fs4	$f28
 #define fs4f	$f29
-#define fs5	$f30
 #define fs5f	$f31
+#endif /* _MIPS_SIM == _ABIO32 */
+
+#if _MIPS_SIM == _ABI64
+#define ft8	$f20	/* caller saved */
+#define ft9	$f21
+#define ft10	$f22
+#define ft11	$f23
+#define ft12	$f1
+#define ft13	$f3
+
+#define fs0	$f24	/* callee saved */
+#define fs1	$f25
+#define fs2	$f26
+#define fs3	$f27
+#define fs4	$f28
+#define fs5	$f29
+#define fs6	$f30
+#define fs7	$f31
+#endif /* _MIPS_SIM == _ABI64 */
+
+#if _MIPS_SIM == _ABIN32
+#define ft8	$f21	/* caller saved */
+#define ft9	$f23
+#define ft10	$f25
+#define ft11	$f27
+#define ft12	$f29
+#define ft13	$f31
+#define ft14	$f1
+#define ft15	$f3
+#endif /* _MIPS_SIM == _ABIN32 */
 
-#define fcr31	$31      /* FPU status register */
+#define fcr31	$31	/* FPU status register */
 
 #endif /* sys/fpregdef.h */
