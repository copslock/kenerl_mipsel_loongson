Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Nov 2008 12:08:54 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:16877 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S23391429AbYKHMIw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Nov 2008 12:08:52 +0000
Received: (qmail 14688 invoked from network); 8 Nov 2008 13:06:29 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 8 Nov 2008 13:06:29 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Florian Fainelli <florian@openwrt.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 0/3] Alchemy: consolidate board code, v2
Date:	Sat,  8 Nov 2008 13:08:47 +0100
Message-Id: <cover.1226143942.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.3
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

(CC'ing Florian and Bruno since they have shown interest in the MTX-1
 code in the past).

This is v2 of my attempts to consolidate Alchemy board code.  This
patchset mostly moves code around with no intented functional changes.

Changes v1->v2:
- amended 2/3 as per Sergeis suggestions,
- simplified 3/3:  now all boards can override the reset/poweroff hooks
  if they want to; no changes for all existing in-tree users.
  (although I'd still like to kill off alchemy/common/reset.c or at least
  move it away from the other CPU-specific code).  This should also
  alleviate all of Sergei's remaining points.


Patch overview:
1/3:	in all boards dirs, merge the irqmap.c/init.c files into
	board_setup.c.

2/3:	create a common subdirectory for Alchemy evalboards; extract
	the prom code which is (almost) identical for all of them.
	Also extract the code augmenting the commandline from
	alchemy/common and sprinkle existing board init code with it.
	Not every board should be forced to have a serial console on UART0.

3/3:	allow boards to override default alchemy reset/poweroff hooks.

All patches have been compile-tested with all Alchemy boards available
in KConfig and tested on Db1200.

Feedback and Testers welcome!

Thanks,
	Manuel Lauss


Manuel Lauss (3):
  Alchemy: merge small board files into single files
  Alchemy: Move evalboard code to common directory
  Alchemy: allow boards to override default reset/poweroff functions.

 arch/mips/Makefile                             |   24 +-
 arch/mips/alchemy/common/setup.c               |   33 +---
 arch/mips/alchemy/db1x00/Makefile              |    8 -
 arch/mips/alchemy/db1x00/board_setup.c         |  108 ---------
 arch/mips/alchemy/db1x00/init.c                |   62 -----
 arch/mips/alchemy/db1x00/irqmap.c              |   86 -------
 arch/mips/alchemy/evalboards/Makefile          |   17 ++
 arch/mips/alchemy/evalboards/common.c          |   62 +++++
 arch/mips/alchemy/evalboards/db1x00.c          |  206 ++++++++++++++++
 arch/mips/alchemy/evalboards/pb1000.c          |  196 +++++++++++++++
 arch/mips/alchemy/evalboards/pb1100.c          |  150 ++++++++++++
 arch/mips/alchemy/evalboards/pb1200.c          |  301 ++++++++++++++++++++++++
 arch/mips/alchemy/evalboards/pb1200_platform.c |  166 +++++++++++++
 arch/mips/alchemy/evalboards/pb1500.c          |  156 ++++++++++++
 arch/mips/alchemy/evalboards/pb1550.c          |   86 +++++++
 arch/mips/alchemy/mtx-1/Makefile               |    2 +-
 arch/mips/alchemy/mtx-1/board_setup.c          |   60 +++++-
 arch/mips/alchemy/mtx-1/init.c                 |   60 -----
 arch/mips/alchemy/mtx-1/irqmap.c               |   52 ----
 arch/mips/alchemy/pb1000/Makefile              |    8 -
 arch/mips/alchemy/pb1000/board_setup.c         |  165 -------------
 arch/mips/alchemy/pb1000/init.c                |   57 -----
 arch/mips/alchemy/pb1000/irqmap.c              |   38 ---
 arch/mips/alchemy/pb1100/Makefile              |    8 -
 arch/mips/alchemy/pb1100/board_setup.c         |  109 ---------
 arch/mips/alchemy/pb1100/init.c                |   60 -----
 arch/mips/alchemy/pb1100/irqmap.c              |   40 ---
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
 arch/mips/alchemy/xxs1500/board_setup.c        |   59 +++++-
 arch/mips/alchemy/xxs1500/init.c               |   58 -----
 arch/mips/alchemy/xxs1500/irqmap.c             |   49 ----
 44 files changed, 1473 insertions(+), 1967 deletions(-)
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
