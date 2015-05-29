Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2015 15:44:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6735 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007676AbbE2NoAxZ0BW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2015 15:44:00 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 69BB4C8FAF29F
        for <linux-mips@linux-mips.org>; Fri, 29 May 2015 14:43:55 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 29 May 2015 14:43:57 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 29 May 2015 14:43:57 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH] MIPS: asm: pgtable-bits: Add R6 support for PTE RI/XI bits
Date:   Fri, 29 May 2015 14:43:52 +0100
Message-ID: <1432907032-16689-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47723
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

Commit be0c37c985ed ("MIPS: Rearrange PTE bits into fixed positions.")
rearranged the PTE bits into fixed positions in preparation for the XPA
support. However, this patch broke R6 since it only took R2 cores
into consideration for the RI/XI bits leading to boot failures. We fix
this by adding the missing CONFIG_CPU_MIPSR6 definitions

Fixes: be0c37c985ed ("MIPS: Rearrange PTE bits into fixed positions.")
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
This is a bugfix for a bug introduced in 4.1-rc1. Can we please have
this patch in 4.1?
---
 arch/mips/include/asm/pgtable-bits.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 18ae5ddef118..c28a8499aec7 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -113,7 +113,7 @@
 #define _PAGE_PRESENT_SHIFT	0
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
 /* R2 or later cores check for RI/XI support to determine _PAGE_READ */
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 #define _PAGE_WRITE_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
 #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
 #else
@@ -135,16 +135,16 @@
 #define _PAGE_SPLITTING		(1 << _PAGE_SPLITTING_SHIFT)
 
 /* Only R2 or newer cores have the XI bit */
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 #define _PAGE_NO_EXEC_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
 #else
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_SPLITTING_SHIFT + 1)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
-#endif	/* CONFIG_CPU_MIPSR2 */
+#endif	/* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 
 #endif	/* CONFIG_64BIT && CONFIG_MIPS_HUGE_TLB_SUPPORT */
 
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 /* XI - page cannot be executed */
 #ifndef _PAGE_NO_EXEC_SHIFT
 #define _PAGE_NO_EXEC_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
@@ -160,10 +160,10 @@
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
 
-#else	/* !CONFIG_CPU_MIPSR2 */
+#else	/* !CONFIG_CPU_MIPSR2 && !CONFIG_CPU_MIPSR6 */
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
-#endif	/* CONFIG_CPU_MIPSR2 */
+#endif	/* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 
 #define _PAGE_VALID_SHIFT	(_PAGE_GLOBAL_SHIFT + 1)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
@@ -205,7 +205,7 @@
  */
 static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 {
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (cpu_has_rixi) {
 		int sa;
 #ifdef CONFIG_32BIT
-- 
2.4.2
