Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Mar 2010 12:02:46 +0100 (CET)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:56209 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491204Ab0CULCn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Mar 2010 12:02:43 +0100
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
        (easymta 1.00 BETA 1)
        id 1NtIvZ-0006es-GP; Sun, 21 Mar 2010 12:02:41 +0100
Date:   Sun, 21 Mar 2010 12:02:41 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] mips/mm: fix module support on SiByte
Message-ID: <20100321110241.GA25569@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Key-Id: FE3F4706
X-Key-Fingerprint: FFDA BBBB 3563 1B27 75C9  925B 98D5 5C1C FE3F 4706
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sebastian@breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
Precedence: bulk
X-list: linux-mips

Since commit 656be92f aka "Load modules to CKSEG0 if
CONFIG_BUILD_ELF64=n" module support is broken on 64bit. Since then
modules arr loaded into 32bit compat adresses which are sign extended
64bit addresses. The SiByte war handler was not updated and those
addresses were not recognized by the TLB hadling.
This patch fixes this by shifting away the upper bits including the R
and Fill bits. Now we compare VPN2 of C0_ENTRYHI against the matching
bits at C0_BADVADDR.

Cc: <stable@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/mips/mm/tlbex.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index badcf5e..47faeb4 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -745,6 +745,10 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 		UASM_i_MFC0(&p, K1, C0_ENTRYHI);
 		uasm_i_xor(&p, K0, K0, K1);
 		UASM_i_SRL(&p, K0, K0, PAGE_SHIFT + 1);
+#ifdef CONFIG_64BIT
+		/* Make sure we have here just VPN2 */
+		uasm_i_dsll32(&p, K0, K0, PAGE_SHIFT + 1 + 24 - 32);
+#endif
 		uasm_il_bnez(&p, &r, K0, label_leave);
 		/* No need for uasm_i_nop */
 	}
@@ -1264,6 +1268,10 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 		UASM_i_MFC0(&p, K1, C0_ENTRYHI);
 		uasm_i_xor(&p, K0, K0, K1);
 		UASM_i_SRL(&p, K0, K0, PAGE_SHIFT + 1);
+#ifdef CONFIG_64BIT
+		/* Make sure we have here just VPN2 */
+		uasm_i_dsll32(&p, K0, K0, PAGE_SHIFT + 1 + 24 - 32);
+#endif
 		uasm_il_bnez(&p, &r, K0, label_leave);
 		/* No need for uasm_i_nop */
 	}
-- 
1.6.6
