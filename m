Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2013 03:27:57 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:19372 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867248Ab3LFC0pu0nFu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Dec 2013 03:26:45 +0100
X-IronPort-AV: E=Sophos;i="4.93,838,1378882800"; 
   d="scan'208";a="419984"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw1-out.broadcom.com with ESMTP; 05 Dec 2013 18:30:23 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Thu, 5 Dec 2013 18:26:24 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.1.438.0; Thu, 5 Dec 2013 18:26:24 -0800
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 5E163246A3;  Thu,  5 Dec
 2013 18:26:24 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>, <jogo@openwrt.org>,
        <mbizon@freebox.fr>, <cernekee@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/5] tty: serial: bcm63xx_uart: do not depend on MIPS
Date:   Thu, 5 Dec 2013 18:26:03 -0800
Message-ID: <1386296768-20204-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Hi all,

This patchset reduces the dependency of the bcm63xx_uart on the MIPS BCM63XX
SoC support code in preparation for being used on different architectures
such as ARM.

Due to the MIPS patch which breaks down the register defines, this series
should ideally go via the MIPS tree.

Thanks!

Florian Fainelli (5):
  tty: serial: bcm63xx_uart: remove unused inclusion
  tty: serial: bcm63xx_uart: drop bcm_{readl,writel} macros
  MIPS: BCM63XX: move UART register definitions
  tty: serial: bcm63xx_uart: use linux/serial_bcm63xx.h
  MIPS: BCM63XX: use linux/serial_bcm63xx.h

 arch/mips/bcm63xx/early_printk.c                  |   2 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h | 120 ----------------------
 drivers/tty/serial/bcm63xx_uart.c                 |   9 +-
 include/linux/serial_bcm63xx.h                    | 119 +++++++++++++++++++++
 4 files changed, 123 insertions(+), 127 deletions(-)
 create mode 100644 include/linux/serial_bcm63xx.h

-- 
1.8.3.2
