Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 14:08:24 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:59842 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990391AbeCTNISG-f27 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Mar 2018 14:08:18 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8B6D920879; Tue, 20 Mar 2018 14:08:11 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 49777203A2;
        Tue, 20 Mar 2018 14:08:01 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v6 0/6] MIPS: add support for Microsemi MIPS SoCs
Date:   Tue, 20 Mar 2018 14:07:55 +0100
Message-Id: <20180320130801.9247-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63077
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

Changes in v6:
 - Fixup SPDX identifiers
 - remove unit-address for cpuintc
 - add unit-address for ahb
 - remove CONFIG_32BIT requirement (implied by CONFIG_CPU_MIPS32_R2)
 - Add TLB entry lookup provided by James
 - Readd vendor prefix addition


Alexandre Belloni (6):
  dt-bindings: Add vendor prefix for Microsemi Corporation
  dt-bindings: mips: Add bindings for Microsemi SoCs
  MIPS: mscc: add ocelot dtsi
  MIPS: mscc: add ocelot PCB123 device tree
  MIPS: generic: Add support for Microsemi Ocelot
  MAINTAINERS: Add entry for Microsemi MIPS SoCs

 Documentation/devicetree/bindings/mips/mscc.txt    |  43 ++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   9 ++
 arch/mips/Makefile                                 |   4 +
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/mscc/Makefile                   |   3 +
 arch/mips/boot/dts/mscc/ocelot.dtsi                | 117 +++++++++++++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts          |  27 +++++
 arch/mips/configs/generic/board-ocelot.config      |  35 ++++++
 arch/mips/generic/Kconfig                          |  16 +++
 arch/mips/generic/Makefile                         |   1 +
 arch/mips/generic/board-ocelot.c                   |  78 ++++++++++++++
 12 files changed, 335 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt
 create mode 100644 arch/mips/boot/dts/mscc/Makefile
 create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb123.dts
 create mode 100644 arch/mips/configs/generic/board-ocelot.config
 create mode 100644 arch/mips/generic/board-ocelot.c

-- 
2.16.2
