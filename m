Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2015 14:44:40 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:56162 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011367AbbJZNohysXGQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2015 14:44:37 +0100
Received: from 1.general.henrix.uk.vpn ([10.172.192.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1Zqi4j-0000YU-KZ; Mon, 26 Oct 2015 13:44:37 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 074/104] MIPS: CPS: Stop dangling delay slot from has_mt.
Date:   Mon, 26 Oct 2015 13:42:56 +0000
Message-Id: <1445867006-18048-75-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1445867006-18048-1-git-send-email-luis.henriques@canonical.com>
References: <1445867006-18048-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt19 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 1e5fb282f8eda889776ee83f9214d5df9edaa26d upstream.

The has_mt macro ended with a branch, leaving its callers with a delay
slot that would be executed if Config3.MT is not set. However it would
not be executed if Config3 (or earlier Config registers) don't exist
which makes it somewhat inconsistent at best. Fill the delay slot in the
macro & fix the mips_cps_boot_vpes caller appropriately.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/10865/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[ luis: backported to 3.16: adjusted context ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 3b3fb8924628..5652af5786ef 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -39,6 +39,7 @@
 	 mfc0	\dest, CP0_CONFIG, 3
 	andi	\dest, \dest, MIPS_CONF3_MT
 	beqz	\dest, \nomt
+	 nop
 	.endm
 
 .section .text.cps-vec
@@ -226,7 +227,6 @@ LEAF(mips_cps_core_init)
 #ifdef CONFIG_MIPS_MT
 	/* Check that the core implements the MT ASE */
 	has_mt	t0, 3f
-	 nop
 
 	.set	push
 	.set	mt
@@ -309,8 +309,8 @@ LEAF(mips_cps_boot_vpes)
 	addu	t0, t0, t1
 
 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
+	li	t9, 0
 	has_mt	t6, 1f
-	 li	t9, 0
 
 	/* Find the number of VPEs present in the core */
 	mfc0	t1, CP0_MVPCONF0
