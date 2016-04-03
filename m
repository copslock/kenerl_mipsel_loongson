Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2016 14:00:54 +0200 (CEST)
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36777 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006506AbcDCMAw6HV0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Apr 2016 14:00:52 +0200
Received: by mail-lf0-f49.google.com with SMTP id g184so57221178lfb.3
        for <linux-mips@linux-mips.org>; Sun, 03 Apr 2016 05:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PsMgulnbWd4V9Ul+ph5IlQU+WEiLwcFVEHOw5dRqEk=;
        b=NBfJJM+ctjnqc1XOciZTwG60r0B6UMicbPL4zmmob5Ccib7SbnZrys94kucxE/yQNw
         KFOJu1HyRpSyYZxswo9dYgLSqo6hStAJWAZLNmj/NLQqV64lTFb14I38lGWO/YK/Q1uT
         2DEojwfbcRFl82rU9s67XVtHCN1o5d2b02edzxSAvFmlvBMDkR0DyJAMf6eJrv3ViiPj
         H7kXh2DBlCSzuf3A+WVFnA70JTT+eYHkqrrL/6cnJPXpHki+flyeYHRx77Z/BRpC6Bm7
         LQq8RBFCFcSqdQRo5UflojR4IwOCwwuZjoMJcpn1ICgndgIigp3eWAZI25aA4ExHZHF+
         qnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PsMgulnbWd4V9Ul+ph5IlQU+WEiLwcFVEHOw5dRqEk=;
        b=jEFVfGzASjITmAdv2kn8iV3xk/reQgEFZaC0etPzqXOHYx8SBW1AkY2HR6EzJFalRb
         FHOSZC+whRPQFwzDH9yUwiR1aTHBRNRnu2fPCcCSoHQI8ZpjZbcvY+OMJHTIsMe5MtBb
         GMFINc4URXH3zQhtNvRcs6B8qoUZXNmHuJTebjXA6mcOCGSJWtmmYSsMfyyW0wp3rqHz
         PrXXiXKJFMU19rMXbb5gSnq1lgGmJClGvJoLF+hnaF4rdrAqfLUnRSus/xtD2QyqM0+V
         /6bGrCoZ5H3fgQPqAdwDS0+uOOkqxMILIz6oenx+fMMxzWqSe34AQqohIvFqwK+3w1zd
         +Zrg==
X-Gm-Message-State: AD7BkJJsmGw1rqjxr+UEjK2zjCr8Ex6v5+JORpVWzNSLcWbDRUgSi+sKcocr+X9O2uFJsA==
X-Received: by 10.194.21.197 with SMTP id x5mr2782756wje.90.1459684847272;
        Sun, 03 Apr 2016 05:00:47 -0700 (PDT)
Received: from localhost.localdomain (228.red-83-55-41.dynamicip.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id n66sm8398341wmg.20.2016.04.03.05.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Apr 2016 05:00:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH] bmips: rename BCM63168 to BCM63268
Date:   Sun,  3 Apr 2016 14:00:46 +0200
Message-Id: <1459684846-11308-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

BCM63168 and BCM63268 are very similar and Broadcom refers to them as BCM63268
in GPL sources (e.g. 63268_map_part.h).
Use alphabetical order for supported bmips quirks.
Add BCM63268 to devicetree documentation.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
 arch/mips/bmips/setup.c                             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index e58a4f6..aae0b92 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -4,7 +4,7 @@ Required properties:
 
 - compatible: "brcm,bcm3384", "brcm,bcm33843"
               "brcm,bcm3384-viper", "brcm,bcm33843-viper"
-              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
+              "brcm,bcm63268", "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
               "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
               "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"
 
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 38b5bd5..bfee6ea 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -112,10 +112,10 @@ static void bcm6368_quirks(void)
 static const struct bmips_quirk bmips_quirk_list[] = {
 	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
 	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
+	{ "brcm,bcm63268",		&bcm6368_quirks			},
 	{ "brcm,bcm6328",		&bcm6328_quirks			},
 	{ "brcm,bcm6358",		&bcm6358_quirks			},
 	{ "brcm,bcm6368",		&bcm6368_quirks			},
-	{ "brcm,bcm63168",		&bcm6368_quirks			},
 	{ },
 };
 
-- 
2.1.4
