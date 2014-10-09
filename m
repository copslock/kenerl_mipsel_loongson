Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 20:56:33 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:58465
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010986AbaJIS42OIX8A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 20:56:28 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 0/4] pinctrl: ralink: add support for rt2880 pinmux
Date:   Thu,  9 Oct 2014 04:55:23 +0200
Message-Id: <1412823327-10296-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

This series adds a pinctrl driver for ralink SoC. as it touches both arch and
pinctrl files i would prefer to have this go via the mips tree with the other
ralink pathes that i have sent.

John Crispin (4):
  MIPS: ralink: cleanup the soc specific pinmux data
  pinctrl: ralink: add a pinctrl driver for the rt2880 family of SoCs
  pinctrl: ralink: add binding documentation
  MIPS: ralink: always enable pinctrl on ralink SoC

 .../bindings/pinctrl/ralink,rt2880-pinmux.txt      |   74 +++
 arch/mips/Kconfig                                  |    2 +
 arch/mips/include/asm/mach-ralink/mt7620.h         |   41 +-
 arch/mips/include/asm/mach-ralink/pinmux.h         |   55 +++
 arch/mips/include/asm/mach-ralink/rt305x.h         |   35 +-
 arch/mips/include/asm/mach-ralink/rt3883.h         |   16 +-
 arch/mips/ralink/common.h                          |   19 -
 arch/mips/ralink/mt7620.c                          |  159 +++----
 arch/mips/ralink/rt288x.c                          |   62 +--
 arch/mips/ralink/rt305x.c                          |  153 +++----
 arch/mips/ralink/rt3883.c                          |  173 ++-----
 drivers/pinctrl/Kconfig                            |    5 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-rt2880.c                   |  474 ++++++++++++++++++++
 14 files changed, 849 insertions(+), 420 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.txt
 create mode 100644 arch/mips/include/asm/mach-ralink/pinmux.h
 create mode 100644 drivers/pinctrl/pinctrl-rt2880.c

-- 
1.7.10.4
