Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 17:21:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53791 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993419AbdEaPUJ7GGOT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 17:20:09 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7A59C37E992A2;
        Wed, 31 May 2017 16:19:59 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 31 May 2017 16:20:03 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 4/4] MIPS: Branch straight to ll in mips_atomic_set()
Date:   Wed, 31 May 2017 16:19:50 +0100
Message-ID: <c17c30b035caec45c1de97f4d069ab31fec2067e.1496240182.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com>
References: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Adjust the atomic loop in the MIPS_ATOMIC_SET operation of the sysmips
system call to branch straight back to the linked load rather than
jumping via a different subsection (whose purpose remains a mystery to
me).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/syscall.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index ca54ac40252b..6c6bf43d681b 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -137,13 +137,9 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		"	move	%[tmp], %[new]				\n"
 		"2:							\n"
 		user_sc("%[tmp]", "(%[addr])")
-		"	beqz	%[tmp], 4f				\n"
+		"	beqz	%[tmp], 1b				\n"
 		"3:							\n"
 		"	.insn						\n"
-		"	.subsection 2					\n"
-		"4:	b	1b					\n"
-		"	.previous					\n"
-		"							\n"
 		"	.section .fixup,\"ax\"				\n"
 		"5:	li	%[err], %[efault]			\n"
 		"	j	3b					\n"
-- 
git-series 0.8.10
