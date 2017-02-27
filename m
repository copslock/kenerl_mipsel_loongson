Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2017 19:50:48 +0100 (CET)
Received: from prod-mail-xrelay08.akamai.com ([96.6.114.112]:48084 "EHLO
        prod-mail-xrelay08.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbdB0SulPaM7r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Feb 2017 19:50:41 +0100
Received: from prod-mail-xrelay08.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id F125D200037;
        Mon, 27 Feb 2017 18:50:32 +0000 (GMT)
Received: from prod-mail-relay08.akamai.com (prod-mail-relay08.akamai.com [172.27.22.71])
        by prod-mail-xrelay08.akamai.com (Postfix) with ESMTP id D9FBF200014;
        Mon, 27 Feb 2017 18:50:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; s=a1;
        t=1488221432; bh=DQ/fXPYoLsDiJALqPNXZRvJC1vmX613KApgSFqaOFhI=;
        l=4622; h=From:To:Cc:Date:From;
        b=nsJURsEn8iGrj/u0xIWNb9iOUn0PbLrIWPE0U/zQoUCysTzLNqxlged9Bc0TS54sj
         nUty/4XcdwqFuqvBZjrhy2bt144UvH6oBzwhoPiHBNOkfeEKar2UDvfCwsuTDd247f
         ME83EHL/aXtS+FcGV4AyR38nun7M4obgY/GcvEKU=
Received: from bos-lpjec.kendall.corp.akamai.com (bos-lpjec.kendall.corp.akamai.com [172.28.13.148])
        by prod-mail-relay08.akamai.com (Postfix) with ESMTP id F27879808E;
        Mon, 27 Feb 2017 18:50:31 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     rostedt@goodmis.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anton Blanchard <anton@samba.org>,
        Rabin Vincent <rabin@rab.in>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Zhigang Lu <zlu@ezchip.com>,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] jump_label: align jump_entry table to at least 4-bytes
Date:   Mon, 27 Feb 2017 13:49:24 -0500
Message-Id: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <jbaron@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbaron@akamai.com
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

The core jump_label code makes use of the 2 lower bits of the
static_key::[type|entries|next] field. Thus, ensure that the jump_entry
table is at least 4-byte aligned.

Reported-and-tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>
Cc: Rabin Vincent <rabin@rab.in>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Zhigang Lu <zlu@ezchip.com>
Cc: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 arch/arm/include/asm/jump_label.h     | 2 ++
 arch/mips/include/asm/jump_label.h    | 2 ++
 arch/powerpc/include/asm/jump_label.h | 3 +++
 arch/tile/include/asm/jump_label.h    | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
index 34f7b6980d21..9c017bb04d1c 100644
--- a/arch/arm/include/asm/jump_label.h
+++ b/arch/arm/include/asm/jump_label.h
@@ -13,6 +13,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	asm_volatile_goto("1:\n\t"
 		 WASM(nop) "\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".balign 4\n\t"
 		 ".word 1b, %l[l_yes], %c0\n\t"
 		 ".popsection\n\t"
 		 : :  "i" (&((char *)key)[branch]) :  : l_yes);
@@ -27,6 +28,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	asm_volatile_goto("1:\n\t"
 		 WASM(b) " %l[l_yes]\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".balign 4\n\t"
 		 ".word 1b, %l[l_yes], %c0\n\t"
 		 ".popsection\n\t"
 		 : :  "i" (&((char *)key)[branch]) :  : l_yes);
diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
index e77672539e8e..243791f3ae71 100644
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -31,6 +31,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	asm_volatile_goto("1:\t" NOP_INSN "\n\t"
 		"nop\n\t"
 		".pushsection __jump_table,  \"aw\"\n\t"
+		".balign 4\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"
 		: :  "i" (&((char *)key)[branch]) : : l_yes);
@@ -45,6 +46,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	asm_volatile_goto("1:\tj %l[l_yes]\n\t"
 		"nop\n\t"
 		".pushsection __jump_table,  \"aw\"\n\t"
+		".balign 4\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"
 		: :  "i" (&((char *)key)[branch]) : : l_yes);
diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index 9a287e0ac8b1..bfe83496b590 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -24,6 +24,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	asm_volatile_goto("1:\n\t"
 		 "nop # arch_static_branch\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".balign 4\n\t"
 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
@@ -38,6 +39,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	asm_volatile_goto("1:\n\t"
 		 "b %l[l_yes] # arch_static_branch_jump\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".balign 4\n\t"
 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
@@ -63,6 +65,7 @@ struct jump_entry {
 #define ARCH_STATIC_BRANCH(LABEL, KEY)		\
 1098:	nop;					\
 	.pushsection __jump_table, "aw";	\
+	.balign 4;				\
 	FTR_ENTRY_LONG 1098b, LABEL, KEY;	\
 	.popsection
 #endif
diff --git a/arch/tile/include/asm/jump_label.h b/arch/tile/include/asm/jump_label.h
index cde7573f397b..a964e6135ea3 100644
--- a/arch/tile/include/asm/jump_label.h
+++ b/arch/tile/include/asm/jump_label.h
@@ -25,6 +25,7 @@ static __always_inline bool arch_static_branch(struct static_key *key,
 	asm_volatile_goto("1:\n\t"
 		"nop" "\n\t"
 		".pushsection __jump_table,  \"aw\"\n\t"
+		".balign 4\n\t"
 		".quad 1b, %l[l_yes], %0 + %1 \n\t"
 		".popsection\n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
@@ -39,6 +40,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key,
 	asm_volatile_goto("1:\n\t"
 		"j %l[l_yes]" "\n\t"
 		".pushsection __jump_table,  \"aw\"\n\t"
+		".balign 4\n\t"
 		".quad 1b, %l[l_yes], %0 + %1 \n\t"
 		".popsection\n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
-- 
2.6.1
