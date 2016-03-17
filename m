Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:34:42 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35600 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006209AbcCQDekNMXrp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:40 +0100
Received: by mail-lf0-f66.google.com with SMTP id e138so2230842lfe.2;
        Wed, 16 Mar 2016 20:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5wdnpG29Qoi8nXwZ1jNwNPywMh0QYp3ZQpKzJeg3WbY=;
        b=JoG4Kib6fDSKZTedTC7mj+1QWTmnMNXtid7tQWp8ztSqjkAtKUVTlnTilO1jKqTKI1
         vCc4jbU+pepBIQ6+gcpbawJWs4jZAIfRl/IrWQxhI5Pq9KT9EuJjqLVACUHG0ErKlwue
         RfIrkluL+qkF+f5KeWXvyfFg2s4doMEkw52Id1rweFUBomOiekIwOQHQh0IBk6rX0ve4
         JOWJ1A3ntnXO8tReLAB5Tu4pCRNvBKBt8iy3Rug3q/Ze5JPQL7vh+QZkj3TRXdI95FHR
         xqoHNDOk4E5IBjP5S1xgCoydw+CebUg5BIXPBGtYouO77sjQedPLWolKNmzp38m9VoLq
         QzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5wdnpG29Qoi8nXwZ1jNwNPywMh0QYp3ZQpKzJeg3WbY=;
        b=Ec8L2BJHfhuPogRaZihm6kTzaBQIqll+q7CeTH4zcx6kh2vn7fyLwGZqtp1kqUaPcw
         YzWqlEg7GHijT9aKGbcCEgJMqXDBKhL5KSsUCCSJRLrDRH8KjijQNHQ/2eWHoYGPpoNx
         n7Nx9fNxXeBJD0IQaqbMBNIGICpoJ0xL/YG1woiquXgZqs1A1YHZj62bKCsjATpaeAj3
         eS7EGefePHc1CR52uuLZqvo02XvsEo+ZRjlNd2fNkULcwW6py9UfuJ72azDdjlRnmn5Y
         TFfIjje7axvvsYNngK1SRX67Iy1C/9LTLHQqdLdLNFWkbnLkcNunVzBAslDjNLrFTo1A
         nbjw==
X-Gm-Message-State: AD7BkJIjcjSnntpEdJc+cI8HY1110VkB9R7KLeHMTMmqTZe8BGo4XFOy6XbwmwtsWf8Pdw==
X-Received: by 10.25.26.208 with SMTP id a199mr2213390lfa.77.1458185673303;
        Wed, 16 Mar 2016 20:34:33 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:32 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Marek Vasut <marex@denx.de>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v2 00/18] MIPS: ath79: update devicetree support for AR9132 and AR9331
Date:   Thu, 17 Mar 2016 06:34:07 +0300
Message-Id: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52614
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

Hi all,

This patch series combines patches previously introduced
in 'MIPS: ath79: update devicetree support for AR9132'
and '[RFC v5 00/15] MIPS: ath79: AR9331: add devicetree support'
(please see https://www.linux-mips.org/archives/linux-mips/2016-02/msg00473.html
and https://www.linux-mips.org/archives/linux-mips/2016-02/msg00317.html
respectively).

The patch series relies on additional USB support and appended DTB handling
patches by Alban Bedel:

  * https://patchwork.linux-mips.org/patch/11497/
  * https://patchwork.linux-mips.org/patch/11495/

  * MIPS: OF: Rework the appended DTB handling to keep the PROM arguments
     ** https://github.com/AlbanBedel/linux/commit/3e1bb5db49a9da1d5d9c90d345fd114f00596c19

  * MIPS: ath79: Add support for DTB passed using the UHI boot protocol
     ** https://github.com/AlbanBedel/linux/commit/b0229b82f84c3e054308eb481d0f4a782fc8ac41

  * MIPS: ath79: Remove the builtin DTB support
     ** https://github.com/AlbanBedel/linux/commit/0b8843b069e525db690c253e03b7a15bc1d1f0df


The patch series with Alban's patches and defconfigs is available at github:

    https://github.com/frantony/linux/tree/20160317.ralf-ath79-dt


