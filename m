Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 04:57:43 +0200 (CEST)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:34908
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdHWC5gn9vKs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 04:57:36 +0200
Received: by mail-pg0-x243.google.com with SMTP id m133so461547pga.2;
        Tue, 22 Aug 2017 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h5mTxLiBFYE0bF05U8Mwrv3ydBDfFGkMMI8nBETkZuo=;
        b=YL5uGkt3UYY4JDPTNFudU2AONjnjSxyjwvAjQYVlgCWlcOkxyrMQRaHxhPxZLzdrmK
         VtyMyPtG1Ww/+lcNo7a2yubU05Ahg0M45WyVLytPOwRkGZKrUSc/RCv0E6S3xuwQISKG
         5iMKBsdQYOIdtEQfdJSQ77NRIiSgzkRq0emNrcg/1vNNeITSz7Krv99H5PmTnmcpdPdC
         dFsO+v1LLXR3heYx0IXLi46atPj8L8I6UfsxwzhKcQgrU2rGfxFapme++ZzExv+NYK3y
         wDEVBWKWQaLd4ZX+n3QUpii8XMn3K5POepKXlSh0BIFrZLhPAKTN2rkKudymmhn+jPFd
         KFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h5mTxLiBFYE0bF05U8Mwrv3ydBDfFGkMMI8nBETkZuo=;
        b=fAUb7Ig1gZXnRWroGyP1/+uV3Oc57Um09heN5ZhB4AONmZDWDzSt+XH+6GWFw+jvsF
         0YlDie+DQ3t2b0fAVnIlFBdcCrZ9hH7fyoQVHhl7aKI2cJEqTXiqI0YTQylafal6Jr1D
         fJWRCPhc5MggHhaGrV/EyM+VFMAO8tWAh8YbKhCZJuP4YoyTmjZfV63wusciVLkZXwuB
         I1uRBDMHEN7aMSQsrvikRp6qAJlcq8jhpIqpH7k1Col2chzWHN2ZNX233WoPbDjLF5CX
         QwclnECt4P8FvB9NVjmLrLYzMDLuvKmifbjcz6JDjAAHKo2mjCbt7ee24EpM24/mPhNo
         zMUw==
X-Gm-Message-State: AHYfb5ieHnKayW++yYS6LUsdnRrAs8aKt2Vzn32wFY2PY7Qf2H6cRjSb
        CLEtilBd5kJreA==
X-Received: by 10.84.132.73 with SMTP id 67mr1308249ple.53.1503457050557;
        Tue, 22 Aug 2017 19:57:30 -0700 (PDT)
Received: from linux.local ([42.109.139.20])
        by smtp.gmail.com with ESMTPSA id 10sm489771pfs.131.2017.08.22.19.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 19:57:29 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        paul@crapouillou.net, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v2 0/4] crypto: Add driver for JZ4780 PRNG
Date:   Wed, 23 Aug 2017 08:27:03 +0530
Message-Id: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59764
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

This patch series adds support of pseudo random number generator found
in Ingenic's JZ4780 and X1000 SoC.

Based on Paul's review comments, add 'syscon' compatible in CGU node in
jz4780.dtsi. jz4780-rng driver uses regmap exposed via syscon interface
to access the RNG registers. CGU driver is not modified in this patch
set as registers used by CGU driver and this driver are different.

PrasannaKumar Muralidharan (4):
  crypto: jz4780-rng: Add JZ4780 PRNG devicetree binding documentation
  crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
  crypto: jz4780-rng: Add RNG node to jz4780.dtsi
  crypto: jz4780-rng: Enable PRNG support in CI20 defconfig

 .../bindings/crypto/ingenic,jz4780-rng.txt         |  20 +++
 MAINTAINERS                                        |   5 +
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |   6 +-
 arch/mips/configs/ci20_defconfig                   |   5 +
 drivers/crypto/Kconfig                             |  19 +++
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/jz4780-rng.c                        | 168 +++++++++++++++++++++
 7 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
 create mode 100644 drivers/crypto/jz4780-rng.c

-- 
2.10.0
