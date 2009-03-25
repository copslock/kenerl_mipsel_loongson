Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 16:49:42 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.191]:10103 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28574876AbZCYQte (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 16:49:34 +0000
Received: by mu-out-0910.google.com with SMTP id w1so57967mue.4
        for <linux-mips@linux-mips.org>; Wed, 25 Mar 2009 09:49:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=665K4x/rcLb43avRSoKT/9pz8R0IqFKOHHz3E92KCtU=;
        b=VZb95GLaboZ6ifHJaL2Fg4YUOLdhUL6exqH+1kMwpKRZkI2Wu1GfQoJCsGpjzah1ar
         rVCoiS0mjbFd86VDhc/fz+oJ0fS2Gb9paFEcznM1E7rCzNoK5+327aCJ63kHpqqIrPHf
         b67Sysivl7yKLpMiViV+i/rSkCWnzJw3zn9vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=XfsOhkt8mCTD/m9na9TQ2tzHP/yJ1ME47QwLRYwbKNnTropcBn3ECDwXFPH5mtZiHD
         zTVoDdl1R7gHpUmN+cXhK5R/rvmVw6ZeqscVTjWqdABX0/cb6VcufY5/gPclAMUugnxA
         NXD+twY6wa69CG0G3EcY80q5+aHkp+/1WMS2g=
Received: by 10.103.171.6 with SMTP id y6mr4288505muo.31.1237999772993;
        Wed, 25 Mar 2009 09:49:32 -0700 (PDT)
Received: from localhost.localdomain (p5496CCD7.dip.t-dialin.net [84.150.204.215])
        by mx.google.com with ESMTPS id e10sm14966093muf.41.2009.03.25.09.49.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 09:49:32 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 0/6] Alchemy updates for 2.6.30
Date:	Wed, 25 Mar 2009 17:49:27 +0100
Message-Id: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello!

Here is another set of patches which aim to improve Alchemy and DB1200 support.
(doesn't apply against Kevin Hickey's DB1300 patches)

#1-#3 introduce a single CPU_ALCHEMY, add cpu feature overrides and add
      Alchemy to the list of cores which don't require hazard workarounds.

#4    gets rid of the sole Alchemy entry in smc91x.h

#5    I dislike the alchemy/common/platform.c file because it makes passing
      platform data to drivers ugly (the platdata struct and the consumer
      are in different files) and I also don't like the fact that every
      conceivable piece of alchemy hardware has a driver registered whether
      I like it or not.  To not change existing behaviour, the platform.c
      file is now invoked by the board Makefiles instead of the one in common/.

#6    Adds more complete DB1200 support (see patch for more info).

All have been run-tested on DB1200 for a few months without issues.

Have a nice day,
	Manuel Lauss

--- 

Manuel Lauss (6):
  Alchemy: unify CPU model constants.
  Alchemy: provide cpu feature overrides.
  Alchemy: MIPS hazard workarounds are not required.
  Alchemy: PB1200: use SMC91X platform data.
  Alchemy: don't unconditionally register all alchemy platform devices
  Alchemy: extended DB1200 board support.

 arch/mips/alchemy/common/Makefile                  |    2 +-
 arch/mips/alchemy/common/platform.c                |    4 -
 arch/mips/alchemy/devboards/Makefile               |    5 +-
 arch/mips/alchemy/devboards/db1200/Makefile        |    1 +
 arch/mips/alchemy/devboards/db1200/platform.c      |  712 ++++++++++
 arch/mips/alchemy/devboards/db1200/setup.c         |  204 +++
 arch/mips/alchemy/devboards/pb1200/board_setup.c   |    5 -
 arch/mips/alchemy/devboards/pb1200/irqmap.c        |   19 +-
 arch/mips/alchemy/devboards/pb1200/platform.c      |   14 +-
 arch/mips/alchemy/mtx-1/Makefile                   |    2 +-
 arch/mips/alchemy/xxs1500/Makefile                 |    1 +
 arch/mips/configs/db1200_defconfig                 | 1388 +++++++++++---------
 arch/mips/include/asm/cpu.h                        |    3 +-
 arch/mips/include/asm/hazards.h                    |    4 +-
 .../asm/mach-au1x00/cpu-feature-overrides.h        |   49 +
 arch/mips/include/asm/mach-db1x00/db1200.h         |   23 +-
 arch/mips/kernel/cpu-probe.c                       |   21 +-
 arch/mips/mm/c-r4k.c                               |   17 +-
 arch/mips/mm/tlbex.c                               |    8 +-
 drivers/net/smc91x.h                               |   32 -
 sound/soc/au1x/Kconfig                             |   10 +-
 sound/soc/au1x/Makefile                            |    4 +-
 sound/soc/au1x/db1200.c                            |  198 +++
 sound/soc/au1x/sample-ac97.c                       |  144 --
 24 files changed, 1967 insertions(+), 903 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1200/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1200/platform.c
 create mode 100644 arch/mips/alchemy/devboards/db1200/setup.c
 create mode 100644 arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
 create mode 100644 sound/soc/au1x/db1200.c
 delete mode 100644 sound/soc/au1x/sample-ac97.c
