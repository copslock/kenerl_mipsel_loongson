Return-Path: <SRS0=ZcmI=YZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739C6CA9ED2
	for <linux-mips@archiver.kernel.org>; Fri,  1 Nov 2019 14:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C44218AC
	for <linux-mips@archiver.kernel.org>; Fri,  1 Nov 2019 14:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfKAOKJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:10:09 -0400
Received: from foss.arm.com ([217.140.110.172]:35956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbfKAOKI (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Nov 2019 10:10:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5CCE332;
        Fri,  1 Nov 2019 07:10:07 -0700 (PDT)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE9293F718;
        Fri,  1 Nov 2019 07:10:04 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH v15 05/23] mips: mm: Add p?d_leaf() definitions
Date:   Fri,  1 Nov 2019 14:09:24 +0000
Message-Id: <20191101140942.51554-6-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101140942.51554-1-steven.price@arm.com>
References: <20191101140942.51554-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_leaf() functions/macros.

If _PAGE_HUGE is defined we can simply look for it. When not defined we
can be confident that there are no leaf pages in existence and fall back
on the generic implementation (added in a later patch) which returns 0.

CC: Ralf Baechle <ralf@linux-mips.org>
CC: Paul Burton <paul.burton@mips.com>
CC: James Hogan <jhogan@kernel.org>
CC: linux-mips@vger.kernel.org
Signed-off-by: Steven Price <steven.price@arm.com>
Acked-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/include/asm/pgtable.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index f85bd5b15f51..fff392ea80c7 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -639,6 +639,11 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+#ifdef _PAGE_HUGE
+#define pmd_leaf(pmd)	((pmd_val(pmd) & _PAGE_HUGE) != 0)
+#define pud_leaf(pud)	((pud_val(pud) & _PAGE_HUGE) != 0)
+#endif
+
 #define gup_fast_permitted(start, end)	(!cpu_has_dc_aliases)
 
 #include <asm-generic/pgtable.h>
-- 
2.20.1

