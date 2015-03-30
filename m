Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2015 20:24:36 +0200 (CEST)
Received: from kiutl.biot.com ([31.172.244.210]:42354 "EHLO kiutl.biot.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014787AbbC3SYfQDhTH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Mar 2015 20:24:35 +0200
Received: from spamd by kiutl.biot.com with sa-checked (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YceMV-0005HP-S0
        for linux-mips@linux-mips.org; Mon, 30 Mar 2015 20:24:36 +0200
Received: from [2a02:578:4a04:2a00::5] (helo=sumner.biot.com)
        by kiutl.biot.com with esmtps (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YceMR-0005H3-1B; Mon, 30 Mar 2015 20:24:31 +0200
Received: from bert by sumner.biot.com with local (Exim 4.82)
        (envelope-from <bert@biot.com>)
        id 1YceMQ-0003VW-O1; Mon, 30 Mar 2015 20:24:30 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     ralf@linux-mips.org, broonie@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH v2 0/1] spi: Add driver for Routerboard RB4xx boards
Date:   Mon, 30 Mar 2015 20:24:16 +0200
Message-Id: <1427739857-13395-1-git-send-email-bert@biot.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <bert@biot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46607
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

Changes in v2:
This is a near complete rewrite of the original OpenWrt driver. All comments
were taken into account, and the spi_transfer.fast_write flag is gone.
Instead, the cs_change flag is used. It's not too bad a hack, as it really
does use CS.

The CPLD module will be submitted as an MFD driver, as suggested.

Bert Vermeulen (1):
  spi: Add SPI driver for Mikrotik RB4xx series boards

 drivers/spi/Kconfig     |   6 ++
 drivers/spi/Makefile    |   1 +
 drivers/spi/spi-rb4xx.c | 241 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/spi/spi-rb4xx.c

-- 
1.9.1
