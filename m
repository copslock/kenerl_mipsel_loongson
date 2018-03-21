Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:32:45 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:33964
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994032AbeCUT2mrbuEZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:28:42 +0100
Received: by mail-qt0-x242.google.com with SMTP id l25so6502972qtj.1
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Pg17qXyloENPmgjD7pnIvtfo1P7Zu48l7jG1AOteFh4=;
        b=ihvxDwFmAACW9xUv4pgfec+pFD1oFgi/uJw4OdTapqAyFJwz6VX1zDmaDMz4QKjHux
         3JBP33uIXn7qQDLF+KvZZFvJ6cbagq1GS9nsAm360QSrKXC6zm4r9LZn6UAyjSm+isDH
         Xi3KFoZ5AW2f8LVSo89huJLvum5c87enA7Kc7TdlpeabiArnEcOrdU1PeaeObAtSm+ES
         26ieW8+KSpYuLzStjDDqbJzqClOm8kiBsEHtoPdj/Ot1S8F+p3Qar3oFvJ7+E7oUzKVg
         DQq9m5Op3fIiOuDbYnQBTeW6ALKqlPeKktcl2N4Tc2ZgpGvFYUmkJHwbnV0NNwjkGjH8
         IlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pg17qXyloENPmgjD7pnIvtfo1P7Zu48l7jG1AOteFh4=;
        b=rD3vVF8UDjEVri22Bep0b3WkGg6+x4GlDlRAUlypOSu2qxsfP5773vEt6BFA5eaM9y
         copAxD+tQR7qxVHRFIaPIAxM4tdzT0pF5svRR7UeZWqS/Rymn9t5A/rqMToqYRD1JwJh
         5tUrcgoq9vqYpcnnBLXcFm/VhLAHt9sxcWBsmZ+NOnMHItjeDU4Jmy6MnaJPsyOXY+pM
         PAlhOAbitrprA2+PiEa9ilArMsQA4cqGv8vfavaFZtiWATe0GEaWrHJ5F/6x/wLc8vG7
         BvDfIvmHbxPZd45x8oIXXW2TcX5JWke6vKwxm6BOdwW8ZziWuGXi4Bm7GN66uMcsgO+r
         ZFbw==
X-Gm-Message-State: AElRT7FDcj0od8v8m/7ZViabakB2U3K+Xfl8zLvgIY9h2SGWPDulx/6U
        JgWanXw84HqKMVshQ/TppalWIg==
X-Google-Smtp-Source: AIpwx48hfGqP18/uL/ae3WSka8DAu2OFibTUJfNnvLdfwiFebWUJTG/TQDQrLjxh1Yb8r9nUBKkMfQ==
X-Received: by 10.237.50.100 with SMTP id y91mr3631207qtd.146.1521660516559;
        Wed, 21 Mar 2018 12:28:36 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:28:35 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v3 00/14] Enable SD/MMC on JZ4780 SoCs
Date:   Wed, 21 Mar 2018 16:27:27 -0300
Message-Id: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63123
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

Changes from v2:
  * Fix commit log in "mmc: dt-bindings: add MMC support to JZ4740 SoC"

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
