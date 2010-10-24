Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2010 20:36:49 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:43885 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491107Ab0JXSgq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Oct 2010 20:36:46 +0200
Received: by wyf22 with SMTP id 22so2735524wyf.36
        for <linux-mips@linux-mips.org>; Sun, 24 Oct 2010 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xknhzXHPpaYK5u0eutc4mfNAUYoO0VxFRKykS7CbqpU=;
        b=rHhGhrrWc1hxqI/8yLpimFD7cI+N+9S+2OUWPMqxgWuQszlI0Zjytc3aLDQqF2Je7/
         H29LhgY+RewpGFrSQrlUiLDI0JbX5iNa8GSnGq/vHokWX/hO+VKptA4sCC91zjfO+vlc
         aMO+q3ovy3as9m/I29nQomTQu/GAEqI51EXck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HcFFaRhNS4JGiTRIjwq2Kh693ADb8FCpr0TwikipKTQDenaqCFe8phgMsm0gSlODsm
         VGIwkvPWnnr+A9pKJaigAPtHAFsFEGAvi7kV514jeaWlpfy/jJ0an+WqbhT35ws2684f
         aIVLkMSMXNefsvsTlZ+5yWTBo0CLMmAScFbUA=
Received: by 10.227.138.71 with SMTP id z7mr4738182wbt.23.1287945400012;
        Sun, 24 Oct 2010 11:36:40 -0700 (PDT)
Received: from localhost.localdomain (188-22-0-103.adsl.highway.telekom.at [188.22.0.103])
        by mx.google.com with ESMTPS id i19sm4836481wbe.11.2010.10.24.11.36.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 11:36:38 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RESEND 0/2] Au1300/DB1300 support
Date:   Sun, 24 Oct 2010 20:36:31 +0200
Message-Id: <1287945393-10080-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.3.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The following 2 patches implement basic Au1300/DB1300 support.

It's possible to boot a filesystem from NFSroot, mount IDE devices
(CF cards and harddisks; however using a harddisk as a root device
hangs the system early in the boot process), work with NAND/NOR 
flashes and use the ddma controller.

This is a resend of the patches I sent out earlier this year,
rebased on latest linus -git.

Please consider for 2.6.37.

Thanks,
      Manuel Lauss

Manuel Lauss (2):
  MIPS: Alchemy: Au1300 SoC support
  MIPS: Alchemy: DB1300 support

 arch/mips/alchemy/Kconfig                        |   17 +
 arch/mips/alchemy/Platform                       |    7 +
 arch/mips/alchemy/common/Makefile                |    2 +
 arch/mips/alchemy/common/dbdma.c                 |   48 ++-
 arch/mips/alchemy/common/gpioint.c               |  468 +++++++++++++++++
 arch/mips/alchemy/common/gpiolib-au1300.c        |   54 ++
 arch/mips/alchemy/common/platform.c              |    9 +
 arch/mips/alchemy/common/power.c                 |    9 +-
 arch/mips/alchemy/common/sleeper.S               |   73 +++
 arch/mips/alchemy/common/time.c                  |    1 +
 arch/mips/alchemy/devboards/Makefile             |    1 +
 arch/mips/alchemy/devboards/db1300/Makefile      |    1 +
 arch/mips/alchemy/devboards/db1300/platform.c    |  608 ++++++++++++++++++++++
 arch/mips/alchemy/devboards/db1300/setup.c       |  269 ++++++++++
 arch/mips/alchemy/devboards/prom.c               |    8 +-
 arch/mips/boot/compressed/uart-alchemy.c         |    5 +-
 arch/mips/configs/db1300_defconfig               |  298 +++++++++++
 arch/mips/include/asm/cpu.h                      |    8 +
 arch/mips/include/asm/mach-au1x00/au1000.h       |  198 +++++++-
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |   33 ++
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h  |  250 +++++++++
 arch/mips/include/asm/mach-au1x00/gpio.h         |    4 +
 arch/mips/include/asm/mach-db1x00/bcsr.h         |    5 +-
 arch/mips/include/asm/mach-db1x00/db1300.h       |   40 ++
 arch/mips/include/asm/mach-db1x00/irq.h          |   23 +
 arch/mips/kernel/cpu-probe.c                     |   18 +
 drivers/i2c/busses/Kconfig                       |    6 +-
 drivers/pcmcia/Kconfig                           |    4 +-
 drivers/pcmcia/db1xxx_ss.c                       |   30 +-
 drivers/spi/Kconfig                              |    2 +-
 drivers/video/Kconfig                            |    8 +-
 sound/soc/au1x/Kconfig                           |    6 +-
 32 files changed, 2483 insertions(+), 30 deletions(-)
 create mode 100644 arch/mips/alchemy/common/gpioint.c
 create mode 100644 arch/mips/alchemy/common/gpiolib-au1300.c
 create mode 100644 arch/mips/alchemy/devboards/db1300/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1300/platform.c
 create mode 100644 arch/mips/alchemy/devboards/db1300/setup.c
 create mode 100644 arch/mips/configs/db1300_defconfig
 create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1300.h
 create mode 100644 arch/mips/include/asm/mach-db1x00/db1300.h
 create mode 100644 arch/mips/include/asm/mach-db1x00/irq.h

-- 
1.7.3.2
