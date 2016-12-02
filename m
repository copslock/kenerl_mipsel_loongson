Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 09:59:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41678 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993038AbcLBI6mPGPe0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 09:58:42 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 96A0C8F108CC1;
        Fri,  2 Dec 2016 08:58:33 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 08:58:36 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 2/4] MIPS: Kconfig: fix indentation for kexec-related entries
Date:   Fri, 2 Dec 2016 09:58:29 +0100
Message-ID: <1480669111-15562-3-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1480669111-15562-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1480669111-15562-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Kconfig entries are not aligned properly, so remove incorrect
whitespace.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2da660e..9d07bee 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2795,8 +2795,8 @@ config KEXEC
 	  made.
 
 config CRASH_DUMP
-	  bool "Kernel crash dumps"
-	  help
+	bool "Kernel crash dumps"
+	help
 	  Generate crash dump after being started by kexec.
 	  This should be normally only set in special crash dump kernels
 	  which are loaded in the main kernel with kexec-tools into
@@ -2806,11 +2806,11 @@ config CRASH_DUMP
 	  PHYSICAL_START.
 
 config PHYSICAL_START
-	  hex "Physical address where the kernel is loaded"
-	  default "0xffffffff84000000" if 64BIT
-	  default "0x84000000" if 32BIT
-	  depends on CRASH_DUMP
-	  help
+	hex "Physical address where the kernel is loaded"
+	default "0xffffffff84000000" if 64BIT
+	default "0x84000000" if 32BIT
+	depends on CRASH_DUMP
+	help
 	  This gives the CKSEG0 or KSEG0 address where the kernel is loaded.
 	  If you plan to use kernel for capturing the crash dump change
 	  this value to start of the reserved region (the "X" value as
-- 
2.7.4
