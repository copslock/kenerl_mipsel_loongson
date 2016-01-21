Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 23:34:42 +0100 (CET)
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34495 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010087AbcAUWelcaYTN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 23:34:41 +0100
Received: by mail-lf0-f49.google.com with SMTP id 17so36141173lfz.1
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 14:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HimEDrUguaBGiUHQ1HIYXtYsFhnABpBIerYL5xzzRT8=;
        b=BfXE78ndXA6CY0kNHlZySsI6A/3hkvu3AiNCa+2hw3KSTkbd7qVFDwPAVE6NEntPHe
         p5Kliu89tt+GSdm+E1m5kKqPwu2CuaXC4kN8A+avu6tiXlmLqyljGVK3f0R1B48TnSdW
         I+wpF9GxycrwYdrI6HByB84tN+tNyRIxDgvXVD441lI8ZY+fgHRGjA4wz64Jgkdp2txO
         Z/38Z1+noOMQFKIqsBrs+GWqU4DWEJ8cA3H6m3QqizQcSBxC/J9u3HOHrfwYug03LUwG
         Euskp0msI3L+2aUY0wi6eg0Y3J8nuW+ogS0iLl4t9idXz1AFrNorDfQcMVgTF4cFweUF
         Vf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HimEDrUguaBGiUHQ1HIYXtYsFhnABpBIerYL5xzzRT8=;
        b=ZuvzZgyodE+1+l+z6x3WUQEteJ/2IUxWzpbk9gn1TOg91ekE3XURupDQR9P++JimTq
         u+bVX9iRemnUarQ/3t7E9AyZ1TYeMPIAd0A6msU6n2xPUE3y6QozqsTGo1hlbsfnNZSJ
         bNI8x2J3PaqzCCChVC6StM4G+j+btjd+nCg0oFSYXgZhDm5Wy4rh+9nL+lbAKgWPdgQE
         dvULRr2vZdydWX36dtbSsGTLQVif11ZKDveI92Fcecqa2rblNjb9YcgoftmOZ0WOiPVQ
         x4OqUcfyyI8/+GFhrfIvDjmwt2MQ8ba+aXiOpTnl9676xckxKkbs6sF4npWYyACyGbmT
         YmUA==
X-Gm-Message-State: ALoCoQmeX6KDHuq10dc3hO8GwtZnohVuEZW2Dic9LA7m+f7lASP9knKf4HrRDHJdj4bJdzAKcejHlNNRrNnvxgf3LgEog8Kp1Q==
X-Received: by 10.25.149.146 with SMTP id x140mr16186016lfd.64.1453415675932;
        Thu, 21 Jan 2016 14:34:35 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id j130sm319217lfe.23.2016.01.21.14.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 14:34:35 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC v2 0/7] MIPS: ath79: introduce AR9331 devicetree support
Date:   Fri, 22 Jan 2016 01:34:17 +0300
Message-Id: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51283
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

Changes since RFC v1:

  * add Dragino MS14 board support;
  * add "ref" oscillator input clock for pll-controller;
    add necessary nodes to board dts files.

TODO:

  * add Onion Omega board support;
  * add AR9132 SoC clock driver;
  * fixup Kconfig & Makefile changes.


Antony Pavlov (7):
  WIP: clk: add AR9331 SoCs clock driver
  WIP: MIPS: ath79: use drivers/clk/clk-ath79.c driver for ar933x
  MIPS: dts: qca: introduce AR9331 devicetree
  MIPS: ath79: add initial support for TP-LINK MR3020
  devicetree: add Dragino vendor id
  MIPS: ath79: add initial support for Dragino MS14 (Dragino 2)
  WIP: MIPS: add ar9331 devicetree defconfigs

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/mips/ath79/Kconfig                            |  10 ++
 arch/mips/ath79/clock.c                            |   6 +-
 arch/mips/boot/dts/qca/Makefile                    |   2 +
 arch/mips/boot/dts/qca/ar9331.dtsi                 | 123 ++++++++++++++++++
 arch/mips/boot/dts/qca/dragino_ms14.dts            |  73 +++++++++++
 arch/mips/boot/dts/qca/tl_mr3020.dts               |  72 +++++++++++
 arch/mips/configs/dragino-ms14-dt-raw_defconfig    |  85 +++++++++++++
 arch/mips/configs/tl-mr3020-dt-raw_defconfig       |  85 +++++++++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-ath79.c                            | 137 +++++++++++++++++++++
 include/dt-bindings/clock/ar933x-clk.h             |  22 ++++
 12 files changed, 616 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/dts/qca/ar9331.dtsi
 create mode 100644 arch/mips/boot/dts/qca/dragino_ms14.dts
 create mode 100644 arch/mips/boot/dts/qca/tl_mr3020.dts
 create mode 100644 arch/mips/configs/dragino-ms14-dt-raw_defconfig
 create mode 100644 arch/mips/configs/tl-mr3020-dt-raw_defconfig
 create mode 100644 drivers/clk/clk-ath79.c
 create mode 100644 include/dt-bindings/clock/ar933x-clk.h

-- 
2.6.2
