Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:57:21 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58915 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993907AbdFSPuZIMgZH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:50:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id AD75A1A4551;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 8DA961A45F2;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 2/8] MIPS: build: Fix "-modd-spreg" switch usage when compiling for mips32r6
Date:   Mon, 19 Jun 2017 17:50:09 +0200
Message-Id: <1497887415-13825-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

Add "-modd-spreg" when compiling the kernel for mips32r6 target.

This makes sure the kernel builds properly even with toolchains that
use "-mno-odd-spreg" by default. This is the case with Android gcc.
Prior to this patch, kernel builds using gcc for Android failed with
following error messages, if target architecture is set to mips32r6:

arch/mips/kernel/r4k_switch.S: Assembler messages:
.../r4k_switch.S:210: Error: float register should be even, was 1
.../r4k_switch.S:212: Error: float register should be even, was 3
.../r4k_switch.S:214: Error: float register should be even, was 5
.../r4k_switch.S:216: Error: float register should be even, was 7
.../r4k_switch.S:218: Error: float register should be even, was 9
.../r4k_switch.S:220: Error: float register should be even, was 11
.../r4k_switch.S:222: Error: float register should be even, was 13
.../r4k_switch.S:224: Error: float register should be even, was 15
.../r4k_switch.S:226: Error: float register should be even, was 17
.../r4k_switch.S:228: Error: float register should be even, was 19
.../r4k_switch.S:230: Error: float register should be even, was 21
.../r4k_switch.S:232: Error: float register should be even, was 23
.../r4k_switch.S:234: Error: float register should be even, was 25
.../r4k_switch.S:236: Error: float register should be even, was 27
.../r4k_switch.S:238: Error: float register should be even, was 29
.../r4k_switch.S:240: Error: float register should be even, was 31
make[2]: *** [arch/mips/kernel/r4k_switch.o] Error 1

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index bc96c39..1c0ec36 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -160,7 +160,7 @@ cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS
 			-Wa,-mips32 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R2)	+= $(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
 			-Wa,-mips32r2 -Wa,--trap
-cflags-$(CONFIG_CPU_MIPS32_R6)	+= -march=mips32r6 -Wa,--trap
+cflags-$(CONFIG_CPU_MIPS32_R6)	+= -march=mips32r6 -Wa,--trap -modd-spreg
 cflags-$(CONFIG_CPU_MIPS64_R1)	+= $(call cc-option,-march=mips64,-mips64 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64) \
 			-Wa,-mips64 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS64_R2)	+= $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64) \
-- 
2.7.4
