Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 07:41:13 +0200 (CEST)
Received: from mga12.intel.com ([192.55.52.136]:54372 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992494AbeFLFlF5En-a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jun 2018 07:41:05 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 22:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="58480365"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2018 22:40:58 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com
Cc:     linux-mips@linux-mips.org, qi-ming.wu@intel.com,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        James Hogan <jhogan@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/7] MIPS: intel: add initial support for Intel MIPS SoCs
Date:   Tue, 12 Jun 2018 13:40:27 +0800
Message-Id: <20180612054034.4969-1-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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

This patch series is for adding the support for Intel MIPS interAptiv SoC GRX500 family.
It includes CCF support, serial driver optimization and DTS modification.

This patch series is applied on top of v4.17.1. Basic verification is performed on GRX500 board.
Any comments on this would be appreciated.

We propose merging this patch series into MIPS Linux tree.


Hua Ma (1):
  MIPS: intel: Add initial support for Intel MIPS SoCs

Songjun Wu (5):
  MIPS: dts: Add aliases node for lantiq danube serial
  tty: serial: lantiq: Always use readl()/writel()
  tty: serial: lantiq: Convert global lock to per device lock
  tty: serial: lantiq: Remove unneeded header includes and macros
  tty: serial: lantiq: Add CCF support

Yixin Zhu (1):
  clk: intel: Add clock driver for GRX500 SoC

 .../devicetree/bindings/clock/intel,grx500-clk.txt |  46 ++
 .../devicetree/bindings/serial/lantiq_asc.txt      |  15 +
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  37 +-
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/intel-mips/Makefile             |   3 +
 arch/mips/boot/dts/intel-mips/easy350_anywan.dts   |  20 +
 arch/mips/boot/dts/intel-mips/xrx500.dtsi          | 196 ++++++
 arch/mips/boot/dts/lantiq/danube.dtsi              |   6 +-
 arch/mips/configs/grx500_defconfig                 | 165 +++++
 .../asm/mach-intel-mips/cpu-feature-overrides.h    |  61 ++
 arch/mips/include/asm/mach-intel-mips/ioremap.h    |  39 ++
 arch/mips/include/asm/mach-intel-mips/irq.h        |  17 +
 .../asm/mach-intel-mips/kernel-entry-init.h        |  76 +++
 arch/mips/include/asm/mach-intel-mips/spaces.h     |  29 +
 arch/mips/include/asm/mach-intel-mips/war.h        |  18 +
 arch/mips/intel-mips/Kconfig                       |  22 +
 arch/mips/intel-mips/Makefile                      |   3 +
 arch/mips/intel-mips/Platform                      |  11 +
 arch/mips/intel-mips/irq.c                         |  36 ++
 arch/mips/intel-mips/prom.c                        | 184 ++++++
 arch/mips/intel-mips/time.c                        |  56 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/intel/Kconfig                          |  21 +
 drivers/clk/intel/Makefile                         |   7 +
 drivers/clk/intel/clk-cgu-api.c                    | 676 +++++++++++++++++++++
 drivers/clk/intel/clk-cgu-api.h                    | 120 ++++
 drivers/clk/intel/clk-grx500.c                     | 236 +++++++
 drivers/tty/serial/Kconfig                         |   2 +-
 drivers/tty/serial/lantiq.c                        | 415 ++++++++-----
 include/dt-bindings/clock/intel,grx500-clk.h       |  61 ++
 32 files changed, 2418 insertions(+), 164 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
 create mode 100644 arch/mips/boot/dts/intel-mips/Makefile
 create mode 100644 arch/mips/boot/dts/intel-mips/easy350_anywan.dts
 create mode 100644 arch/mips/boot/dts/intel-mips/xrx500.dtsi
 create mode 100644 arch/mips/configs/grx500_defconfig
 create mode 100644 arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/ioremap.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/irq.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/spaces.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/war.h
 create mode 100644 arch/mips/intel-mips/Kconfig
 create mode 100644 arch/mips/intel-mips/Makefile
 create mode 100644 arch/mips/intel-mips/Platform
 create mode 100644 arch/mips/intel-mips/irq.c
 create mode 100644 arch/mips/intel-mips/prom.c
 create mode 100644 arch/mips/intel-mips/time.c
 create mode 100644 drivers/clk/intel/Kconfig
 create mode 100644 drivers/clk/intel/Makefile
 create mode 100644 drivers/clk/intel/clk-cgu-api.c
 create mode 100644 drivers/clk/intel/clk-cgu-api.h
 create mode 100644 drivers/clk/intel/clk-grx500.c
 create mode 100644 include/dt-bindings/clock/intel,grx500-clk.h

-- 
2.11.0
