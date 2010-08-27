Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Aug 2010 17:56:15 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:51968 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491809Ab0H0P4L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Aug 2010 17:56:11 +0200
Received: by bwz13 with SMTP id 13so2526676bwz.36
        for <linux-mips@linux-mips.org>; Fri, 27 Aug 2010 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ikr75LRn2O2WZGSuKllxYG4jxKdF642zY873ut9MVhk=;
        b=g6TDjoeQ3bV5ZztFxduwAiv2hHAZum/T60dKSt2c8ESuMh1GOMiq02yrm4rGZWdnTE
         9EmNEhBWaxymhZVXypoPUx5WnontjOS5GiHU/He1gFZzkS8FwG4WhOTDwYHHa2JplhYM
         lDriBtfUULmGNxfOu2r4KNCEjukiOTMQpyFE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Tl8Le/k9XeXINwtCAGMXP2dhPfw/tE6CuO5/VEYIAnM+Q914eSmwZIkh/Ait9APVq6
         V9gmMw8Rin4jfxtzh/ormeYp8qTIGxL7BHDQpUNIuS9bgd8lEPBlTI5tXWufgNChdSCh
         wMgoqEz3wjGYyDnxpFOUmlJFQ9Op9cYcYClhU=
Received: by 10.204.161.209 with SMTP id s17mr651925bkx.67.1282924570356;
        Fri, 27 Aug 2010 08:56:10 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 24sm2683051bkr.19.2010.08.27.08.56.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 08:56:09 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 0/2] MIPS: Au1300/DB1300 support.
Date:   Fri, 27 Aug 2010 17:56:03 +0200
Message-Id: <1282924565-16024-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The following 2 patches add basic Au1300 and DB1300 support.
DB1300 core support includes everything required to get either
NFSroot or a rootfs on Harddisk/CFcard working.

Please consider for 2.6.37.

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
 arch/mips/alchemy/devboards/db1300/platform.c    |  605 ++++++++++++++++++++++
 arch/mips/alchemy/devboards/db1300/setup.c       |  259 +++++++++
 arch/mips/alchemy/devboards/prom.c               |    4 +
 arch/mips/boot/compressed/uart-alchemy.c         |    5 +-
 arch/mips/configs/db1300_defconfig               |  280 ++++++++++
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
 32 files changed, 2450 insertions(+), 28 deletions(-)
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
1.7.2
