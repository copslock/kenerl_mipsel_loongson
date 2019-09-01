Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E0DC3A5A8
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CC823429
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfIAPv6 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:51:58 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:56978 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfIAPv5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 11:51:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 6B99B404FF
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:43:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6CLKjmgsfE7T for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 17:43:05 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 751EB403CF
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:43:05 +0200 (CEST)
Date:   Sun, 1 Sep 2019 17:43:05 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 020/120] MIPS: R5900: Define CP0.Config register fields
Message-ID: <e7bb27bb8ff03271ee0da7f94fbd41a68bd404ca.1567326213.git.noring@nocrew.org>
References: <cover.1567326213.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567326213.git.noring@nocrew.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The following CP0.Config fields are specific to the R5900[1]:

	Field | Bit | Type | Description
	------+-----+------+-----------------------------
	  DIE |  18 |   RW | Enable double issue
	  ICE |  17 |   RW | Enable the instruction cache
	  DCE |  16 |   RW | Enable the data cache
	  BE  |  15 |   RO | Enable big-endian
	  NBE |  13 |   RW | Enable nonblocking load
	  BPE |  12 |   RW | Enable branch prediction
	------+-----+------+-----------------------------

References:

[1] "TX System RISC TX79 Core Architecture" manual, revision 2.0,
    Toshiba Corporation, p. 4-23, https://wiki.qemu.org/File:C790.pdf

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 arch/mips/include/asm/mipsregs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index ec22406c800f..a3b3ee011539 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -511,6 +511,14 @@
 #define R5K_CONF_SE		(_ULCAST_(1) << 12)
 #define R5K_CONF_SS		(_ULCAST_(3) << 20)
 
+/* Bits specific to the R5900.	*/
+#define R5900_CONF_BPE		(_ULCAST_(1) << 12)	/* Enable branch prediction. */
+#define R5900_CONF_NBE		(_ULCAST_(1) << 13)	/* Enable non-blocking load. */
+#define R5900_CONF_BE		(_ULCAST_(1) << 15)	/* Enable big-endian (read-only). */
+#define R5900_CONF_DCE		(_ULCAST_(1) << 16)	/* Enable the data cache. */
+#define R5900_CONF_ICE		(_ULCAST_(1) << 17)	/* Enable the instruction cache. */
+#define R5900_CONF_DIE		(_ULCAST_(1) << 18)	/* Enable double issue. */
+
 /* Bits specific to the RM7000.	 */
 #define RM7K_CONF_SE		(_ULCAST_(1) <<	 3)
 #define RM7K_CONF_TE		(_ULCAST_(1) << 12)
-- 
2.21.0

