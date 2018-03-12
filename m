Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 22:59:20 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:34963
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990404AbeCLV7OQigqf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:14 +0100
Received: by mail-qk0-x242.google.com with SMTP id s188so13252350qkb.2
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=GEyNJxoGfytoZ3KrH3FLjR8PZRgK0FViL2kTQWFCuFI=;
        b=nCFCHi0BIzjfQGPz47lJWFNu59B34xdeOXtHl+cunkGWeXikR1IQhfV9M4r0g+Kaz3
         J9EwjZkKrilrebmI2KmF3OxnO409pld7jo9XqE7RarR+Vm1AaOG0yjLym2Ktr0gundoC
         3sqsVdbDB0e1NR0Pi3dSx0Ppd4ln2mxZusmxV6Qw5gkGrnpqBeVxyD84gBg7fw8z643U
         y+w6ScmI5HnR8NFf/nOAGLPDMHBVdtck0DzmsuQC9XS2Z6AyD/Cy2eKBX8mcmnF+vykq
         /yjGDhCrzmvHpLAO/qIQmH0RkfmJHcri0wGRKD/FlxLA7P+3M6xMz8vCxJrnDPHLvToh
         y13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GEyNJxoGfytoZ3KrH3FLjR8PZRgK0FViL2kTQWFCuFI=;
        b=Auc0YwtYtDx1BSfoa75dJA5bCVNE0WMGg5tIPXy1khLfUZl072wQ1x6TzEx8DAA4rH
         UEf2/cwX2FnnBZEyK3/umvilh5n0diX1r/55AYMwzgDGLtEQI5f9xj9pG492Na/XuQZl
         vjdAKGovz1K5p6YjdMyg63+SEP0IJcO1tIj1Nka9Ax/XSfZ2LylglT4O4S+6UkK0F8FL
         DwuINz4J+okwBiRuquaS5cisWGTUxE/vFUeWS9OQbfj+MxuV/xfYZPat7hthHQF4mBRi
         jIAcsSXNU6rvQlbeH/MHd5B+MYriGaGmF5SQJDio9r/zsOpjT5szfn5Qyi8xvQx9ydPF
         V5qA==
X-Gm-Message-State: AElRT7EfYRCbCRV48FagxBQ15ieJWg2FLioO8zGX+ccii6BzCEV4BcGN
        fjMGwl2rKqkbWSwXiThfdi/Siw==
X-Google-Smtp-Source: AG47ELvDIFkrUcyB2gG2pHIukJt849caFtSS48CKbPiKOrswct+HtdmK6R96hzJJfT8Uc7BjVwbdbw==
X-Received: by 10.55.90.198 with SMTP id o189mr248698qkb.295.1520891948008;
        Mon, 12 Mar 2018 14:59:08 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:07 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 00/14] Enable SD/MMC on JZ4780 SoCs
Date:   Mon, 12 Mar 2018 18:55:40 -0300
Message-Id: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62931
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

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

This patchset adds support for SD/MMC on JZ4780 based
platforms, such as the MIPS Creator CI20 board.

Most of the work has been done by Alex, Paul and Zubair,
while I've only prepared the upstream submission, cleaned
some patches, and written some commit logs where needed.

All praises should go to them, all rants to me.

The series is based on v4.16-rc4.

Changes from v1:
  * Reordered patches, fixes first, for easier backporting.
  * Added Link and Fixes tags to patch "Fix race condition",
    for easier backporting.
  * Enabled the DMA in the dtsi for jz4780, dropped it from the ci20 dts.
  * Reworded config and help user visible text.
  * Reworded commit logs, using imperative.
  * Re-authored my patches, as Collabora is partially
    sponsoring them.

Alex Smith (3):
  mmc: jz4740: Fix race condition in IRQ mask update
  mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
  mmc: jz4740: Add support for the JZ4780

Ezequiel Garcia (9):
  mmc: jz4780: Order headers alphabetically
  mmc: jz4740: Use dev_get_platdata
  mmc: jz4740: Introduce devicetree probe
  mmc: dt-bindings: add MMC support to JZ4740 SoC
  mmc: jz4740: Use dma_request_chan()
  MIPS: dts: jz4780: Add DMA controller node to the devicetree
  MIPS: dts: jz4780: Add MMC controller node to the devicetree
  MIPS: dts: ci20: Enable MMC in the devicetree
  MIPS: configs: ci20: Enable DMA and MMC support

Paul Cercueil (1):
  mmc: jz4740: Fix error exit path in driver's probe

Zubair Lutfullah Kakakhel (1):
  mmc: jz4740: Reset the device requesting the interrupt

 Documentation/devicetree/bindings/mmc/jz4740.txt |  38 ++++
 arch/mips/boot/dts/ingenic/ci20.dts              |  34 ++++
 arch/mips/boot/dts/ingenic/jz4780.dtsi           |  52 +++++
 arch/mips/configs/ci20_defconfig                 |   3 +
 drivers/mmc/host/Kconfig                         |   9 +-
 drivers/mmc/host/jz4740_mmc.c                    | 230 ++++++++++++++++-------
 include/dt-bindings/dma/jz4780-dma.h             |  49 +++++
 7 files changed, 345 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/jz4740.txt
 create mode 100644 include/dt-bindings/dma/jz4780-dma.h

-- 
2.16.2
