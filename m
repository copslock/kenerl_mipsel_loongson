Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 20:28:20 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:37544
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994888AbdHQS0kJow27 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 20:26:40 +0200
Received: by mail-pg0-x244.google.com with SMTP id 83so11084085pgb.4;
        Thu, 17 Aug 2017 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KelOezPq9zl5b0z1tNld+E9BoNQ2UA5soznkU6um/Yc=;
        b=LrrerwwzUeVPNljzF1yO3kvTtzLkezGlMn4AEmIlRJon2n8JnIQVU57UOvUZK8k44L
         MsU4tWvuy0hBu3HngucCjw3+C5O1x0rfXvnMgA9RaKYbqRb6n7EZcMkLaU38mbcChNvd
         L6wN79a2kVru4LgC/EsgfZwswjHraKu/VlWa5j/sfAPGLk7TfZCTIcfVzHt6CovaOTbO
         InPTW0lgDkuZ82Fn/kar/PdM3Bbah4A/JntQLSYEvHWo+VIwesGr9sMeXnZ2vJej5wNP
         bf9vp/d1oHfO4G9iClNtD1XaWWaKAvojKTy21lFi/vDtAAZa83ORevnX+PYwQ+ewgTrM
         fRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KelOezPq9zl5b0z1tNld+E9BoNQ2UA5soznkU6um/Yc=;
        b=P1Ti6OR3REPsMwXu8Xs295gVjn4ETecbYLynexVVG7WJsChepkM8cGwVKyiqqhsoJL
         ahuxFaumx7Usc/Urv4DBYcMArnrQ3vAxRDgxYWrGQM2xL2dOMzzBjl55m3ma5lBa17xQ
         doV/ttWXQVEhFI0Dk9+YpE/a8onaAWII2x/p1nAPlkvga09L5Z1TuIgR5cIM8Wt/iA3x
         ZoaAZD4b4Qu46sxeblbIZDm5Yfhk2IeW98+/auzZCJLj00b8m1rAC1tz776/d/JWytPz
         MERocu6M9zFRCQbQQfI4VstmUk8oj2uBkBeGMFESVIv3VfHegPIgFtckHs0299e6IdPL
         pxjw==
X-Gm-Message-State: AHYfb5ghYOm6PlBFgvEWufKjd7i9eOmo/E5T0ckTLH1C0cITikJRmp+L
        f1bQ+FHlJo4Dyg==
X-Received: by 10.101.73.72 with SMTP id q8mr5911115pgs.219.1502994394481;
        Thu, 17 Aug 2017 11:26:34 -0700 (PDT)
Received: from linux.local ([42.109.133.212])
        by smtp.gmail.com with ESMTPSA id a86sm8882565pfe.181.2017.08.17.11.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 11:26:34 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH 6/6] crypto: jz4780-rng: Enable PRNG support in CI20 defconfig
Date:   Thu, 17 Aug 2017 23:55:20 +0530
Message-Id: <20170817182520.20102-7-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
References: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Enable PRNG driver support in MIPS Creator CI20 default config.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/mips/configs/ci20_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index b42cfa7..9f48f2c 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -88,6 +88,11 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=5
 CONFIG_SERIAL_8250_INGENIC=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_CRYPTO_USER=y
+CONFIG_CRYPTO_USER_API=y
+CONFIG_CRYPTO_USER_API_RNG=y
+CONFIG_CRYPTO_HW=y
+CONFIG_CRYPTO_DEV_JZ4780_RNG=y
 CONFIG_I2C=y
 CONFIG_I2C_JZ4780=y
 CONFIG_GPIO_SYSFS=y
-- 
2.10.0
