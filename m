Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:11:16 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:7404 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225399AbSLSKLQ>;
	Thu, 19 Dec 2002 10:11:16 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 535F8D657; Thu, 19 Dec 2002 11:17:18 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: remove warnings on promlib
References: <Pine.GSO.3.96.1021218174743.5977E-100000@delta.ds2.pg.gda.pl>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.3.96.1021218174743.5977E-100000@delta.ds2.pg.gda.pl>
Date: 19 Dec 2002 11:17:18 +0100
Message-ID: <m2r8cemhxt.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On 18 Dec 2002, Juan Quintela wrote:
>> Index: arch/mips/lib/promlib.c
>> ===================================================================
>> RCS file: /home/cvs/linux/arch/mips/lib/promlib.c,v
>> retrieving revision 1.1.2.1
>> diff -u -r1.1.2.1 promlib.c
>> --- arch/mips/lib/promlib.c	28 Sep 2002 22:28:38 -0000	1.1.2.1
>> +++ arch/mips/lib/promlib.c	18 Dec 2002 00:49:18 -0000
>> @@ -1,3 +1,7 @@
>> +
>> +#include <asm/sgialib.h>
>> +#include <linux/kernel.h>
>> +
>> #include <stdarg.h>
>> 
>> void prom_printf(char *fmt, ...)

maciej> A few comments:

maciej> 1. <linux> includes first, <asm> ones following (hmm, shouldn't that be
maciej> obvious...).

maciej> 2. <linux/kernel.h> is obviously OK for vsprintf().

maciej> 3. I would hesitate using <asm/sgialib.h> here being too much platform
maciej> specific.  Either a separate generic <asm/prom.h> should be created for
maciej> primitives like prom_putchar(), prom_getchar(), etc. or a private
maciej> conservative declaration should be used here.  The reason is the functions
maciej> are much platform-specific, e.g. they may be pointers or even macros --
maciej> see <asm/dec/prom.h> for a not-so-trivial example (luckily, DECstations
maciej> support prom_printf() directly, so they don't have to use promlib.c).

Something like that?

Once there, s/vsprintf/vsnprintf/.

If anybody calls prom_printf with more than 1024 chars, we were b0rked
:((

I didn't did the changes for the other users of prom_* that was using 
asm/sgialib.h, but change is trivial.

Later, Juan.

diff -uNp build/include/asm-mips/prom.h.orig build/include/asm-mips/prom.h
--- build/include/asm-mips/prom.h.orig	1970-01-01 01:00:00.000000000 +0100
+++ build/include/asm-mips/prom.h	2002-12-18 19:00:47.000000000 +0100
@@ -0,0 +1,21 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Interface with the low level prom consoles.
+ *
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ * Copyright (C) 2001, 2002 Ralf Baechle (ralf@gnu.org)
+ */
+#ifndef _ASM_PROM_H
+#define _ASM_PROM_H
+
+/* Simple char-by-char console I/O. */
+extern void prom_putchar(char c);
+extern char prom_getchar(void);
+
+/* Generic printf() console I/O. */
+extern void prom_printf(char *fmt, ...);
+
+#endif /* _ASM_PROM_H */
Index: arch/mips/arc/init.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/arc/init.c,v
retrieving revision 1.10.2.3
diff -u -r1.10.2.3 init.c
--- arch/mips/arc/init.c	1 Aug 2002 22:26:40 -0000	1.10.2.3
+++ arch/mips/arc/init.c	19 Dec 2002 09:21:07 -0000
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 
 #include <asm/sgialib.h>
+#include <asm/prom.h>
 
 #undef DEBUG_PROM_INIT
 
Index: arch/mips/lib/promlib.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/promlib.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 promlib.c
--- arch/mips/lib/promlib.c	28 Sep 2002 22:28:38 -0000	1.1.2.1
+++ arch/mips/lib/promlib.c	19 Dec 2002 09:21:08 -0000
@@ -1,13 +1,20 @@
+
+
+#include <linux/kernel.h>
+#include <asm/prom.h>
+
 #include <stdarg.h>
 
+#define BUFSIZE 1024
+
 void prom_printf(char *fmt, ...)
 {
 	va_list args;
-	char ppbuf[1024];
+	char ppbuf[BUFSIZE];
 	char *bptr;
 
 	va_start(args, fmt);
-	vsprintf(ppbuf, fmt, args);
+	vsnprintf(ppbuf, BUFSIZE, fmt, args);
 
 	bptr = ppbuf;
 

Index: arch/mips/sgi-ip22/ip22-system.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-system.c,v
retrieving revision 1.1.2.8
diff -u -r1.1.2.8 ip22-system.c
--- arch/mips/sgi-ip22/ip22-system.c	18 Dec 2002 19:11:09 -0000	1.1.2.8
+++ arch/mips/sgi-ip22/ip22-system.c	19 Dec 2002 09:21:09 -0000
@@ -11,6 +11,7 @@
 #include <asm/cpu.h>
 #include <asm/sgi/sgi.h>
 #include <asm/sgialib.h>
+#include <asm/prom.h>
 
 enum sgi_mach sgimach;
 
Index: include/asm-mips/sgialib.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/sgialib.h,v
retrieving revision 1.10.2.3
diff -u -r1.10.2.3 sgialib.h
--- include/asm-mips/sgialib.h	1 Aug 2002 22:26:40 -0000	1.10.2.3
+++ include/asm-mips/sgialib.h	19 Dec 2002 09:21:15 -0000
@@ -30,13 +30,6 @@
 /* Init the PROM library and it's internal data structures. */
 extern void prom_init(int argc, char **argv, char **envp, int *prom_vec);
 
-/* Simple char-by-char console I/O. */
-extern void prom_putchar(char c);
-extern char prom_getchar(void);
-
-/* Generic printf() using ARCS console I/O. */
-extern void prom_printf(char *fmt, ...);
-
 /* Memory descriptor management. */
 #define PROM_MAX_PMEMBLOCKS    32
 struct prom_pmemblock {

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
