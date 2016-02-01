Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:10:55 +0100 (CET)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35786 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007295AbcBAAKyLSbBA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:10:54 +0100
Received: by mail-lb0-f178.google.com with SMTP id bc4so65956187lbc.2
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pR45YTr/0/ZYjfncZvuoiumaC3ZfWJc3nydDbznepMw=;
        b=vdRL5Bf8vlB2OkxWjnqIZUsAOilk0rqXlQ3G6CK0bpVvj7IwqJj+FGBgNdR6zPVx7/
         PVet2mDM0ERLl3o4NdgeLddbParxPk4Avdl5fI+X1fjlo33X4zRvkQTYzkRAcofL5JZp
         A5KDj6qyXpscP0HQ4e6Ri83R7fKjMIMaTl/gD4mWd2W08gZoSb39/wyuvyxJ4NXG4S95
         xBGEY0ovHGhCjm99Ulfz4URe7WX1mJAzVl7cjhq6EMZxPWvTMy2SF624uXnCAzzidlVr
         m7OPtWuQg9q1KviOdf9xrom+Mk3Z3tMMFdZ3yjLwuSJPj+85eKACAsilaG3FDQvGsPfg
         CGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pR45YTr/0/ZYjfncZvuoiumaC3ZfWJc3nydDbznepMw=;
        b=IpZLrl+IZFcquDAqiAeoGIPS/vMopp9TRhJUYi7HQ8gzfR8G0WMjNkc7UcXD0yTPAo
         1oRxeIa2QQ3k0Mp8Tb0CuCQg24KlkAnEmN4t6/gRc7QMwlOUm7mWYHOpGac0BUB5L6TP
         wNFwCAPTgF/gbDqs+Je9R+/ZWLTd+dkv+PChUGLnJnsJGbPssxzCaD/ZFFq1HgcqgP0d
         /9tsntT1SKfaXE6dsECSuPsFPqVWy2QkQ4ay6F+EwI86KrP0lhKZ7/k99w9aFcUKZdP2
         myJEEklsiMLVEZXD2trmZe6pvA4Fi5Eop+cGQOVHbaCUSHkTAvcPwSCX0SjaF96oqMRn
         rqiA==
X-Gm-Message-State: AG10YOQdLeDqj7U/0tbPx7soJe/ZyueRM4QxljAU8hSv/1yGEwnzSDGz+SnlIc6UOncXwg==
X-Received: by 10.112.148.33 with SMTP id tp1mr7559662lbb.52.1454285448842;
        Sun, 31 Jan 2016 16:10:48 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:48 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC v4 00/15] MIPS: AR913X/AR933X devicetree patchseries
Date:   Mon,  1 Feb 2016 03:10:25 +0300
Message-Id: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51561
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

To use USB support on AR9331 please apply additional Alban Bedel's patches:

  * https://patchwork.linux-mips.org/patch/11497/
  * https://patchwork.linux-mips.org/patch/11495/

Changes since RFC v3:

  * clk: get pll registers base address from devicetree node
  * MIPS: dts: qca: ar9132: use short references for usb too
  * MIPS: dts: qca: ar9331: add usb support
  * MIPS: ath79: Dragino MS14: enable usb support

TODO:

  * usb does not work on MR3020: the board just reboots after USB host
    initialization; AFAIR we have to use GPIO 8 for USB power activation
    (see https://dev.openwrt.org/browser/trunk/target/linux/ar71xx/files/arch/mips/ath79/mach-tl-mr3020.c?rev=32454);
  * test usb on Onion Omega;
  * clk: clk-ath79.c: take into account [1] and [2]
    [1] https://www.linux-mips.org/archives/linux-mips/2016-01/msg00555.html
    [2] https://www.linux-mips.org/archives/linux-mips/2016-01/msg00736.html
  * ar9132_tl_wr1043nd_v1.dts -> tl_wr1043nd_v1.dts
  * can we use appended DTB? see https://www.linux-mips.org/archives/linux-mips/2016-01/msg00577.html


Changes since RFC v2:

  * add Onion Omega board support;
  * add AR9132 SoC clock driver;
  * add AR9132 devicetree fixes.

Changes since RFC v1:

  * add Dragino MS14 board support;
  * add "ref" oscillator input clock for pll-controller;
    add necessary nodes to board dts files.

Antony Pavlov (15):
  WIP: clk: add Atheros AR724X/AR913X/AR933X SoCs clock driver
  MIPS: ath79: use clk-ath79.c driver for AR913X/AR933X
  WIP: MIPS: ath79: setup.c: disable platform code for OF boards
  MIPS: dts: qca: ar9132: use dt-bindings/clock/ath79-clk.h macros
  MIPS: dts: qca: ar9132: make extosc-related description shorter
  MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop unused alias node
  MIPS: dts: qca: ar9132: use short references for uart, usb and spi nodes
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
 arch/mips/ath79/clock.c                            |   7 +-
 arch/mips/ath79/setup.c                            |  17 +-
 arch/mips/boot/dts/qca/Makefile                    |   8 +-
 arch/mips/boot/dts/qca/ar9132.dtsi                 |  23 ++-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts   | 104 +++++-----
 arch/mips/boot/dts/qca/ar9331.dtsi                 | 158 +++++++++++++++
 arch/mips/boot/dts/qca/dragino_ms14.dts            |  80 ++++++++
 arch/mips/boot/dts/qca/omega.dts                   |  54 ++++++
 arch/mips/boot/dts/qca/tl_mr3020.dts               |  72 +++++++
 arch/mips/configs/dragino-ms14-dt-raw_defconfig    |  93 +++++++++
 arch/mips/configs/onion-omega-dt-raw_defconfig     |  85 ++++++++
 arch/mips/configs/tl-mr3020-dt-raw_defconfig       |  85 ++++++++
 arch/mips/configs/tl-wr1043nd_defconfig            |  95 +++++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-ath79.c                            | 214 +++++++++++++++++++++
 include/dt-bindings/clock/ath79-clk.h              |  22 +++
 18 files changed, 1055 insertions(+), 80 deletions(-)
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
2.7.0
