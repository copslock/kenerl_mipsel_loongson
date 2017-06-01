Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2017 17:46:38 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36893 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993977AbdFAPoWqvFk- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jun 2017 17:44:22 +0200
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSGr-0004tg-TT; Thu, 01 Jun 2017 16:44:21 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSGp-0007h2-10; Thu, 01 Jun 2017 16:44:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "James Hogan" <james.hogan@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Jayachandran C" <jchandra@broadcom.com>
Date:   Thu, 01 Jun 2017 16:43:15 +0100
Message-ID: <lsq.1496331795.249057696@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 012/212] MIPS: Netlogic: Fix assembler warning from
 smpboot.S
In-Reply-To: <lsq.1496331794.574686034@decadent.org.uk>
X-SA-Exim-Connect-IP: 82.70.136.246
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58119
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

3.16.44-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit a8b3b0c94ac282628f0668d1366239a3fa72dc9d upstream.

The netlogic platform can be built for either MIPS32 or MIPS64, and when
built for MIPS32 (as by nlm_xlr_defconfig) the use of the dla
pseudo-instruction leads to warnings such as the following from recent
versions of the GNU assembler:

  arch/mips/netlogic/common/smpboot.S: Assembler messages:
  arch/mips/netlogic/common/smpboot.S:62: Warning: dla used to load 32-bit register; recommend using la instead
  arch/mips/netlogic/common/smpboot.S:63: Warning: dla used to load 32-bit register; recommend using la instead

Avoid these warnings by using the PTR_LA macro to make use of the
appropriate la or dla pseudo-instruction for the build.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 66d29985fab8 ("MIPS: Netlogic: Merge some of XLR/XLP wakup code")
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Jayachandran C <jchandra@broadcom.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14185/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/netlogic/common/smpboot.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -61,8 +61,8 @@ NESTED(xlp_boot_core0_siblings, PT_SIZE,
 	sync
 	/* find the location to which nlm_boot_siblings was relocated */
 	li	t0, CKSEG1ADDR(RESET_VEC_PHYS)
-	dla	t1, nlm_reset_entry
-	dla	t2, nlm_boot_siblings
+	PTR_LA	t1, nlm_reset_entry
+	PTR_LA	t2, nlm_boot_siblings
 	dsubu	t2, t1
 	daddu	t2, t0
 	/* call it */
