Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Sep 2011 17:17:10 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:35666 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491963Ab1IXPRD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Sep 2011 17:17:03 +0200
Received: by fxg7 with SMTP id 7so6005710fxg.36
        for <multiple recipients>; Sat, 24 Sep 2011 08:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=TgQF+SvxBjdRaWc0BT3f4PmBAyal+9P2bACCkL6QPJ8=;
        b=L437IQZQgPe5izjjX5MXtMtzf7h4uMwCGMgF+SLeVcHUArgdkDoQFj7RAN1hRzclfU
         6d2iQ0tw/8mohZKmxk8GXuHWblq+L4893HyfFlDACL2d2eZR9momf1eFocVkI/Xd2qF4
         WLubiHs8SUn5qknbRaFPsYun8nQ+06a5TCT8o=
Received: by 10.223.94.134 with SMTP id z6mr7134201fam.8.1316877417944;
        Sat, 24 Sep 2011 08:16:57 -0700 (PDT)
Received: from localhost.localdomain (188-22-1-130.adsl.highway.telekom.at. [188.22.1.130])
        by mx.google.com with ESMTPS id w14sm14549396fae.13.2011.09.24.08.16.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 08:16:56 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 0/2] MIPS: Alchemy: remove old board support
Date:   Sat, 24 Sep 2011 17:16:54 +0200
Message-Id: <1316877416-14958-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6.1
X-archive-position: 31150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13881

Hello,

These 2 patches remove support for the PB1000 and BOSPORUS/MIRAGE boards.
I have no appropriate test hardware, noone seems to be using them.
With the PB1000 gone the old Alchemy PCMCIA socket code can go away as well.
Support could be brought back if anyone is still interested (I do have
datasheets for all).

Manuel Lauss (2):
  MIPS: Alchemy: remove PB1000 support
  MIPS: Alchemy: drop MIRAGE/BOSPORUS board support

 arch/mips/alchemy/Kconfig                        |   23 -
 arch/mips/alchemy/Platform                       |   21 -
 arch/mips/alchemy/common/irq.c                   |   11 -
 arch/mips/alchemy/devboards/Makefile             |    3 -
 arch/mips/alchemy/devboards/db1x00/board_setup.c |  105 +----
 arch/mips/alchemy/devboards/db1x00/platform.c    |   67 +---
 arch/mips/alchemy/devboards/pb1000/Makefile      |    8 -
 arch/mips/alchemy/devboards/pb1000/board_setup.c |  209 ---------
 arch/mips/alchemy/devboards/prom.c               |    5 +-
 arch/mips/include/asm/mach-pb1x00/pb1000.h       |   87 ----
 drivers/net/irda/au1k_ir.c                       |    5 +-
 drivers/pcmcia/Kconfig                           |    4 -
 drivers/pcmcia/Makefile                          |    4 -
 drivers/pcmcia/au1000_generic.c                  |  545 ----------------------
 drivers/pcmcia/au1000_generic.h                  |  135 ------
 drivers/pcmcia/au1000_pb1x00.c                   |  294 ------------
 16 files changed, 5 insertions(+), 1521 deletions(-)
 delete mode 100644 arch/mips/alchemy/devboards/pb1000/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/pb1000/board_setup.c
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/pb1000.h
 delete mode 100644 drivers/pcmcia/au1000_generic.c
 delete mode 100644 drivers/pcmcia/au1000_generic.h
 delete mode 100644 drivers/pcmcia/au1000_pb1x00.c

-- 
1.7.6.1
