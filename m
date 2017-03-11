Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Mar 2017 06:20:47 +0100 (CET)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:48123 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992100AbdCKFTzbijtF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Mar 2017 06:19:55 +0100
X-QQ-mid: bizesmtp8t1489209564tlpm3pn9p
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 11 Mar 2017 13:19:22 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82B00A0000000
X-QQ-FEAT: 6dXuswn9i1VJK429T/PVRiRQL991i0UfqfUJxDeQS3SbsR3tXoNv6zQ537bHw
        5pABQi9F/2bLqgwRu5VC4yvEAZqyviMynurUti22/CeQp0U25ZXS/vn91ZIpaNHUn/ZkvEN
        dFaJb4dI1s6WXhhhF4SLxVknNFZZbAXI3wVJai73kKdSEyXp+iwiGajm0zM8Rh6iDjAXg7n
        sztbiGsIy7BpckzMD33LYuFYhfAKKuJWvTkGkFQZI9tefCAKR4hlh61IeVyTqRXqplaEvXL
        MF9MCrIqLJ1H7hJG9/84+EP2YMLdxLMqDQFg==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V2 7/7] MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
Date:   Sat, 11 Mar 2017 13:19:58 +0800
Message-Id: <1489209598-30312-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1489209598-30312-1-git-send-email-chenhc@lemote.com>
References: <1489209598-30312-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57138
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

This patch is borrowed from ARM64 to ensure pmd_present() returns false
after pmd_mknotpresent(). This is needed for THP.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/pgtable-64.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 514cbc0..ef6f007 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -193,6 +193,11 @@ static inline int pmd_bad(pmd_t pmd)
 
 static inline int pmd_present(pmd_t pmd)
 {
+#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
+	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
+		return pmd_val(pmd) & _PAGE_PRESENT;
+#endif
+
 	return pmd_val(pmd) != (unsigned long) invalid_pte_table;
 }
 
-- 
2.7.0


ÿÿÿ	
