Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 14:08:05 +0100 (CET)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:35420 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009614AbcAUNIEZCsyu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jan 2016 14:08:04 +0100
X-QQ-mid: bizesmtp15t1453381646t125t10
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 21 Jan 2016 21:06:54 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: oIoGrveFQB/pb9B6I0HPVc14s0FOcQ+GUeqF7MSH6IjsmWvaYwmz2R+ucFoSa
        JRyAAQuINPxa1K8SgSik4qVwzzYD69jP2j/wlaEsuOCcW3h7Srze+jyedDVETzO0VCy/Gu8
        GHpW5ZAvZhv/eAaPi05pdOMO+sR8vAEhKSbRs/AqmaDd0KgFNAGwIafybDZW8/NZP4E4h24
        Rn1FgD3KL4AsDMIfOF6pKnbiANIjyWK1X3ioEd5vP5fJfrhOc0CWdREPwxgBy2V6zIJ5UT/
        7bgb5GiQhu3m7koyDdOgtKOqQ=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH V2 6/6] MIPS: Fix some missing CONFIG_CPU_MIPSR6 #ifdefs
Date:   Thu, 21 Jan 2016 21:09:52 +0800
Message-Id: <1453381793-8357-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1453381793-8357-1-git-send-email-chenhc@lemote.com>
References: <1453381793-8357-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Commit be0c37c985eddc4 (MIPS: Rearrange PTE bits into fixed positions.)
defines fixed PTE bits for MIPS R2. Then, commit d7b631419b3d230a4d383
(MIPS: pgtable-bits: Fix XPA damage to R6 definitions.) adds the MIPS
R6 definitions in the same way as MIPS R2. But some R6 #ifdefs in the
later commit are missing, so in this patch I fix that.

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/pgtable.h | 4 ++--
 arch/mips/mm/tlbex.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 8957f15..18826aa 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -353,7 +353,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (!(pte_val(pte) & _PAGE_NO_READ))
 		pte_val(pte) |= _PAGE_SILENT_READ;
 	else
@@ -560,7 +560,7 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 {
 	pmd_val(pmd) |= _PAGE_ACCESSED;
 
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (!(pmd_val(pmd) & _PAGE_NO_READ))
 		pmd_val(pmd) |= _PAGE_SILENT_READ;
 	else
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 32e0be2..29f73e0 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -242,7 +242,7 @@ static void output_pgtable_bits_defines(void)
 	pr_define("_PAGE_HUGE_SHIFT %d\n", _PAGE_HUGE_SHIFT);
 	pr_define("_PAGE_SPLITTING_SHIFT %d\n", _PAGE_SPLITTING_SHIFT);
 #endif
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (cpu_has_rixi) {
 #ifdef _PAGE_NO_EXEC_SHIFT
 		pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
-- 
2.4.6