Changes since RFC v5 and PATCH v1 series:

  * keep current ath79 pll output clock numbering:
    (drop ATH79_CLK_REF, use dtc reference 'ref' clock instead);
    separate out 'MIPS: ath79: introduce <dt-bindings/clock/ath79-clk.h>' patch;
  * use chipidea,usb2 driver for AR9331 USB host (instead of
    generic-ehci driver); use regulator-fixed driver
    for TP-Link MR3020 USB connector VCC control;
  * get mips_hpt_frequency value from dt, add the appropriate
    clock parameter to the cpu@0 node;
  * add short references for wdt@18060008 and spi@1f000000
    ar9132.dtsi nodes;
  * ar9331.dtsi: move usb@1b000100 outside of apb section.
  * the patch 'MIPS: dts: qca: ar9132: fix typo: "ppl" -> "pll"'
    is squashed into 'dt-bindings: clock: qca,ath79-pll: fix copy-paste typos'


Changes since RFC v4:

  * AR3132-related patches are postponed;
  * drivers/clk/clk-ath79.c is rewritten;
  * DPTechnics DPT-Module board support is added;
  * TP-LINK MR3020 USB support is added;
  * gpio polled keys support is added for all boards;
  * appended DTB is used, so now we can use single vmlinux.bin
    image for all boards.

Changes since RFC v3:

  * clk: get pll registers base address from devicetree node
  * MIPS: dts: qca: ar9132: use short references for usb too
  * MIPS: dts: qca: ar9331: add usb support
  * MIPS: ath79: Dragino MS14: enable usb support

Changes since RFC v2:

  * add Onion Omega board support;
  * add AR9132 SoC clock driver;
  * add AR9132 devicetree fixes.

Changes since RFC v1:

  * add Dragino MS14 board support;
  * add "ref" oscillator input clock for pll-controller;
    add necessary nodes to board dts files.

Alban Bedel (1):
  MIPS: ath79: Fix the ar913x reference clock rate

Antony Pavlov (16):
  dt-bindings: clock: qca,ath79-pll: fix copy-paste typos
  MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop unused alias node
  MIPS: dts: qca: ar9132: use short references for dt nodes
  MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: use "ref" for reference clock name
  MIPS: ath79: introduce <dt-bindings/clock/ath79-clk.h>
  MIPS: ath79: update devicetree clock support for AR9132
  MIPS: ath79: setup.c: disable platform code for OF boards
  MIPS: dts: qca: introduce AR9331 devicetree
  MIPS: ath79: update devicetree clock support for AR9331
  MIPS: ath79: add initial support for TP-LINK MR3020
  devicetree: add Dragino vendor id
  MIPS: ath79: add initial support for Dragino MS14 (Dragino 2)
  devicetree: add Onion Corporation vendor id
  MIPS: ath79: add initial support for Onion Omega
  devicetree: add DPTechnics vendor id
  MIPS: ath79: add initial support for DPT-Module

Weijie Gao (1):
  MIPS: ath79: Fix the ar724x clock calculation

 .../devicetree/bindings/clock/qca,ath79-pll.txt    |   6 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   3 +
 arch/mips/ath79/clock.c                            | 263 ++++++++++++---------
 arch/mips/ath79/setup.c                            |  51 +++-
 arch/mips/boot/dts/qca/Makefile                    |   4 +
 arch/mips/boot/dts/qca/ar9132.dtsi                 |  19 +-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts   | 100 ++++----
 arch/mips/boot/dts/qca/ar9331.dtsi                 | 155 ++++++++++++
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts       |  78 ++++++
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts     | 102 ++++++++
 arch/mips/boot/dts/qca/ar9331_omega.dts            |  78 ++++++
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts        | 118 +++++++++
 include/dt-bindings/clock/ath79-clk.h              |  19 ++
 13 files changed, 812 insertions(+), 184 deletions(-)
 create mode 100644 arch/mips/boot/dts/qca/ar9331.dtsi
 create mode 100644 arch/mips/boot/dts/qca/ar9331_dpt_module.dts
 create mode 100644 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
 create mode 100644 arch/mips/boot/dts/qca/ar9331_omega.dts
 create mode 100644 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
 create mode 100644 include/dt-bindings/clock/ath79-clk.h

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: Marek Vasut <marex@denx.de>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>

-- 
2.7.0
