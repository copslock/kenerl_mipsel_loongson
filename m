Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 00:43:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27150 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010939AbbHEWnYpyRx8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 00:43:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7231CCBF681DA;
        Wed,  5 Aug 2015 23:43:13 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 23:43:17 +0100
Received: from localhost (192.168.159.103) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 5 Aug
 2015 23:43:16 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH 1/6] MIPS: CPS: use 32b accesses to GCRs
Date:   Wed, 5 Aug 2015 15:42:35 -0700
Message-ID: <1438814560-19821-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438814560-19821-1-git-send-email-paul.burton@imgtec.com>
References: <1438814560-19821-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.103]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48620
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

Commit b677bc03d757 ("MIPS: cps-vec: Use macros for various arithmetics
and memory operations") replaced various load & store instructions
through cps-vec.S with the PTR_L & PTR_S macros. However it was somewhat
overzealous in doing so for CM GCR accesses, since the bit width of the
CM doesn't necessarily match that of the CPU. The registers accessed
(GCR_CL_COHERENCE & GCR_CL_ID) should be safe to simply always access
using 32b instructions, so do so in order to avoid issues when using a
32b CM with a 64b CPU.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: <stable@vger.kernel.org> # 3.16+
---

 arch/mips/kernel/cps-vec.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 1b6ca63..9f71c06 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -152,7 +152,7 @@ dcache_done:
 
 	/* Enter the coherent domain */
 	li	t0, 0xff
-	PTR_S	t0, GCR_CL_COHERENCE_OFS(v1)
+	sw	t0, GCR_CL_COHERENCE_OFS(v1)
 	ehb
 
 	/* Jump to kseg0 */
@@ -302,7 +302,7 @@ LEAF(mips_cps_boot_vpes)
 	PTR_L	t0, 0(t0)
 
 	/* Calculate a pointer to this cores struct core_boot_config */
-	PTR_L	t0, GCR_CL_ID_OFS(t0)
+	lw	t0, GCR_CL_ID_OFS(t0)
 	li	t1, COREBOOTCFG_SIZE
 	mul	t0, t0, t1
 	PTR_LA	t1, mips_cps_core_bootcfg
-- 
2.5.0
