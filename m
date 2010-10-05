Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2010 14:01:48 +0200 (CEST)
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:35637 "EHLO
        eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491004Ab0JEMBU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Oct 2010 14:01:20 +0200
Received: from source ([167.4.1.35]) (using TLSv1) by eu1sys200aob105.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKsTcXgsmLcncKc9Huf/CeW3PqxAYiXU@postini.com; Tue, 05 Oct 2010 12:01:19 UTC
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
        by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id 76DBD133;
        Tue,  5 Oct 2010 11:56:52 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
        by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 808DF6CF;
        Tue,  5 Oct 2010 12:00:08 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
        by relay2.stm.gmessaging.net (Postfix) with ESMTPS id 48B90A8095;
        Tue,  5 Oct 2010 14:00:02 +0200 (CEST)
Received: from localhost (10.201.54.119) by exdcvycastm022.EQ1STM.local
 (10.230.100.30) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 5 Oct
 2010 14:00:07 +0200
From:   Arun Murthy <arun.murthy@stericsson.com>
To:     <lars@metafoo.de>, <akpm@linux-foundation.org>,
        <kernel@pengutronix.de>, <philipp.zabel@gmail.com>,
        <robert.jarzmik@free.fr>, <marek.vasut@gmail.com>,
        <eric.y.miao@gmail.com>, <rpurdie@rpsys.net>,
        <sameo@linux.intel.com>, <kgene.kim@samsung.com>,
        <linux-omap@vger.kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <STEricsson_nomadik_linux@list.st.com>,
        <arun.murthy@stericsson.com>, <bgat@billgatliff.com>
Subject: [PATCHv2 0/7] PWM core driver for pwm based led and backlight driver
Date:   Tue, 5 Oct 2010 17:29:55 +0530
Message-ID: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
X-Mailer: git-send-email 1.7.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <arun.murthy@stericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips

PWM core driver for pwm based led and backlight driver.
The intention of the pwm core driver is not to break the build if two or more
pwm drivers are enabled.
Align the existing pwm drivers to make use of the pwm core driver

Arun Murthy (7):
  pwm: Add pwm core driver
  backlight:pwm: add an element 'name' to platform data
  leds: pwm: add a new element 'name' to platform data
  pwm: Align existing pwm drivers with pwm-core driver
  platform: Update the pwm based led and backlight platform data
  pwm: move existing pwm driver to drivers/pwm
  pwm: Modify backlight and led Kconfig aligning to pwm core

 arch/arm/mach-pxa/cm-x300.c               |    1 +
 arch/arm/mach-pxa/colibri-pxa270-income.c |    1 +
 arch/arm/mach-pxa/ezx.c                   |    1 +
 arch/arm/mach-pxa/hx4700.c                |    1 +
 arch/arm/mach-pxa/lpd270.c                |    1 +
 arch/arm/mach-pxa/magician.c              |    1 +
 arch/arm/mach-pxa/mainstone.c             |    1 +
 arch/arm/mach-pxa/mioa701.c               |    1 +
 arch/arm/mach-pxa/palm27x.c               |    1 +
 arch/arm/mach-pxa/palmtc.c                |    1 +
 arch/arm/mach-pxa/palmte2.c               |    1 +
 arch/arm/mach-pxa/pcm990-baseboard.c      |    1 +
 arch/arm/mach-pxa/raumfeld.c              |    1 +
 arch/arm/mach-pxa/tavorevb.c              |    2 +
 arch/arm/mach-pxa/viper.c                 |    1 +
 arch/arm/mach-pxa/z2.c                    |    2 +
 arch/arm/mach-pxa/zylonite.c              |    1 +
 arch/arm/mach-s3c2410/mach-h1940.c        |    1 +
 arch/arm/mach-s3c2440/mach-rx1950.c       |    1 +
 arch/arm/mach-s3c64xx/mach-hmt.c          |    1 +
 arch/arm/mach-s3c64xx/mach-smartq.c       |    1 +
 arch/arm/plat-mxc/pwm.c                   |  166 +++++++++------------
 arch/arm/plat-pxa/pwm.c                   |  210 ++++++++++++--------------
 arch/arm/plat-samsung/pwm.c               |  235 +++++++++++++----------------
 arch/mips/jz4740/pwm.c                    |    2 +-
 drivers/Kconfig                           |    2 +
 drivers/Makefile                          |    1 +
 drivers/leds/Kconfig                      |    2 +-
 drivers/leds/leds-pwm.c                   |    4 +-
 drivers/mfd/Kconfig                       |    9 -
 drivers/mfd/Makefile                      |    1 -
 drivers/mfd/twl-core.c                    |   13 ++
 drivers/mfd/twl6030-pwm.c                 |  163 --------------------
 drivers/misc/Kconfig                      |    9 -
 drivers/misc/Makefile                     |    1 -
 drivers/misc/ab8500-pwm.c                 |  168 --------------------
 drivers/pwm/Kconfig                       |   35 +++++
 drivers/pwm/Makefile                      |    4 +
 drivers/pwm/pwm-ab8500.c                  |  157 +++++++++++++++++++
 drivers/pwm/pwm-core.c                    |  130 ++++++++++++++++
 drivers/pwm/pwm-twl6040.c                 |  196 ++++++++++++++++++++++++
 drivers/video/backlight/Kconfig           |    2 +-
 drivers/video/backlight/pwm_bl.c          |    4 +-
 include/linux/leds_pwm.h                  |    3 +-
 include/linux/pwm.h                       |   31 ++++-
 include/linux/pwm_backlight.h             |    1 +
 46 files changed, 876 insertions(+), 696 deletions(-)
 delete mode 100644 drivers/mfd/twl6030-pwm.c
 delete mode 100644 drivers/misc/ab8500-pwm.c
 create mode 100644 drivers/pwm/Kconfig
 create mode 100644 drivers/pwm/Makefile
 create mode 100644 drivers/pwm/pwm-ab8500.c
 create mode 100644 drivers/pwm/pwm-core.c
 create mode 100644 drivers/pwm/pwm-twl6040.c

-- 
1.7.2.dirty
