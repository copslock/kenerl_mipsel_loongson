Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Aug 2016 20:09:51 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38808 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993074AbcHMSJob6VbD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Aug 2016 20:09:44 +0200
Received: from 92.40.249.202.threembb.co.uk ([92.40.249.202] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYdNP-0004Ml-GQ; Sat, 13 Aug 2016 19:09:43 +0100
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYd3g-0002xO-AT; Sat, 13 Aug 2016 18:49:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, "Paul Burton" <paul.burton@imgtec.com>
Date:   Sat, 13 Aug 2016 18:42:51 +0100
Message-ID: <lsq.1471110171.294452247@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 128/305] MIPS: fix read_msa_* & write_msa_* functions
 on non-MSA toolchains
In-Reply-To: <lsq.1471110169.907390585@decadent.org.uk>
X-SA-Exim-Connect-IP: 92.40.249.202
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.37-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 70dff4d90aab40326d1d06a331e2b07eae99d067 upstream.

Commit d96cc3d1ec5d "MIPS: Add microMIPS MSA support." attempted to use
the value of a macro within an inline asm statement but instead emitted
a comment leading to the cfcmsa & ctcmsa instructions being omitted. Fix
that by passing CFC_MSA_INSN & CTC_MSA_INSN as arguments to the asm
statements.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7305/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/msa.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -112,10 +112,10 @@ static inline unsigned int read_msa_##na
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
@@ -126,9 +126,9 @@ static inline void write_msa_##name(unsi
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
