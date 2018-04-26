Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2018 16:29:00 +0200 (CEST)
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34121 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994614AbeDZO2v5DhL0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Apr 2018 16:28:51 +0200
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A84721A88;
        Thu, 26 Apr 2018 10:28:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 26 Apr 2018 10:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XcEW6lLgIsV9uYmPm
        83pZLnTxHnFIePUrOwoz4QodvQ=; b=PC3Sjo7F15uLYnIAX1jgIKHDuL/olK1WA
        N1dc6qgLvHOdW1yjKlA/OGyzBTcC95UB2WH465v3uEG9oXePAqPkYA+LKTrrshlY
        Eei+SIK8rbsyE78pKGmL0Baa3fuspEkLxzEqK/DfyCugKYrgwbXKYxDWHrri6wTv
        n9C+BF8vp4mLn3/2SlT2qBkO8vr6u3FqK1Q3ua7AI8kwKovJmHiP9JIbM6189+Hb
        x+LO/umdmj9aopq03vryz2RSI3xOfrA+IDsSGb03BVFF42KezlJna2KL2yfSlI9J
        QC0K+t/+LjtRDgQH2dneJJxvkL4JW45daqpsSPJ1Eyei2B/W+4/DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=XcEW6lLgIsV9uYmPm83pZLnTxHnFIePUrOwoz4QodvQ=; b=itNEjpMy
        uLEuhjptpjSFudP1gdXPKhhAFiqTQvodfkVAm/p9khXD8bn4orWHPLDeGwIRrxxq
        u1QUlaPfHs9jCA4A+puH8xoeAVOG3ruR0l4Ih+SNE+vyxR4xKH2O/JtOtJ/oETnr
        MONiwYxjl0WX3u5skuaEXJS6qbaCHd457eT6nsbVyf6GZSbC05NK0V3fcBlsEtcp
        xVFNxYOl+szX8CGmqkASyPzRnkEUmmqg9ji5Vr0Ex4cuMpgq013Uqs3XlT3XfYn8
        1m5qrdR2/Xm5wKgX8FZk27nWmzztFWWprsUdBADW0y6BMO5WwqBRRe0VstueTlnw
        2XN9AdzZFP582w==
X-ME-Sender: <xms:I-LhWro0Mex3PjAzcPqCfaNlr1Ff2YFIBeiTTDpWt9ioOllyBIFILw>
Received: from tenansix.rutgers.edu (pool-165-230-225-59.nat.rutgers.edu [165.230.225.59])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04E96E47A0;
        Thu, 26 Apr 2018 10:28:51 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Zi Yan <zi.yan@cs.rutgers.edu>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org
Subject: [RFC PATCH 5/9] mips: mm: migrate: add pmd swap entry to support thp migration.
Date:   Thu, 26 Apr 2018 10:28:00 -0400
Message-Id: <20180426142804.180152-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426142804.180152-1-zi.yan@sent.com>
References: <20180426142804.180152-1-zi.yan@sent.com>
Return-Path: <zi.yan@sent.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zi.yan@sent.com
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

From: Zi Yan <zi.yan@cs.rutgers.edu>

Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org
Cc: linux-mm@kvack.org
---
 arch/mips/include/asm/pgtable-64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 0036ea0c7173..ec72e5b12965 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -366,6 +366,8 @@ static inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 #define __swp_offset(x)		((x).val >> 24)
 #define __swp_entry(type, offset) ((swp_entry_t) { pte_val(mk_swap_pte((type), (offset))) })
 #define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
+#define __pmd_to_swp_entry(pmd) ((swp_entry_t) { pmd_val(pmd) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+#define __swp_entry_to_pmd(x)	((pmd_t) { (x).val })
 
 #endif /* _ASM_PGTABLE_64_H */
-- 
2.17.0
