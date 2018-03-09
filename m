Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:13:20 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:43793
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994806AbeCIPNNpxqzw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:13 +0100
Received: by mail-qt0-x241.google.com with SMTP id d26so11014430qtk.10
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=qbyaUv0GlLGLpF+UWUgp06WkZ+87ylqpim1RJ2nWSho=;
        b=FWRgWqLLSnxCsjJaWa/PBvxNy6MaXSdCvrIOISvkI42lk5n4c+00k/u3iyT6NvQ5Nq
         S0gJBGy+jeihFdN5eKFLRFUoT7gd3htESvcHy6TjSv7o8wTMI+jjMCTpWQjZgk4Irn2h
         WQo+T/XepPC5D6c7/e6BHiT2fKqgEHw+A8EzYp4Tiad/E81nNGy29l4gH5PYcIQvz/ei
         RktTZG96F8bG19JbXYZliKX8HMUJJokEjq0ECXPhnz0o+X26YslaUlF6B24MNR/RWNJI
         pv0KqnKToB4pT/d5Gc1JByuHzLq3+yzl/Y9Xn+w6NhGIYUF9r8TVHoXjtH3P+Icx/twN
         +mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qbyaUv0GlLGLpF+UWUgp06WkZ+87ylqpim1RJ2nWSho=;
        b=UyJecaKoGSrXoZ8CrMlXJOFFCPcOZ479sgtATlADdXAAs939pLRwU+r24dZQQFNDyd
         cw4yfpH8JOr5BdKZDliLs79d66yiz542kR/Wc3f/TV8nK15jd59kKvkVl/hJzRzlF33a
         1KtWxnkLRVgcu3dP9h8+hUMfkgpcg9eyy0RCHKN74ZkthF7RuezF0Jjup/j5GwQK6xOc
         AzvyoxuWmCHBaL2Pba+NhySNtQW4lvPsrXiayxOtjqpg1OKRtGqxXbxOVcR3UOvrcnTV
         DyDsFP2d29NmgC4IvKVlXyCfpCr6OQZ7OzHFjqX3mL67NZsa65mQDysYzUn2ioajNGWh
         W7JA==
X-Gm-Message-State: AElRT7FisDdw+R3+e59WT6ed9eKp2Dq4dtgqTO0D9pKKm8o/lE3VL66d
        ecyjZE5SYmirTjUYviKFi+Awdw==
X-Google-Smtp-Source: AG47ELtnAKh3KCPjEzRAwLiiaEF6kYc8EMPkg4z3osxAdhilKmyM27psVMd/CsjMsfbBZeMzejqkAg==
X-Received: by 10.200.7.11 with SMTP id g11mr14019770qth.264.1520608387587;
        Fri, 09 Mar 2018 07:13:07 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:06 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 00/14] Enable SD/MMC on JZ4780 SoCs
Date:   Fri,  9 Mar 2018 12:12:05 -0300
Message-Id: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

This patchset adds support for SD/MMC on JZ4780 based
platforms, such as the MIPS Creator CI20 board.

Most of the work has been done by Alex, Paul and Zubair,
while I've only prepared the upstream submission, cleaned
some patches, and written some commit logs where needed.

All praises should go to them, all rants to me.

The series is based on v4.16-rc4.

Alex Smith (3):
  mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
  mmc: jz4740: Add support for the JZ4780
  mmc: jz4740: Fix race condition in IRQ mask update

Ezequiel Garcia (9):
  mmc: jz4780: Order headers alphabetically
  mmc: jz4740: Use dev_get_platdata
  mmc: jz4740: Introduce devicetree probe
  mmc: dt-bindings: add MMC support to JZ4740 SoC
  mmc: jz4740: Use dma_request_chan()
  MIPS: dts: jz4780: Add DMA controller node to the devicetree
  MIPS: dts: jz4780: Add MMC controller node to the devicetree
  MIPS: dts: ci20: Enable DMA and MMC in the devicetree
  MIPS: configs: ci20: Enable DMA and MMC support

Paul Cercueil (1):
  mmc: jz4740: Fix error exit path in driver's probe

Zubair Lutfullah Kakakhel (1):
  mmc: jz4740: Reset the device requesting the interrupt

 Documentation/devicetree/bindings/mmc/jz4740.txt |  38 ++++
 arch/mips/boot/dts/ingenic/ci20.dts              |  38 ++++
 arch/mips/boot/dts/ingenic/jz4780.dtsi           |  54 ++++++
 arch/mips/configs/ci20_defconfig                 |   3 +
 drivers/mmc/host/Kconfig                         |   2 +-
 drivers/mmc/host/jz4740_mmc.c                    | 232 ++++++++++++++++-------
 include/dt-bindings/dma/jz4780-dma.h             |  49 +++++
 7 files changed, 349 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/jz4740.txt
 create mode 100644 include/dt-bindings/dma/jz4780-dma.h

-- 
2.16.2
