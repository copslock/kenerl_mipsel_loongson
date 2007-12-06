Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2007 07:13:08 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:18952 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022157AbXLFHM6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Dec 2007 07:12:58 +0000
Received: (qmail 20223 invoked by uid 1000); 6 Dec 2007 08:11:56 +0100
Date:	Thu, 6 Dec 2007 08:11:56 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Alchemy: Fix Au1x SD controller IRQ
Message-ID: <20071206071156.GA20211@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

With the introduction of MIPS_CPU_IRQ_BASE, the hardcoded IRQ number
of the au1100/au1200 SD controller(s) is no longer valid.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

--- linux-2.6.24-rc4/include/asm-mips/mach-au1x00/au1100_mmc.h	2007-12-04 08:31:24.613002000 +0100
+++ linux-2.6.24-rc4-work/include/asm-mips/mach-au1x00/au1100_mmc.h	2007-12-06 15:33:35.000000000 +0100
@@ -41,8 +41,11 @@
 
 #define NUM_AU1100_MMC_CONTROLLERS	2
 
-
-#define AU1100_SD_IRQ	2
+#if defined(CONFIG_SOC_AU1100)
+#define AU1100_SD_IRQ	AU1100_SD_INT
+#elif defined(CONFIG_SOC_AU1200)
+#define AU1100_SD_IRQ	AU1200_SD_INT
+#endif
 
 
 #define SD0_BASE	0xB0600000
