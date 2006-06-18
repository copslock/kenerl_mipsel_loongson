Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jun 2006 07:17:08 +0100 (BST)
Received: from sccrmhc13.comcast.net ([204.127.200.83]:31879 "EHLO
	sccrmhc13.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8134172AbWFRGQ7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Jun 2006 07:16:59 +0100
Received: from [127.0.0.1] (unknown[69.140.185.142])
          by comcast.net (sccrmhc13) with ESMTP
          id <2006061806165201300mcfnpe>; Sun, 18 Jun 2006 06:16:53 +0000
Message-ID: <4494EFD5.8090601@gentoo.org>
Date:	Sun, 18 Jun 2006 02:16:53 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: Add Missing R4K Cache Macros to IP27 & IP32
Content-Type: multipart/mixed;
 boundary="------------060001030903080505010700"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060001030903080505010700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Keeping in accordance with other machines, IP27 and IP32 lack a few macros. 
IP27 lacks cpu_has_4kex & cpu_has_4k_cache macros while IP32 lacks just the 
cpu_has_4k_cache macro.

--Kumba


Signed-off-by: Joshua Kinard <kumba@gentoo.org>

  mach-ip27/cpu-feature-overrides.h |    3 +++
  mach-ip32/cpu-feature-overrides.h |    2 ++
  2 files changed, 5 insertions(+)

--------------060001030903080505010700
Content-Type: text/plain;
 name="add-4k-cache-macros.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-4k-cache-macros.patch"

diff -Naurp linux-2.6.17.mips.orig/include/asm-mips/mach-ip27/cpu-feature-overrides.h linux-2.6.17.mips.p1/include/asm-mips/mach-ip27/cpu-feature-overrides.h
--- linux-2.6.17.mips.orig/include/asm-mips/mach-ip27/cpu-feature-overrides.h	2006-06-17 00:45:12.000000000 -0400
+++ linux-2.6.17.mips.p1/include/asm-mips/mach-ip27/cpu-feature-overrides.h	2006-06-17 00:54:29.000000000 -0400
@@ -31,6 +31,9 @@
 #define cpu_has_nofpuex		0
 #define cpu_has_64bits		1
 
+#define cpu_has_4kex		1
+#define cpu_has_4k_cache	1
+
 #define cpu_has_subset_pcaches	1
 
 #define cpu_dcache_line_size()	32
diff -Naurp linux-2.6.17.mips.orig/include/asm-mips/mach-ip32/cpu-feature-overrides.h linux-2.6.17.mips.p1/include/asm-mips/mach-ip32/cpu-feature-overrides.h
--- linux-2.6.17.mips.orig/include/asm-mips/mach-ip32/cpu-feature-overrides.h	2006-06-17 00:45:12.000000000 -0400
+++ linux-2.6.17.mips.p1/include/asm-mips/mach-ip32/cpu-feature-overrides.h	2006-06-17 00:54:29.000000000 -0400
@@ -38,6 +38,8 @@
 #define cpu_has_vtag_icache	0
 #define cpu_has_ic_fills_f_dc	0
 #define cpu_has_dsp		0
+#define cpu_has_4k_cache	1
+
 
 #define cpu_has_mips32r1	0
 #define cpu_has_mips32r2	0

--------------060001030903080505010700--
