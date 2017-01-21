Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2017 01:56:15 +0100 (CET)
Received: from smtpproxy19.qq.com ([184.105.206.84]:41063 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993014AbdAUA4II1-n0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jan 2017 01:56:08 +0100
X-QQ-mid: bizesmtp16t1484960137thspeq92
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 21 Jan 2017 08:54:39 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ72B00A0000000
X-QQ-FEAT: 6dXuswn9i1U9NDq7M5wefjrifLPTVPpJ/+x3NiHVyu9JuJ3g0LFmlJoLjY/bN
        KSXvl4F/k7XlSrSWHmLz0oAxOSKSW+KC7a6GHWF48BcbjV/NHbjVLamwGcPw5veMoOxpQRJ
        v2146qQZQQLnLTGzL4xGklOPuBpuEbQVLiMzYBkAouNsWubT6TYr3/OIxNYUx2lih+i8g2+
        YDP3038h9IEvhhBcjXWUiklJ4zwMKGqnUsU8P9BB3pR5sYZbgopSw2IV7DFvJdCPyP2JMCP
        i1snfOlc7+56TxRlXenqNmqFL8x8Ftg+dzcA==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH RESEND 4/4] MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
Date:   Sat, 21 Jan 2017 08:56:06 +0800
Message-Id: <1484960166-30022-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1484960166-30022-1-git-send-email-chenhc@lemote.com>
References: <1484960166-30022-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56439
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
