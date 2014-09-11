Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 10:39:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61741 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008714AbaIKIhiSVhTy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 10:37:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 26DF774F2B3C9;
        Thu, 11 Sep 2014 09:37:30 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 09:37:31 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 11 Sep 2014 08:35:00 +0100
Received: from pburton-laptop.home (192.168.159.78) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 08:35:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 10/10] MIPS: Kconfig option to better exercise/debug hybrid FPRs
Date:   Thu, 11 Sep 2014 08:30:23 +0100
Message-ID: <1410420623-11691-11-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
References: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.78]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The hybrid FPR scheme exists to allow for compatibility between existing
FP32 code and newly compiled FP64A code. Such code should hopefully be
rare in the real world, and for the moment is difficult to come across.
All code except that built for the FP64 ABI can correctly execute using
the hybrid FPR scheme, so debugging the hybrid FPR implementation can
be eased by forcing all such code to use it. This is undesirable in
general due to the trap & emulate overhead of the hybrid FPR
implementation, but is a very useful option to have for debugging.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig.debug | 13 +++++++++++++
 arch/mips/kernel/elf.c  | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 3a2b775..88a9f43 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -122,4 +122,17 @@ config SPINLOCK_TEST
 	help
 	  Add several files to the debugfs to test spinlock speed.
 
+config FP32XX_HYBRID_FPRS
+	bool "Run FP32 & FPXX code with hybrid FPRs"
+	depends on MIPS_O32_FP64_SUPPORT
+	help
+	  The hybrid FPR scheme is normally used only when a program needs to
+	  execute a mix of FP32 & FP64A code, since the trapping & emulation
+	  that it entails is expensive. When enabled, this option will lead
+	  to the kernel running programs which use the FP32 & FPXX FP ABIs
+	  using the hybrid FPR scheme, which can be useful for debugging
+	  purposes.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 34e9af5..abf8a1a 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -124,6 +124,24 @@ int arch_check_elf(void *_ehdr, bool has_interpreter,
 
 void mips_set_personality_fp(struct arch_elf_state *state)
 {
+	if (config_enabled(CONFIG_FP32XX_HYBRID_FPRS)) {
+		/*
+		 * Use hybrid FPRs for all code which can correctly execute
+		 * with that mode.
+		 */
+		switch (state->overall_abi) {
+		case MIPS_ABI_FP_DOUBLE:
+		case MIPS_ABI_FP_SINGLE:
+		case MIPS_ABI_FP_SOFT:
+		case MIPS_ABI_FP_XX:
+		case MIPS_ABI_FP_ANY:
+			/* FR=1, FRE=1 */
+			clear_thread_flag(TIF_32BIT_FPREGS);
+			set_thread_flag(TIF_HYBRID_FPREGS);
+			return;
+		}
+	}
+
 	switch (state->overall_abi) {
 	case MIPS_ABI_FP_DOUBLE:
 	case MIPS_ABI_FP_SINGLE:
-- 
2.0.4
