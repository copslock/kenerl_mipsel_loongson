Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 18:03:10 +0100 (WEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:65035 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022326AbZFCRDC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 18:03:02 +0100
Received: by bwz25 with SMTP id 25so145388bwz.0
        for <multiple recipients>; Wed, 03 Jun 2009 10:02:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=6rNNWFTMwMnQmeItQ5MsgWw8f62GThNccNmZKFwilag=;
        b=QsF60/xZNv3KTnTx/Ms4CChZAlSyd6xPtgKNJl30YQzvE8Nqa4vuL34Yp8FVkLYpYQ
         hUyShyNbmfPRhubcB4EA7bhAQOFgtpzBUwNn4pO36LJId04wFV6QRQLaTMu9rzbTZI1y
         F3/ekody7j0xpnYQZHLitrOZriQlGl1Up6PKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FFhOMsQsqymTcJ6GPJtUxX4Zo5EnYduJCY5V7MXf1MT3yek21RFWmRHB+IoZyF13+q
         c84LX6PaIwgf3lUPKMOhIGvIkolDYrGx4WL9rzmfA+dQNY3ySoZk6/6VH4lf82f7BX1O
         7TlP+pj+NXS5U4DyFGt9sRdVNi57hoOVdYKYI=
Received: by 10.204.53.143 with SMTP id m15mr1057883bkg.119.1244048576697;
        Wed, 03 Jun 2009 10:02:56 -0700 (PDT)
Received: from localhost.localdomain (p5496DB58.dip.t-dialin.net [84.150.219.88])
        by mx.google.com with ESMTPS id 18sm2452543fks.10.2009.06.03.10.02.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 10:02:56 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 0/5] Alchemy: core and platform updates
Date:	Wed,  3 Jun 2009 19:02:43 +0200
Message-Id: <1244048568-18006-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Minor updates to the Alchemy core code to get rid of a hack in the
irq dispatcher and the global variable "allow_au1k_wait".

The bulk of this series is in patches #3 to #5, which introduce new
DB1200 platform code, a new PCMCIA socket driver for almost all
Alchemy demoboards and finally the elimination of the alchemy-flash
MTD map driver in favor of physmap_flash platform devices.

As always, run-tested on the DB1200 only.

Manuel Lauss (5):
  Alchemy: prioritize timer and usb irqs
  Alchemy: get rid of allow_au1k_wait
  Alchemy: extended DB1200 board support.
  Alchemy: new PCMCIA socket driver for devboards.
  Alchemy: convert to physmap flash

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
 arch/mips/alchemy/devboards/db1x00/platform.c    |  243 ++++
 arch/mips/alchemy/devboards/pb1000/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1000/platform.c    |   84 ++
 arch/mips/alchemy/devboards/pb1100/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1100/platform.c    |  134 ++
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    5 -
 arch/mips/alchemy/devboards/pb1200/irqmap.c      |   19 +-
 arch/mips/alchemy/devboards/pb1200/platform.c    |  167 +++-
 arch/mips/alchemy/devboards/pb1500/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1500/platform.c    |  134 ++
 arch/mips/alchemy/devboards/pb1550/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |    3 +
 arch/mips/alchemy/devboards/pb1550/platform.c    |  181 +++
 arch/mips/configs/db1200_defconfig               | 1629 +++++++++++++---------
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
 43 files changed, 3875 insertions(+), 1547 deletions(-)
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
