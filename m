Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 00:19:43 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:55448 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012571AbbKLXSsjXn8l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2015 00:18:48 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1Zx18i-0006Py-44; Thu, 12 Nov 2015 23:18:48 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1Zx18f-0000AV-TR; Thu, 12 Nov 2015 15:18:45 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 016/155] MIPS: CPS: #ifdef on CONFIG_MIPS_MT_SMP rather than CONFIG_MIPS_MT
Date:   Thu, 12 Nov 2015 15:16:10 -0800
Message-Id: <1447370309-357-17-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1447370309-357-1-git-send-email-kamal@canonical.com>
References: <1447370309-357-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt10 -stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index d729a5e..b38a518 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -224,7 +224,7 @@ LEAF(excep_ejtag)
 	END(excep_ejtag)
 
 LEAF(mips_cps_core_init)
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP
 	/* Check that the core implements the MT ASE */
 	has_mt	t0, 3f
 
@@ -311,7 +311,7 @@ LEAF(mips_cps_boot_vpes)
 
 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	li	t9, 0
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP
 	has_mt	t6, 1f
 
 	/* Find the number of VPEs present in the core */
@@ -339,7 +339,7 @@ LEAF(mips_cps_boot_vpes)
 	lw	t7, COREBOOTCFG_VPECONFIG(t0)
 	addu	v0, v0, t7
 
-#ifdef CONFIG_MIPS_MT
+#ifdef CONFIG_MIPS_MT_SMP
 
 	/* If the core doesn't support MT then return */
 	bnez	t6, 1f
@@ -453,7 +453,7 @@ LEAF(mips_cps_boot_vpes)
 
 2:	.set	pop
 
-#endif /* CONFIG_MIPS_MT */
+#endif /* CONFIG_MIPS_MT_SMP */
 
 	/* Return */
 	jr	ra
-- 
1.9.1
