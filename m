Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 13:12:37 +0200 (CEST)
Received: from smtp206.alice.it ([82.57.200.102]:24634 "EHLO smtp206.alice.it"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026197AbbD1LMWZs1HM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Apr 2015 13:12:22 +0200
Received: from jcn (87.10.137.246) by smtp206.alice.it (8.6.060.28)
        id 547D8AFA1BEE75AE; Tue, 28 Apr 2015 13:12:03 +0200
Received: from ao2 by jcn with local (Exim 4.84)
        (envelope-from <ao2@ao2.it>)
        id 1Yn3Qo-0001LS-VB; Tue, 28 Apr 2015 13:12:03 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Antonio Ospite <ao2@ao2.it>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: [PATCH 06/12] trivial: MIPS: Netlogic: xlp/ahci-init-xlp2.c fix 0x0x prefixes
Date:   Tue, 28 Apr 2015 13:11:25 +0200
Message-Id: <1430219491-5076-7-git-send-email-ao2@ao2.it>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430219491-5076-1-git-send-email-ao2@ao2.it>
References: <1430219491-5076-1-git-send-email-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Return-Path: <ao2@ao2.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47128
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

Fix the 0x0x prefix in integer constants, in this case the registers
interval is actually 0x8065 .. 0x80A4 as confirmed some lines above in
the code.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/netlogic/xlp/ahci-init-xlp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/netlogic/xlp/ahci-init-xlp2.c b/arch/mips/netlogic/xlp/ahci-init-xlp2.c
index 7b066a4..c11b9c7 100644
--- a/arch/mips/netlogic/xlp/ahci-init-xlp2.c
+++ b/arch/mips/netlogic/xlp/ahci-init-xlp2.c
@@ -152,7 +152,7 @@ static const u8 sata_phy_config1[]  = {
 	0xC9, 0xC9, 0x07, 0x07, 0x18, 0x18, 0x01, 0x01, 0x22, 0x00
 };
 
-/* SATA PHY config for register block 2 0x0x8065 .. 0x0x80A4 */
+/* SATA PHY config for register block 2 0x8065 .. 0x80A4 */
 static const u8 sata_phy_config2[]  = {
 	0xAA, 0x00, 0x4C, 0xC9, 0xC9, 0x07, 0x07, 0x18,
 	0x18, 0x05, 0x0C, 0x10, 0x00, 0x10, 0x00, 0xFF,
-- 
2.1.4
