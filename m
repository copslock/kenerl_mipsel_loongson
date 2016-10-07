Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2016 12:52:16 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:36587 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991759AbcJGKwJD4dmc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Oct 2016 12:52:09 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D1A59ADE8;
        Fri,  7 Oct 2016 10:52:05 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] MIPS: Malta: Fix IOCU disable switch read for MIPS64
Date:   Fri,  7 Oct 2016 12:51:33 +0200
Message-Id: <20161007105157.13743-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161007105157.13743-1-jslaby@suse.cz>
References: <20161007105157.13743-1-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Paul Burton <paul.burton@imgtec.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit 305723ab439e14debc1d339aa04e835d488b8253 upstream.

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
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14187/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/mti-malta/malta-setup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index c72a06936781..2046e1c385d4 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -36,6 +36,9 @@
 #include <linux/console.h>
 #endif
 
+#define ROCIT_CONFIG_GEN0		0x1f403000
+#define  ROCIT_CONFIG_GEN0_PCI_IOCU	BIT(7)
+
 extern void malta_be_init(void);
 extern int malta_be_handler(struct pt_regs *regs, int is_fixup);
 
@@ -108,6 +111,8 @@ static void __init fd_activate(void)
 static int __init plat_enable_iocoherency(void)
 {
 	int supported = 0;
+	u32 cfg;
+
 	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO) {
 		if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
 			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
@@ -130,7 +135,8 @@ static int __init plat_enable_iocoherency(void)
 	} else if (gcmp_niocu() != 0) {
 		/* Nothing special needs to be done to enable coherency */
 		pr_info("CMP IOCU detected\n");
-		if ((*(unsigned int *)0xbf403000 & 0x81) != 0x81) {
+		cfg = __raw_readl((u32 *)CKSEG1ADDR(ROCIT_CONFIG_GEN0));
+		if (!(cfg & ROCIT_CONFIG_GEN0_PCI_IOCU)) {
 			pr_crit("IOCU OPERATION DISABLED BY SWITCH - DEFAULTING TO SW IO COHERENCY\n");
 			return 0;
 		}
-- 
2.10.1
