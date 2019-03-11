Return-Path: <SRS0=SHWW=RO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F45EC43381
	for <linux-mips@archiver.kernel.org>; Mon, 11 Mar 2019 21:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281D52087C
	for <linux-mips@archiver.kernel.org>; Mon, 11 Mar 2019 21:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfCKVPX (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:15:23 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:17262 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfCKVPX (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 11 Mar 2019 17:15:23 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2019 17:15:22 EDT
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 8DF204D89;
        Mon, 11 Mar 2019 22:08:36 +0100 (CET)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id e2c0766e;
        Mon, 11 Mar 2019 22:08:33 +0100 (CET)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     linux-mips@vger.kernel.org
Cc:     =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] mips: bcm47xx: Enable USB power on Netgear WNDR3400v2
Date:   Mon, 11 Mar 2019 22:08:22 +0100
Message-Id: <1552338502-9511-1-git-send-email-ynezz@true.cz>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Eric has reported on OpenWrt's bug tracking system[1], that he's not
able to use USB devices on his WNDR3400v2 device after the boot, until
he turns on GPIO #21 manually through sysfs.

1. https://bugs.openwrt.org/index.php?do=details&task_id=2170

Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Reported-by: Eric Bohlman <ericbohlman@gmail.com>
Tested-by: Eric Bohlman <ericbohlman@gmail.com>
Signed-off-by: Petr Štetiar <ynezz@true.cz>
---
 arch/mips/bcm47xx/workarounds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
index 46eddbe..0ab95dd 100644
--- a/arch/mips/bcm47xx/workarounds.c
+++ b/arch/mips/bcm47xx/workarounds.c
@@ -24,6 +24,7 @@ void __init bcm47xx_workarounds(void)
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
 		bcm47xx_workarounds_enable_usb_power(12);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNDR3400V2:
 	case BCM47XX_BOARD_NETGEAR_WNDR3400_V3:
 		bcm47xx_workarounds_enable_usb_power(21);
 		break;
-- 
1.9.1

