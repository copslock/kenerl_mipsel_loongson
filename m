Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Sep 2009 20:15:35 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:62676 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493658AbZI2SP3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Sep 2009 20:15:29 +0200
Received: by fxm21 with SMTP id 21so1108497fxm.33
        for <linux-mips@linux-mips.org>; Tue, 29 Sep 2009 11:15:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hsJeKQWfzFGTmp//4KDvLCJFI67n7IVBUVxL0LunHrY=;
        b=NQvrk8kk2YeOCFPjfNu9NUURi52agQn20ZxSYAimR42DEFYb9y7X36WK3Hc3wUOz9D
         trgZWTxKEvw3waaDKNoUu1F7PSOzAjbxs+Mm01s6kCYmq1RKzV+OlQYWncEXeYTv1MIE
         jFnFtYeZCLTksNQY0t4EE8e3oZfMGG4qVrfYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kNj5sEZxl+vAe42ST3ArBcJgPqFhys6FZBezYjGL3uNrmdwr0i7NX4o+xS3/oFWh2y
         nYHIJfql66fwjQCpX//gSSp1c6ot4YgtJ7nc/tW1vH4/COWALuDS8pQiqAn12Mo4rm+K
         kFfbXMV6zP9OR38y+xcC0GHiV5kH1jeD2kXnM=
Received: by 10.86.41.19 with SMTP id o19mr4457905fgo.45.1254248122921;
        Tue, 29 Sep 2009 11:15:22 -0700 (PDT)
Received: from localhost.localdomain (p5496CA2C.dip.t-dialin.net [84.150.202.44])
        by mx.google.com with ESMTPS id 3sm46061fge.23.2009.09.29.11.15.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Sep 2009 11:15:22 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 0/3] Alchemy: devboards: BCSR abstraction and new PCMCIA socket driver
Date:	Tue, 29 Sep 2009 20:15:11 +0200
Message-Id: <1254248114-4158-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

These 3 patches add a small API for the devboard CPLD registers,
collect all board register data in a single place,
and add a first user: a new PCMCIA socket driver for Db1xxx/Pb1xxx.

#1 adds basic devboard register ("BCSR" space) API and converts
   all "bcsr->" invocations to use the new API.
   The API is slower than direct access but adds locking to register
   modify operations, which patch #3 can take advantage of.
#2 generalizes PB1200's CPLD IRQ controller code; DB1300 can use it
   too.
#3 replaces the current devboard PCMCIA socket code.  See patch for
   more details.   While it doesn't really belong to this series
   per-se, it does make use of the functions introduced by #1.


As always, run-tested on the DB1200; although testers for the other
boards are very welcome! (are there any left at all?)

On a related note: Are there any users of the PB1000 left?  Since this
board is so very different from the rest, and noone seems to care
about it (most code related to it doesn't build and I only have Au1200
boards to test) I'm inclined to remove it from the tree altogether.

Thanks!

Manuel Lauss (3):
  Alchemy: devboard register abstraction
  Alchemy: devboards: factor out PB1200 IRQ cascade code.
  Alchemy: new PCMCIA socket driver for devboards.

 arch/mips/alchemy/common/platform.c              |    6 -
 arch/mips/alchemy/common/setup.c                 |    3 +-
 arch/mips/alchemy/devboards/Makefile             |    2 +-
 arch/mips/alchemy/devboards/bcsr.c               |  148 +++++
 arch/mips/alchemy/devboards/db1x00/Makefile      |    3 +-
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   62 ++-
 arch/mips/alchemy/devboards/db1x00/irqmap.c      |   18 +-
 arch/mips/alchemy/devboards/db1x00/platform.c    |  164 ++++++
 arch/mips/alchemy/devboards/pb1100/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1100/board_setup.c |    7 +-
 arch/mips/alchemy/devboards/pb1100/platform.c    |   83 +++
 arch/mips/alchemy/devboards/pb1200/board_setup.c |   49 +-
 arch/mips/alchemy/devboards/pb1200/irqmap.c      |   67 +---
 arch/mips/alchemy/devboards/pb1200/platform.c    |  240 ++++++++-
 arch/mips/alchemy/devboards/pb1500/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   10 +-
 arch/mips/alchemy/devboards/pb1500/platform.c    |   83 +++
 arch/mips/alchemy/devboards/pb1550/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   17 +-
 arch/mips/alchemy/devboards/pb1550/platform.c    |  126 +++++
 arch/mips/include/asm/mach-au1x00/au1000.h       |   14 +
 arch/mips/include/asm/mach-db1x00/bcsr.h         |  235 ++++++++
 arch/mips/include/asm/mach-db1x00/db1200.h       |  122 ----
 arch/mips/include/asm/mach-db1x00/db1x00.h       |  100 ----
 arch/mips/include/asm/mach-pb1x00/pb1100.h       |   56 --
 arch/mips/include/asm/mach-pb1x00/pb1200.h       |  121 +----
 arch/mips/include/asm/mach-pb1x00/pb1500.h       |   20 -
 arch/mips/include/asm/mach-pb1x00/pb1550.h       |   96 ----
 drivers/mtd/nand/au1550nd.c                      |    4 +-
 drivers/net/irda/au1k_ir.c                       |   14 +-
 drivers/pcmcia/Kconfig                           |   17 +-
 drivers/pcmcia/Makefile                          |    9 +-
 drivers/pcmcia/au1000_db1x00.c                   |  305 ----------
 drivers/pcmcia/db1xxx_ss.c                       |  649 ++++++++++++++++++++++
 34 files changed, 1860 insertions(+), 999 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/bcsr.c
 create mode 100644 arch/mips/alchemy/devboards/db1x00/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1100/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1500/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1550/platform.c
 create mode 100644 arch/mips/include/asm/mach-db1x00/bcsr.h
 delete mode 100644 drivers/pcmcia/au1000_db1x00.c
 create mode 100644 drivers/pcmcia/db1xxx_ss.c
