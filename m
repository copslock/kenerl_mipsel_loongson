Return-Path: <SRS0=+ZmA=SZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21342C282DD
	for <linux-mips@archiver.kernel.org>; Tue, 23 Apr 2019 03:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C1621841
	for <linux-mips@archiver.kernel.org>; Tue, 23 Apr 2019 03:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="n6YMDDai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfDWDvu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:51:50 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:38995 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730606AbfDWDvu (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 22 Apr 2019 23:51:50 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x3N3o2cD023044;
        Tue, 23 Apr 2019 12:50:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3N3o2cD023044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555991412;
        bh=ck3m1Bnhk+gBZ69Ip9jiWsEf5IWvpXJTs7wxMIQoCXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6YMDDaiO+Y+ehsJY3BwtkUdg1YDcyPA3Dzmuu8XOwJ1WrZig5ClP17Sypb2aBakK
         pdb05/Mxt6GVPh61aaBT0xJP66Mu0V7s+lzlxmzMKtCZpnT8wEPrNDYE+HzwcwOsrt
         M+K4hgRSZ2BsDVMyqA2McjsJjJooi4+aOx81MKG7ecEsFD8/riXxDnXctaXPrCzSeY
         2Awph1mCyl2BuT2YcctjtjX9fGNx3slwDHVqkisVXH/eIqwqW4g1+6Ign1Zg0xzjsQ
         nEbhKOdhvwUnu9BexA/KqiOdzGngWI9/3T9raieSibcixW3rUYkf2NW/Jkw05P6Tx3
         svNkTBvfuxmgA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RESEND PATCH v3 05/11] mtd: rawnand: vf610_nfc: add initializer to avoid -Wmaybe-uninitialized
Date:   Tue, 23 Apr 2019 12:49:53 +0900
Message-Id: <20190423034959.13525-6-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423034959.13525-1-yamada.masahiro@socionext.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

Kbuild test robot has never reported -Wmaybe-uninitialized warning
for this probably because vf610_nfc_run() is inlined by the x86
compiler's inlining heuristic.

If CONFIG_OPTIMIZE_INLINING is enabled for a different architecture
and vf610_nfc_run() is not inlined, the following warning is reported:

drivers/mtd/nand/raw/vf610_nfc.c: In function ‘vf610_nfc_cmd’:
drivers/mtd/nand/raw/vf610_nfc.c:455:3: warning: ‘offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   vf610_nfc_rd_from_sram(instr->ctx.data.buf.in + offset,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            nfc->regs + NFC_MAIN_AREA(0) + offset,
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            trfr_sz, !nfc->data_access);
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 drivers/mtd/nand/raw/vf610_nfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index a662ca1970e5..19792d725ec2 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -364,7 +364,7 @@ static int vf610_nfc_cmd(struct nand_chip *chip,
 {
 	const struct nand_op_instr *instr;
 	struct vf610_nfc *nfc = chip_to_nfc(chip);
-	int op_id = -1, trfr_sz = 0, offset;
+	int op_id = -1, trfr_sz = 0, offset = 0;
 	u32 col = 0, row = 0, cmd1 = 0, cmd2 = 0, code = 0;
 	bool force8bit = false;
 
-- 
2.17.1

