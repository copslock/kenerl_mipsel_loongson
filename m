Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 19:14:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59032 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992474AbcHSROKtXhdr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 19:14:10 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B4442186F4A3F;
        Fri, 19 Aug 2016 18:13:50 +0100 (IST)
Received: from localhost (10.100.200.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 19 Aug
 2016 18:13:54 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/3] MIPS: c-r4k: Treat I6400 dcache as though physically indexed
Date:   Fri, 19 Aug 2016 18:13:34 +0100
Message-ID: <20160819171336.28401-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54692
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

The L1 data cache in I6400 CPUs is indexed by physical address bits if
an entry for the address is present in the DTLB early enough in the
pipelined execution of a memory access instruction. If an entry is not
present then it's indexed by virtual address bits, but hardware will
check in a later pipeline stage when a DTLB entry has been created
whether the virtual address bits used match the physical address bits,
and if not will transparently restart the memory access instruction.

This means that although it isn't always physically indexed, it appears
so to software & we can treat the I6400 L1 data cache as being
physically indexed in order to avoid considering aliasing.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/mm/c-r4k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index ef7f925..7a64a8a81 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1266,6 +1266,7 @@ static void probe_pcache(void)
 	switch (current_cpu_type()) {
 	case CPU_20KC:
 	case CPU_25KF:
+	case CPU_I6400:
 	case CPU_SB1:
 	case CPU_SB1A:
 	case CPU_XLR:
@@ -1292,7 +1293,6 @@ static void probe_pcache(void)
 	case CPU_PROAPTIV:
 	case CPU_M5150:
 	case CPU_QEMU_GENERIC:
-	case CPU_I6400:
 	case CPU_P6600:
 	case CPU_M6250:
 		if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
-- 
2.9.3
