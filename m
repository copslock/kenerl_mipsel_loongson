Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:33:24 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36877 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901165Ab2BQKdR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:17 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 0/6] MIPS: lantiq: use managed gpios
Date:   Fri, 17 Feb 2012 11:32:45 +0100
Message-Id: <1329474771-20874-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 32437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

3.2 introduced devm_request_gpio to allow devres to manage our gpios.

This series adds a new struct device pointer to our gpio_request wrapper
and ocnverts from gpio_request to devm_gpio_request.

John Crispin (6):
  MIPS: lantiq: remove redunant ltq_gpio_request() declaration and add
    device parameter
  MIPS: lantiq: use devm_request_gpio inside xway gpio driver
  MIPS: lantiq: use devm_request_gpio inside falcon gpio driver
  NET: MIPS: lantiq: convert etop to managed gpio
  MIPS: lantiq: convert pci to managed gpio
  MIPS: lantiq: convert gpio_stp to managed gpio

 .../include/asm/mach-lantiq/falcon/lantiq_soc.h    |    4 +---
 arch/mips/include/asm/mach-lantiq/lantiq.h         |    4 ++++
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    3 ---
 arch/mips/lantiq/falcon/gpio.c                     |    4 ++--
 arch/mips/lantiq/xway/gpio.c                       |    4 ++--
 arch/mips/lantiq/xway/gpio_stp.c                   |   13 ++++++++-----
 arch/mips/pci/pci-lantiq.c                         |   18 ++++++++++--------
 drivers/net/ethernet/lantiq_etop.c                 |    9 ++++++---
 8 files changed, 33 insertions(+), 26 deletions(-)

-- 
1.7.7.1
