Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2017 15:42:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52945 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993878AbdCAOljRKidI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Mar 2017 15:41:39 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 724C5EA84828A;
        Wed,  1 Mar 2017 14:41:30 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 1 Mar 2017 14:41:32 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 2/5] MIPS: microMIPS: Fix decoding of addiusp instruction
Date:   Wed, 1 Mar 2017 14:41:17 +0000
Message-ID: <1488379280-2954-3-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488379280-2954-1-git-send-email-matt.redfearn@imgtec.com>
References: <1488379280-2954-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56943
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

Commit 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
added handling of microMIPS instructions to manipulate the stack
pointer. Unfortunately the decoding of the addiusp instruction was
incorrect, and performed a left shift by 2 bits to the raw immediate,
rather than decoding the immediate and then performing the shift, as
documented in the ISA.

This led to incomplete stack traces, due to incorrect frame sizes being
calculated. For example the instruction:
801faee0 <do_sys_poll>:
801faee0:       4e25            addiu   sp,sp,-952

As decoded by objdump, would be interpreted by the existing code as
having manipulated the stack pointer by +1096.

Fix this by changing the order of decoding the immediate and applying
the left shift.

Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

Changes in v2:
- Replace conditional with xor and subtract

 arch/mips/kernel/process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index df69ebd361fc..799273d45d21 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -386,8 +386,9 @@ static int get_frame_info(struct mips_frame_info *info)
 
 					if (ip->halfword[0] & mm_addiusp_func)
 					{
-						tmp = (((ip->halfword[0] >> 1) & 0x1ff) << 2);
-						info->frame_size = -(signed short)(tmp | ((tmp & 0x100) ? 0xfe00 : 0));
+						tmp = (ip->halfword[0] >> 1) & 0x1ff;
+						tmp = (tmp ^ 0x100) - 0x100;
+						info->frame_size = -(signed short)(tmp << 2);
 					} else {
 						tmp = (ip->halfword[0] >> 1);
 						info->frame_size = -(signed short)(tmp & 0xf);
-- 
2.7.4
