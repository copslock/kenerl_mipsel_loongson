Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2017 03:22:59 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37857 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992990AbdKVCUZhoYIn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2017 03:20:25 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eHKeE-0004Y0-DH; Wed, 22 Nov 2017 02:20:22 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1eHKe8-0003C3-Ei; Wed, 22 Nov 2017 02:20:16 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Marcin Nowakowski" <marcin.nowakowski@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>,
        "Miodrag Dinic" <miodrag.dinic@imgtec.com>,
        "Paul Burton" <paul.burton@imgtec.com>,
        "David Daney" <david.daney@cavium.com>,
        "Ingo Molnar" <mingo@kernel.org>
Date:   Wed, 22 Nov 2017 01:58:13 +0000
Message-ID: <lsq.1511315893.265961265@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 095/133] MIPS: microMIPS: Fix decoding of swsp16
 instruction
In-Reply-To: <lsq.1511315892.657723235@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61041
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

3.16.51-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit cea8cd498f4f1c30ea27e3664b3c671e495c4fce upstream.

When the immediate encoded in the instruction is accessed, it is sign
extended due to being a signed value being assigned to a signed integer.
The ISA specifies that this operation is an unsigned operation.
The sign extension leads us to incorrectly decode:

801e9c8e:       cbf1            sw      ra,68(sp)

As having an immediate of 1073741809.

Since the instruction format does not specify signed/unsigned, and this
is currently the only location to use this instuction format, change it
to an unsigned immediate.

Fixes: bb9bc4689b9c ("MIPS: Calculate microMIPS ra properly when unwinding the stack")
Suggested-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Miodrag Dinic <miodrag.dinic@imgtec.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16957/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/uapi/asm/inst.h | 2 +-
 arch/mips/kernel/process.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -808,7 +808,7 @@ struct mm16_r3_format {		/* Load from gl
 struct mm16_r5_format {		/* Load/store from stack pointer format */
 	__BITFIELD_FIELD(unsigned int opcode : 6,
 	__BITFIELD_FIELD(unsigned int rt : 5,
-	__BITFIELD_FIELD(signed int simmediate : 5,
+	__BITFIELD_FIELD(unsigned int imm : 5,
 	__BITFIELD_FIELD(unsigned int : 16, /* Ignored */
 	;))))
 };
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -241,7 +241,7 @@ static inline int is_ra_save_ins(union m
 			if (ip->mm16_r5_format.rt != 31)
 				return 0;
 
-			*poff = ip->mm16_r5_format.simmediate;
+			*poff = ip->mm16_r5_format.imm;
 			*poff = (*poff << 2) / sizeof(ulong);
 			return 1;
 
