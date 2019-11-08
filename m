Return-Path: <SRS0=IVZI=ZA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF26C5DF60
	for <linux-mips@archiver.kernel.org>; Fri,  8 Nov 2019 11:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD576215EA
	for <linux-mips@archiver.kernel.org>; Fri,  8 Nov 2019 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214114;
	bh=WvA7ooE23+rMcSXpkAwDLVyHFb12QEhAyN/XFwoVHjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M10cvNdyrIpXOx9FBmEexm7tZa+ZichBAN09mL5cJ4OPaNRqVPiVc5gh/rnMht2w5
	 +8ftsQBCNw4GEVVsEduuB6YMBx2uEOgfheQB0ILDxwgi39LyUkGKRNOGkwpCXMgWc6
	 BKPWKETO6DUBh2bX/6RkR/LxBMQBcr5SRRjIZumA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbfKHLqE (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391244AbfKHLqD (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 8 Nov 2019 06:46:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D844721D82;
        Fri,  8 Nov 2019 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213562;
        bh=WvA7ooE23+rMcSXpkAwDLVyHFb12QEhAyN/XFwoVHjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWgsfV2zikTa8FAxNqZBZ4o6niF58kOj42cUrafpYD127xs+uy1U86gMru5ee0Xt6
         OiuYrJbowUFJraqF3bBw3p4WIIV4mXJW9Atavhw1+y8N9AFlLwR1woJmBlnsL8Nwo+
         63qxxVSENvLKHMcdAa78ikKJIkp+gXs+Cc+UWmBk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@mips.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Sasha Levin <sashal@kernel.org>,
        linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 11/64] MIPS: BCM47XX: Enable USB power on Netgear WNDR3400v3
Date:   Fri,  8 Nov 2019 06:44:52 -0500
Message-Id: <20191108114545.15351-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>

[ Upstream commit feef7918667b84f9d5653c501542dd8d84ae32af ]

Setting GPIO 21 high seems to be required to enable power to USB ports
on the WNDR3400v3. As there is already similar code for WNR3500L,
make the existing USB power GPIO code generic and use that.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20259/
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/bcm47xx/workarounds.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
index e81ce4623070e..06fb94370c7c9 100644
--- a/arch/mips/bcm47xx/workarounds.c
+++ b/arch/mips/bcm47xx/workarounds.c
@@ -4,9 +4,8 @@
 #include <bcm47xx_board.h>
 #include <bcm47xx.h>
 
-static void __init bcm47xx_workarounds_netgear_wnr3500l(void)
+static void __init bcm47xx_workarounds_enable_usb_power(int usb_power)
 {
-	const int usb_power = 12;
 	int err;
 
 	err = gpio_request_one(usb_power, GPIOF_OUT_INIT_HIGH, "usb_power");
@@ -22,7 +21,10 @@ void __init bcm47xx_workarounds(void)
 
 	switch (board) {
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
-		bcm47xx_workarounds_netgear_wnr3500l();
+		bcm47xx_workarounds_enable_usb_power(12);
+		break;
+	case BCM47XX_BOARD_NETGEAR_WNDR3400_V3:
+		bcm47xx_workarounds_enable_usb_power(21);
 		break;
 	default:
 		/* No workaround(s) needed */
-- 
2.20.1

