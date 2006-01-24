Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 19:26:22 +0000 (GMT)
Received: from smtp.gentoo.org ([134.68.220.30]:51094 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S8133545AbWAXT0E (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2006 19:26:04 +0000
Received: from kumba by smtp.gentoo.org with local (Exim 4.54)
	id 1F1Tru-000537-QC
	for linux-mips@linux-mips.org; Tue, 24 Jan 2006 19:30:18 +0000
Date:	Tue, 24 Jan 2006 19:30:18 +0000
From:	Kumba <kumba@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Fix IP22 4k cache macro in cpu-feature-overrides.h
Message-ID: <20060124193018.GA24568@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

MIPS machines define a macro in cpu-feature-overrides.h that
specifies the cache style they use.  Several machines have a typo in
this macro that will cause the kernel to panic early in the boot
process.

The attached patch fixes these typos so the correct cache style is
defined.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---

 mach-ip22/cpu-feature-overrides.h  |    2 +-
 mach-mips/cpu-feature-overrides.h  |    4 ++--
 mach-rm200/cpu-feature-overrides.h |    2 +-
 mach-sim/cpu-feature-overrides.h   |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-4k-cache-macros.patch"

diff -Naurp mipslinux/include/asm-mips/mach-ip22/cpu-feature-overrides.h mipslinux-4kcache/include/asm-mips/mach-ip22/cpu-feature-overrides.h
--- mipslinux/include/asm-mips/mach-ip22/cpu-feature-overrides.h	2006-01-22 21:14:29.000000000 -0500
+++ mipslinux-4kcache/include/asm-mips/mach-ip22/cpu-feature-overrides.h	2006-01-24 13:41:14.000000000 -0500
@@ -13,7 +13,7 @@
  */
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 #define cpu_has_fpu		1
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
diff -Naurp mipslinux/include/asm-mips/mach-mips/cpu-feature-overrides.h mipslinux-4kcache/include/asm-mips/mach-mips/cpu-feature-overrides.h
--- mipslinux/include/asm-mips/mach-mips/cpu-feature-overrides.h	2006-01-22 21:14:29.000000000 -0500
+++ mipslinux-4kcache/include/asm-mips/mach-mips/cpu-feature-overrides.h	2006-01-24 13:41:14.000000000 -0500
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
diff -Naurp mipslinux/include/asm-mips/mach-rm200/cpu-feature-overrides.h mipslinux-4kcache/include/asm-mips/mach-rm200/cpu-feature-overrides.h
--- mipslinux/include/asm-mips/mach-rm200/cpu-feature-overrides.h	2006-01-22 21:14:29.000000000 -0500
+++ mipslinux-4kcache/include/asm-mips/mach-rm200/cpu-feature-overrides.h	2006-01-24 13:41:14.000000000 -0500
@@ -14,7 +14,7 @@
 
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 #define cpu_has_fpu		1
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
diff -Naurp mipslinux/include/asm-mips/mach-sim/cpu-feature-overrides.h mipslinux-4kcache/include/asm-mips/mach-sim/cpu-feature-overrides.h
--- mipslinux/include/asm-mips/mach-sim/cpu-feature-overrides.h	2006-01-22 21:14:29.000000000 -0500
+++ mipslinux-4kcache/include/asm-mips/mach-sim/cpu-feature-overrides.h	2006-01-24 13:41:14.000000000 -0500
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

--n8g4imXOkfNTN/H1--
