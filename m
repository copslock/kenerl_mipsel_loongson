Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Oct 2009 14:56:06 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:46395 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492490AbZJDMzj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Oct 2009 14:55:39 +0200
Received: by ewy10 with SMTP id 10so1846480ewy.33
        for <multiple recipients>; Sun, 04 Oct 2009 05:55:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=qof7ZKcCo269st5oJasbZZulS7I4jV3DUapHhYkl+MM=;
        b=MZ/j09xEelQ2EieVtFD9c8cpF3T8CDRH5gTODIif/1JyEFvJXEIc9MSFeYSavl3j52
         LTizI2yW/pHE47XFX9d10v93UrCahtS1RB/mrSNBset40t7IpLEPGIt34aI9iK/ff3k8
         grQx4NepKt9sCSmBSaY3OsMK4z04GC0BO/9Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EPakUMX5jr9N/UgW6F4QIyICCGo+YNnFel/RqwlHgYc31Rw1Qn17+Vv2oqnWnYX/Si
         AGnASvJ31zn+CT2yIsg/nYOFAawC6AWURbMaPLW4f2iQk2nTbSY8xqfsROXyv0QB//Sn
         rHBlsG5dzCEKedb4Q7+bpKgf2MSPHSoSOJ8FI=
Received: by 10.211.143.13 with SMTP id v13mr5772854ebn.21.1254660930991;
        Sun, 04 Oct 2009 05:55:30 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 28sm1555483eyg.4.2009.10.04.05.55.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 05:55:29 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH V2 0/6] Alchemy: devboard and platform updates
Date:	Sun,  4 Oct 2009 14:55:23 +0200
Message-Id: <1254660929-15453-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

This is a V2 of the series formerly sent as "BCSR abstraction
and new PCMCIA socket driver".

