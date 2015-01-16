Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 11:57:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28350 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010639AbbAPKw2Prvln (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:52:28 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8A452ED809EA9
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:52:20 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:52:22 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:52:19 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [PATCH RFC v2 23/70] MIPS: asm: futex: Set the appropriate ISA level for MIPS R6
Date:   Fri, 16 Jan 2015 10:49:02 +0000
Message-ID: <1421405389-15512-24-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45167
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

MIPS R6 changed the opcodes for LL/SC instructions so we need to set
the appropriate ISA level.

Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/futex.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index ef9987a61d88..9d06d266c22b 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -53,11 +53,11 @@
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
-		"	.set	arch=r4000			\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
 		"1:	"user_ll("%1", "%4")" # __futex_atomic_op\n"	\
 		"	.set	mips0				\n"	\
 		"	" insn	"				\n"	\
-		"	.set	arch=r4000			\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
 		"2:	"user_sc("$1", "%2")"			\n"	\
 		"	beqz	$1, 1b				\n"	\
 		__WEAK_LLSC_MB						\
@@ -183,12 +183,12 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"# futex_atomic_cmpxchg_inatomic			\n"
 		"	.set	push					\n"
 		"	.set	noat					\n"
-		"	.set	arch=r4000				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"1:	"user_ll("%1", "%3")"				\n"
 		"	bne	%1, %z4, 3f				\n"
 		"	.set	mips0					\n"
 		"	move	$1, %z5					\n"
-		"	.set	arch=r4000				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"2:	"user_sc("$1", "%2")"				\n"
 		"	beqz	$1, 1b					\n"
 		__WEAK_LLSC_MB
-- 
2.2.1
