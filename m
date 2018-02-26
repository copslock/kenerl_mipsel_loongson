Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Feb 2018 18:12:15 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:41265 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991025AbeBZRMG0m6sO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Feb 2018 18:12:06 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 26 Feb 2018 17:10:45 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Mon, 26 Feb 2018 09:03:07 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        "Matt Redfearn" <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] MIPS: VDSO: Replace __mips_isa_rev with MIPS_ISA_REV
Date:   Mon, 26 Feb 2018 17:02:45 +0000
Message-ID: <1519664565-10955-5-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
References: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1519665043-321457-2236-2367-4
X-BESS-VER: 2018.2-r1802232356
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190443
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Remove the need to check that __mips_isa_rev is defined by using the
newly added MIPS_ISA_REV.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/vdso/elf.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/mips/vdso/elf.S b/arch/mips/vdso/elf.S
index be37bbb1f061..428a1917afc6 100644
--- a/arch/mips/vdso/elf.S
+++ b/arch/mips/vdso/elf.S
@@ -10,6 +10,8 @@
 
 #include "vdso.h"
 
+#include <asm/isa-rev.h>
+
 #include <linux/elfnote.h>
 #include <linux/version.h>
 
@@ -40,11 +42,7 @@ __mips_abiflags:
 	.byte	__mips		/* isa_level */
 
 	/* isa_rev */
-#ifdef __mips_isa_rev
-	.byte	__mips_isa_rev
-#else
-	.byte	0
-#endif
+	.byte	MIPS_ISA_REV
 
 	/* gpr_size */
 #ifdef __mips64
@@ -54,7 +52,7 @@ __mips_abiflags:
 #endif
 
 	/* cpr1_size */
-#if (defined(__mips_isa_rev) && __mips_isa_rev >= 6) || defined(__mips64)
+#if (MIPS_ISA_REV >= 6) || defined(__mips64)
 	.byte	2		/* AFL_REG_64 */
 #else
 	.byte	1		/* AFL_REG_32 */
-- 
2.7.4
