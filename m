Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 20:31:25 +0000 (GMT)
Received: from smtp.gentoo.org ([134.68.220.30]:47085 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S3457351AbWAWUbI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 20:31:08 +0000
Received: from kumba by smtp.gentoo.org with local (Exim 4.54)
	id 1F18PF-0003yG-OD
	for linux-mips@linux-mips.org; Mon, 23 Jan 2006 20:35:17 +0000
Date:	Mon, 23 Jan 2006 20:35:17 +0000
From:	Kumba <kumba@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH]: Fix IP22 4k cache macro in cpu-feature-overrides.h
Message-ID: <20060123203517.GC499@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In include/asm-mips/mach-ip22/cpu-feature-overrides.h, the macro to use R4K-style caches is mis-spelt.  This will 
cause IP22 systems to panic early in the boot due to no cache style being defined.  The attached patch corrects this.


--Kumba


--
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands do them because they must, while the
eyes of the great are elsewhere." --Elrond


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="misc-2.6.15-ip22-fix-4k-cache-macro.patch"

--- include/asm-mips/mach-ip22/cpu-feature-overrides.h.orig	2006-01-23 13:18:24.000000000 -0500
+++ include/asm-mips/mach-ip22/cpu-feature-overrides.h	2006-01-23 13:18:53.000000000 -0500
@@ -13,7 +13,7 @@
  */
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_4kcache		1
+#define cpu_has_4k_cache	1
 #define cpu_has_fpu		1
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1

--9Ek0hoCL9XbhcSqy--
