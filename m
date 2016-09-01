Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:31:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44251 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992255AbcIAQaxcQ-y2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:30:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 48CC8EC785251;
        Thu,  1 Sep 2016 17:30:34 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:30:37 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 2/9] MIPS: traps: Convert ebase to KSeg0
Date:   Thu, 1 Sep 2016 17:30:08 +0100
Message-ID: <89ba2209bfa719084688012c20ee6ea152be865c.1472747205.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

When allocating boot memory for the exception vector when vectored
interrupts (vint) or vectored external interrupt controllers (veic) are
enabled, try to ensure that the virtual address resides in KSeg0 (and
WARN should that not be possible).

This will be helpful on MIPS64 cores supporting the CP0_EBase Write Gate
(WG) bit once we start using the WG bit to write the full ebase into
CP0_EBase, as we ideally need to avoid hitting the architecturally
poorly defined exception base for Cache Errors when CP0_EBase is in
XKPhys.

An exception is made for Enhanced Virtual Addressing (EVA) kernels which
allow segments to be rearranged and to become uncached during cache
error handling, making it valid for ebase to be elsewhere.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/traps.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 686903f62fa3..cb2419dc4651 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2209,8 +2209,25 @@ void __init trap_init(void)
 
 	if (cpu_has_veic || cpu_has_vint) {
 		unsigned long size = 0x200 + VECTORSPACING*64;
+		phys_addr_t ebase_pa;
+
 		ebase = (unsigned long)
 			__alloc_bootmem(size, 1 << fls(size), 0);
+
+		/*
+		 * Try to ensure ebase resides in KSeg0 if possible.
+		 *
+		 * It shouldn't generally be in XKPhys on MIPS64 to avoid
+		 * hitting a poorly defined exception base for Cache Errors.
+		 * The allocation is likely to be in the low 512MB of physical,
+		 * in which case we should be able to convert to KSeg0.
+		 *
+		 * EVA is special though as it allows segments to be rearranged
+		 * and to become uncached during cache error handling.
+		 */
+		ebase_pa = __pa(ebase);
+		if (!IS_ENABLED(CONFIG_EVA) && !WARN_ON(ebase_pa >= 0x20000000))
+			ebase = CKSEG0ADDR(ebase_pa);
 	} else {
 		ebase = CAC_BASE;
 
-- 
git-series 0.8.10
