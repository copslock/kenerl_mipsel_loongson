Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 15:38:11 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990435AbeBBOiFFji0L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Feb 2018 15:38:05 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A27214DA;
        Fri,  2 Feb 2018 14:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A27214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: CPS: Fix MIPS_ISA_LEVEL_RAW fallout
Date:   Fri,  2 Feb 2018 14:36:40 +0000
Message-Id: <20180202143640.24490-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180202120658.GA8479@saruman>
References: <20180202120658.GA8479@saruman>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

Commit 17278a91e04f ("MIPS: CPS: Fix r1 .set mt assembler warning")
added .set MIPS_ISA_LEVEL_RAW to silence warnings about .set mt on r1,
however this can result in a MOVE being encoded as a 64-bit DADDU
instruction on certain version of binutils (e.g. 2.22), and reserved
instruction exceptions at runtime on 32-bit hardware.

Reduce the sizes of the push/pop sections to include only instructions
that are part of the MT ASE or which won't convert to 64-bit
instructions after .set mips64r2/mips64r6.

Reported-by: Greg Ungerer <gerg@linux-m68k.org>
Fixes: 17278a91e04f ("MIPS: CPS: Fix r1 .set mt assembler warning")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.15
---
Greg: Please can you test this patch.
---
 arch/mips/kernel/cps-vec.S | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index e68e6e04063a..1025f937ab0e 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -388,15 +388,16 @@ LEAF(mips_cps_boot_vpes)
 
 #elif defined(CONFIG_MIPS_MT)
 
-	.set	push
-	.set	MIPS_ISA_LEVEL_RAW
-	.set	mt
-
 	/* If the core doesn't support MT then return */
 	has_mt	t0, 5f
 
 	/* Enter VPE configuration state */
+	.set	push
+	.set	MIPS_ISA_LEVEL_RAW
+	.set	mt
 	dvpe
+	.set	pop
+
 	PTR_LA	t1, 1f
 	jr.hb	t1
 	 nop
@@ -422,6 +423,10 @@ LEAF(mips_cps_boot_vpes)
 	mtc0	t0, CP0_VPECONTROL
 	ehb
 
+	.set	push
+	.set	MIPS_ISA_LEVEL_RAW
+	.set	mt
+
 	/* Skip the VPE if its TC is not halted */
 	mftc0	t0, CP0_TCHALT
 	beqz	t0, 2f
@@ -495,6 +500,8 @@ LEAF(mips_cps_boot_vpes)
 	ehb
 	evpe
 
+	.set	pop
+
 	/* Check whether this VPE is meant to be running */
 	li	t0, 1
 	sll	t0, t0, a1
@@ -509,7 +516,7 @@ LEAF(mips_cps_boot_vpes)
 1:	jr.hb	t0
 	 nop
 
-2:	.set	pop
+2:
 
 #endif /* CONFIG_MIPS_MT_SMP */
 
-- 
2.13.6
