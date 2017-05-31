Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 17:20:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25846 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992517AbdEaPUGkYSET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 17:20:06 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 31608AA9A834A;
        Wed, 31 May 2017 16:19:57 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 31 May 2017 16:20:00 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/4] MIPS: Fix mips_atomic_set() retry condition
Date:   Wed, 31 May 2017 16:19:47 +0100
Message-ID: <a673943ade3863746a0f9c12f0fe9218969dff85.1496240182.git-series.james.hogan@imgtec.com>
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
X-archive-position: 58091
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

The inline asm retry check in the MIPS_ATOMIC_SET operation of the
sysmips system call has been backwards since commit f1e39a4a616c ("MIPS:
Rewrite sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler")
merged in v2.6.32, resulting in the non R10000_LLSC_WAR case retrying
until the operation was inatomic, before returning the new value that
was probably just written multiple times instead of the old value.

Invert the branch condition to fix that particular issue.

Fixes: f1e39a4a616c ("MIPS: Rewrite sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
---
 arch/mips/kernel/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index f1d17ece4181..9dd0788fc56d 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -134,7 +134,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		"1:	ll	%[old], (%[addr])			\n"
 		"	move	%[tmp], %[new]				\n"
 		"2:	sc	%[tmp], (%[addr])			\n"
-		"	bnez	%[tmp], 4f				\n"
+		"	beqz	%[tmp], 4f				\n"
 		"3:							\n"
 		"	.insn						\n"
 		"	.subsection 2					\n"
-- 
git-series 0.8.10
