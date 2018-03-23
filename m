Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 23:58:27 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:35781
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbeCWW6U5NHxl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 23:58:20 +0100
Received: by mail-lf0-x243.google.com with SMTP id t132-v6so20499201lfe.2;
        Fri, 23 Mar 2018 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JiJ+qcrFT6hIQtbQGU/byzkYZ2VdWW+tSrUOFpjhkf4=;
        b=cKf3BnLSb85IiG7MUq/RkUKqToNmUVUzueMSip2ZJqdsbOhcmQyMngAevS/OKDJhga
         tWO4cM6TxDQggkYdfbKatPFflcP5qRzMYHDzuHqzsGT8q3KVQH34KqkU7S1gCxXUUKb1
         ib6krhf2k1ZkleQNefuStZhBf4AbCjLj8Cf5dS8y3K5TLZV4ot06lANlooGOHd+VXnTk
         PWjjPwacSehcbKKf2cSgisGTbLGL/spWsQKbtKBUWp/fn0i964pZAXdA9z23WcYsYBkg
         Lzq5G5NLLMqydqTBXxBwSf5QKWKJgtNWpcQHb7fRHolx6ANKKN323JIsnD5PS5T6sPkZ
         ko6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JiJ+qcrFT6hIQtbQGU/byzkYZ2VdWW+tSrUOFpjhkf4=;
        b=OjjOfUnbk9Xvu4a2XLai68NMqNOfi8Fej0o6aYwhWO2TTt7loxk7cqP5Ohs2pilGAc
         3j7iAr19ycUgH1gMw5HQCiWaCzl3ZtGeI6G2v//bdphSlh3tfYYgvONnaLdsPZi/yoYX
         IOA/JJuonuoBQEbrt4erF3Sa11Fa5A2c0URoK8OjZfJeSTbEuRhMeqr73Q8l//VozwSo
         KkaM4yDHBq+wgyJ2pkfZX+0MqWn+jvq3FR1J6izUeaW8OcTIOQS5C8JDHoV31Ap0BLNn
         oimlAJt/AUeOZVSDNnss6gvuTO5yH2n7v6K3XLG2cbXIBzCJJ0LWTmuP0hzDhqZmPAqM
         xufQ==
X-Gm-Message-State: AElRT7HF9iAijABwiZsMVCkFlPPj/A6Rs/w2zu2u2vRuxsCtqwAzq6v2
        y3rx1sxiW1Ofb7ZMd8URIcnsLA==
X-Google-Smtp-Source: AG47ELuoPB4m2HFDaj5EpOCPKZYZ3rO2N4s9erey01cwkwx6/YquzYnC+gVNPX3aolVSdLMLZBnTeQ==
X-Received: by 10.46.151.72 with SMTP id f8mr13556643ljj.53.1521845894978;
        Fri, 23 Mar 2018 15:58:14 -0700 (PDT)
Received: from linux-samsung.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a67sm2093188ljf.54.2018.03.23.15.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 15:58:14 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, James Hogan <jhogan@kernel.org>,
        Dan Haab <riproute@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] MIPS: BCM47XX: Use __initdata for the bcm47xx_leds_pdata
Date:   Fri, 23 Mar 2018 23:58:07 +0100
Message-Id: <20180323225807.13386-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

From: Rafał Miłecki <rafal@milecki.pl>

This struct variable is used during init only. It gets passed to the
gpio_led_register_device() which creates its own data copy. That allows
using __initdata and saving some minimal amount of memory.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/mips/bcm47xx/leds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 8307a8a02667..fb87a6c54bc9 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -521,7 +521,7 @@ bcm47xx_leds_simpletech_simpleshare[] __initconst = {
  * Init
  **************************************************/
 
-static struct gpio_led_platform_data bcm47xx_leds_pdata;
+static struct gpio_led_platform_data bcm47xx_leds_pdata __initdata;
 
 #define bcm47xx_set_pdata(dev_leds) do {				\
 	bcm47xx_leds_pdata.leds = dev_leds;				\
-- 
2.11.0
