Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 10:28:35 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:21919 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20032732AbZC2J1D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Mar 2009 10:27:03 +0100
Received: (qmail 22285 invoked from network); 29 Mar 2009 11:26:14 +0200
Received: from flagship.roarinelk.net (HELO localhost.localdomain) (192.168.0.197)
  by 192.168.0.1 with SMTP; 29 Mar 2009 11:26:14 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 0/3] Alchemy: platform updates
Date:	Sun, 29 Mar 2009 11:26:59 +0200
Message-Id: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello!

Patch overview:

#1: eliminate alchemy/common/platform.c.  Add platform device
    registration to all boards instead.

    I realize this is a lot of (needless) code duplication at first,
    but it seems a lot cleaner to me if each board registered the
    devices it needs/wants.

#2: platform au1xxx-rtc device for all devboards with 32kHz crystal.

#3: eliminate the alchemy-flash MTD map driver; add physmap-flash
    platform devices to each devboard.


I have 4 more patches which convert a few drivers to platform_devices
(irda and au1000-ac97c alsa) which (in part) depend on these.

Compile-tested on all boards touched by these patches; run-tested on
the DB1200 only.  If anyone has access to the other boards, please test
and report bugs to me!

Thanks!
	Manuel Lauss

--- 

Manuel Lauss (3):
  Alchemy: get rid of common/platform.c
  Alchemy: add RTC device to devboards
  Alchemy: convert to physmap flash

 arch/mips/alchemy/common/Makefile             |    4 +-
 arch/mips/alchemy/common/platform.c           |  369 -------------------------
 arch/mips/alchemy/devboards/db1x00/Makefile   |    2 +-
 arch/mips/alchemy/devboards/db1x00/platform.c |  247 +++++++++++++++++
 arch/mips/alchemy/devboards/pb1000/Makefile   |    2 +-
 arch/mips/alchemy/devboards/pb1000/platform.c |  144 ++++++++++
 arch/mips/alchemy/devboards/pb1100/Makefile   |    2 +-
 arch/mips/alchemy/devboards/pb1100/platform.c |  171 ++++++++++++
 arch/mips/alchemy/devboards/pb1200/platform.c |  249 +++++++++++++++++-
 arch/mips/alchemy/devboards/pb1500/Makefile   |    2 +-
 arch/mips/alchemy/devboards/pb1500/platform.c |  142 ++++++++++
 arch/mips/alchemy/devboards/pb1550/Makefile   |    2 +-
 arch/mips/alchemy/devboards/pb1550/platform.c |  160 +++++++++++
 arch/mips/alchemy/mtx-1/platform.c            |   64 +++++
 arch/mips/alchemy/xxs1500/Makefile            |    3 +-
 arch/mips/alchemy/xxs1500/platform.c          |   87 ++++++
 drivers/mtd/maps/Kconfig                      |    6 -
 drivers/mtd/maps/Makefile                     |    1 -
 drivers/mtd/maps/alchemy-flash.c              |  166 -----------
 19 files changed, 1272 insertions(+), 551 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/platform.c
 create mode 100644 arch/mips/alchemy/devboards/db1x00/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1000/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1100/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1500/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1550/platform.c
 create mode 100644 arch/mips/alchemy/xxs1500/platform.c
 delete mode 100644 drivers/mtd/maps/alchemy-flash.c
