Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 22:33:31 +0000 (GMT)
Received: from smtp.gentoo.org ([134.68.220.30]:37355 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S3458400AbWAWWdO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 22:33:14 +0000
Received: from kumba by smtp.gentoo.org with local (Exim 4.54)
	id 1F1AJP-0004uX-JD
	for linux-mips@linux-mips.org; Mon, 23 Jan 2006 22:37:23 +0000
Date:	Mon, 23 Jan 2006 22:37:23 +0000
From:	Kumba <kumba@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Fix IP22 4k cache macro in cpu-feature-overrides.h
Message-ID: <20060123223723.GF499@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vKFfOv5t3oGVpiF+"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> "cpu_has_4kcache" is used in a number of other files too.

Attached is an updated patch which takes care of all of those references as well.


--Kumba


--
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands do them because they must, while the
eyes of the great are elsewhere." --Elrond


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="misc-2.6.15-fix-4k-cache-macros.patch"

diff -Naurp linux-2.6.15.1.orig/include/asm-mips/mach-ip22/cpu-feature-overrides.h linux-2.6.15.1/include/asm-mips/mach-ip22/cpu-feature-overrides.h
--- linux-2.6.15.1.orig/include/asm-mips/mach-ip22/cpu-feature-overrides.h	2006-01-23 16:49:30.000000000 -0500
+++ linux-2.6.15.1/include/asm-mips/mach-ip22/cpu-feature-overrides.h	2006-01-23 17:16:13.000000000 -0500
@@ -13,7 +13,7 @@
  */
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 #define cpu_has_fpu		1
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
diff -Naurp linux-2.6.15.1.orig/include/asm-mips/mach-mips/cpu-feature-overrides.h linux-2.6.15.1/include/asm-mips/mach-mips/cpu-feature-overrides.h
--- linux-2.6.15.1.orig/include/asm-mips/mach-mips/cpu-feature-overrides.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15.1/include/asm-mips/mach-mips/cpu-feature-overrides.h	2006-01-23 17:15:57.000000000 -0500
@@ -17,7 +17,7 @@
 #ifdef CONFIG_CPU_MIPS32
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 /* #define cpu_has_fpu		? */
 /* #define cpu_has_32fpr	? */
 #define cpu_has_counter		1
@@ -43,7 +43,7 @@
 #ifdef CONFIG_CPU_MIPS64
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 /* #define cpu_has_fpu		? */
 /* #define cpu_has_32fpr	? */
 #define cpu_has_counter		1
diff -Naurp linux-2.6.15.1.orig/include/asm-mips/mach-rm200/cpu-feature-overrides.h linux-2.6.15.1/include/asm-mips/mach-rm200/cpu-feature-overrides.h
--- linux-2.6.15.1.orig/include/asm-mips/mach-rm200/cpu-feature-overrides.h	2006-01-23 16:49:30.000000000 -0500
+++ linux-2.6.15.1/include/asm-mips/mach-rm200/cpu-feature-overrides.h	2006-01-23 17:16:25.000000000 -0500
@@ -14,7 +14,7 @@
 
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 #define cpu_has_fpu		1
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
diff -Naurp linux-2.6.15.1.orig/include/asm-mips/mach-sim/cpu-feature-overrides.h linux-2.6.15.1/include/asm-mips/mach-sim/cpu-feature-overrides.h
--- linux-2.6.15.1.orig/include/asm-mips/mach-sim/cpu-feature-overrides.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15.1/include/asm-mips/mach-sim/cpu-feature-overrides.h	2006-01-23 17:16:42.000000000 -0500
@@ -16,7 +16,7 @@
 #ifdef CONFIG_CPU_MIPS32
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 #define cpu_has_fpu		0
 /* #define cpu_has_32fpr	? */
 #define cpu_has_counter		1
@@ -41,7 +41,7 @@
 #ifdef CONFIG_CPU_MIPS64
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 /* #define cpu_has_fpu		? */
 /* #define cpu_has_32fpr	? */
 #define cpu_has_counter		1

--vKFfOv5t3oGVpiF+--
