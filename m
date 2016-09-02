Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 17:07:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37081 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991984AbcIBPHt0uL9f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 17:07:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2B437B8FB3E42;
        Fri,  2 Sep 2016 16:07:30 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 16:07:32 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Malta: Fix IOCU disable switch read for MIPS64
Date:   Fri, 2 Sep 2016 16:07:10 +0100
Message-ID: <20160902150711.18268-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55002
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

Malta boards used with CPU emulators feature a switch to disable use of
an IOCU. Software has to check this switch & ignore any present IOCU if
the switch is closed. The read used to do this was unsafe for 64 bit
kernels, as it simply casted the address 0xbf403000 to a pointer &
dereferenced it. Whilst in a 32 bit kernel this would access kseg1, in a
64 bit kernel this attempts to access xuseg & results in an address
error exception.

Fix by accessing a correctly formed ckseg1 address generated using the
CKSEG1ADDR macro.

Whilst modifying this code, define the name of the register and the bit
we care about within it, which indicates whether PCI DMA is routed to
the IOCU or straight to DRAM. The code previously checked that bit 0 was
also set, but the least significant 7 bits of the CONFIG_GEN0 register
contain the value of the MReqInfo signal provided to the IOCU OCP bus,
so singling out bit 0 makes little sense & that part of the check is
dropped.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: b6d92b4a6bdb ("MIPS: Add option to disable software I/O coherency.")
---

 arch/mips/mti-malta/malta-setup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index ec5b216..7e7364b 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -39,6 +39,9 @@
 #include <linux/console.h>
 #endif
 
+#define ROCIT_CONFIG_GEN0		0x1f403000
+#define  ROCIT_CONFIG_GEN0_PCI_IOCU	BIT(7)
+
 extern void malta_be_init(void);
 extern int malta_be_handler(struct pt_regs *regs, int is_fixup);
 
@@ -107,6 +110,8 @@ static void __init fd_activate(void)
 static int __init plat_enable_iocoherency(void)
 {
 	int supported = 0;
+	u32 cfg;
+
 	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO) {
 		if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
 			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
@@ -129,7 +134,8 @@ static int __init plat_enable_iocoherency(void)
 	} else if (mips_cm_numiocu() != 0) {
 		/* Nothing special needs to be done to enable coherency */
 		pr_info("CMP IOCU detected\n");
-		if ((*(unsigned int *)0xbf403000 & 0x81) != 0x81) {
+		cfg = __raw_readl((u32 *)CKSEG1ADDR(ROCIT_CONFIG_GEN0));
+		if (!(cfg & ROCIT_CONFIG_GEN0_PCI_IOCU)) {
 			pr_crit("IOCU OPERATION DISABLED BY SWITCH - DEFAULTING TO SW IO COHERENCY\n");
 			return 0;
 		}
-- 
2.9.3
