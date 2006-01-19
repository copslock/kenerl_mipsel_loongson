Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 14:14:04 +0000 (GMT)
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:39043 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8134398AbWASOMn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 14:12:43 +0000
Received: from [192.168.1.4] (pcp04414054pcs.nrockv01.md.comcast.net[69.140.185.48])
          by comcast.net (rwcrmhc14) with ESMTP
          id <20060119141626014002e0f0e>; Thu, 19 Jan 2006 14:16:26 +0000
Message-ID: <43CF9F37.6030801@gentoo.org>
Date:	Thu, 19 Jan 2006 09:16:23 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: Fix RM52xx Support for SGI O2
Content-Type: multipart/mixed;
 boundary="------------010204030906080203070507"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010204030906080203070507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


SGI O2 systems can use the rare RM5200 CPU board (Nevada).  Building the kernel 
with RM52xx selected, will however, cause an ARCS Exception at bootup because 
the kernel was built with cpu_has_llsc defined.

Changing the macro check in asm-mips/mach-ip32/cpu-feature-overrides.h to check 
for both CPU_R5000 or CPU_NEVADA and CPU_64BIT will fix the issue by defining 
cpu_has_llsc to 0.  The patch below does this, allowing an RM52xx kernel to be 
booted on SGI O2 systems.  It also allows such a CPU to be selected in 
menuconfig on O2 as well.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

--------------010204030906080203070507
Content-Type: text/plain;
 name="misc-2.6.15-ip32-fix-rm52xx-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.6.15-ip32-fix-rm52xx-support.patch"

diff -Naurp linux-2.6.14.6.orig/arch/mips/Kconfig linux-2.6.14.6/arch/mips/Kconfig
--- linux-2.6.14.6.orig/arch/mips/Kconfig	2006-01-19 01:36:52.000000000 -0500
+++ linux-2.6.14.6/arch/mips/Kconfig	2006-01-19 01:44:23.000000000 -0500
@@ -594,6 +594,7 @@ config SGI_IP32
 	select SYS_HAS_CPU_R5000
 	select SYS_HAS_CPU_R10000 if BROKEN
 	select SYS_HAS_CPU_RM7000
+	select SYS_HAS_CPU_NEVADA
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	help
diff -Naurp linux-2.6.14.6.orig/include/asm-mips/mach-ip32/cpu-feature-overrides.h linux-2.6.14.6/include/asm-mips/mach-ip32/cpu-feature-overrides.h
--- linux-2.6.14.6.orig/include/asm-mips/mach-ip32/cpu-feature-overrides.h	2006-01-19 01:36:52.000000000 -0500
+++ linux-2.6.14.6/include/asm-mips/mach-ip32/cpu-feature-overrides.h	2006-01-19 01:44:52.000000000 -0500
@@ -18,7 +18,7 @@
  * so, for 64bit IP32 kernel we just don't use ll/sc.
  * This does not affect luserland.
  */
-#if defined(CONFIG_CPU_R5000) && defined(CONFIG_64BIT)
+#if (defined(CONFIG_CPU_R5000) || defined(CONFIG_CPU_NEVADA)) && defined(CONFIG_64BIT)
 #define cpu_has_llsc		0
 #else
 #define cpu_has_llsc		1

--------------010204030906080203070507--
