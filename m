Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2007 07:27:34 +0100 (BST)
Received: from alnrmhc15.comcast.net ([204.127.225.95]:37119 "EHLO
	alnrmhc15.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021865AbXEYG1c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 May 2007 07:27:32 +0100
Received: from [192.168.1.4] (c-76-106-119-205.hsd1.md.comcast.net[76.106.119.205])
          by comcast.net (alnrmhc15) with ESMTP
          id <20070525062648b15008ei1te>; Fri, 25 May 2007 06:26:48 +0000
Message-ID: <465681A7.1060300@gentoo.org>
Date:	Fri, 25 May 2007 02:26:47 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH]: Fix IP35 definitions in IP32 code
Content-Type: multipart/mixed;
 boundary="------------010907040309080707090409"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010907040309080707090409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Some IP35 defines snuck into some IP32-specific code during the DMA re-write. 
Although cosmetic, the attached patch corrects these defines to their proper 
IP32 versions.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>


  dma-coherence.h |    6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

--------------010907040309080707090409
Content-Type: text/plain;
 name="ip32-is-not-ip35.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ip32-is-not-ip35.patch"

diff -Naurp mipslinux.a/include/asm-mips/mach-ip32/dma-coherence.h mipslinux.b/include/asm-mips/mach-ip32/dma-coherence.h
--- mipslinux.a/include/asm-mips/mach-ip32/dma-coherence.h	2007-05-14 02:13:24.000000000 -0400
+++ mipslinux.b/include/asm-mips/mach-ip32/dma-coherence.h	2007-05-14 09:15:36.000000000 -0400
@@ -6,8 +6,8 @@
  * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
  *
  */
-#ifndef __ASM_MACH_IP35_DMA_COHERENCE_H
-#define __ASM_MACH_IP35_DMA_COHERENCE_H
+#ifndef __ASM_MACH_IP32_DMA_COHERENCE_H
+#define __ASM_MACH_IP32_DMA_COHERENCE_H
 
 #include <asm/ip32/crime.h>
 
@@ -69,4 +69,4 @@ static inline int plat_device_is_coheren
 	return 0;		/* IP32 is non-cohernet */
 }
 
-#endif /* __ASM_MACH_IP35_DMA_COHERENCE_H */
+#endif /* __ASM_MACH_IP32_DMA_COHERENCE_H */

--------------010907040309080707090409--
