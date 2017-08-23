Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 04:59:17 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:34934
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdHWC6DUEGts (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 04:58:03 +0200
Received: by mail-pg0-x244.google.com with SMTP id m133so462266pga.2;
        Tue, 22 Aug 2017 19:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7u9+dRxvsQONkUPhdnrGQyiXziyb1EZd5TCVnDTOVQA=;
        b=aBpuOZzDiaPPfFyopbidlpIMP0LSV/FHJFm6yRibGFJB7fPagucpz2KBs/9TLYZ/0r
         bieArssIBafEBOte2x8sy0vH+58TvWN1l8Ed/RLPNcDHIhK8pYlRjknyjcy0ILv2rhrS
         WFz7vfZuFhQu/he3MggrF6A+SrGwH+vA6P+rl6kHYnrfqQMf87NonRjIeTtAvvW5nnkw
         9fUhAAWh1YG/amSoW3Boekkjzi6GnLmTCn9y4iX0pVPQRCnBMblyTXeIdvRFAQcZA8MK
         Sr1wA2kMvbH6NzDR/nCB2Lt+ihR0b5jYIWw8qPZuBnjRwJniVrMKBRHcTbKQxT/IUTxd
         Fg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7u9+dRxvsQONkUPhdnrGQyiXziyb1EZd5TCVnDTOVQA=;
        b=PDjJ+G6cIMrACXVvz3nftGjq6vbF20E6t7Gq4kKCIvl1SyPX2t3eztIH6BmM//V2i7
         97SyPaMGgdmq8GmHWkWkxRVrRGpFrH62Zjhi49A5nUXcgTu9P7Kr/Mveqjb3YviaYyJY
         CkChISEkTJA8m77T8k1+OvbFXoacu0xOop0jZZcAIQOXgvxKHXXsZb61PSFpMjftK/pL
         dvAIZH5sGxjj+rsRTIdfbTqGeqZdvA8mrrG41sbkfKI8tperpFsmEdkI1P5d6S0wF4+H
         a97qAj417NAtHpjXFduXgq+Eyl6OK3hrzO4Q5Bwhw3V45by+5YdrQJokbT7MQQJfUDqb
         3zNQ==
X-Gm-Message-State: AHYfb5gun944d8TFszqJn8gLOkXLLQf89lMuIEZWEuj5s3gli36n5wY1
        03fALwuM2243zoKduI5EXA==
X-Received: by 10.84.218.139 with SMTP id r11mr1331378pli.25.1503457077635;
        Tue, 22 Aug 2017 19:57:57 -0700 (PDT)
Received: from linux.local ([42.109.139.20])
        by smtp.gmail.com with ESMTPSA id 10sm489771pfs.131.2017.08.22.19.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 19:57:57 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        paul@crapouillou.net, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v2 4/4] crypto: jz4780-rng: Enable PRNG support in CI20 defconfig
Date:   Wed, 23 Aug 2017 08:27:07 +0530
Message-Id: <20170823025707.27888-5-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
References: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59768
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
No changes in v2

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
