Return-Path: <SRS0=x683=O4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79A9C43387
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FE421852
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYE7FrNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeLSHIK (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:08:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40034 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeLSHIK (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 19 Dec 2018 02:08:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so18326290wrt.7
        for <linux-mips@vger.kernel.org>; Tue, 18 Dec 2018 23:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hst+F6VKhDFpZObL3jgNAlAblZFRxOaBP89DJzo+N5U=;
        b=OYE7FrNjE5TCyPx7Bfn3JPdd9rnDbOxu/GT+GtR+TQxXlN2WC3IxZXkJ4HmkiU6gEU
         T2bgSaBqALN3wvMKtTdTBbuSC96wBW7v0t6Z/TGHEryWIAhDimfcHuegWCW4hHxgSvpe
         23+ZSpJUG2Ylv/yHYQUAcCKbHacpJoMtLi8uhJIE4R5Z2C48w/jMPsVc0t96HS8w8hVw
         oqYMv0IPVbXdIaiBt49AZrlOaR1gVZqnQVEEgcNdqi8CMUNOLGooVDkquK+GDl/+J1+b
         RuWxYW9qDho2HUfvQILMo0/rWYR85AMe9kFlZO1DGZiOiCUDKYtz2kxsHS7NYHVckx/f
         yFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hst+F6VKhDFpZObL3jgNAlAblZFRxOaBP89DJzo+N5U=;
        b=MIWkLCaoZYdumorRbT1zX23/cDOMtavKp80fQMklI3rTrDFHK20inB+uAaIUH54e8u
         PA8gl4EWTnBwN9kssoo90UL6El/KvIbU7RzbUNA8Zy0w0mtci4pCbeLSpfDsaGEXBGkT
         cBOULK7d6Qv7Rh+b7NWNtlPWNGGN+o5zwp/kkFsZvTfNf8sL48eDBqhX+g4PFkL60vPm
         LuVyuHdhoBNcRsHfnqD/s0B1be/TVTKqC9Mx1Tdwi9BG4yg7E0Us/noUFenKff3VPx5i
         A0eFHqLiKzds8OiruXmC67CfW4GRdPlyI0VCQnCyLb74vjN6RI4bKPjeOGfmBXSVwVOT
         qugQ==
X-Gm-Message-State: AA+aEWZz/mEoCF7K7nYsStzphkNOjb6qxxAT3bTeIn6Hm0yWgsnk/v4w
        d84EP7Xi4G2XljKwJtYklWGOKZQV
X-Google-Smtp-Source: AFSGD/URZHY+4lsifIQHmhzD3oZhuBhR9Y05+u9mV2XDVD0a8zIX55zbByR9BfsQsgKlDGjzvzbR9A==
X-Received: by 2002:adf:9521:: with SMTP id 30mr16495503wrs.192.1545203287876;
        Tue, 18 Dec 2018 23:08:07 -0800 (PST)
Received: from flagship2.speedport.ip (p200300C20BD333581B9ECEB655B1C7D2.dip0.t-ipconnect.de. [2003:c2:bd3:3358:1b9e:ceb6:55b1:c7d2])
        by smtp.gmail.com with ESMTPSA id s16sm3245724wrt.77.2018.12.18.23.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 23:08:07 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@vger.kernel.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 3/5] MIPS: Alchemy: drop DB1000 IrDA support bits
Date:   Wed, 19 Dec 2018 08:08:01 +0100
Message-Id: <20181219070803.449981-4-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181219070803.449981-1-manuel.lauss@gmail.com>
References: <20181219070803.449981-1-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The IrDA drivers are gone, drop the now unused DB1000 board
support for it.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1000.c | 58 ----------------------------
 1 file changed, 58 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 13e3c84859fe..aab842a8ddf3 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -389,58 +389,6 @@ static struct platform_device db1100_mmc1_dev = {
 
 /******************************************************************************/
 
-static void db1000_irda_set_phy_mode(int mode)
-{
-	unsigned short mask = BCSR_RESETS_IRDA_MODE_MASK | BCSR_RESETS_FIR_SEL;
-
-	switch (mode) {
-	case AU1000_IRDA_PHY_MODE_OFF:
-		bcsr_mod(BCSR_RESETS, mask, BCSR_RESETS_IRDA_MODE_OFF);
-		break;
-	case AU1000_IRDA_PHY_MODE_SIR:
-		bcsr_mod(BCSR_RESETS, mask, BCSR_RESETS_IRDA_MODE_FULL);
-		break;
-	case AU1000_IRDA_PHY_MODE_FIR:
-		bcsr_mod(BCSR_RESETS, mask, BCSR_RESETS_IRDA_MODE_FULL |
-					    BCSR_RESETS_FIR_SEL);
-		break;
-	}
-}
-
-static struct au1k_irda_platform_data db1000_irda_platdata = {
-	.set_phy_mode	= db1000_irda_set_phy_mode,
-};
-
-static struct resource au1000_irda_res[] = {
-	[0] = {
-		.start	= AU1000_IRDA_PHYS_ADDR,
-		.end	= AU1000_IRDA_PHYS_ADDR + 0x0fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1000_IRDA_TX_INT,
-		.end	= AU1000_IRDA_TX_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1000_IRDA_RX_INT,
-		.end	= AU1000_IRDA_RX_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device db1000_irda_dev = {
-	.name	= "au1000-irda",
-	.id	= -1,
-	.dev	= {
-		.platform_data = &db1000_irda_platdata,
-	},
-	.resource	= au1000_irda_res,
-	.num_resources	= ARRAY_SIZE(au1000_irda_res),
-};
-
-/******************************************************************************/
-
 static struct ads7846_platform_data db1100_touch_pd = {
 	.model		= 7846,
 	.vref_mv	= 3300,
@@ -497,15 +445,10 @@ static struct platform_device *db1x00_devs[] = {
 	&db1x00_audio_dev,
 };
 
-static struct platform_device *db1000_devs[] = {
-	&db1000_irda_dev,
-};
-
 static struct platform_device *db1100_devs[] = {
 	&au1100_lcd_device,
 	&db1100_mmc0_dev,
 	&db1100_mmc1_dev,
-	&db1000_irda_dev,
 };
 
 int __init db1000_dev_setup(void)
@@ -565,7 +508,6 @@ int __init db1000_dev_setup(void)
 		d1 = 3; /* GPIO number, NOT irq! */
 		s0 = AU1000_GPIO1_INT;
 		s1 = AU1000_GPIO4_INT;
-		platform_add_devices(db1000_devs, ARRAY_SIZE(db1000_devs));
 	} else if ((board == BCSR_WHOAMI_PB1500) ||
 		   (board == BCSR_WHOAMI_PB1500R2)) {
 		c0 = AU1500_GPIO203_INT;
-- 
2.20.0

