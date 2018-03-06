Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2018 13:17:34 +0100 (CET)
Received: from [62.4.15.54] ([62.4.15.54]:44883 "EHLO mail.bootlin.com"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994687AbeCFMRILmz8r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2018 13:17:08 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A14B0209E0; Tue,  6 Mar 2018 13:16:50 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 33474209DB;
        Tue,  6 Mar 2018 13:16:19 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 0/5] MIPS: add support for Microsemi MIPS SoCs
Date:   Tue,  6 Mar 2018 13:16:02 +0100
Message-Id: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Hi,

This patch series adds initial support for the Microsemi MIPS SoCs. It
is currently focusing on the Microsemi Ocelot (VSC7513, VSC7514).

Changes in v5:
 - reworked the DT to remove ocelot_measure_hpt_freq()
 - fixed the memory node (memory@0)
 - fixed indentation
 - board-ocelot.config:
    o require CONFIG_CPU_MIPS32_R2
    o removed CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER
    o removed CONFIG_SQUASHFS because generic_defconfig has
      # CONFIG_MISC_FILESYSTEMS is not set
 - removed DMA_NONCOHERENT from MSCC_OCELOT

Alexandre Belloni (5):
  dt-bindings: mips: Add bindings for Microsemi SoCs
  MIPS: mscc: add ocelot dtsi
  MIPS: mscc: add ocelot PCB123 device tree
  MIPS: generic: Add support for Microsemi Ocelot
  MAINTAINERS: Add entry for Microsemi MIPS SoCs

 Documentation/devicetree/bindings/mips/mscc.txt |  43 +++++++++
 MAINTAINERS                                     |   9 ++
 arch/mips/Makefile                              |   4 +
 arch/mips/boot/dts/Makefile                     |   1 +
 arch/mips/boot/dts/mscc/Makefile                |   3 +
 arch/mips/boot/dts/mscc/ocelot.dtsi             | 117 ++++++++++++++++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts       |  27 ++++++
 arch/mips/configs/generic/board-ocelot.config   |  36 ++++++++
 arch/mips/generic/Kconfig                       |  16 ++++
 arch/mips/generic/Makefile                      |   1 +
 arch/mips/generic/board-ocelot.c                |  67 ++++++++++++++
 11 files changed, 324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt
 create mode 100644 arch/mips/boot/dts/mscc/Makefile
 create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb123.dts
 create mode 100644 arch/mips/configs/generic/board-ocelot.config
 create mode 100644 arch/mips/generic/board-ocelot.c

-- 
2.16.2
