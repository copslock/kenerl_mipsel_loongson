Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 20:27:05 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.148]:59244 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1494030AbZKCT1A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2009 20:27:00 +0100
Received: by ey-out-1920.google.com with SMTP id 5so1176585eyb.52
        for <linux-mips@linux-mips.org>; Tue, 03 Nov 2009 11:26:57 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KHp3E4NkozXbLGyBEN25sSpZk5jA2OgCjvjzkvkia84=;
        b=eKOGbHPJeYx7u813NQAyFiR3GLNiILKnahsvEipdQyYsTfa5AXbDd3Wqqz1jwTA35v
         vGa43wOkzRps+WrTvSQRcGt49kgpzuIyptCSjNf+j+iHUUn88+DUgFzthXARP2pU3TVa
         hqafTEwKz/CbmG8fftP5esdP5mUSpPDNQOed0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kLi2GW2L3UHXRtfKRZQBjhydsjLgrX71pIWgVekk6Bju+/zhJVLFolZYVW/aRarGoQ
         UTQ0+ufxhYNLn2tPD/gA2OSEG8elsioYfFXLMF9cWjBc53ixk3KmoBo9ACvKhovoUJF+
         w5lwCOVB0ZlH+LCPJCXc5E4PGLWejIcgT33lM=
Received: by 10.216.90.18 with SMTP id d18mr158902wef.225.1257276417824;
        Tue, 03 Nov 2009 11:26:57 -0800 (PST)
Received: from localhost.localdomain (p5496F342.dip.t-dialin.net [84.150.243.66])
        by mx.google.com with ESMTPS id p10sm1157027gvf.29.2009.11.03.11.26.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 11:26:56 -0800 (PST)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Kevin Hickey <khickey@netlogicmicro.com>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH -queue 0/2] DB1300 support
Date:	Tue,  3 Nov 2009 20:27:01 +0100
Message-Id: <1257276423-26413-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Here are 2 patches against current mips-queue which add Au1300 and
Db1300 devboard support.  It's a work-in-progress, and has one
serious flaw:  I can't get the serial console to work reliably once
kernel starts booting userpsace.  Enabling debugging shows the
enabling the proper irq, however hardly any interrupts arrive unless
massive amounts of debug info (by way of the irq dispatcher) is
dumped out to it.  Once userspace has booted, and most debig output
has been hidden (echo 0 0 0 0 > /proc/sys/kernel/printk) it continues
to work as it should for a few bytes, then it dies.  Judging from
the debug logs it seems the UART generates far less interrupts than
for example the au1200 ones.

Until its figured out what's going on, please take the opportunity
to have a look at the code and suggest better ways to implement things
and bugs.

Thanks!

Manuel Lauss (2):
  MIPS: Alchemy: Au1300 SoC support
  Alchemy: DB1300 support WIP WIP WIP

 arch/mips/Makefile                               |    7 +
 arch/mips/alchemy/Kconfig                        |   31 +-
 arch/mips/alchemy/common/Makefile                |    9 +-
 arch/mips/alchemy/common/dbdma.c                 |   48 +-
 arch/mips/alchemy/common/gpioint.c               |  374 +++++++
 arch/mips/alchemy/common/gpiolib-au1300.c        |   54 +
 arch/mips/alchemy/common/platform.c              |    9 +
 arch/mips/alchemy/common/power.c                 |   18 +-
 arch/mips/alchemy/common/time.c                  |    1 +
 arch/mips/alchemy/devboards/Makefile             |    1 +
 arch/mips/alchemy/devboards/db1300/Makefile      |    2 +
 arch/mips/alchemy/devboards/db1300/platform.c    |  234 +++++
 arch/mips/alchemy/devboards/db1300/setup.c       |  158 +++
 arch/mips/alchemy/devboards/prom.c               |    4 +
 arch/mips/configs/db1300_defconfig               | 1160 ++++++++++++++++++++++
 arch/mips/include/asm/cpu.h                      |    8 +
 arch/mips/include/asm/mach-au1x00/au1000.h       |  189 ++++
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |   33 +
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h  |  211 ++++
 arch/mips/include/asm/mach-au1x00/gpio.h         |    4 +
 arch/mips/include/asm/mach-db1x00/bcsr.h         |    3 +
 arch/mips/include/asm/mach-db1x00/db1300.h       |   37 +
 arch/mips/kernel/cpu-probe.c                     |   18 +
 drivers/i2c/busses/Kconfig                       |    2 +-
 drivers/pcmcia/db1xxx_ss.c                       |   14 +-
 drivers/spi/Kconfig                              |    2 +-
 drivers/video/Kconfig                            |   10 +-
 27 files changed, 2613 insertions(+), 28 deletions(-)
 create mode 100644 arch/mips/alchemy/common/gpioint.c
 create mode 100644 arch/mips/alchemy/common/gpiolib-au1300.c
 create mode 100644 arch/mips/alchemy/devboards/db1300/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1300/platform.c
 create mode 100644 arch/mips/alchemy/devboards/db1300/setup.c
 create mode 100644 arch/mips/configs/db1300_defconfig
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1300.h
 create mode 100644 arch/mips/include/asm/mach-db1x00/db1300.h
