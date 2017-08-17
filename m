Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 20:25:58 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:38456
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994887AbdHQSZwDBgo7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 20:25:52 +0200
Received: by mail-pg0-x241.google.com with SMTP id 123so11055757pga.5;
        Thu, 17 Aug 2017 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LJubvV5uWllSou/VLVhRjf5T3AX8ujo4Xf7/Vm1Lse0=;
        b=EWX46/2+BDmlMQrjJe3W1pzZstRsLDbX2fS0/TUMPQBzGXaqzklN24dyqaWGh68aT+
         cW7CkclQ4m3ajQ9Io6R/by22CUlPrAAm5yOd7Yl/3GaRTJAM3yFViAmGu2/cG3IRHFWx
         JtPebol6cMzMBVFDOZpDHoSPt393mmpjDzK5Mq52jU+iVHIw3ixuwNgEpZDzjfKs5km9
         Tk9h7DateJGtdQmUBm4EFfXOt0duKpn+PrdP53z6BzJjabG5RtsPqxEjrmCQzKXBYvHM
         09uaxcgTVG1n+wN2RCc3ZEpsLF76ELsVxtzANedfFY0206LBAWCBc7DgAkOjK29KVgbd
         6aNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LJubvV5uWllSou/VLVhRjf5T3AX8ujo4Xf7/Vm1Lse0=;
        b=fYKYXUT2vxiOc/sd7zpqmBF6Jtn4aktfNh5LiTSOCSqA5QbpR+NzKzBM38EOBdTxD+
         tbelT2mFqZamFJ8tLQZ+diXmOHSbEdO3XGH9C+l4KSCNipX4FN7QT4z4txZhw17Iu4f1
         tp8TR58ltTcUr2WewtnNqa8qIW+k8QXbQym6JmsAeV+FCOEGuzUa3W2/2z4d7mUw7zI0
         qyr+6vZ8oZK9uU6T3Ja/zcNnHMtR6LGifPeT/IR4fIi2HBNGoPv6nEMBrIb8eM3sS8dl
         LES/pnH/1zK0IqDuwpoLE2B9b2EcwwBC1/gCzU+BjTW1bVyVT6UFdT1fr24YYJteirrc
         JnVg==
X-Gm-Message-State: AHYfb5h8IbQxA77W+ymb+fWqZfiF1PZZYsuL9DCFVbtJn1fba/aI+Dw7
        pyCOSl6SDrY9CA==
X-Received: by 10.101.86.74 with SMTP id m10mr5867479pgs.79.1502994345832;
        Thu, 17 Aug 2017 11:25:45 -0700 (PDT)
Received: from linux.local ([42.109.133.212])
        by smtp.gmail.com with ESMTPSA id a86sm8882565pfe.181.2017.08.17.11.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 11:25:45 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH 0/6] crypto: Add driver for JZ4780 PRNG
Date:   Thu, 17 Aug 2017 23:55:14 +0530
Message-Id: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59628
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

The PRNG hardware block registers are a part of same hardware block
that has clock and power registers which is handled by CGU driver.
Ingenic M200 SoC contains power related registers that are present
after the PRNG registers. So instead of reducing the register range,
syscon interface is used to expose a register map that is used by both
CGU driver and this driver. Changes made to jz4740-cgu.c is only compile
tested.

PrasannaKumar Muralidharan (6):
  crypto: jz4780-rng: Add devicetree bindings for RNG in JZ4780 SoC
  crypto: jz4780-rng: Make ingenic CGU driver use syscon
  crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
  crypto: jz4780-rng: Add RNG node to jz4780.dtsi
  crypto: jz4780-rng: Add myself as mainatainer for JZ4780 PRNG driver
  crypto: jz4780-rng: Enable PRNG support in CI20 defconfig

 .../devicetree/bindings/rng/ingenic,jz4780-rng.txt |  24 +++
 MAINTAINERS                                        |   5 +
 arch/mips/boot/dts/ingenic/jz4740.dtsi             |  14 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |  18 ++-
 arch/mips/configs/ci20_defconfig                   |   5 +
 drivers/clk/ingenic/cgu.c                          |  46 +++---
 drivers/clk/ingenic/cgu.h                          |   9 +-
 drivers/clk/ingenic/jz4740-cgu.c                   |  30 ++--
 drivers/clk/ingenic/jz4780-cgu.c                   |  10 +-
 drivers/crypto/Kconfig                             |  19 +++
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/jz4780-rng.c                        | 173 +++++++++++++++++++++
 12 files changed, 304 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
 create mode 100644 drivers/crypto/jz4780-rng.c

-- 
2.10.0
