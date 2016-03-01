Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 03:38:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39061 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007156AbcCACinsG0h- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 03:38:43 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id CB2C253025FEA;
        Tue,  1 Mar 2016 02:38:37 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 02:38:37 +0000
Received: from localhost (10.100.200.88) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 1 Mar
 2016 02:38:37 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lars Persson <lars.persson@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] MIPS: Flush dcache for flush_kernel_dcache_page
Date:   Tue, 1 Mar 2016 02:37:56 +0000
Message-ID: <1456799879-14711-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>
References: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52377
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

The flush_kernel_dcache_page function was previously essentially a nop.
This is incorrect for MIPS, where if a page has been modified & either
it aliases or it's executable & the icache doesn't fill from dcache then
the content needs to be written back from dcache to the next level of
the cache hierarchy (which is shared with the icache).

Implement this by simply calling flush_dcache_page, treating this
kmapped cache flush function (flush_kernel_dcache_page) exactly the same
as its non-kmapped counterpart (flush_dcache_page).

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/cacheflush.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 723229f..7e9f468 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -132,6 +132,7 @@ static inline void kunmap_noncoherent(void)
 static inline void flush_kernel_dcache_page(struct page *page)
 {
 	BUG_ON(cpu_has_dc_aliases && PageHighMem(page));
+	flush_dcache_page(page);
 }
 
 /*
-- 
2.7.1
