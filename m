Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 19:41:02 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36213 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816479AbaDGRlAOGUhR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 19:41:00 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1WXDXQ-0005Uk-VE; Mon, 07 Apr 2014 12:40:52 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: microMIPS: Work around an assembler bug.
Date:   Mon,  7 Apr 2014 12:40:46 -0500
Message-Id: <1396892446-23883-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

In newer toolchains, the 16-bit branch delay slot instruction
calculation is wrong. We get a message very similar to:

   {standard input}: Assembler messages:
   {standard input}:7035: Warning: wrong size instruction
   in a 16-bit branch delay slot

This corner case only occurs in 'arch/mips/kernel/traps.c' and
we add the '-fno-delayed-branch' option when compiling it.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/kernel/Makefile |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 66c6705..76c8638 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -116,4 +116,12 @@ CFLAGS_branch.o			= $(CFLAGS_DSP)
 CFLAGS_ptrace.o			= $(CFLAGS_DSP)
 endif
 
+#
+# Workaround for newer toolchains when building microMIPS kernels.
+#
+ifeq ($(CONFIG_CPU_MICROMIPS), y)
+CFLAGS_traps.o    = $(shell if [ $(call cc-version) -gt 0407 ]; then \
+			echo $(call cc-option, -fno-delayed-branch); fi)
+endif
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
-- 
1.7.10.4
