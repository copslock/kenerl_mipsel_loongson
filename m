Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 14:56:26 +0100 (CET)
Received: from smtp207.alice.it ([82.57.200.103]:17910 "EHLO smtp207.alice.it"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011373AbcA0N4Yph-hN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2016 14:56:24 +0100
Received: from jcn (87.13.159.1) by smtp207.alice.it (8.6.060.28)
        id 562CAA69137DC493; Wed, 27 Jan 2016 14:56:07 +0100
Received: from ao2 by jcn with local (Exim 4.86)
        (envelope-from <ao2@ao2.it>)
        id 1aOQZt-00008r-JB; Wed, 27 Jan 2016 14:56:09 +0100
From:   Antonio Ospite <ao2@ao2.it>
To:     linux-mips@linux-mips.org
Cc:     Antonio Ospite <ao2@ao2.it>, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: BCM1480: bcm1480_regs.h: strip redundant comments
Date:   Wed, 27 Jan 2016 14:56:06 +0100
Message-Id: <1453902966-506-1-git-send-email-ao2@ao2.it>
X-Mailer: git-send-email 2.7.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Return-Path: <ao2@ao2.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ao2@ao2.it
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

Strip some comments which probably meant to repeat the same value of the
define; they also contained a confusing 0x0x prefix.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/include/asm/sibyte/bcm1480_regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/sibyte/bcm1480_regs.h b/arch/mips/include/asm/sibyte/bcm1480_regs.h
index ec0dacf..32a8483 100644
--- a/arch/mips/include/asm/sibyte/bcm1480_regs.h
+++ b/arch/mips/include/asm/sibyte/bcm1480_regs.h
@@ -415,8 +415,8 @@
 					(cpu)*BCM1480_IMR_ALIAS_MAILBOX_SPACING)
 #define A_BCM1480_IMR_ALIAS_MAILBOX_REGISTER(cpu, reg) (A_BCM1480_IMR_ALIAS_MAILBOX(cpu)+(reg))
 
-#define R_BCM1480_IMR_ALIAS_MAILBOX_0		0x0000		/* 0x0x0 */
-#define R_BCM1480_IMR_ALIAS_MAILBOX_0_SET	0x0008		/* 0x0x8 */
+#define R_BCM1480_IMR_ALIAS_MAILBOX_0		0x0000
+#define R_BCM1480_IMR_ALIAS_MAILBOX_0_SET	0x0008
 
 /*
  * these macros work together to build the address of a mailbox
-- 
2.7.0
