Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Feb 2018 18:06:54 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:40873 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991068AbeBZRG0yNTqO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Feb 2018 18:06:26 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 26 Feb 2018 17:06:21 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Mon, 26 Feb 2018 09:03:03 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        "Matt Redfearn" <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@mips.com>
Subject: [PATCH 2/4] MIPS: cpu-features.h: Replace __mips_isa_rev with MIPS_ISA_REV
Date:   Mon, 26 Feb 2018 17:02:43 +0000
Message-ID: <1519664565-10955-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
References: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1519664770-637139-10619-123029-9
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
X-archive-position: 62716
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

 arch/mips/include/asm/cpu-features.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 721b698bfe3c..5f74590e0bea 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -11,6 +11,7 @@
 
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
+#include <asm/isa-rev.h>
 #include <cpu-feature-overrides.h>
 
 /*
@@ -493,7 +494,7 @@
 # define cpu_has_perf		(cpu_data[0].options & MIPS_CPU_PERF)
 #endif
 
-#if defined(CONFIG_SMP) && defined(__mips_isa_rev) && (__mips_isa_rev >= 6)
+#if defined(CONFIG_SMP) && (MIPS_ISA_REV >= 6)
 /*
  * Some systems share FTLB RAMs between threads within a core (siblings in
  * kernel parlance). This means that FTLB entries may become invalid at almost
@@ -525,7 +526,7 @@
 #  define cpu_has_shared_ftlb_entries \
 	(current_cpu_data.options & MIPS_CPU_SHARED_FTLB_ENTRIES)
 # endif
-#endif /* SMP && __mips_isa_rev >= 6 */
+#endif /* SMP && MIPS_ISA_REV >= 6 */
 
 #ifndef cpu_has_shared_ftlb_ram
 # define cpu_has_shared_ftlb_ram 0
-- 
2.7.4
