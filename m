Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:37:55 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37597 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011736AbbJ1WhyPIUVO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:54 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id B5DAC100029;
        Wed, 28 Oct 2015 23:37:53 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/15] MIPS: lantiq: add clock and PMU support for new SoCs
Date:   Wed, 28 Oct 2015 23:37:29 +0100
Message-Id: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This is based on lantiq GPL code and adds SoC detection, clocks and PMU 
bits for some more SoCs and also adds the PMU bits for more devices. 

This was tested on a VRX288 and a GRX300.
This is targeted at kernel 4.5.

Hauke Mehrtens (15):
  MIPS: lantiq: add locking for PMU register and check status afterwards
  MIPS: lantiq: add support for setting PMU register on AR10 and GRX390
  MIPS: lantiq: rename CGU_SYS_VR9 register
  MIPS: lantiq: fix pp32 clock on vr9
  MIPS: lantiq: add clock detection for grx390 and ar10
  MIPS: lantiq: deactivate most of the devices by default
  MIPS: lantiq: add PMU bits for USB and SDIO devices
  MIPS: lantiq: add pmu bits for ar10 and grx390
  MIPS: lantiq: add support for gphy firmware loading for ar10 and
    grx390
  MIPS: lantiq: add SoC detection for ar10 and grx390
  MIPS: lantiq: add clock for mei driver
  MIPS: lantiq: add 1e103100.deu clock
  MIPS: lantiq: add misc clocks
  MIPS: lantiq: add support for xRX220 SoC
  MIPS: lantiq: fix check for return value of request_mem_region()

 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |  14 ++
 arch/mips/lantiq/clk.h                             |  13 ++
 arch/mips/lantiq/irq.c                             |   8 +-
 arch/mips/lantiq/xway/clk.c                        | 174 +++++++++++++-
 arch/mips/lantiq/xway/prom.c                       |  34 ++-
 arch/mips/lantiq/xway/reset.c                      | 113 +++++++--
 arch/mips/lantiq/xway/sysctrl.c                    | 256 +++++++++++++++++----
 7 files changed, 538 insertions(+), 74 deletions(-)

-- 
2.6.1
