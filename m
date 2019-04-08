Return-Path: <SRS0=L1Yz=SK=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07802C10F14
	for <linux-mips@archiver.kernel.org>; Mon,  8 Apr 2019 14:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F8F21473
	for <linux-mips@archiver.kernel.org>; Mon,  8 Apr 2019 14:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfDHOV1 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:21:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:33780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfDHOV1 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 8 Apr 2019 10:21:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE2C1AD7C;
        Mon,  8 Apr 2019 14:21:24 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 0/6] Use MFD framework for SGI IOC3 drivers
Date:   Mon,  8 Apr 2019 16:20:52 +0200
Message-Id: <20190408142100.27618-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SGI IOC3 ASIC includes support for ethernet, PS2 keyboard/mouse,
NIC (number in a can), GPIO and a byte  bus. By attaching a
SuperIO chip to it, it also supports serial lines and a parallel
port. The chip is used on a variety of SGI systems with different
configurations. This patchset moves code out of the network driver,
which doesn't belong there, into its new place a MFD driver and
specific platform drivers for the different subfunctions.

Thomas Bogendoerfer (6):
  MIPS: SGI-IP27: remove ioc3 ethernet init
  MIPS: SGI-IP27: remove setup of RTC platform device
  mfd: ioc3: Add driver for SGI IOC3 chip
  MIPS: SGI-IP27: fix readb/writeb addressing
  tty: serial: Add 8250-core base IOC3 driver
  Input: add IOC3 serio driver

 arch/mips/include/asm/mach-ip27/mangle-port.h |    2 +-
 arch/mips/include/asm/sn/ioc3.h               |  350 ++---
 arch/mips/sgi-ip27/ip27-console.c             |    5 +-
 arch/mips/sgi-ip27/ip27-init.c                |   13 -
 arch/mips/sgi-ip27/ip27-timer.c               |   20 -
 drivers/input/serio/Kconfig                   |   12 +
 drivers/input/serio/Makefile                  |    1 +
 drivers/input/serio/ioc3kbd.c                 |  183 +++
 drivers/mfd/Kconfig                           |   13 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/ioc3.c                            |  802 +++++++++++
 drivers/net/ethernet/sgi/Kconfig              |    4 +-
 drivers/net/ethernet/sgi/ioc3-eth.c           | 1869 +++++++++----------------
 drivers/rtc/rtc-m48t35.c                      |   11 +
 drivers/tty/serial/8250/8250_ioc3.c           |   98 ++
 drivers/tty/serial/8250/Kconfig               |   11 +
 drivers/tty/serial/8250/Makefile              |    1 +
 include/linux/platform_data/ioc3eth.h         |   15 +
 18 files changed, 1974 insertions(+), 1437 deletions(-)
 create mode 100644 drivers/input/serio/ioc3kbd.c
 create mode 100644 drivers/mfd/ioc3.c
 create mode 100644 drivers/tty/serial/8250/8250_ioc3.c
 create mode 100644 include/linux/platform_data/ioc3eth.h

-- 
2.13.7

