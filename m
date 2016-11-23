Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 14:46:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22369 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993035AbcKWNoKCJSuG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2016 14:44:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 98626A7836ACF;
        Wed, 23 Nov 2016 13:43:58 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 23 Nov 2016 13:44:01 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 07/10] MIPS: fix mem=X@Y commandline processing
Date:   Wed, 23 Nov 2016 14:43:49 +0100
Message-ID: <1479908632-30392-8-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1479908632-30392-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

When a memory offset is specified through the commandline, add the
memory in range PHYS_OFFSET:Y as reserved memory area.
Otherwise the bootmem allocator is initialised with low page equal to
min_low_pfn = PHYS_OFFSET, and in free_all_bootmem will process pages
starting from min_low_pfn instead of PFN(Y).

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/kernel/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c22f0fd..ae88866 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -662,6 +662,10 @@ static int __init early_parse_mem(char *p)
 		start = memparse(p + 1, &p);
 
 	add_memory_region(start, size, BOOT_MEM_RAM);
+
+	if (start && start > PHYS_OFFSET)
+		add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
+				BOOT_MEM_RESERVED);
 	return 0;
 }
 early_param("mem", early_parse_mem);
-- 
2.7.4
