Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 19:16:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15775 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992500AbcHSRQMzrsgr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 19:16:12 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7783074E17087;
        Fri, 19 Aug 2016 18:15:53 +0100 (IST)
Received: from localhost (10.100.200.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 19 Aug
 2016 18:15:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Fix BUILD_ROLLBACK_PROLOGUE for microMIPS
Date:   Fri, 19 Aug 2016 18:15:40 +0100
Message-ID: <20160819171540.28673-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54695
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

When the kernel is built for microMIPS, branches targets need to be
known to be microMIPS code in order to result in bit 0 of the PC being
set. The branch target in the BUILD_ROLLBACK_PROLOGUE macro was simply
the end of the macro, which may be pointing at padding rather than at
code. This results in recent enough GNU linkers complaining like so:

    mips-img-linux-gnu-ld: arch/mips/built-in.o: .text+0x3e3c: Unsupported branch between ISA modes.
    mips-img-linux-gnu-ld: final link failed: Bad value
    Makefile:936: recipe for target 'vmlinux' failed
    make: *** [vmlinux] Error 1

Fix this by changing the branch target to be the start of the
appropriate handler, skipping over any padding.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/genex.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 17326a9..dc0b296 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -142,9 +142,8 @@ LEAF(__r4k_wait)
 	PTR_LA	k1, __r4k_wait
 	ori	k0, 0x1f	/* 32 byte rollback region */
 	xori	k0, 0x1f
-	bne	k0, k1, 9f
+	bne	k0, k1, \handler
 	MTC0	k0, CP0_EPC
-9:
 	.set pop
 	.endm
 
-- 
2.9.3
