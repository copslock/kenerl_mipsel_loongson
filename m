Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 01:49:51 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:59889 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993828AbeKTAtsF98Uq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Nov 2018 01:49:48 +0100
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1404.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 20 Nov 2018 00:49:44 +0000
Received: from ubuntu-hassan.mipstec.com (10.20.2.43) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Mon, 19
 Nov 2018 16:50:19 -0800
From:   Hassan Naveed <hassan.naveed@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Hassan Naveed <hnaveed@wavecomp.com>
Subject: [PATCH] MIPS: Enable Undefined Behavior Sanitizer UBSAN
Date:   Mon, 19 Nov 2018 16:49:37 -0800
Message-ID: <20181120004937.8211-1-hassan.naveed@mips.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.20.2.43]
X-ClientProxiedBy: mipsdag01.mipstec.com (10.20.40.46) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1542674984-382908-21582-244119-1
X-BESS-VER: 2018.15-r1811092049
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.204088
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Hassan.Naveed@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hassan.naveed@mips.com
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

From: Hassan Naveed <hnaveed@wavecomp.com>

Select ARCH_HAS_UBSAN_SANITIZE_ALL in order to allow the user to
enable CONFIG_UBSAN_SANITIZE_ALL and instrument the entire kernel for
ubsan checks.
We exclude the VDSO from this because its build doesn't include the
__ubsan_handle_*() functions that the kernel proper defines in from
lib/ubsan.c, and the VDSO would have no sane way to report errors even
if it had definitions of these functions.

Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/Kconfig       | 1 +
 arch/mips/vdso/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35511999156a..8418721bb3f9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -7,6 +7,7 @@ config MIPS
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_SUPPORTS_UPROBES
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 34605ca21498..b0f2382b5671 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -50,6 +50,7 @@ VDSO_LDFLAGS := \
 	$(call cc-ldoption, -Wl$(comma)--build-id)
 
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 #
 # Shared build commands.
-- 
2.19.0
