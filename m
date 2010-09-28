Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 09:44:41 +0200 (CEST)
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:50180 "EHLO
        eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491049Ab0I1Hoh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 09:44:37 +0200
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob102.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKGcdbo/8jY49Fh3etmfNaoWIPZ/Arit@postini.com; Tue, 28 Sep 2010 07:44:37 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5376C88;
        Tue, 28 Sep 2010 07:41:09 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 05EA6194D;
        Tue, 28 Sep 2010 07:41:00 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
        by relay2.stm.gmessaging.net (Postfix) with ESMTPS id 2FC19A809E;
        Tue, 28 Sep 2010 09:40:52 +0200 (CEST)
Received: from localhost (10.201.54.119) by exdcvycastm022.EQ1STM.local
 (10.230.100.30) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 28 Sep
 2010 09:40:55 +0200
From:   Arun Murthy <arun.murthy@stericsson.com>
To:     <eric.y.miao@gmail.com>, <linux@arm.linux.org.uk>,
        <grinberg@compulab.co.il>, <mike@compulab.co.il>,
        <robert.jarzmik@free.fr>, <marek.vasut@gmail.com>,
        <drwyrm@gmail.com>, <stefan@openezx.org>, <laforge@openezx.org>,
        <ospite@studenti.unina.it>, <philipp.zabel@gmail.com>,
        <mad_soft@inbox.ru>, <maz@misterjones.org>, <daniel@caiaq.de>,
        <haojian.zhuang@marvell.com>, <timur@freescale.com>,
        <ben-linux@fluff.org>, <support@simtec.co.uk>,
        <arnaud.patard@rtp-net.org>, <dgreenday@gmail.com>,
        <anarsoul@gmail.com>, <akpm@linux-foundation.org>,
        <mcuelenaere@gmail.com>, <kernel@pengutronix.de>,
        <andre.goddard@gmail.com>, <jkosina@suse.cz>, <tj@kernel.org>,
        <hsweeten@visionengravers.com>, <u.kleine-koenig@pengutronix.de>,
        <kgene.kim@samsung.com>, <ralf@linux-mips.org>, <lars@metafoo.de>,
        <dilinger@collabora.co.uk>, <mroth@nessie.de>,
        <randy.dunlap@oracle.com>, <lethal@linux-sh.org>,
        <rusty@rustcorp.com.au>, <damm@opensource.se>, <mst@redhat.com>,
        <rpurdie@rpsys.net>, <sguinot@lacie.co>, <sameo@linux.intel.com>,
        <broonie@opensource.wolfsonmicro.com>, <balajitk@ti.com>,
        <rnayak@ti.com>, <santosh.shilimkar@ti.com>, <hemanthv@ti.com>,
        <michael.hennerich@analog.com>, <vapier@gentoo.org>,
        <khali@linux-fr.org>, <jic23@cam.ac.uk>, <re.emese@gmail.com>,
        <linux@simtec.co.uk>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <arun.murthy@stericsson.com>, <linus.walleij@stericsson.com>,
        <mattias.wallin@stericsson.com>
Subject: [PATCHv2 0/7] PWM core driver for pwm based led and backlight driver
Date:   Tue, 28 Sep 2010 13:10:41 +0530
Message-ID: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
X-Mailer: git-send-email 1.7.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-archive-position: 27836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22112

The series of patch add a new pwm core driver.
Align the existing pwm drivers to make use of the pwm core driver.

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
 drivers/pwm/Kconfig                       |   33 ++++
 drivers/pwm/Makefile                      |    4 +
 drivers/pwm/pwm-ab8500.c                  |  157 +++++++++++++++++++
 drivers/pwm/pwm-core.c                    |  124 +++++++++++++++
 drivers/pwm/pwm-twl6040.c                 |  196 ++++++++++++++++++++++++
 drivers/video/backlight/Kconfig           |    2 +-
 drivers/video/backlight/pwm_bl.c          |    4 +-
 include/linux/leds_pwm.h                  |    1 +
 include/linux/pwm.h                       |   29 ++++-
 include/linux/pwm_backlight.h             |    1 +
 46 files changed, 864 insertions(+), 696 deletions(-)
 delete mode 100644 drivers/mfd/twl6030-pwm.c
 delete mode 100644 drivers/misc/ab8500-pwm.c
 create mode 100644 drivers/pwm/Kconfig
 create mode 100644 drivers/pwm/Makefile
 create mode 100644 drivers/pwm/pwm-ab8500.c
 create mode 100644 drivers/pwm/pwm-core.c
 create mode 100644 drivers/pwm/pwm-twl6040.c

-- 
1.7.2.dirty
