Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Dec 2015 06:04:42 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:48268 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006645AbbLXFElQn-7b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Dec 2015 06:04:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From;
        bh=YnDZL9OuCTY+C2M3JncMqcwyiHyvVgPicOx5h+ByxTA=; b=C9BLEB+jDffLfRt644X0yof7t6
        WZ81VnDz21X0fncnsNIL3ajW1485TvTPrWV+RAJKYiatz5neUO+3vuy3ZTKW3ainCA7WDlCkNEnLu
        psuegxzb6FPR/U0k94Co2DMUOdZVwlPcPN4x/dc/Ds7ZQ4M4rvPBIJIAZmADT14d9yD4=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54539 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86)
        (envelope-from <linux@roeck-us.net>)
        id 1aBy54-003Jdd-Ok; Thu, 24 Dec 2015 05:04:51 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH -next] MIPS: VDSO: Fix build error with binutils 2.24 and earlier
Date:   Wed, 23 Dec 2015 21:04:31 -0800
Message-Id: <1450933471-7357-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.1.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Commit 2a037f310bab ("MIPS: VDSO: Fix build error") tries to fix a build
error seen with binutils 2.24 and earlier. However, the fix does not work,
and again results in the already known build errors if the kernel is built
with an earlier version of binutils.

CC      arch/mips/vdso/gettimeofday.o
/tmp/ccnOVbHT.s: Assembler messages:
/tmp/ccnOVbHT.s:50: Error: can't resolve `_start' {*UND* section} - `L0 {.text section}
/tmp/ccnOVbHT.s:374: Error: can't resolve `_start' {*UND* section} - `L0 {.text section}
scripts/Makefile.build:258: recipe for target 'arch/mips/vdso/gettimeofday.o' failed
make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1

Fixes: 2a037f310bab ("MIPS: VDSO: Fix build error")
Cc: Qais Yousef <qais.yousef@imgtec.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Tested with binutils 2.25 and 2.22.

 arch/mips/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 018f8c7b94f2..14568900fc1d 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -26,7 +26,7 @@ aflags-vdso := $(ccflags-vdso) \
 # the comments on that file.
 #
 ifndef CONFIG_CPU_MIPSR6
-  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
+  ifeq ($(call ld-ifversion, -lt, 22500000, y),y)
     $(warning MIPS VDSO requires binutils >= 2.25)
     obj-vdso-y := $(filter-out gettimeofday.o, $(obj-vdso-y))
     ccflags-vdso += -DDISABLE_MIPS_VDSO
-- 
2.1.4
