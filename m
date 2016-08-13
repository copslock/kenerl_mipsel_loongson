Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Aug 2016 19:59:23 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38079 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992955AbcHMR7Qg0h2D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Aug 2016 19:59:16 +0200
Received: from 92.40.249.202.threembb.co.uk ([92.40.249.202] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYdDE-0003ey-Hq; Sat, 13 Aug 2016 18:59:12 +0100
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYd3f-0002sU-7C; Sat, 13 Aug 2016 18:49:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, pgynther@google.com,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>, john@phrozen.org,
        cernekee@gmail.com, dragan.stancevic@gmail.com, jogo@openwrt.org,
        linux-mips@linux-mips.org, jaedon.shin@gmail.com,
        jfraser@broadcom.com
Date:   Sat, 13 Aug 2016 18:42:51 +0100
Message-ID: <lsq.1471110171.501971181@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 052/305] MIPS: BMIPS: Fix PRID_IMP_BMIPS5000 masking
 for BMIPS5200
In-Reply-To: <lsq.1471110169.907390585@decadent.org.uk>
X-SA-Exim-Connect-IP: 92.40.249.202
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.37-rc1 review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/bmips_vec.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

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
@@ -264,6 +267,8 @@ LEAF(bmips_enable_xks01)
 #endif /* CONFIG_CPU_BMIPS4380 */
 #if defined(CONFIG_CPU_BMIPS5000)
 	li	t1, PRID_IMP_BMIPS5000
+	/* mask with PRID_IMP_BMIPS5000 to cover both variants */
+	andi	t2, PRID_IMP_BMIPS5000
 	bne	t2, t1, 2f
 
 	mfc0	t0, $22, 5
