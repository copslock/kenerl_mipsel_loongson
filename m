Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 02:38:31 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:48687 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991162AbeFSAiXO0MRg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 02:38:23 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1413.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 19 Jun 2018 00:38:04 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Mon, 18
 Jun 2018 17:38:17 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Mon, 18 Jun 2018 17:38:17 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Always use -march=<arch>, not -<arch> shortcuts
Date:   Mon, 18 Jun 2018 17:37:59 -0700
Message-ID: <20180619003800.32129-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529368684-531715-24936-178260-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194177
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,jhogan@kernel.org,ralf@linux-mips.org,stable@vger.kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

The VDSO Makefile filters CFLAGS to select a subset which it uses whilst
building the VDSO ELF. One of the flags it allows through is the -march=
flag that selects the architecture/ISA to target.

Unfortunately in cases where CONFIG_CPU_MIPS32_R{1,2}=y and the
toolchain defaults to building for MIPS64, the main MIPS Makefile ends
up using the short-form -<arch> flags in cflags-y. This is because the
calls to cc-option always fail to use the long-form -march=<arch> flag
due to the lack of an -mabi=<abi> flag in KBUILD_CFLAGS at the point
where the cc-option function is executed. The resulting GCC invocation
is something like:

  $ mips64-linux-gcc -Werror -march=mips32r2 -c -x c /dev/null -o tmp
  cc1: error: '-march=mips32r2' is not compatible with the selected ABI

These short-form -<arch> flags are dropped by the VDSO Makefile's
filtering, and so we attempt to build the VDSO without specifying any
architecture. This results in an attempt to build the VDSO using
whatever the compiler's default architecture is, regardless of whether
that is suitable for the kernel configuration.

One encountered build failure resulting from this mismatch is a
rejection of the sync instruction if the kernel is configured for a
MIPS32 or MIPS64 r1 or r2 target but the toolchain defaults to an older
architecture revision such as MIPS1 which did not include the sync
instruction:

    CC      arch/mips/vdso/gettimeofday.o
  /tmp/ccGQKoOj.s: Assembler messages:
  /tmp/ccGQKoOj.s:273: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:329: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:520: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:714: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1009: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1066: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1114: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1279: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1334: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1374: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1459: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1514: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:1814: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:2002: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  /tmp/ccGQKoOj.s:2066: Error: opcode not supported on this processor: mips1 (mips1) `sync'
  make[2]: *** [scripts/Makefile.build:318: arch/mips/vdso/gettimeofday.o] Error 1
  make[1]: *** [scripts/Makefile.build:558: arch/mips/vdso] Error 2
  make[1]: *** Waiting for unfinished jobs....

This can be reproduced for example by attempting to build
pistachio_defconfig using Arnd's GCC 8.1.0 mips64 toolchain from
kernel.org:

  https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-mips64-linux.tar.xz

Resolve this problem by using the long-form -march=<arch> in all cases,
which makes it through the arch/mips/vdso/Makefile's filtering & is thus
consistently used to build both the kernel proper & the VDSO.

The use of cc-option to prefer the long-form & fall back to the
short-form flags makes no sense since the short-form is just an
abbreviation for the also-supported long-form in all GCC versions that
we support building with. This means there is no case in which we have
to use the short-form -<arch> flags, so we can simply remove them.

The manual redefinition of _MIPS_ISA is removed naturally along with the
use of the short-form flags that it accompanied, and whilst here we
remove the separate assembler ISA selection. I suspect that both of
these were only required due to the mips32 vs mips2 mismatch that was
introduced by commit 59b3e8e9aac6 ("[MIPS] Makefile crapectomy.") and
fixed but not cleaned up by commit 9200c0b2a07c ("[MIPS] Fix Makefile
bugs for MIPS32/MIPS64 R1 and R2.").

I've marked this for backport as far as v4.4 where the MIPS VDSO was
introduced. In earlier kernels there should be no ill effect to using
the short-form flags.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.4+
---

 arch/mips/Makefile | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index e2122cca4ae2..1e98d22ec119 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -155,15 +155,11 @@ cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
 cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
 cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
 cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
-cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
-			-Wa,-mips32 -Wa,--trap
-cflags-$(CONFIG_CPU_MIPS32_R2)	+= $(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
-			-Wa,-mips32r2 -Wa,--trap
+cflags-$(CONFIG_CPU_MIPS32_R1)	+= -march=mips32 -Wa,--trap
+cflags-$(CONFIG_CPU_MIPS32_R2)	+= -march=mips32r2 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R6)	+= -march=mips32r6 -Wa,--trap -modd-spreg
-cflags-$(CONFIG_CPU_MIPS64_R1)	+= $(call cc-option,-march=mips64,-mips64 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64) \
-			-Wa,-mips64 -Wa,--trap
-cflags-$(CONFIG_CPU_MIPS64_R2)	+= $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64) \
-			-Wa,-mips64r2 -Wa,--trap
+cflags-$(CONFIG_CPU_MIPS64_R1)	+= -march=mips64 -Wa,--trap
+cflags-$(CONFIG_CPU_MIPS64_R2)	+= -march=mips64r2 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS64_R6)	+= -march=mips64r6 -Wa,--trap
 cflags-$(CONFIG_CPU_R5000)	+= -march=r5000 -Wa,--trap
 cflags-$(CONFIG_CPU_R5432)	+= $(call cc-option,-march=r5400,-march=r5000) \
-- 
2.17.1
