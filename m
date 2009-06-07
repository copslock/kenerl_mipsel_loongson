Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jun 2009 19:39:19 +0100 (WEST)
Received: from fg-out-1718.google.com ([72.14.220.157]:20925 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20021813AbZFGSjM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Jun 2009 19:39:12 +0100
Received: by fg-out-1718.google.com with SMTP id 22so936918fge.9
        for <multiple recipients>; Sun, 07 Jun 2009 11:39:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9LKk0ADKWFSjWMbfd9ade20YHu0CSDRecuZFv/bSdq4=;
        b=fBcomrWE1ahZSoivOFXgOTrsb07tM4nsPAlRyCM7Uzmprh4RZVJqy4PmIJfpGLsR3+
         av6NpDnUBfQZuXX/QgxLelPwodDWHBEs88bPtV3fQ80AAfSfYKlSzmdHFzt7XH8qIWDV
         CthtKIPeyXg7RpJEx0vXHsB81bhu4WGfeqAuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PqI2HfbZ1XBC8ibbEe2o/3122XcOESUkrOLmExyOMOdIADY4mPYDLSYsogTYMrGeJ7
         dbo50qnXLum58jfc42lFR48EZIjqztEDbEJusZh2YrQzS5n+YMdBCGeVNRA1rW2Ku51w
         2q86Na/4SJmH/i+mf6UCui27ERvtI7zU6tzHY=
Received: by 10.86.30.5 with SMTP id d5mr2508990fgd.26.1244399951161;
        Sun, 07 Jun 2009 11:39:11 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 12sm421510fgg.0.2009.06.07.11.39.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Jun 2009 11:39:10 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 0/7] Alchemy: core and platform updates v2
Date:	Sun,  7 Jun 2009 20:38:57 +0200
Message-Id: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Minor updates to the Alchemy core code to get rid of a hack in the
irq dispatcher and the global variable "allow_au1k_wait".

The bulk of this series is in patches #3 to #7, which introduce new
DB1200 platform code, a new PCMCIA socket driver for almost all
Alchemy demoboards and finally the elimination of the alchemy-flash
MTD map driver in favor of physmap_flash platform devices.

As always, run-tested on the DB1200 only.
I'm particularly interested in success/failure reports wrt. PCMCIA on
other devboards (are there even any users left?)

History:
v2:  split DB1200 patch in core/defconfig and sound (alsa people wanted
     to have a look at it too).
     Initialize more PCMCIA irqs for all non-db1200 devboards.

Manuel Lauss (7):
  Alchemy: prioritize timer and usb irqs
  Alchemy: get rid of allow_au1k_wait
  Alchemy: extended DB1200 board support.
  Alchemy: DB1200 AC97+I2S audio support.
  Alchemy: new PCMCIA socket driver for devboards.
  Alchemy: convert to physmap flash
  Alchemy: db1200 defconfig update.

 arch/mips/alchemy/common/irq.c                   |  275 ++--
 arch/mips/alchemy/common/platform.c              |    6 -
 arch/mips/alchemy/common/reset.c                 |    3 -
 arch/mips/alchemy/common/setup.c                 |    3 +-
 arch/mips/alchemy/common/time.c                  |   14 +-
 arch/mips/alchemy/devboards/Makefile             |    2 +-
 arch/mips/alchemy/devboards/db1200/Makefile      |    1 +
 arch/mips/alchemy/devboards/db1200/platform.c    |  667 +++++++++
 arch/mips/alchemy/devboards/db1200/setup.c       |  181 +++
 arch/mips/alchemy/devboards/db1x00/Makefile      |    3 +-
 arch/mips/alchemy/devboards/db1x00/irqmap.c      |   18 +-
 arch/mips/alchemy/devboards/db1x00/platform.c    |  243 ++++
 arch/mips/alchemy/devboards/pb1000/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1000/platform.c    |   84 ++
 arch/mips/alchemy/devboards/pb1100/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1100/platform.c    |  134 ++
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    5 -
 arch/mips/alchemy/devboards/pb1200/irqmap.c      |   19 +-
 arch/mips/alchemy/devboards/pb1200/platform.c    |  167 +++-
 arch/mips/alchemy/devboards/pb1500/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |    3 +
 arch/mips/alchemy/devboards/pb1500/platform.c    |  134 ++
 arch/mips/alchemy/devboards/pb1550/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |    6 +
 arch/mips/alchemy/devboards/pb1550/platform.c    |  177 +++
 arch/mips/configs/db1200_defconfig               | 1620 +++++++++++++---------
 arch/mips/include/asm/mach-au1x00/au1000.h       |   14 +
 arch/mips/include/asm/mach-db1x00/db1200.h       |   38 +-
 arch/mips/include/asm/mach-db1x00/db1x00.h       |    8 -
 arch/mips/include/asm/mach-pb1x00/pb1100.h       |    7 -
 arch/mips/include/asm/mach-pb1x00/pb1200.h       |   14 -
 arch/mips/include/asm/mach-pb1x00/pb1500.h       |    7 -
 arch/mips/include/asm/mach-pb1x00/pb1550.h       |    7 -
 arch/mips/kernel/cpu-probe.c                     |   10 +-
 drivers/mtd/maps/Kconfig                         |    6 -
 drivers/mtd/maps/Makefile                        |    1 -
 drivers/mtd/maps/alchemy-flash.c                 |  166 ---
 drivers/pcmcia/Kconfig                           |   17 +-
 drivers/pcmcia/Makefile                          |    9 +-
 drivers/pcmcia/au1000_db1x00.c                   |  305 ----
 drivers/pcmcia/db1xxx_ss.c                       |  700 ++++++++++
 sound/soc/au1x/Kconfig                           |   10 +-
 sound/soc/au1x/Makefile                          |    4 +-
 sound/soc/au1x/db1200.c                          |  189 +++
 sound/soc/au1x/sample-ac97.c                     |  144 --
 45 files changed, 3871 insertions(+), 1562 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1200/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1200/platform.c
 create mode 100644 arch/mips/alchemy/devboards/db1200/setup.c
 create mode 100644 arch/mips/alchemy/devboards/db1x00/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1000/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1100/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1500/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1550/platform.c
 delete mode 100644 drivers/mtd/maps/alchemy-flash.c
 delete mode 100644 drivers/pcmcia/au1000_db1x00.c
 create mode 100644 drivers/pcmcia/db1xxx_ss.c
 create mode 100644 sound/soc/au1x/db1200.c
 delete mode 100644 sound/soc/au1x/sample-ac97.c
