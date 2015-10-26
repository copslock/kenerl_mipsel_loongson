Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2015 14:45:42 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:56175 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011370AbbJZNojqd7oQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2015 14:44:39 +0100
Received: from 1.general.henrix.uk.vpn ([10.172.192.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1Zqi4l-0000Yn-FI; Mon, 26 Oct 2015 13:44:39 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 076/104] MIPS: CPS: #ifdef on CONFIG_MIPS_MT_SMP rather than CONFIG_MIPS_MT
Date:   Mon, 26 Oct 2015 13:42:58 +0000
Message-Id: <1445867006-18048-77-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1445867006-18048-1-git-send-email-luis.henriques@canonical.com>
References: <1445867006-18048-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49700
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

commit 7a63076d9a31a6c2073da45021eeb4f89d2a8b56 upstream.

The CONFIG_MIPS_MT symbol can be selected by CONFIG_MIPS_VPE_LOADER in
addition to CONFIG_MIPS_MT_SMP. We only want MT code in the CPS SMP boot
vector if we're using MT for SMP. Thus switch the config symbol we ifdef
against to CONFIG_MIPS_MT_SMP.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/10867/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[ luis: backported to 3.16: adjusted context ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index acd9bd6daf99..05a96be42075 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -224,7 +224,7 @@ LEAF(excep_ejtag)
 	END(excep_ejtag)
 
 LEAF(mips_cps_core_init)
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP
 	/* Check that the core implements the MT ASE */
 	has_mt	t0, 3f
 
@@ -310,7 +310,7 @@ LEAF(mips_cps_boot_vpes)
 
 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	li	t9, 0
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP
 	has_mt	t6, 1f
 
 	/* Find the number of VPEs present in the core */
@@ -338,7 +338,7 @@ LEAF(mips_cps_boot_vpes)
 	lw	t7, COREBOOTCFG_VPECONFIG(t0)
 	addu	v0, v0, t7
 
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP
 
 	/* If the core doesn't support MT then return */
 	bnez	t6, 1f
@@ -451,7 +451,7 @@ LEAF(mips_cps_boot_vpes)
 
 2:	.set	pop
 
-#endif /* CONFIG_MIPS_MT */
+#endif /* CONFIG_MIPS_MT_SMP */
 
 	/* Return */
 	jr	ra
