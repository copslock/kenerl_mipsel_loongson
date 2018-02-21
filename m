Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 14:11:54 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994730AbeBUNLQSDeDT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2018 14:11:16 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 32B7B121D;
        Wed, 21 Feb 2018 13:10:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org
Subject: [PATCH 4.15 113/163] MIPS: CPS: Fix MIPS_ISA_LEVEL_RAW fallout
Date:   Wed, 21 Feb 2018 13:49:02 +0100
Message-Id: <20180221124536.407722932@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit 8dbc1864b74f5dea5a3f7c30ca8fd358a675132f upstream.

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
Tested-by: Greg Ungerer <gerg@linux-m68k.org>
Patchwork: https://patchwork.linux-mips.org/patch/18578/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/cps-vec.S |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

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
 
