Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 16:41:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64233 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012407AbbBBPlPHz-0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 16:41:15 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 48B2E378E0649;
        Mon,  2 Feb 2015 15:41:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 2 Feb 2015 15:41:09 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 2 Feb 2015 15:41:07 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 1/2] MIPS: Makefile: Move the ASEs checks after setting the core's CFLAGS
Date:   Mon, 2 Feb 2015 15:41:01 +0000
Message-ID: <1422891662-13838-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

We need to check the ASEs support against the core's CFLAGS instead
of depending to the default -march option from the toolchain.

Cc: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Makefile | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2563a088d3b8..61818364221d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -122,26 +122,8 @@ predef-le += -DMIPSEL -D_MIPSEL -D__MIPSEL -D__MIPSEL__
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(shell $(CC) -dumpmachine |grep -q 'mips.*el-.*' && echo -EB $(undef-all) $(predef-be))
 cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= $(shell $(CC) -dumpmachine |grep -q 'mips.*el-.*' || echo -EL $(undef-all) $(predef-le))
 
-# For smartmips configurations, there are hundreds of warnings due to ISA overrides
-# in assembly and header files. smartmips is only supported for MIPS32r1 onwards
-# and there is no support for 64-bit. Various '.set mips2' or '.set mips3' or
-# similar directives in the kernel will spam the build logs with the following warnings:
-# Warning: the `smartmips' extension requires MIPS32 revision 1 or greater
-# or
-# Warning: the 64-bit MIPS architecture does not support the `smartmips' extension
-# Pass -Wa,--no-warn to disable all assembler warnings until the kernel code has
-# been fixed properly.
-cflags-$(CONFIG_CPU_HAS_SMARTMIPS)	+= $(call cc-option,-msmartmips) -Wa,--no-warn
-cflags-$(CONFIG_CPU_MICROMIPS) += $(call cc-option,-mmicromips)
-
 cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
 				   -fno-omit-frame-pointer
-
-ifeq ($(CONFIG_CPU_HAS_MSA),y)
-toolchain-msa	:= $(call cc-option-yn,-mhard-float -mfp64 -Wa$(comma)-mmsa)
-cflags-$(toolchain-msa)		+= -DTOOLCHAIN_SUPPORTS_MSA
-endif
-
 #
 # CPU-dependent compiler/assembler options for optimization.
 #
@@ -194,6 +176,23 @@ KBUILD_CFLAGS_MODULE += -msb1-pass1-workarounds
 endif
 endif
 
+# For smartmips configurations, there are hundreds of warnings due to ISA overrides
+# in assembly and header files. smartmips is only supported for MIPS32r1 onwards
+# and there is no support for 64-bit. Various '.set mips2' or '.set mips3' or
+# similar directives in the kernel will spam the build logs with the following warnings:
+# Warning: the `smartmips' extension requires MIPS32 revision 1 or greater
+# or
+# Warning: the 64-bit MIPS architecture does not support the `smartmips' extension
+# Pass -Wa,--no-warn to disable all assembler warnings until the kernel code has
+# been fixed properly.
+mips-cflags				:= "$(cflags-y)"
+cflags-$(CONFIG_CPU_HAS_SMARTMIPS)	+= $(call cc-option,$(mips-cflags),-msmartmips) -Wa,--no-warn
+cflags-$(CONFIG_CPU_MICROMIPS)		+= $(call cc-option,$(mips-cflags),-mmicromips)
+ifeq ($(CONFIG_CPU_HAS_MSA),y)
+toolchain-msa				:= $(call cc-option-yn,-$(mips-cflags),mhard-float -mfp64 -Wa$(comma)-mmsa)
+cflags-$(toolchain-msa)			+= -DTOOLCHAIN_SUPPORTS_MSA
+endif
+
 #
 # Firmware support
 #
-- 
2.2.2
