Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Feb 2007 13:09:22 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:51415 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20038757AbXBCNJR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Feb 2007 13:09:17 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1HDKam-0003Kg-00; Sat, 03 Feb 2007 14:06:08 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 48B42C2E0E; Sat,  3 Feb 2007 14:06:10 +0100 (CET)
Date:	Sat, 3 Feb 2007 14:06:10 +0100
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: PATCH: Fix mc146818_decode_year
Message-ID: <20070203130610.GA18062@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips


Big endian RMs uses a different mc146818_decode_year than little endian RMs
Correct mc146818_decode_year for years before 2000

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 include/asm-mips/mach-atlas/mc146818rtc.h   |    2 +-
 include/asm-mips/mach-generic/mc146818rtc.h |    2 +-
 include/asm-mips/mach-mips/mc146818rtc.h    |    2 +-
 include/asm-mips/mach-rm/mc146818rtc.h      |   10 +++++++---
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/asm-mips/mach-atlas/mc146818rtc.h b/include/asm-mips/mach-atlas/mc146818rtc.h
index a73a569..51d337e 100644
--- a/include/asm-mips/mach-atlas/mc146818rtc.h
+++ b/include/asm-mips/mach-atlas/mc146818rtc.h
@@ -55,6 +55,6 @@ static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
 
 #define RTC_ALWAYS_BCD	0
 
-#define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1970)
+#define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1900)
 
 #endif /* __ASM_MACH_ATLAS_MC146818RTC_H */
diff --git a/include/asm-mips/mach-generic/mc146818rtc.h b/include/asm-mips/mach-generic/mc146818rtc.h
index 90c2e6f..0b9a942 100644
--- a/include/asm-mips/mach-generic/mc146818rtc.h
+++ b/include/asm-mips/mach-generic/mc146818rtc.h
@@ -30,7 +30,7 @@ static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
 #define RTC_ALWAYS_BCD	1
 
 #ifndef mc146818_decode_year
-#define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1970)
+#define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1900)
 #endif
 
 #endif /* __ASM_MACH_GENERIC_MC146818RTC_H */
diff --git a/include/asm-mips/mach-mips/mc146818rtc.h b/include/asm-mips/mach-mips/mc146818rtc.h
index 6730ba0..ea612f3 100644
--- a/include/asm-mips/mach-mips/mc146818rtc.h
+++ b/include/asm-mips/mach-mips/mc146818rtc.h
@@ -43,6 +43,6 @@ static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
 
 #define RTC_ALWAYS_BCD	0
 
-#define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1970)
+#define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1900)
 
 #endif /* __ASM_MACH_MALTA_MC146818RTC_H */
diff --git a/include/asm-mips/mach-rm/mc146818rtc.h b/include/asm-mips/mach-rm/mc146818rtc.h
index d37ae68..103ae8e 100644
--- a/include/asm-mips/mach-rm/mc146818rtc.h
+++ b/include/asm-mips/mach-rm/mc146818rtc.h
@@ -7,11 +7,15 @@
  *
  * RTC routines for PC style attached Dallas chip with ARC epoch.
  */
-#ifndef __ASM_MACH_RM200_MC146818RTC_H
-#define __ASM_MACH_RM200_MC146818RTC_H
+#ifndef __ASM_MACH_RM_MC146818RTC_H
+#define __ASM_MACH_RM_MC146818RTC_H
 
+#if CONFIG_CPU_BIG_ENDIAN
+#define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1900)
+#else
 #define mc146818_decode_year(year) ((year) + 1980)
+#endif
 
 #include_next <mc146818rtc.h>
 
-#endif /* __ASM_MACH_RM200_MC146818RTC_H */
+#endif /* __ASM_MACH_RM_MC146818RTC_H */
-- 
1.4.4.3

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
