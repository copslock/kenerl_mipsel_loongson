Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jan 2017 05:32:45 +0100 (CET)
Received: from resqmta-ch2-08v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:40]:53290
        "EHLO resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbdA2Ecif0Nh9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jan 2017 05:32:38 +0100
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-08v.sys.comcast.net with SMTP
        id Xh9qcK9SYdT7bXhAKc6zHS; Sun, 29 Jan 2017 04:32:36 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-01v.sys.comcast.net with SMTP
        id XhAJcloGtqBvQXhAJcztco; Sun, 29 Jan 2017 04:32:36 +0000
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH] IP27: Fix spaces.h to prevent a build error
Message-ID: <a6e09082-643a-b8f6-8a48-0783309f482a@gentoo.org>
Date:   Sat, 28 Jan 2017 23:32:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO56dc9KipNT0gRdPCXf5eMpEn1EHc2+sUtd1FZ9ppqfn2AL8kSGtYe6a8RYbnnZYTWuV30JvCMWCmU4ZIKRD6/JbDaKau8NN+VzgK9FfHnbDfWT2UJn
 45yIGswOpm71ARWOzs49/3OnOvOccPxPXN/9THlyoJyeeS0PXcI4m7Vm51Mw1DJY6nkbo1vQdDviSeRUEpTuDfoLc6+yzApu2epzjzHRmPo6OnQ5oV0LIFZt
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Joshua Kinard <kumba@gentoo.org>

Fix IP27's spaces.h file to avoid the below build error:

    CC      arch/mips/vdso/gettimeofday-o32.o
  In file included from ./arch/mips/include/asm/mach-ip27/spaces.h:29:0,
                   from ./arch/mips/include/asm/page.h:12,
                   from arch/mips/vdso/vdso.h:26,
                   from arch/mips/vdso/gettimeofday.c:11:
  ./arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE" redefined [-Werror]
   #define CAC_BASE  _AC(0x80000000, UL)
  
  In file included from ./arch/mips/include/asm/page.h:12:0,
                   from arch/mips/vdso/vdso.h:26,
                   from arch/mips/vdso/gettimeofday.c:11:
  ./arch/mips/include/asm/mach-ip27/spaces.h:22:0: note: this is the location of the previous definition
   #define CAC_BASE  0xa800000000000000
  
  cc1: all warnings being treated as errors
  make[2]: *** [arch/mips/vdso/Makefile:117: arch/mips/vdso/gettimeofday-o32.o] Error 1
  make[1]: *** [scripts/Makefile.build:551: arch/mips/vdso] Error 2
  make[1]: *** Waiting for unfinished jobs....

Fixes include using the _AC() constant to protect addresses if used in
assembly and wrapping the addresses with a CONFIG_64BIT ifdef.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/mach-ip27/spaces.h |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

linux-mips-4.10-ip27-fix-spaces_h.patch
diff --git a/arch/mips/include/asm/mach-ip27/spaces.h b/arch/mips/include/asm/mach-ip27/spaces.h
index 4775a1136a5b..27d32da8442c 100644
--- a/arch/mips/include/asm/mach-ip27/spaces.h
+++ b/arch/mips/include/asm/mach-ip27/spaces.h
@@ -10,21 +10,24 @@
 #ifndef _ASM_MACH_IP27_SPACES_H
 #define _ASM_MACH_IP27_SPACES_H
 
+#include <linux/const.h>
+
 /*
  * IP27 uses the R10000's uncached attribute feature.  Attribute 3 selects
  * uncached memory addressing.
  */
-
-#define HSPEC_BASE		0x9000000000000000
-#define IO_BASE			0x9200000000000000
-#define MSPEC_BASE		0x9400000000000000
-#define UNCAC_BASE		0x9600000000000000
-#define CAC_BASE		0xa800000000000000
+#ifdef CONFIG_64BIT
+#define HSPEC_BASE		_AC(0x9000000000000000, UL)
+#define IO_BASE			_AC(0x9200000000000000, UL)
+#define MSPEC_BASE		_AC(0x9400000000000000, UL)
+#define UNCAC_BASE		_AC(0x9600000000000000, UL)
+#define CAC_BASE		_AC(0xa800000000000000, UL)
 
 #define TO_MSPEC(x)		(MSPEC_BASE | ((x) & TO_PHYS_MASK))
 #define TO_HSPEC(x)		(HSPEC_BASE | ((x) & TO_PHYS_MASK))
 
 #define HIGHMEM_START		(~0UL)
+#endif /* CONFIG_64BIT */
 
 #include <asm/mach-generic/spaces.h>
 
