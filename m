Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2017 05:10:09 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49789 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990514AbdDBDKBV05LH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2017 05:10:01 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtv-0003GQ-SZ; Sun, 02 Apr 2017 04:09:59 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtu-0004R6-Vk; Sun, 02 Apr 2017 04:09:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "James Hogan" <james.hogan@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Paul Burton" <paul.burton@imgtec.com>
Date:   Sun, 02 Apr 2017 04:04:24 +0100
Message-ID: <lsq.1491102264.593686941@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 22/26] MIPS: traps: Fix inline asm ctc1 missing .set
 hardfloat
In-Reply-To: <lsq.1491102264.9835075@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57525
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

3.16.43-rc2 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit d76e9b9fc5de7e8fc4fd0e72a94e8c723929ffea upstream.

Commit 842dfc11ea9a ("MIPS: Fix build with binutils 2.24.51+") in v3.18
enabled -msoft-float and sprinkled ".set hardfloat" where necessary to
use FP instructions. However it missed enable_restore_fp_context() which
since v3.17 does a ctc1 with inline assembly, causing the following
assembler errors on Mentor's 2014.05 toolchain:

{standard input}: Assembler messages:
{standard input}:2913: Error: opcode not supported on this processor: mips32r2 (mips32r2) `ctc1 $2,$31'
scripts/Makefile.build:257: recipe for target 'arch/mips/kernel/traps.o' failed

Fix that to use the new write_32bit_cp1_register() macro so that ".set
hardfloat" is automatically added when -msoft-float is in use.

Fixes 842dfc11ea9a ("MIPS: Fix build with binutils 2.24.51+")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9173/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/traps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1183,7 +1183,8 @@ static int enable_restore_fp_context(int
 
 		/* Restore the scalar FP control & status register */
 		if (!was_fpu_owner)
-			asm volatile("ctc1 %0, $31" : : "r"(current->thread.fpu.fcr31));
+			write_32bit_cp1_register(CP1_STATUS,
+						 current->thread.fpu.fcr31);
 	}
 	return 0;
 }
