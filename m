Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jun 2017 22:53:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27353 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994901AbdFQUxwaVzdF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jun 2017 22:53:52 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6FD011AAD9901;
        Sat, 17 Jun 2017 21:53:41 +0100 (IST)
Received: from localhost (10.20.78.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 17 Jun
 2017 21:53:45 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v5 0/4] MIPS Boston support
Date:   Sat, 17 Jun 2017 13:52:45 -0700
Message-ID: <20170617205249.1391-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.225]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series introduces support for the MIPS Boston development board,
allowing generic kernels to run on it. Typically a Boston board will be
running the U-Boot bootloader & we make use of the Flattened Image Tree
(FIT) image format for the kernel.

If physical Boston hardware is unavailable this series can be tested
using QEMU built from the master branch (or v2.9 onwards). To do so,
configure the kernel for the generic 64r6el_defconfig & run QEMU like
so:

  $ make ARCH=mips 64r6el_defconfig
  $ make ARCH=mips CROSS_COMPILE=my-toolchain-
  $ qemu-system-mips64el -M boston \
      -kernel arch/mips/boot/vmlinux.gz.itb \
      serial stdio

Applies atop v4.12-rc5.

Paul Burton (4):
  dt-bindings: Document img,boston-clock binding
  clk: boston: Add a driver for MIPS Boston board clocks
  MIPS: DTS: img: Don't attempt to build-in all .dtb files
  MIPS: generic: Support MIPS Boston development boards

 .../devicetree/bindings/clock/img,boston-clock.txt |  31 +++
 MAINTAINERS                                        |  10 +
 arch/mips/boot/dts/img/Makefile                    |   5 +-
 arch/mips/boot/dts/img/boston.dts                  | 224 +++++++++++++++++++++
 arch/mips/configs/generic/board-boston.config      |  48 +++++
 arch/mips/generic/Kconfig                          |  12 ++
 arch/mips/generic/vmlinux.its.S                    |  25 +++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/imgtec/Kconfig                         |   9 +
 drivers/clk/imgtec/Makefile                        |   1 +
 drivers/clk/imgtec/clk-boston.c                    | 103 ++++++++++
 include/dt-bindings/clock/boston-clock.h           |  14 ++
 13 files changed, 482 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/img,boston-clock.txt
 create mode 100644 arch/mips/boot/dts/img/boston.dts
 create mode 100644 arch/mips/configs/generic/board-boston.config
 create mode 100644 drivers/clk/imgtec/Kconfig
 create mode 100644 drivers/clk/imgtec/Makefile
 create mode 100644 drivers/clk/imgtec/clk-boston.c
 create mode 100644 include/dt-bindings/clock/boston-clock.h

-- 
2.13.1
