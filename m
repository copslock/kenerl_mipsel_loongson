Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:14:29 +0100 (CET)
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34143 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011117AbcBIIO2da035 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:28 +0100
Received: by mail-lf0-f50.google.com with SMTP id j78so110750437lfb.1
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rU38N0d7OgF1ZEsxjXRFcyMqruicXgkJ+t+gKH0v1Z4=;
        b=XJmltl7yDollOFUz//uO16Jrwc9rnwAnpZtaWF584HHAzm1LiXm+5WC4SHFzEA+GJ/
         FhyR0y1n5T8JO2oREJOsnTbsLknbfU/7tvhzaPJ4J/5X7smDd+rCc0WU10lBZjTX8WuE
         zu4j4WrAWimeb8QzROKIzqcj6NDfSdKxXj5VYCezx9Q4GjZ4jMvZpbtwQnMmOu7cx8dI
         Kt4yT6fkTDiQAoJs8tlPNwBtEoeWiCHKV3Hydtild5juaaAleda0JjPUvpXfPvGKGRJR
         Oa8/XjUOsu5IaOPgIUTrsefGiUQCXiAsUwPwmu7ZEKzykh8//WWQFFCgQaPi85mWZ3Vo
         uo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rU38N0d7OgF1ZEsxjXRFcyMqruicXgkJ+t+gKH0v1Z4=;
        b=Z2PGDtl6P+3MolBuoS5YkjRY/t6/8OHSLTL9lS2SRW8ibu8FiCFR3Phb07UuigLIjP
         jrbcpl/bRTIsxgqrV/YDfiRwUpT8YfXMgi/Y860YFFD+zstZe680qb8nFyi9S3F6qUN5
         yy37RDuA+hsCQbQCze1Ja0zgGEAr3VZXwpLN1kX63/NUK0JSxCdMAi0Kz+cxVC43V0PK
         2lAmic5SU553HHEdGc74gNaVXSeT0PbZd6Wu4jR/F06g/ecei843UjM5WW8yO1zfwk1Z
         ejIZGS1d0ecUhhSWvGhvtRqo1vFMwhLe4CS85ozTqXWQyMV7ZEhLOG17/8kkg6pQFkCp
         IV2w==
X-Gm-Message-State: AG10YORsHcENHprDjufIfjt456mwc6j1e8w899jNsSPR57+2jtyC4etoWlor55nrPJWb0Q==
X-Received: by 10.25.8.4 with SMTP id 4mr6825937lfi.164.1455005663150;
        Tue, 09 Feb 2016 00:14:23 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:22 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>
Subject: [RFC v5 00/15] MIPS: ath79: AR9331: add devicetree support
Date:   Tue,  9 Feb 2016 11:13:46 +0300
Message-Id: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51876
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

This patchseries relies on additonal USB support and appended DTB handling
patches by Alban Bedel:

  * https://patchwork.linux-mips.org/patch/11497/
  * https://patchwork.linux-mips.org/patch/11495/

  * MIPS: OF: Rework the appended DTB handling to keep the PROM arguments
    https://github.com/AlbanBedel/linux/commit/3e1bb5db49a9da1d5d9c90d345fd114f00596c19

  * MIPS: ath79: Add support for DTB passed using the UHI boot protocol
    https://github.com/AlbanBedel/linux/commit/b0229b82f84c3e054308eb481d0f4a782fc8ac41

  * MIPS: ath79: Remove the builtin DTB support
    https://github.com/AlbanBedel/linux/commit/0b8843b069e525db690c253e03b7a15bc1d1f0df

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


Antony Pavlov (15):
  WIP: clk: add Atheros AR933X SoCs clock driver
  dt-bindings: clock: qca,ath79-pll: fix copy-paste typos
  MIPS: ath79: use clk-ath79.c driver for AR933X
  WIP: MIPS: ath79: setup.c: disable platform code for OF boards
  MIPS: dts: qca: introduce AR9331 devicetree
  MIPS: ath79: add initial support for TP-LINK MR3020
  usb: ehci: add vbus-gpio parameter
  MIPS: tl_mr3020: enable usb support
  devicetree: add Dragino vendor id
  MIPS: ath79: add initial support for Dragino MS14 (Dragino 2)
  devicetree: add Onion Corporation vendor id
  MIPS: ath79: add initial support for Onion Omega
  devicetree: add DPTechnics vendor id
  MIPS: ath79: add DPT-Module support
  WIP: MIPS: ath79: add AR9331 devicetree defconfig

 .../devicetree/bindings/clock/qca,ath79-pll.txt    |   4 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   3 +
 arch/mips/ath79/clock.c                            |   6 +-
 arch/mips/ath79/setup.c                            |  17 +-
 arch/mips/boot/dts/qca/Makefile                    |   4 +
 arch/mips/boot/dts/qca/ar9331.dtsi                 | 157 +++++++++
 arch/mips/boot/dts/qca/dpt_module.dts              |  77 +++++
 arch/mips/boot/dts/qca/dragino_ms14.dts            | 101 ++++++
 arch/mips/boot/dts/qca/omega.dts                   |  77 +++++
 arch/mips/boot/dts/qca/tl_mr3020.dts               | 108 +++++++
 arch/mips/configs/ar9331-dt-raw_defconfig          | 100 ++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-ath79.c                            | 354 +++++++++++++++++++++
 drivers/usb/host/ehci-platform.c                   |  22 ++
 include/dt-bindings/clock/ath79-clk.h              |  22 ++
 15 files changed, 1041 insertions(+), 12 deletions(-)
 create mode 100644 arch/mips/boot/dts/qca/ar9331.dtsi
 create mode 100644 arch/mips/boot/dts/qca/dpt_module.dts
 create mode 100644 arch/mips/boot/dts/qca/dragino_ms14.dts
 create mode 100644 arch/mips/boot/dts/qca/omega.dts
 create mode 100644 arch/mips/boot/dts/qca/tl_mr3020.dts
 create mode 100644 arch/mips/configs/ar9331-dt-raw_defconfig
 create mode 100644 drivers/clk/clk-ath79.c
 create mode 100644 include/dt-bindings/clock/ath79-clk.h

-- 
2.7.0
