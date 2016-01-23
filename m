Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:17:49 +0100 (CET)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36578 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009333AbcAWURsKFc3d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:17:48 +0100
Received: by mail-lb0-f174.google.com with SMTP id oh2so56903455lbb.3
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+EvasEPHx8T2Y5ynSvR3RYegbEqP0S47FLyDikPHwyA=;
        b=grLk7owmMeJrERcgOkjqFF97I8/2ru2htp7gdAAYnxMH45vGbYEaN9FWfKu5xKkurV
         dptp7KGMSGkz5zOYX8d6v2Sg1GUHUv4vYHDD0dX+QchjyyyuKWfZ6bv9wSJUmxkfgCSE
         S2x6gBK3a8c6iWTEsLs0wphmqR5imbxQRnvVJQK9mVTC2i2IhronU1pLOt685hB0dAHY
         aKAbiCjr4xfnkPlD0NTFmlslU7yPRLgqTzMD+OmwcIS7S+Pxi5D6YceU7hXFamtReBa5
         6sUotxAgb8WrJJC50CKTihlsz9yfjgTFqbiJsyFVfpn+5d8yM7BltFZyqkB/Yy0CO/gH
         p5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+EvasEPHx8T2Y5ynSvR3RYegbEqP0S47FLyDikPHwyA=;
        b=bl/6aN3LSuLoieKWLzmmr1E6X8UhzvKYYUk9YFl9F/4slvvVyBgHkxRjvXTOCCxz/p
         1pzaLTiiIq/P7vQXXhuhYfsUVIuD3VEEtXLUEciaguHaHN5U4vfySD1S+Q49loKCO/DR
         gzw047r8yvlhmPULjGUcSaZbaMSs/L6cKKKoVxfPd14nKRL/YDnXupukYtsDWrDnFysO
         AZhdbLF9hkwNOEXP2kbXOBVwuFDTwerdF57i1S96TeBiluJClr1x6z8k6GMX4xjxbVvI
         u1/xMUeR5yJO6qp3D/AIUoAGOVTfaxB4FoDKpMY9waWxUf9lUzwsKZPjdAQlPy8Qr0KC
         yLVQ==
X-Gm-Message-State: AG10YORjMKHexkY7bvtn7cx0ZJWLzCQX9S+8l73Ee13i+HQXlFb4idjVAgHdVmmcAlsmtg==
X-Received: by 10.112.140.41 with SMTP id rd9mr3647143lbb.138.1453580262629;
        Sat, 23 Jan 2016 12:17:42 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:41 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC v3 00/14] MIPS: AR913X/AR933X devicetree patchseries
Date:   Sat, 23 Jan 2016 23:17:17 +0300
Message-Id: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Changes since RFC v2:

  * add Onion Omega board support;
  * add AR9132 SoC clock driver;
  * add AR9132 devicetree fixes.

Changes since RFC v1:

  * add Dragino MS14 board support;
  * add "ref" oscillator input clock for pll-controller;
    add necessary nodes to board dts files.

Antony Pavlov (14):
  WIP: clk: add Atheros AR724X/AR913X/AR933X SoCs clock driver
  MIPS: ath79: use clk-ath79.c driver for AR913X/AR933X
  MIPS: dts: qca: ar9132: use dt-bindings/clock/ath79-clk.h macros
  MIPS: dts: qca: ar9132: make extosc-related description shorter
  MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop unused alias node
  MIPS: dts: qca: ar9132: use short references for uart and spi nodes
  MIPS: dts: qca: simplify Makefile
  MIPS: dts: qca: introduce AR9331 devicetree
  MIPS: ath79: add initial support for TP-LINK MR3020
  devicetree: add Dragino vendor id
  MIPS: ath79: add initial support for Dragino MS14 (Dragino 2)
  devicetree: add Onion Corporation vendor id
  MIPS: ath79: add initial support for Onion Omega
  WIP: MIPS: ath79: add devicetree defconfigs

 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/mips/ath79/Kconfig                            |  15 ++
 arch/mips/ath79/clock.c                            |  11 +-
 arch/mips/boot/dts/qca/Makefile                    |   8 +-
 arch/mips/boot/dts/qca/ar9132.dtsi                 |  21 ++-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts   |  88 ++++------
 arch/mips/boot/dts/qca/ar9331.dtsi                 | 123 +++++++++++++
 arch/mips/boot/dts/qca/dragino_ms14.dts            |  73 ++++++++
 arch/mips/boot/dts/qca/omega.dts                   |  54 ++++++
 arch/mips/boot/dts/qca/tl_mr3020.dts               |  72 ++++++++
 arch/mips/configs/dragino-ms14-dt-raw_defconfig    |  85 +++++++++
 arch/mips/configs/onion-omega-dt-raw_defconfig     |  85 +++++++++
 arch/mips/configs/tl-mr3020-dt-raw_defconfig       |  85 +++++++++
 arch/mips/configs/tl-wr1043nd_defconfig            |  87 ++++++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-ath79.c                            | 193 +++++++++++++++++++++
 include/dt-bindings/clock/ath79-clk.h              |  22 +++
 17 files changed, 963 insertions(+), 62 deletions(-)
 create mode 100644 arch/mips/boot/dts/qca/ar9331.dtsi
 create mode 100644 arch/mips/boot/dts/qca/dragino_ms14.dts
 create mode 100644 arch/mips/boot/dts/qca/omega.dts
 create mode 100644 arch/mips/boot/dts/qca/tl_mr3020.dts
 create mode 100644 arch/mips/configs/dragino-ms14-dt-raw_defconfig
 create mode 100644 arch/mips/configs/onion-omega-dt-raw_defconfig
 create mode 100644 arch/mips/configs/tl-mr3020-dt-raw_defconfig
 create mode 100644 arch/mips/configs/tl-wr1043nd_defconfig
 create mode 100644 drivers/clk/clk-ath79.c
 create mode 100644 include/dt-bindings/clock/ath79-clk.h

-- 
2.6.2
