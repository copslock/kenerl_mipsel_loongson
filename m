Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 16:35:55 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:24467 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992240AbcJQOf1uyQg4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 16:35:27 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 6D9B17C1249A1;
        Mon, 17 Oct 2016 15:35:18 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 15:35:21 +0100
Received: from localhost (10.100.200.11) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct
 2016 15:35:21 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/4] MIPS: Cleanup LLBit handling in switch_to
Date:   Mon, 17 Oct 2016 15:34:36 +0100
Message-ID: <20161017143438.17298-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161017143438.17298-1-paul.burton@imgtec.com>
References: <20161017143438.17298-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.11]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55456
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

Commit 7c151d3d5d7a ("MIPS: Make use of the ERETNC instruction on MIPS
R6") began clearing LLBit during context switches, but did so on all
systems where it is writable for unclear reasons & did so from a macro
with "software_ll_bit" in its name, which is intended to operate on the
ll_bit variable used by ll/sc emulation for old CPUs.

We do now need to clear LLBit on MIPSr6 systems where we'll use eretnc
to return to userland, but we don't need to do so on MIPSr5 systems with
a writable LLBit.

Move the clear to its own appropriately named macro, do it only for
MIPSr6 systems & comment about why.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/switch_to.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index ebb5c0f..d60ae84 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -66,13 +66,18 @@ do {									\
 #define __mips_mt_fpaff_switch_to(prev) do { (void) (prev); } while (0)
 #endif
 
-#define __clear_software_ll_bit()					\
-do {	if (cpu_has_rw_llb) {						\
+/*
+ * Clear LLBit during context switches on MIPSr6 such that eretnc can be used
+ * unconditionally when returning to userland in entry.S.
+ */
+#define __clear_r6_hw_ll_bit() do {					\
+	if (cpu_has_mips_r6)						\
 		write_c0_lladdr(0);					\
-	} else {							\
-		if (!__builtin_constant_p(cpu_has_llsc) || !cpu_has_llsc)\
-			ll_bit = 0;					\
-	}								\
+} while (0)
+
+#define __clear_software_ll_bit() do {					\
+	if (!__builtin_constant_p(cpu_has_llsc) || !cpu_has_llsc)	\
+		ll_bit = 0;						\
 } while (0)
 
 /*
@@ -102,6 +107,7 @@ do {									\
 		}							\
 		clear_c0_status(ST0_CU2);				\
 	}								\
+	__clear_r6_hw_ll_bit();						\
 	__clear_software_ll_bit();					\
 	if (cpu_has_userlocal)						\
 		write_c0_userlocal(task_thread_info(next)->tp_value);	\
-- 
2.10.0
