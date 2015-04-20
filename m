Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2015 11:54:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41762 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011046AbbDTJymuEsVi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2015 11:54:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ADD14115CA779
        for <linux-mips@linux-mips.org>; Mon, 20 Apr 2015 10:54:36 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 20 Apr 2015 10:54:38 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.117) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 20 Apr 2015 10:54:38 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: asm: spinlock: Adjust arch_spin_lock back-off time
Date:   Mon, 20 Apr 2015 10:54:34 +0100
Message-ID: <1429523674-4335-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.117]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46944
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

Make it similar to the trylock and R10000_LLSC_WAR cases.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
I can't find a reference on why this was different compared to the other
cases so I presume it was just an overlook in commit
2a31b03335e570dce5fdd082e0d71d48b2cb4290
---
 arch/mips/include/asm/spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index 1fca2e0793dc..cc771a21899d 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -109,7 +109,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
 		"2:							\n"
 		"	.subsection 2					\n"
-		"4:	andi	%[ticket], %[ticket], 0x1fff		\n"
+		"4:	andi	%[ticket], %[ticket], 0xffff		\n"
 		"	sll	%[ticket], 5				\n"
 		"							\n"
 		"6:	bnez	%[ticket], 6b				\n"
-- 
2.3.5
