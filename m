Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2003 17:33:55 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:23267 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225418AbTKURdn>; Fri, 21 Nov 2003 17:33:43 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id A4CCB49BFE; Fri, 21 Nov 2003 18:33:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 9334347485; Fri, 21 Nov 2003 18:33:37 +0100 (CET)
Date: Fri, 21 Nov 2003 18:33:37 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] 2.4, head: PAGE_SHIFT changes break glibc
Message-ID: <Pine.LNX.4.55.0311211550270.32551@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Ralf,

 Recent changes made to <asm/page.h> break a build of glibc 2.2.5 for me.  
Compilation bails out due to PAGE_SHIFT being undeclared -- glibc pulls it
as it uses PAGE_SIZE in linuxthreads/internals.h.  The PAGE_SHIFT macro
depends on configuration now (I use an empty cofinguration for glibc
headers, hence the error) and thus it'd better be simply private to the
kernel.  Glibc will then use sysconf(_SC_PAGE_SIZE) which now better
reflects actual configuration of the system it's run on.

 Here's a patch that limits PAGE_SIZE to the kernel scope.  If there's any
other program that needs PAGE_SIZE, it should be converted to
sysconf(_SC_PAGE_SIZE) as well.

 OK to apply?

 Additionally, I think we should also implement the getpagesize syscall to
benefit statically linked programs (and make glibc use it like for other
platforms that use variable page sizes).  Finally, I'm not sure such a
noticeable change was a good move in these late days of 2.4...

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

linux-include-mips-2.4.22-20031115-mips-page_size.patch
diff -up --recursive --new-file linux-include-mips-2.4.22-20031115.macro/include/asm-mips/page.h linux-include-mips-2.4.22-20031115/include/asm-mips/page.h
--- linux-include-mips-2.4.22-20031115.macro/include/asm-mips/page.h	2003-10-17 02:57:33.000000000 +0000
+++ linux-include-mips-2.4.22-20031115/include/asm-mips/page.h	2003-11-21 09:29:52.000000000 +0000
@@ -12,6 +12,8 @@
 
 #include <linux/config.h>
 
+#ifdef __KERNEL__
+
 /*
  * PAGE_SHIFT determines the page size
  */
@@ -27,8 +29,6 @@
 #define PAGE_SIZE	(1L << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
-#ifdef __KERNEL__
-
 #ifndef __ASSEMBLY__
 
 #include <asm/cacheflush.h>
diff -up --recursive --new-file linux-include-mips-2.4.22-20031115.macro/include/asm-mips64/page.h linux-include-mips-2.4.22-20031115/include/asm-mips64/page.h
--- linux-include-mips-2.4.22-20031115.macro/include/asm-mips64/page.h	2003-10-17 02:57:34.000000000 +0000
+++ linux-include-mips-2.4.22-20031115/include/asm-mips64/page.h	2003-11-21 09:30:10.000000000 +0000
@@ -11,6 +11,8 @@
 
 #include <linux/config.h>
 
+#ifdef __KERNEL__
+
 /*
  * PAGE_SHIFT determines the page size
  */
@@ -26,8 +28,6 @@
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
-#ifdef __KERNEL__
-
 #ifndef __ASSEMBLY__
 
 #include <asm/cacheflush.h>
