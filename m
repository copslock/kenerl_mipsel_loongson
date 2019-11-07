Return-Path: <SRS0=EWWg=Y7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7CAFC6198
	for <linux-mips@archiver.kernel.org>; Thu,  7 Nov 2019 11:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA50218AE
	for <linux-mips@archiver.kernel.org>; Thu,  7 Nov 2019 11:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Cb2dw7Na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfKGLSO (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:18:14 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.120]:35993 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfKGLSO (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 7 Nov 2019 06:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573125492;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=V4tJDHqvWbqdzKwfz6qUe3xDpoCXtYHplW9v6qCJKW4=;
        b=Cb2dw7Nal935VSInCgYMUzo/9uJFgf0zU52c5nY/Q3Ckn8VAszCxjs6ef9AILHnoqi
        TrAOMNri2+61nzEJwu2ShRIsNYJuDC2sEu9Eziwyh+Wp1/uQSHYcbf0SQOFD4uMCtxQ1
        +ElfUiU33s8YbSjCcU+8WJhCL9GBX6KrdeepLd3ckdcPiAWG47/RHJ1sow9YAmkbQ5Pr
        Y3QQBWekL5ogVowzDCLcvJtAZ0XlN9oxG5fETEtShoJ25GoQqD2NHSzNRFlHujaTAA7G
        hPlYmA8iiupn3AaR4AfVK3hqUCWTb9Gu/nH8EIs+70wB6lrkljgxOe2Ax0vSN0Cj84rn
        p4zA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7PR5/L9P0"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id L09db3vA7B6Gdh5
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 7 Nov 2019 12:06:16 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-mips@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 7/8] ARM: DTS: omap5: add sgx gpu child node
Date:   Thu,  7 Nov 2019 12:06:10 +0100
Message-Id: <b71f5c9be8db254d6c0bedaaa3c94122137bd232.1573124770.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1573124770.git.hns@goldelico.com>
References: <cover.1573124770.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

and add interrupt.

Tested on Pyra-Handheld.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 1fb7937638f0..333da4788088 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -274,10 +274,11 @@
 			#size-cells = <1>;
 			ranges = <0 0x56000000 0x2000000>;
 
-			/*
-			 * Closed source PowerVR driver, no child device
-			 * binding or driver in mainline
-			 */
+			sgx: gpu@0 {
+				compatible = "ti,omap5-sgx544-116", "img,sgx544-116", "img,sgx544";
+				reg = <0x0 0x10000>;
+				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		dss: dss@58000000 {
-- 
2.23.0

