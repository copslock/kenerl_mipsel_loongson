Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 15:44:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2866 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012309AbbA3Oo2JV9tg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 15:44:28 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F324A71483A19
        for <linux-mips@linux-mips.org>; Fri, 30 Jan 2015 14:44:19 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 14:44:22 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 30 Jan 2015 14:44:20 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/2] MIPS: Makefile: Set correct ISA level for MIPS ASEs
Date:   Fri, 30 Jan 2015 14:44:15 +0000
Message-ID: <1422629056-27715-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45574
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

We need to check the ASE support against the correct ISA level
instead of trusting the toolchain will have a good default.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2563a088d3b8..0608ec524d3d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -131,14 +131,14 @@ cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= $(shell $(CC) -dumpmachine |grep -q 'mips.
 # Warning: the 64-bit MIPS architecture does not support the `smartmips' extension
 # Pass -Wa,--no-warn to disable all assembler warnings until the kernel code has
 # been fixed properly.
-cflags-$(CONFIG_CPU_HAS_SMARTMIPS)	+= $(call cc-option,-msmartmips) -Wa,--no-warn
-cflags-$(CONFIG_CPU_MICROMIPS) += $(call cc-option,-mmicromips)
+cflags-$(CONFIG_CPU_HAS_SMARTMIPS)	+= $(call cc-option,-march=mips32r2 -msmartmips) -Wa,--no-warn
+cflags-$(CONFIG_CPU_MICROMIPS) += $(call cc-option,-march=mips32r2 -mmicromips)
 
 cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
 				   -fno-omit-frame-pointer
 
 ifeq ($(CONFIG_CPU_HAS_MSA),y)
-toolchain-msa	:= $(call cc-option-yn,-mhard-float -mfp64 -Wa$(comma)-mmsa)
+toolchain-msa	:= $(call cc-option-yn,-march=mips32r2 -mhard-float -mfp64 -Wa$(comma)-mmsa)
 cflags-$(toolchain-msa)		+= -DTOOLCHAIN_SUPPORTS_MSA
 endif
 
-- 
2.2.2
