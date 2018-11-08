Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 23:03:54 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:49452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993354AbeKHWDt5flrj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Nov 2018 23:03:49 +0100
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA49B20844;
        Thu,  8 Nov 2018 22:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714628;
        bh=UxZvcv8ABelrSp5nV/dvhaKH0XEtq6rpQ2XQTkFu360=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldRVmfjcUqzYhedCNmL45vDv6O8GNz15oSIiUXtIP9rX4UKKTAqhnGp7p55mMKqIe
         /lvwNvvk6eWOGCnIfXOcyXCG9InXFYAcQmLnfcltWJ44lZr1tSPSr3T66OYA1GHMVl
         ftA+0A6nalqynpaj6XSvOqbarF8vYzLghj63rQ90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 034/171] MIPS: microMIPS: Fix decoding of swsp16 instruction
Date:   Thu,  8 Nov 2018 13:50:04 -0800
Message-Id: <20181108215129.820561095@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <SRS0=nC3z=NT=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit cea8cd498f4f1c30ea27e3664b3c671e495c4fce ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index ba315e523b33..0211dc737a21 100644
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
2.17.1
