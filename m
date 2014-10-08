Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:08:06 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:53905
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010963AbaJIPIEPvNWc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:08:04 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 00/10] MIPS: ralink: various minor fixes and features
Date:   Thu,  9 Oct 2014 01:52:55 +0200
Message-Id: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43136
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

Over the last year these had been staged inside openwrt. These patches are a
pre-req for the following series which adds new mediatek SoCs.

John Crispin (10):
  MIPS: ralink: add verbose pmu info
  MIPS: ralink: add a helper for reading the ECO version
  MIPS: ralink: add rt_sysc_m32 helper
  MIPS: ralink: add a bootrom dumper module
  MIPS: ralink: add illegal access driver
  MIPS: ralink: allow manual memory override
  MIPS: ralink: add missing clk_set_rate() to clk.c
  MIPS: ralink: add rt2880 wmac clock
  MIPS: ralink: add rt3883 wmac clock
  MIPS: ralink: copy the commandline from the devicetree

 arch/mips/include/asm/mach-ralink/mt7620.h      |    5 ++
 arch/mips/include/asm/mach-ralink/ralink_regs.h |    7 ++
 arch/mips/ralink/Makefile                       |    4 ++
 arch/mips/ralink/bootrom.c                      |   48 +++++++++++++
 arch/mips/ralink/clk.c                          |    6 ++
 arch/mips/ralink/ill_acc.c                      |   87 +++++++++++++++++++++++
 arch/mips/ralink/mt7620.c                       |   26 +++++++
 arch/mips/ralink/of.c                           |   18 ++++-
 arch/mips/ralink/rt288x.c                       |    3 +-
 arch/mips/ralink/rt3883.c                       |    1 +
 10 files changed, 203 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/ralink/bootrom.c
 create mode 100644 arch/mips/ralink/ill_acc.c

-- 
1.7.10.4
