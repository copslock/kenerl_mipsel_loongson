Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 22:28:00 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35303 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993060AbdKAV1v2VF4L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Nov 2017 22:27:51 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id vA1LQh1c004958;
        Wed, 1 Nov 2017 22:26:43 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 059/139] MIPS: Fix mips_atomic_set() retry condition
Date:   Wed,  1 Nov 2017 22:26:00 +0100
Message-Id: <1509571600-4858-10-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1509571600-4858-1-git-send-email-w@1wt.eu>
References: <1509571159-4405-1-git-send-email-w@1wt.eu>
 <1509571600-4858-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

From: James Hogan <james.hogan@imgtec.com>

commit 2ec420b26f7b6ff332393f0bb5a7d245f7ad87f0 upstream.

The inline asm retry check in the MIPS_ATOMIC_SET operation of the
sysmips system call has been backwards since commit f1e39a4a616c ("MIPS:
Rewrite sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler")
merged in v2.6.32, resulting in the non R10000_LLSC_WAR case retrying
until the operation was inatomic, before returning the new value that
was probably just written multiple times instead of the old value.

Invert the branch condition to fix that particular issue.

Fixes: f1e39a4a616c ("MIPS: Rewrite sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16148/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kernel/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index b79d13f..eb0f4df 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -140,7 +140,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		"1:	ll	%[old], (%[addr])			\n"
 		"	move	%[tmp], %[new]				\n"
 		"2:	sc	%[tmp], (%[addr])			\n"
-		"	bnez	%[tmp], 4f				\n"
+		"	beqz	%[tmp], 4f				\n"
 		"3:							\n"
 		"	.subsection 2					\n"
 		"4:	b	1b					\n"
-- 
2.8.0.rc2.1.gbe9624a
