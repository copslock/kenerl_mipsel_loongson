Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 16:40:55 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42642 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993870AbdB1PjVRe2uK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2017 16:39:21 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id B8B3F4B421C8D;
        Tue, 28 Feb 2017 15:39:11 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 28 Feb 2017 15:39:15 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/4] MIPS: microMIPS: Fix decoding of swsp16 instruction
Date:   Tue, 28 Feb 2017 15:37:58 +0000
Message-ID: <1488296279-23057-5-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488296279-23057-1-git-send-email-matt.redfearn@imgtec.com>
References: <1488296279-23057-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

---

 arch/mips/include/uapi/asm/inst.h | 2 +-
 arch/mips/kernel/process.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 77429d1622b3..711d9b8465b8 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -964,7 +964,7 @@ struct mm16_r3_format {		/* Load from global pointer format */
 struct mm16_r5_format {		/* Load/store from stack pointer format */
 	__BITFIELD_FIELD(unsigned int opcode : 6,
 	__BITFIELD_FIELD(unsigned int rt : 5,
-	__BITFIELD_FIELD(signed int simmediate : 5,
+	__BITFIELD_FIELD(unsigned int imm : 5,
 	__BITFIELD_FIELD(unsigned int : 16, /* Ignored */
 	;))))
 };
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 6ba5b775579c..67182baaf719 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -212,7 +212,7 @@ static inline int is_ra_save_ins(union mips_instruction *ip, int *poff)
 			if (ip->mm16_r5_format.rt != 31)
 				return 0;
 
-			*poff = ip->mm16_r5_format.simmediate;
+			*poff = ip->mm16_r5_format.imm;
 			*poff = (*poff << 2) / sizeof(ulong);
 			return 1;
 
-- 
2.7.4
