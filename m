Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2008 18:42:42 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:5027 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S23355299AbYKGSl3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Nov 2008 18:41:29 +0000
Received: (qmail 8432 invoked from network); 7 Nov 2008 19:38:33 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 7 Nov 2008 19:38:33 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 0/3] Alchemy: consolidate board code
Date:	Fri,  7 Nov 2008 19:41:19 +0100
Message-Id: <cover.1226082445.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.3
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

The following 3 patches aim to consolidate the alchemy board code
at bit.  The patched basically only move code around; no functional
changes (and tons of checkpatch warnings from the original code).

1/3:	in all evalboard dirs, merge the irqmap.c/init.c files into
	board_setup.c
2/3:	create a common subdirectory for Alchemy evalboards.
3/3:	extract remaining reset/init code from common/ subdir and move
	it to evalboard/.  I added reboot hook initialization to
	the mtx-1 and xxs1500 boards since the removal of common/reset.c
	their reboot functions no longer get called automagically.

All patches have been compile-tested with all Alchemy boards available
for selection in KConfig and tested on Db1200.

I have a few other patched which overhaul Alchemy IRQ code, so I'd like
to get this out of the way first.

Feedback and Testers welcome!

Thanks,
	Manuel Lauss

--- 

Manuel Lauss (3):
  Alchemy: merge small board files into single files
  Alchemy: Move evalboard code to common directory
  Alchemy: common reset code is evalboard code.

 arch/mips/Makefile                             |   24 +-
 arch/mips/alchemy/common/Makefile              |    2 +-
 arch/mips/alchemy/common/reset.c               |  189 ---------------
 arch/mips/alchemy/common/setup.c               |   39 ---
 arch/mips/alchemy/db1x00/Makefile              |    8 -
 arch/mips/alchemy/db1x00/board_setup.c         |  108 ---------
 arch/mips/alchemy/db1x00/init.c                |   62 -----
 arch/mips/alchemy/db1x00/irqmap.c              |   86 -------
 arch/mips/alchemy/evalboards/Makefile          |   17 ++
 arch/mips/alchemy/evalboards/common.c          |  253 ++++++++++++++++++++
 arch/mips/alchemy/evalboards/db1x00.c          |  182 +++++++++++++++
 arch/mips/alchemy/evalboards/pb1000.c          |  181 +++++++++++++++
 arch/mips/alchemy/evalboards/pb1100.c          |  127 ++++++++++
 arch/mips/alchemy/evalboards/pb1200.c          |  296 ++++++++++++++++++++++++
 arch/mips/alchemy/evalboards/pb1200_platform.c |  166 +++++++++++++
 arch/mips/alchemy/evalboards/pb1500.c          |  143 ++++++++++++
 arch/mips/alchemy/evalboards/pb1550.c          |   79 +++++++
 arch/mips/alchemy/mtx-1/Makefile               |    2 +-
 arch/mips/alchemy/mtx-1/board_setup.c          |   57 +++++-
 arch/mips/alchemy/mtx-1/init.c                 |   60 -----
 arch/mips/alchemy/mtx-1/irqmap.c               |   52 ----
 arch/mips/alchemy/pb1000/Makefile              |    8 -
 arch/mips/alchemy/pb1000/board_setup.c         |  165 -------------
 arch/mips/alchemy/pb1000/init.c                |   57 -----
 arch/mips/alchemy/pb1000/irqmap.c              |   38 ---
 arch/mips/alchemy/pb1100/Makefile              |    8 -
 arch/mips/alchemy/pb1100/board_setup.c         |  109 ---------
 arch/mips/alchemy/pb1100/init.c                |   60 -----
 arch/mips/alchemy/pb1100/irqmap.c              |   40 ----
 arch/mips/alchemy/pb1200/Makefile              |    8 -
 arch/mips/alchemy/pb1200/board_setup.c         |  162 -------------
 arch/mips/alchemy/pb1200/init.c                |   58 -----
 arch/mips/alchemy/pb1200/irqmap.c              |  160 -------------
 arch/mips/alchemy/pb1200/platform.c            |  166 -------------
 arch/mips/alchemy/pb1500/Makefile              |    8 -
 arch/mips/alchemy/pb1500/board_setup.c         |  119 ----------
 arch/mips/alchemy/pb1500/init.c                |   58 -----
 arch/mips/alchemy/pb1500/irqmap.c              |   46 ----
 arch/mips/alchemy/pb1550/Makefile              |    8 -
 arch/mips/alchemy/pb1550/board_setup.c         |   58 -----
 arch/mips/alchemy/pb1550/init.c                |   58 -----
 arch/mips/alchemy/pb1550/irqmap.c              |   43 ----
 arch/mips/alchemy/xxs1500/Makefile             |    2 +-
 arch/mips/alchemy/xxs1500/board_setup.c        |   55 ++++-
 arch/mips/alchemy/xxs1500/init.c               |   58 -----
 arch/mips/alchemy/xxs1500/irqmap.c             |   49 ----
 46 files changed, 1565 insertions(+), 2169 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/reset.c
 delete mode 100644 arch/mips/alchemy/db1x00/Makefile
 delete mode 100644 arch/mips/alchemy/db1x00/board_setup.c
 delete mode 100644 arch/mips/alchemy/db1x00/init.c
 delete mode 100644 arch/mips/alchemy/db1x00/irqmap.c
 create mode 100644 arch/mips/alchemy/evalboards/Makefile
 create mode 100644 arch/mips/alchemy/evalboards/common.c
 create mode 100644 arch/mips/alchemy/evalboards/db1x00.c
 create mode 100644 arch/mips/alchemy/evalboards/pb1000.c
 create mode 100644 arch/mips/alchemy/evalboards/pb1100.c
 create mode 100644 arch/mips/alchemy/evalboards/pb1200.c
 create mode 100644 arch/mips/alchemy/evalboards/pb1200_platform.c
 create mode 100644 arch/mips/alchemy/evalboards/pb1500.c
 create mode 100644 arch/mips/alchemy/evalboards/pb1550.c
 delete mode 100644 arch/mips/alchemy/mtx-1/init.c
 delete mode 100644 arch/mips/alchemy/mtx-1/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1000/Makefile
 delete mode 100644 arch/mips/alchemy/pb1000/board_setup.c
 delete mode 100644 arch/mips/alchemy/pb1000/init.c
 delete mode 100644 arch/mips/alchemy/pb1000/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1100/Makefile
 delete mode 100644 arch/mips/alchemy/pb1100/board_setup.c
 delete mode 100644 arch/mips/alchemy/pb1100/init.c
 delete mode 100644 arch/mips/alchemy/pb1100/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1200/Makefile
 delete mode 100644 arch/mips/alchemy/pb1200/board_setup.c
 delete mode 100644 arch/mips/alchemy/pb1200/init.c
 delete mode 100644 arch/mips/alchemy/pb1200/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1200/platform.c
 delete mode 100644 arch/mips/alchemy/pb1500/Makefile
 delete mode 100644 arch/mips/alchemy/pb1500/board_setup.c
 delete mode 100644 arch/mips/alchemy/pb1500/init.c
 delete mode 100644 arch/mips/alchemy/pb1500/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1550/Makefile
 delete mode 100644 arch/mips/alchemy/pb1550/board_setup.c
 delete mode 100644 arch/mips/alchemy/pb1550/init.c
 delete mode 100644 arch/mips/alchemy/pb1550/irqmap.c
 delete mode 100644 arch/mips/alchemy/xxs1500/init.c
 delete mode 100644 arch/mips/alchemy/xxs1500/irqmap.c
