Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:47:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41743 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860085AbaGKPqS2EucS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:46:18 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2F92837E5BFAE
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:46:09 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:46:11 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:46:10 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 07/13] MIPS: fix read_msa_* & write_msa_* functions on non-MSA toolchains
Date:   Fri, 11 Jul 2014 16:44:33 +0100
Message-ID: <1405093479-5123-8-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
References: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.172]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Commit d96cc3d1ec5d "MIPS: Add microMIPS MSA support." attempted to use
the value of a macro within an inline asm statement but instead emitted
a comment leading to the cfcmsa & ctcmsa instructions being omitted. Fix
that by passing CFC_MSA_INSN & CTC_MSA_INSN as arguments to the asm
statements.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/msa.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index f32aa06..7002c18 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -115,10 +115,10 @@ static inline unsigned int read_msa_##name(void)		\
 	"	.set	push\n"					\
 	"	.set	noat\n"					\
 	"	.insn\n"					\
-	"	.word	#CFC_MSA_INSN | (" #cs " << 11)\n"	\
+	"	.word	%1 | (" #cs " << 11)\n"			\
 	"	move	%0, $1\n"				\
 	"	.set	pop\n"					\
-	: "=r"(reg));						\
+	: "=r"(reg) : "i"(CFC_MSA_INSN));			\
 	return reg;						\
 }								\
 								\
@@ -129,9 +129,9 @@ static inline void write_msa_##name(unsigned int val)		\
 	"	.set	noat\n"					\
 	"	move	$1, %0\n"				\
 	"	.insn\n"					\
-	"	.word	#CTC_MSA_INSN | (" #cs " << 6)\n"	\
+	"	.word	%1 | (" #cs " << 6)\n"			\
 	"	.set	pop\n"					\
-	: : "r"(val));						\
+	: : "r"(val), "i"(CTC_MSA_INSN));			\
 }
 
 #endif /* !TOOLCHAIN_SUPPORTS_MSA */
-- 
2.0.1
