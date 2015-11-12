Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 00:19:24 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:55442 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012460AbbKLXSsJgVkl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2015 00:18:48 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1Zx18h-0006Pq-JJ; Thu, 12 Nov 2015 23:18:47 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1Zx18f-0000AO-BJ; Thu, 12 Nov 2015 15:18:45 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 015/155] MIPS: CPS: Don't include MT code in non-MT kernels.
Date:   Thu, 12 Nov 2015 15:16:09 -0800
Message-Id: <1447370309-357-16-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1447370309-357-1-git-send-email-kamal@canonical.com>
References: <1447370309-357-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49907
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

commit a5b0f6db0e6cf6224e50f6585e9c8f0c2d38a8f8 upstream.

The MT-specific code in mips_cps_boot_vpes can safely be omitted from
kernels which don't support MT, with the default VPE==0 case being used
as it would be after the has_mt (Config3.MT) check failed at runtime.
Discarding the code entirely will save us a few bytes & allow cleaner
handling of MT ASE instructions by later patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/10866/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 24b8c0b6..d729a5e 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -311,6 +311,7 @@ LEAF(mips_cps_boot_vpes)
 
 	/* Calculate this VPEs ID. If the core doesn't support MT use 0 */
 	li	t9, 0
+#ifdef CONFIG_MIPS_MT
 	has_mt	t6, 1f
 
 	/* Find the number of VPEs present in the core */
@@ -330,6 +331,7 @@ LEAF(mips_cps_boot_vpes)
 	/* Retrieve the VPE ID from EBase.CPUNum */
 	mfc0	t9, $15, 1
 	and	t9, t9, t1
+#endif
 
 1:	/* Calculate a pointer to this VPEs struct vpe_boot_config */
 	li	t1, VPEBOOTCFG_SIZE
-- 
1.9.1
