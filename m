Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jun 2006 07:17:51 +0100 (BST)
Received: from sccrmhc11.comcast.net ([63.240.77.81]:37004 "EHLO
	sccrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8134174AbWFRGRH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Jun 2006 07:17:07 +0100
Received: from [127.0.0.1] (unknown[69.140.185.142])
          by comcast.net (sccrmhc11) with ESMTP
          id <2006061806170001100ep4cbe>; Sun, 18 Jun 2006 06:17:00 +0000
Message-ID: <4494EFDD.4000500@gentoo.org>
Date:	Sun, 18 Jun 2006 02:17:01 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: Fix R4K Cache Macro names
Content-Type: multipart/mixed;
 boundary="------------010705090509090304030304"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010705090509090304030304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Several machines have the R4K cache macro name spelled incorrectly.  Namely, 
they have cpu_has_4kcache defined instead of cpu_has_4k_cache.

--Kumba


Signed-off-by: Joshua Kinard <kumba@gentoo.org>

  mach-ip22/cpu-feature-overrides.h  |    2 +-
  mach-mips/cpu-feature-overrides.h  |    4 ++--
  mach-rm200/cpu-feature-overrides.h |    2 +-
  mach-sim/cpu-feature-overrides.h   |    4 ++--
  4 files changed, 6 insertions(+), 6 deletions(-)

--------------010705090509090304030304
Content-Type: text/plain;
 name="fix-4k-cache-macros.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-4k-cache-macros.patch"

diff -Naurp linux-2.6.17.mips.orig/include/asm-mips/mach-ip22/cpu-feature-overrides.h linux-2.6.17.mips.p2/include/asm-mips/mach-ip22/cpu-feature-overrides.h
--- linux-2.6.17.mips.orig/include/asm-mips/mach-ip22/cpu-feature-overrides.h	2006-06-17 00:45:12.000000000 -0400
+++ linux-2.6.17.mips.p2/include/asm-mips/mach-ip22/cpu-feature-overrides.h	2006-06-17 00:54:42.000000000 -0400
@@ -13,7 +13,7 @@
  */
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 #define cpu_has_fpu		1
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
diff -Naurp linux-2.6.17.mips.orig/include/asm-mips/mach-mips/cpu-feature-overrides.h linux-2.6.17.mips.p2/include/asm-mips/mach-mips/cpu-feature-overrides.h
--- linux-2.6.17.mips.orig/include/asm-mips/mach-mips/cpu-feature-overrides.h	2006-06-17 00:45:12.000000000 -0400
+++ linux-2.6.17.mips.p2/include/asm-mips/mach-mips/cpu-feature-overrides.h	2006-06-17 00:54:42.000000000 -0400
@@ -17,7 +17,7 @@
 #ifdef CONFIG_CPU_MIPS32
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 /* #define cpu_has_fpu		? */
 /* #define cpu_has_32fpr	? */
 #define cpu_has_counter		1
@@ -47,7 +47,7 @@
 #ifdef CONFIG_CPU_MIPS64
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 /* #define cpu_has_fpu		? */
 /* #define cpu_has_32fpr	? */
 #define cpu_has_counter		1
diff -Naurp linux-2.6.17.mips.orig/include/asm-mips/mach-rm200/cpu-feature-overrides.h linux-2.6.17.mips.p2/include/asm-mips/mach-rm200/cpu-feature-overrides.h
--- linux-2.6.17.mips.orig/include/asm-mips/mach-rm200/cpu-feature-overrides.h	2006-06-17 00:45:12.000000000 -0400
+++ linux-2.6.17.mips.p2/include/asm-mips/mach-rm200/cpu-feature-overrides.h	2006-06-17 00:54:42.000000000 -0400
@@ -14,7 +14,7 @@
 
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 #define cpu_has_fpu		1
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
diff -Naurp linux-2.6.17.mips.orig/include/asm-mips/mach-sim/cpu-feature-overrides.h linux-2.6.17.mips.p2/include/asm-mips/mach-sim/cpu-feature-overrides.h
--- linux-2.6.17.mips.orig/include/asm-mips/mach-sim/cpu-feature-overrides.h	2006-06-17 00:45:12.000000000 -0400
+++ linux-2.6.17.mips.p2/include/asm-mips/mach-sim/cpu-feature-overrides.h	2006-06-17 00:54:42.000000000 -0400
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

--------------010705090509090304030304--
