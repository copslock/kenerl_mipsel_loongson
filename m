Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2015 15:41:14 +0100 (CET)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34641 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008520AbbLVOlKD8x19 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2015 15:41:10 +0100
Received: by mail-lb0-f174.google.com with SMTP id pv2so46231017lbb.1
        for <linux-mips@linux-mips.org>; Tue, 22 Dec 2015 06:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MfSEB722wOd40uCF76eY9sTMLwL/w+YOOIsha1ZZv9s=;
        b=ESbhd40ormPuGenfQP5ucHVw3u8pTHIMIJfXbd25XHvViu9f2b6F2INYeukQZ3ozZE
         E+PHDW1qQG8+unSs8vv//kp2vVQQn7IC8VPzw3EaCpwMwsOH7yMVO0sHh/wK3UOkW7B7
         s13vtMmhvWHklWUYWDZ6/vbkH8bDHQuFBD1dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MfSEB722wOd40uCF76eY9sTMLwL/w+YOOIsha1ZZv9s=;
        b=hU/q9j1p+3o/cjcjsZy+0jcU0r+dTNRTVINIE5Xqsiang0Cjjd4KHgrUry+oXdG9g8
         S78y1QUsHEm25VAxmuWoYZTPBsCDlKFqjn5KT/gWlArELFleCEfFigxuHJPalHIqtIcf
         frKdvfd1mfMB9QmH8UMwIAbDqEedxC315J2hSOUG64Q05zWOS6MeC5iV8wEbFw2B/vND
         lFX/vT6nXz84OjMe/nL2feTK2i1cgydo4u2I2L5QT/UXPbMpQF1gkGlajV1ld/tTQD5K
         JtQ8bKNZ7lYYS1C2rHHNEBajNWn4ojQvP4dtzEdexM6IhkPt7Y/547bPhFnc9jQT0i3y
         OaQA==
X-Gm-Message-State: ALoCoQnHKGw+vwRiqEQllfsk+3ssoJb0mxMxL+ohNFd3kQo2d0O9180wkkTORBsvNBCp7cmmk804T01G0yM6yCoUCHF492uGUg==
X-Received: by 10.112.219.197 with SMTP id pq5mr7195129lbc.73.1450795264732;
        Tue, 22 Dec 2015 06:41:04 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id p1sm3400546lbo.30.2015.12.22.06.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2015 06:41:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 38/54] mips: txx9: Be sure to clamp return value
Date:   Tue, 22 Dec 2015 15:41:01 +0100
Message-Id: <1450795261-27465-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

As we want gpio_chip .get() calls to be able to return negative
error codes and propagate to drivers, we need to go over all
drivers and make sure their return values are clamped to [0,1].
We do this by using the ret = !!(val) design pattern.

Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
MIPS folks: as mentioned in 00/54: either apply this directly
or ACK it and I will take it into the GPIO tree.
---
 arch/mips/kernel/gpio_txx9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/gpio_txx9.c b/arch/mips/kernel/gpio_txx9.c
index c6854d9df926..705be43c3533 100644
--- a/arch/mips/kernel/gpio_txx9.c
+++ b/arch/mips/kernel/gpio_txx9.c
@@ -21,7 +21,7 @@ static struct txx9_pio_reg __iomem *txx9_pioptr;
 
 static int txx9_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
-	return __raw_readl(&txx9_pioptr->din) & (1 << offset);
+	return !!(__raw_readl(&txx9_pioptr->din) & (1 << offset));
 }
 
 static void txx9_gpio_set_raw(unsigned int offset, int value)
-- 
2.4.3
