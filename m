Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 13:16:52 +0100 (CET)
Received: from kiutl.biot.com ([31.172.244.210]:53930 "EHLO kiutl.biot.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014268AbbCTMQvPOHxt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Mar 2015 13:16:51 +0100
Received: from spamd by kiutl.biot.com with sa-checked (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YYvr9-0000Mn-KU
        for linux-mips@linux-mips.org; Fri, 20 Mar 2015 13:16:51 +0100
Received: from [2a02:578:4a04:2a00::5] (helo=sumner.biot.com)
        by kiutl.biot.com with esmtps (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YYvr2-0000Lr-1T; Fri, 20 Mar 2015 13:16:44 +0100
Received: from bert by sumner.biot.com with local (Exim 4.82)
        (envelope-from <bert@biot.com>)
        id 1YYvr1-0006N7-Nz; Fri, 20 Mar 2015 13:16:43 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     ralf@linux-mips.org, broonie@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH 0/2] spi: Add driver for Routerboard RB4xx boards
Date:   Fri, 20 Mar 2015 13:16:31 +0100
Message-Id: <1426853793-24454-1-git-send-email-bert@biot.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <bert@biot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bert@biot.com
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

The driver mediates access between the connected CPLD and other devices
on the bus.

Imported from the OpenWrt project.

Bert Vermeulen (2):
  spi: Add SPI driver for Mikrotik RB4xx series boards
  spi: Add driver for the CPLD chip on Mikrotik RB4xx boards

 arch/mips/include/asm/mach-ath79/rb4xx_cpld.h |  41 +++
 drivers/spi/Kconfig                           |  14 +
 drivers/spi/Makefile                          |   2 +
 drivers/spi/spi-rb4xx-cpld.c                  | 326 +++++++++++++++++
 drivers/spi/spi-rb4xx.c                       | 505 ++++++++++++++++++++++++++
 include/linux/spi/spi.h                       |   2 +
 6 files changed, 890 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ath79/rb4xx_cpld.h
 create mode 100644 drivers/spi/spi-rb4xx-cpld.c
 create mode 100644 drivers/spi/spi-rb4xx.c

-- 
1.9.1
