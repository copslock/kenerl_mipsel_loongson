Return-Path: <SRS0=4POb=WI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1492AC433FF
	for <linux-mips@archiver.kernel.org>; Mon, 12 Aug 2019 10:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4F12085A
	for <linux-mips@archiver.kernel.org>; Mon, 12 Aug 2019 10:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfHLKhK (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:37:10 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:35528 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbfHLKhK (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 12 Aug 2019 06:37:10 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 876B6A1619;
        Mon, 12 Aug 2019 12:37:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id NJXQZ4GMOWhr; Mon, 12 Aug 2019 12:36:57 +0200 (CEST)
From:   Stefan Roese <sr@denx.de>
To:     linux-mips@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4 v4] dt-bindings: mips: Add gardena vendor prefix and board description
Date:   Mon, 12 Aug 2019 12:36:54 +0200
Message-Id: <20190812103655.11070-3-sr@denx.de>
In-Reply-To: <20190812103655.11070-1-sr@denx.de>
References: <20190812103655.11070-1-sr@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This patch adds the vendor prefix for gardena and a short description
including the compatible string for the "GARDENA smart Gateway" based
on the MT7688 SoC.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
v4:
- Move board description into ralink.txt instead of creating a gardena
  board file (Rob)
- Slightly changed board compatible

v3:
- New patch

 Documentation/devicetree/bindings/mips/ralink.txt   | 13 +++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml        |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/ralink.txt b/Documentation/devicetree/bindings/mips/ralink.txt
index 3341945b51d9..8cc0ab41578c 100644
--- a/Documentation/devicetree/bindings/mips/ralink.txt
+++ b/Documentation/devicetree/bindings/mips/ralink.txt
@@ -17,3 +17,16 @@ value must be one of the following values:
   ralink,mt7620n-soc
   ralink,mt7628a-soc
   ralink,mt7688a-soc
+
+2. Boards
+
+GARDENA smart Gateway (MT7688)
+
+This board is based on the MediaTek MT7688 and equipped with 128 MiB
+of DDR and 8 MiB of flash (SPI NOR) and additional 128MiB SPI NAND
+storage.
+
+------------------------------
+Required root node properties:
+- compatible = "gardena,smart-gateway-mt7688", "ralink,mt7688a-soc",
+		"ralink,mt7628a-soc";
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbbbffab..73166adfd4ad 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -337,6 +337,8 @@ patternProperties:
     description: Freescale Semiconductor
   "^fujitsu,.*":
     description: Fujitsu Ltd.
+  "^gardena,.*":
+    description: GARDENA GmbH
   "^gateworks,.*":
     description: Gateworks Corporation
   "^gcw,.*":
-- 
2.22.0

