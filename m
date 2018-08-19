Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Aug 2018 21:20:39 +0200 (CEST)
Received: from mail-lf1-x144.google.com ([IPv6:2a00:1450:4864:20::144]:38811
        "EHLO mail-lf1-x144.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994682AbeHSTUgkRZNO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Aug 2018 21:20:36 +0200
Received: by mail-lf1-x144.google.com with SMTP id a4-v6so9321910lff.5
        for <linux-mips@linux-mips.org>; Sun, 19 Aug 2018 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=MD9e6IlC0gB4zaSRGkqcrpZaimmviU2IMAsekNkAxuY=;
        b=kw9rFY8G5dg2xtNZ1XseWQlBOPthKyxmai4v+N3slaCJSo9ltzdlx7Z7Ip+2mHw3Ie
         fVFQqK1K651if7huTI/Y4j+fuLh+3pg0vrkxtMH/6vyJID4lDJSrFg6Wk7MkYiorG0E+
         YSYBeNybJfv4z4qfvVHRqI8vG0i7fomyShZwmBc3Zfiv2LVPUucOIxPY5exLB0/g+L79
         PO0TG4751fI/+ns7l4Se+J/RoPQj4lCKkXu6RVx2rMX+euBmR/tIchmnPDY7/yTacRDD
         fH0F1VIzCT7aYvFQ5xkgL897w8sC7EbVGNHL0ax5CN0vJkX5NrlvmRpKrv651QgyvlBc
         yMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=MD9e6IlC0gB4zaSRGkqcrpZaimmviU2IMAsekNkAxuY=;
        b=hC5ycmuUqfIJxGwRMcyZxSv/ukGs9Cz3c9aeyvMi4cTGluYlGkId8cdqPVEqxlKspL
         yl3HplwBSakeykeEiQZhFM7QiuKk3jMuMwBUv9RI+ztLm+hJlK/vkQkcepElaSX/+PxU
         yutzI5OjeDyqR8I3RJsIa8yXeVf6aqrEeOkD7mqeRY0AVkvxV+zWJMNUDhdoNMRV+kwo
         eayctdaq1q3VTQ1htehx3udBF2uT1yewrxrMKJ3JNFxljGPgsbsqT6s8vcl38wymaPaI
         HMzXdOc5UdfXQ/qLoaxjLG//gT5XS2gNS/IGtGT0w3v6hdz2tMJiLDb6gqBaqYD8fY/Z
         xCmA==
X-Gm-Message-State: AOUpUlE1BTNRWPsjKQpsKhrsfqLb85RqGAZ46JDLovVw3Fbk5DqUpK2H
        R2pTweIRycBOghp1cOThDys=
X-Google-Smtp-Source: AA+uWPwqz/8lUynIZlLbwVWPEb4/zqQDaqPUKEtOCoM23mwHog9jE1s55MlLGWrIokT5RLB8dw2qdg==
X-Received: by 2002:a19:a111:: with SMTP id k17-v6mr26381802lfe.131.1534706431069;
        Sun, 19 Aug 2018 12:20:31 -0700 (PDT)
Received: from duuni.helsinki.fi (nat-eduroam-hy-138-172.fe.helsinki.fi. [128.214.138.172])
        by smtp.gmail.com with ESMTPSA id f14-v6sm779262lfm.29.2018.08.19.12.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 12:20:29 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH] MIPS: BCM47XX: Enable USB power on Netgear WNDR3400v3
Date:   Sun, 19 Aug 2018 22:20:23 +0300
Message-Id: <20180819192023.18463-1-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.16.3
Return-Path: <dezgeg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tuomas.tynkkynen@iki.fi
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

Setting GPIO 21 high seems to be required to enable power to USB ports
on the WNDR3400v3. As there is already similar code for WNR3500L,
make the existing USB power GPIO code generic and use that.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 arch/mips/bcm47xx/workarounds.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
index 1a8a07e7a563..46eddbec8d9f 100644
--- a/arch/mips/bcm47xx/workarounds.c
+++ b/arch/mips/bcm47xx/workarounds.c
@@ -5,9 +5,8 @@
 #include <bcm47xx_board.h>
 #include <bcm47xx.h>
 
-static void __init bcm47xx_workarounds_netgear_wnr3500l(void)
+static void __init bcm47xx_workarounds_enable_usb_power(int usb_power)
 {
-	const int usb_power = 12;
 	int err;
 
 	err = gpio_request_one(usb_power, GPIOF_OUT_INIT_HIGH, "usb_power");
@@ -23,7 +22,10 @@ void __init bcm47xx_workarounds(void)
 
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
2.16.3
