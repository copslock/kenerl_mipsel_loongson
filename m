Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 19:14:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23923 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992500AbcHSROjT7IDr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 19:14:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 61BB996BBEE03;
        Fri, 19 Aug 2016 18:14:19 +0100 (IST)
Received: from localhost (10.100.200.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 19 Aug
 2016 18:14:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/3] MIPS: sc-mips: L2 cache is inclusive of L1 dcache for CM3
Date:   Fri, 19 Aug 2016 18:13:36 +0100
Message-ID: <20160819171336.28401-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160819171336.28401-1-paul.burton@imgtec.com>
References: <20160819171336.28401-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54694
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

In systems with CM3 & higher, the L2 cache is inclusive of the L1
dcache. Indicate this such that cpu_has_inclusive_pcaches evaluates true
& we avoid some unnecessary cache ops during DMA cache maintenance.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/mm/sc-mips.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 286a4d5..c909c334 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -181,6 +181,7 @@ static int __init mips_sc_probe_cm3(void)
 
 	if (c->scache.linesz) {
 		c->scache.flags &= ~MIPS_CACHE_NOT_PRESENT;
+		c->options |= MIPS_CPU_INCLUSIVE_CACHES;
 		return 1;
 	}
 
-- 
2.9.3
