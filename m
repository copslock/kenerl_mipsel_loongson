Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 13:02:35 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:48767 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991978AbdKNMC3B9FkY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 13:02:29 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 12:02:22 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 14 Nov 2017 04:02:21 -0800
From:   James Hogan <james.hogan@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH] MIPS: CPS: Fix r1 .set mt assembler warning
Date:   Tue, 14 Nov 2017 12:01:20 +0000
Message-ID: <20171114120120.7020-1-james.hogan@mips.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510660941-298552-31881-39267-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186912
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: James Hogan <jhogan@kernel.org>

MIPS CPS has a build warning on kernels configured for MIPS32R1 or
MIPS64R1, due to the use of .set mt without a prior .set mips{32,64}r2:

arch/mips/kernel/cps-vec.S Assembler messages:
arch/mips/kernel/cps-vec.S:238: Warning: the `mt' extension requires MIPS32 revision 2 or greater

Add .set MIPS_ISA_LEVEL_RAW before .set mt to silence the warning.

Fixes: 245a7868d2f2 ("MIPS: smp-cps: rework core/VPE initialisation")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/cps-vec.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index c7ed26029cbb..e68e6e04063a 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -235,6 +235,7 @@ LEAF(mips_cps_core_init)
 	has_mt	t0, 3f
 
 	.set	push
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	mt
 
 	/* Only allow 1 TC per VPE to execute... */
@@ -388,6 +389,7 @@ LEAF(mips_cps_boot_vpes)
 #elif defined(CONFIG_MIPS_MT)
 
 	.set	push
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	mt
 
 	/* If the core doesn't support MT then return */
-- 
2.14.1
