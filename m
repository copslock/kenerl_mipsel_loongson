Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2017 13:39:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24811 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993899AbdBPMjQvwFF4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Feb 2017 13:39:16 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 96AEA83BF8B0;
        Thu, 16 Feb 2017 12:39:07 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 16 Feb 2017 12:39:10 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <stable@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] MIPS: Force o32 fp64 support on 32bit MIPS64r6 kernels
Date:   Thu, 16 Feb 2017 12:39:01 +0000
Message-ID: <01a9d2344224e76ea17ff62ffa7b75717f6f1100.1487248664.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

When a 32-bit kernel is configured to support MIPS64r6 (CPU_MIPS64_R6),
MIPS_O32_FP64_SUPPORT won't be selected as it should be because
MIPS32_O32 is disabled (o32 is already the default ABI available on
32-bit kernels).

This results in userland FP breakage as CP0_Status.FR is read-only 1
since r6 (when an FPU is present) but CP0_Config5.FRE won't be set to
emulate FR=0.

Force o32 fp64 support in this case by also selecting
MIPS_O32_FP64_SUPPORT from CPU_MIPS64_R6 if 32BIT.

Fixes: 4e9d324d4288 ("MIPS: Require O32 FP64 support for MIPS64 with O32 compat")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.0.x-
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b969522feb97..e2890002d6d1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1531,7 +1531,7 @@ config CPU_MIPS64_R6
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_MSA
 	select GENERIC_CSUM
-	select MIPS_O32_FP64_SUPPORT if MIPS32_O32
+	select MIPS_O32_FP64_SUPPORT if 32BIT || MIPS32_O32
 	select HAVE_KVM
 	help
 	  Choose this option to build a kernel for release 6 or later of the
-- 
git-series 0.8.10
