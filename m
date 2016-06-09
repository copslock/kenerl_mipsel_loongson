Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:24:49 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:35307 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041480AbcFIVUVyfWDE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:20:21 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7ND-0005XL-Oq; Thu, 09 Jun 2016 21:20:20 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7NB-0006K9-34; Thu, 09 Jun 2016 14:20:17 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>, john@phrozen.org,
        cernekee@gmail.com, jogo@openwrt.org, jaedon.shin@gmail.com,
        jfraser@broadcom.com, pgynther@google.com,
        dragan.stancevic@gmail.com, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 178/206] MIPS: BMIPS: Fix PRID_IMP_BMIPS5000 masking for BMIPS5200
Date:   Thu,  9 Jun 2016 14:16:27 -0700
Message-Id: <1465507015-23052-179-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53998
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Florian Fainelli <f.fainelli@gmail.com>

commit cbbda6e7c9c3e4532bd70a73ff9d5e6655c894dc upstream.

BMIPS5000 have a PrID value of 0x5A00 and BMIPS5200 have a PrID value of
0x5B00, which, masked with 0x5A00, returns 0x5A00. Update all conditionals on
the PrID to cover both variants since we are going to need this to enable
BMIPS5200 SMP. The existing check, masking with 0xFF00 would not cover
BMIPS5200 at all.

Fixes: 68e6a78373a6d ("MIPS: BMIPS: Add PRId for BMIPS5200 (Whirlwind)")
Fixes: 6465460c92a85 ("MIPS: BMIPS: change compile time checks to runtime checks")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: john@phrozen.org
Cc: cernekee@gmail.com
Cc: jogo@openwrt.org
Cc: jaedon.shin@gmail.com
Cc: jfraser@broadcom.com
Cc: pgynther@google.com
Cc: dragan.stancevic@gmail.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12279/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/bmips_vec.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index 8649507..d9495f3 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -93,7 +93,8 @@ NESTED(bmips_reset_nmi_vec, PT_SIZE, sp)
 #if defined(CONFIG_CPU_BMIPS5000)
 	mfc0	k0, CP0_PRID
 	li	k1, PRID_IMP_BMIPS5000
-	andi	k0, 0xff00
+	/* mask with PRID_IMP_BMIPS5000 to cover both variants */
+	andi	k0, PRID_IMP_BMIPS5000
 	bne	k0, k1, 1f
 
 	/* if we're not on core 0, this must be the SMP boot signal */
@@ -166,10 +167,12 @@ bmips_smp_entry:
 2:
 #endif /* CONFIG_CPU_BMIPS4350 || CONFIG_CPU_BMIPS4380 */
 #if defined(CONFIG_CPU_BMIPS5000)
-	/* set exception vector base */
+	/* mask with PRID_IMP_BMIPS5000 to cover both variants */
 	li	k1, PRID_IMP_BMIPS5000
+	andi	k0, PRID_IMP_BMIPS5000
 	bne	k0, k1, 3f
 
+	/* set exception vector base */
 	la	k0, ebase
 	lw	k0, 0(k0)
 	mtc0	k0, $15, 1
@@ -263,6 +266,8 @@ LEAF(bmips_enable_xks01)
 #endif /* CONFIG_CPU_BMIPS4380 */
 #if defined(CONFIG_CPU_BMIPS5000)
 	li	t1, PRID_IMP_BMIPS5000
+	/* mask with PRID_IMP_BMIPS5000 to cover both variants */
+	andi	t2, PRID_IMP_BMIPS5000
 	bne	t2, t1, 2f
 
 	mfc0	t0, $22, 5
-- 
2.7.4
