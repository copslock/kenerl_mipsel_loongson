Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 19:50:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30963 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011148AbbCCStspnfxn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 19:49:48 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 01135E642295E
        for <linux-mips@linux-mips.org>; Tue,  3 Mar 2015 18:49:40 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 3 Mar 2015 18:49:43 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 3 Mar 2015 18:49:42 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/4] MIPS: asm: spinlock: Fix addiu instruction for R10000_LLSC_WAR case
Date:   Tue, 3 Mar 2015 18:48:48 +0000
Message-ID: <1425408530-21613-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1425408530-21613-1-git-send-email-markos.chandras@imgtec.com>
References: <1425408530-21613-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Commit 5753762cbd1c("MIPS: asm: spinlock: Replace "sub" instruction
with "addiu") replaced the "sub" instruction with addiu but it did
not update the immediate value in the R10000_LLSC_WAR case.

Fixes: 5753762cbd1c("MIPS: asm: spinlock: Replace "sub" instruction with "addiu"")
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index b4548690ade9..1fca2e0793dc 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -263,7 +263,7 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__(
 		"1:	ll	%1, %2		# arch_read_unlock	\n"
-		"	addiu	%1, 1					\n"
+		"	addiu	%1, -1					\n"
 		"	sc	%1, %0					\n"
 		"	beqzl	%1, 1b					\n"
 		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
-- 
2.3.1
