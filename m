Return-Path: <SRS0=Tox3=WO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0035C3A589
	for <linux-mips@archiver.kernel.org>; Sun, 18 Aug 2019 15:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8081B206DF
	for <linux-mips@archiver.kernel.org>; Sun, 18 Aug 2019 15:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfHRPv3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 18 Aug 2019 11:51:29 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:53939 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRPv3 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 18 Aug 2019 11:51:29 -0400
Received: from localhost.localdomain ([92.140.207.10])
        by mwinf5d11 with ME
        id qfrR2000c0Dzhgk03frSjN; Sun, 18 Aug 2019 17:51:27 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Aug 2019 17:51:27 +0200
X-ME-IP: 92.140.207.10
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] MIPS: Octeon: Fix a typo in #define OCTOEN_SERIAL_LEN
Date:   Sun, 18 Aug 2019 17:51:24 +0200
Message-Id: <20190818155124.3750-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

It should be OCTEON_SERIAL_LEN.
Update the #define and use it accordingly

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/mips/include/asm/octeon/octeon.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 60481502826a..a2e2876357ce 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -51,7 +51,7 @@ extern void octeon_setup_delays(void);
 extern void octeon_io_clk_delay(unsigned long);
 
 #define OCTEON_ARGV_MAX_ARGS	64
-#define OCTOEN_SERIAL_LEN	20
+#define OCTEON_SERIAL_LEN	20
 
 struct octeon_boot_descriptor {
 #ifdef __BIG_ENDIAN_BITFIELD
@@ -102,7 +102,7 @@ struct octeon_boot_descriptor {
 	uint16_t chip_type;
 	uint8_t chip_rev_major;
 	uint8_t chip_rev_minor;
-	char board_serial_number[OCTOEN_SERIAL_LEN];
+	char board_serial_number[OCTEON_SERIAL_LEN];
 	uint8_t mac_addr_base[6];
 	uint8_t mac_addr_count;
 	uint64_t cvmx_desc_vaddr;
-- 
2.20.1

