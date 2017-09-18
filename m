Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 16:06:02 +0200 (CEST)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:33021
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993155AbdIROEaGod3Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 16:04:30 +0200
Received: by mail-pg0-x243.google.com with SMTP id i130so301480pgc.0;
        Mon, 18 Sep 2017 07:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KIenUeQjayBAgrzr2Xrbp4UGlbMmpEMOzMn6i80CTgA=;
        b=cjLUEZfqx7EFmBSxMI3+qUnFnBZEb1enX0ZlKH01MedmcekdCBdHS3UbMhOHA6Lfgq
         dgIwexpwzcBqndm5uN/uf6L8ObMUSjuDBrMnVexDcnOs4YeU/2ChsgHb122N1HkgHd/v
         oV0St28ufd3qIaFYN0wTNd/HZxTMagFKcO/LkUhfaOW+VlL5t0ybaqeqTrrkBNDWlQkK
         P3nBeEbrOfanhmvQpzUi7fXGuJfZ3GlxFmVJw9uW8dRodK8H8g3iMys9v4kKekAqg8y/
         ssjgpb0EsYyAajRhhFpntKxq8DSJZrWf9EiHhs8NkTLJmYUKNheGiej5VEIaUdRqsHZx
         9ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KIenUeQjayBAgrzr2Xrbp4UGlbMmpEMOzMn6i80CTgA=;
        b=LOWNqY2fON6WGqzM9nx1evs1zMTKVN4llT8WIDPfWaf9WBEM2+2nhgrOPQOUXmlIUr
         zp/wcY83te+aYvUZqmq0zhZU3CJtJtBWMo8P84aEBrl5cytQ2aK+f2EKFkXcgRwUmiD9
         R1GPUP1C2oti8+HprxW2x1vzfT4JpT0TCIv9WI8M9JY2YxwC0faDzqtI4qHoMJPOa0mD
         IHUPkPNwyAc8vv+4TJ2zLZWDVoqd6KsD2SZ22oe7oe2/WKXdOs5F3D3SRlTT+pLynboa
         haLQOzRLebLdSJS9nXgpwnXmpURkwBB4ScM1mNQATzAIi7pVuhqPkN95Wgj9K7jIqsyu
         790Q==
X-Gm-Message-State: AHPjjUjrs2IJPPfRcRPSTj5uLmyEnKhAhk2Q5zrvMgumU1qjWDUun86T
        EPWoTgNwVor0gw==
X-Google-Smtp-Source: ADKCNb5a13yi0NiqRRzx2WvgE80ZRYXKsBzu6yQ1iFDTPPtRlBa7M+RY7lTSCqAe7uwXpGAaKLkEOQ==
X-Received: by 10.98.65.27 with SMTP id o27mr32826800pfa.205.1505743464069;
        Mon, 18 Sep 2017 07:04:24 -0700 (PDT)
Received: from linux.local ([43.224.131.38])
        by smtp.gmail.com with ESMTPSA id q77sm14683252pfa.173.2017.09.18.07.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 07:04:23 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        ralf@linux-mips.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v3 4/4] crypto: jz4780-rng: Enable PRNG support in CI20 defconfig
Date:   Mon, 18 Sep 2017 19:32:41 +0530
Message-Id: <20170918140241.24003-5-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60060
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
No changes in v3

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