Changes V1->V2:
- split the pcmcia socket driver patch in a driver-patch and
  board-support patch (#4 / #5);
- fixed typos in #1
- added new patch #3
- added #6 to the series, since it depends on #4 to compile.


#1 adds basic devboard register ("BCSR" space) API and converts
   all "bcsr->" invocations to use the new API.
   The API is slower than direct access but adds locking to register
   modify operations, which patch #3 can take advantage of.
#2 generalizes PB1200's CPLD IRQ controller code; DB1300 can use it
   too.
#3 gets rid of the "board_init_irq" callback in the boards: On all
   currently supported boards it's sufficient to initialize
   GPIO-based interrupts in an arch_initcall through use of standard
   irq functions.

#4 replaces the current devboard PCMCIA socket code.  See patch for
   more details.   While it doesn't really belong to this series
   per-se, it does make use of the functions introduced by #1.
#5 wire up the new pcmcia driver
#6 new pcmcia socket driver for XXS1500 systems (compiled only).


As always, run-tested on the DB1200 where possible;  although testers
for all other boards would be very much appreciated!

Patches 1-3 are more-or-less MIPS-specific, I'd like for them
to get applied while 4-6 await feedback from pcmcia list.


Thanks,
	Manuel Lauss


Manuel Lauss (6):
  Alchemy: devboard register abstraction
  Alchemy: devboards: factor out PB1200 IRQ cascade code.
  Alchemy: remove board_init_irq() function.
  PCMCIA: new socket driver for Au1000 demoboards.
  Alchemy: devboards: wire up new PCMCIA driver.
  Alchemy: XXS1500 PCMCIA driver rewrite

 arch/mips/alchemy/common/irq.c                   |   15 +-
 arch/mips/alchemy/common/platform.c              |    6 -
 arch/mips/alchemy/common/setup.c                 |    3 +-
 arch/mips/alchemy/devboards/Makefile             |    2 +-
 arch/mips/alchemy/devboards/bcsr.c               |  148 +++++
 arch/mips/alchemy/devboards/db1x00/Makefile      |    2 +-
 arch/mips/alchemy/devboards/db1x00/board_setup.c |  109 +++-
 arch/mips/alchemy/devboards/db1x00/irqmap.c      |   90 ---
 arch/mips/alchemy/devboards/db1x00/platform.c    |   84 +++
 arch/mips/alchemy/devboards/pb1000/board_setup.c |   17 +-
 arch/mips/alchemy/devboards/pb1100/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1100/board_setup.c |   31 +-
 arch/mips/alchemy/devboards/pb1100/platform.c    |   41 ++
 arch/mips/alchemy/devboards/pb1200/Makefile      |    2 +-
 arch/mips/alchemy/devboards/pb1200/board_setup.c |   91 +++-
 arch/mips/alchemy/devboards/pb1200/irqmap.c      |  134 -----
 arch/mips/alchemy/devboards/pb1200/platform.c    |   80 +++-
 arch/mips/alchemy/devboards/pb1500/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   35 +-
 arch/mips/alchemy/devboards/pb1500/platform.c    |   41 ++
 arch/mips/alchemy/devboards/pb1550/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   38 +-
 arch/mips/alchemy/devboards/pb1550/platform.c    |   63 +++
 arch/mips/alchemy/devboards/platform.c           |   89 +++
 arch/mips/alchemy/devboards/platform.h           |   18 +
 arch/mips/alchemy/mtx-1/Makefile                 |    2 +-
 arch/mips/alchemy/mtx-1/board_setup.c            |   24 +
 arch/mips/alchemy/mtx-1/irqmap.c                 |   56 --
 arch/mips/alchemy/xxs1500/Makefile               |    2 +-
 arch/mips/alchemy/xxs1500/board_setup.c          |   37 +-
 arch/mips/alchemy/xxs1500/irqmap.c               |   52 --
 arch/mips/alchemy/xxs1500/platform.c             |   63 +++
 arch/mips/include/asm/mach-au1x00/au1000.h       |   29 +-
 arch/mips/include/asm/mach-db1x00/bcsr.h         |  238 ++++++++
 arch/mips/include/asm/mach-db1x00/db1200.h       |  123 +-----
 arch/mips/include/asm/mach-db1x00/db1x00.h       |  100 ----
 arch/mips/include/asm/mach-pb1x00/pb1100.h       |   85 ---
 arch/mips/include/asm/mach-pb1x00/pb1200.h       |  122 +----
 arch/mips/include/asm/mach-pb1x00/pb1500.h       |   49 --
 arch/mips/include/asm/mach-pb1x00/pb1550.h       |   96 ----
 drivers/mtd/nand/au1550nd.c                      |    4 +-
 drivers/net/irda/au1k_ir.c                       |   14 +-
 drivers/pcmcia/Kconfig                           |   21 +
 drivers/pcmcia/Makefile                          |   12 +-
 drivers/pcmcia/au1000_db1x00.c                   |  305 -----------
 drivers/pcmcia/au1000_generic.h                  |   12 +-
 drivers/pcmcia/au1000_pb1x00.c                   |  119 +----
 drivers/pcmcia/au1000_xxs1500.c                  |  188 -------
 drivers/pcmcia/db1xxx_ss.c                       |  630 ++++++++++++++++++++++
 drivers/pcmcia/xxs1500_ss.c                      |  357 ++++++++++++
 50 files changed, 2172 insertions(+), 1716 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/bcsr.c
 delete mode 100644 arch/mips/alchemy/devboards/db1x00/irqmap.c
 create mode 100644 arch/mips/alchemy/devboards/db1x00/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1100/platform.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1200/irqmap.c
 create mode 100644 arch/mips/alchemy/devboards/pb1500/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1550/platform.c
 create mode 100644 arch/mips/alchemy/devboards/platform.c
 create mode 100644 arch/mips/alchemy/devboards/platform.h
 delete mode 100644 arch/mips/alchemy/mtx-1/irqmap.c
 delete mode 100644 arch/mips/alchemy/xxs1500/irqmap.c
 create mode 100644 arch/mips/alchemy/xxs1500/platform.c
 create mode 100644 arch/mips/include/asm/mach-db1x00/bcsr.h
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/pb1100.h
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/pb1500.h
 delete mode 100644 drivers/pcmcia/au1000_db1x00.c
 delete mode 100644 drivers/pcmcia/au1000_xxs1500.c
 create mode 100644 drivers/pcmcia/db1xxx_ss.c
 create mode 100644 drivers/pcmcia/xxs1500_ss.c
