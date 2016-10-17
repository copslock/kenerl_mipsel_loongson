Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 16:36:20 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:52153 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990864AbcJQOfnM3iA4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 16:35:43 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id B059A16379B6;
        Mon, 17 Oct 2016 15:35:32 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 15:35:35 +0100
Received: from localhost (10.100.200.11) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct
 2016 15:35:35 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/4] MIPS: Allow pre-r6 emulation on SMP MIPSr6 kernels
Date:   Mon, 17 Oct 2016 15:34:37 +0100
Message-ID: <20161017143438.17298-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161017143438.17298-1-paul.burton@imgtec.com>
References: <20161017143438.17298-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.11]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55457
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

There's no reason for the pre-r6 instruction emulation code to be
limited to uniprocessor kernels. We already emulate atomic memory access
instructions in a way that works for SMP systems, and nothing else
should be affected. Remove the artificial limitation, allowing pre-r6
instruction emulation to be used with SMP kernels.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde..5582ce1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2286,7 +2286,7 @@ config MIPS_MT_FPAFF
 
 config MIPSR2_TO_R6_EMULATOR
 	bool "MIPS R2-to-R6 emulator"
-	depends on CPU_MIPSR6 && !SMP
+	depends on CPU_MIPSR6
 	default y
 	help
 	  Choose this option if you want to run non-R6 MIPS userland code.
@@ -2294,8 +2294,6 @@ config MIPSR2_TO_R6_EMULATOR
 	  default. You can enable it using the 'mipsr2emu' kernel option.
 	  The only reason this is a build-time option is to save ~14K from the
 	  final kernel image.
-comment "MIPS R2-to-R6 emulator is only available for UP kernels"
-	depends on SMP && CPU_MIPSR6
 
 config MIPS_VPE_LOADER
 	bool "VPE loader support."
-- 
2.10.0
