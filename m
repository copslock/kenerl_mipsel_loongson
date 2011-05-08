Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 May 2011 10:42:36 +0200 (CEST)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:63956 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491003Ab1EHImc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 May 2011 10:42:32 +0200
Received: by wwi18 with SMTP id 18so1552983wwi.0
        for <linux-mips@linux-mips.org>; Sun, 08 May 2011 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=+n2pmT7iV0bbHsoUmKpmt7xyvo1Nyi34sZ2c03sWQEI=;
        b=MfQH89jCSOa0+PUeiPD5ckhK1v559Y5bRjVYglj35oAZRy6oLMcW75yOjTc+AXQkYh
         hgabmIcBZXRJXX0R9tLKBQa/3vImOU9Y15vR5ITs9w36QHCiEHREXVN0/M0ooC26cFA+
         Vq9wXXnDBg4+syR766xvx1vElRXraYposEU4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NopKJs0dbY1zjvvZSABVbATPhejf2jVn+2HH4bdtjQdep8XHneQCFPM87wKJDHwJTC
         oBKqs6HDP6+nLCLvYTNqk+4pabRrSciGCy15XpJAczG1yoDDPMG4C/2oIZ6DQadYRUMe
         ftLuVUDwqxpwUL4cMMNyqYFqJTQpbLhB9YcpE=
Received: by 10.227.164.79 with SMTP id d15mr5952083wby.62.1304844145916;
        Sun, 08 May 2011 01:42:25 -0700 (PDT)
Received: from localhost.localdomain (178-191-5-255.adsl.highway.telekom.at [178.191.5.255])
        by mx.google.com with ESMTPS id z9sm3022884wbx.34.2011.05.08.01.42.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 01:42:25 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH 0/9] Misc. Alchemy updates
Date:   Sun,  8 May 2011 10:42:11 +0200
Message-Id: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.rc3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

This is a RFC for a series of patches I've been sitting on a while,
it applies on top of latest linus-git (#3-#9 need to be applied
in sequence).


These two are older; they've been updated a bit:

#1  improves stability of DB1200 board,
#2  is a buildfix for mtx-1 with gpiolib=n; the gpio api has
    been updated with new functions, which this patch adds.


the other patches mainly replace au_readl/au_writel with __raw_*
functions, and try to reduce the register address clutter in
the au1000.h header.  This was basically a single large patch
broken down into smaller ones, one for each ip block.

#3  removes most of the irq-controller related register defines
    and updates irq.c to get rid of au_readl/writel.
#4  converts IRQ PM to syscore_ops
#5  converts DBDMA PM to syscore_ops
#6  rewrite UART setup to use runtime CPU detection, and get
    rid of most of the uart base address defines
#7  rewrite ethernet setup to use runtime CPU detection,
    and get rid of most of the redundant ethernet constants
#8  updates the old au1000 dma driver: according to the
    databooks physical addresses should be used for source
    and destination; this also allows then to remove
    another bunch of redundant address constants.
#9  changes the GPIO1/GPIO2 defines into offsets from their
    respective ip block base.  I also had to fixup the
    mtx-1 wdt driver a bit since it modified the gpio2 block
    directly.

All patches have been compile tested, and except for #7, #8 and
the wdt parts of #9 also been run- and PM-tested on the DB1200.

CCing Florian and Wolfgang: If you have time, please test #7-#9
on your MTX-1 and GPR boards!  I'd like to know whether ethernet
and the mtx-1 watchdog still work!  Thanks!

Please test/comment!

Thank you,
     Manuel Lauss

Manuel Lauss (9):
  MIPS: DB1200: Set Config[OD] for improved stability.
  MIPS: Alchemy: update inlinable GPIO API
  MIPS: Alchemy: irq code and constant cleanup
  MIPS: Alchemy: convert irq.c to syscore_ops.
  MIPS: Alchemy: convert dbdma.c to syscore_ops
  MIPS: Alchemy: rewrite UART setup and constants.
  MIPS: Alchemy: rewrite ethernet platform setup
  MIPS: Alchemy: cleanup DMA addresses
  MIPS: Alchemy: clean up GPIO registers and accessors

 arch/mips/alchemy/common/dbdma.c                 |  123 +++-----
 arch/mips/alchemy/common/dma.c                   |   46 ++--
 arch/mips/alchemy/common/irq.c                   |  345 +++++++++++-----------
 arch/mips/alchemy/common/platform.c              |  250 ++++++++++------
 arch/mips/alchemy/common/setup.c                 |    4 +-
 arch/mips/alchemy/devboards/db1200/setup.c       |    7 +
 arch/mips/alchemy/devboards/pb1000/board_setup.c |    2 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |    2 +-
 arch/mips/alchemy/devboards/prom.c               |    2 +-
 arch/mips/alchemy/gpr/board_setup.c              |   14 +-
 arch/mips/alchemy/gpr/init.c                     |    2 +-
 arch/mips/alchemy/mtx-1/board_setup.c            |    2 +-
 arch/mips/alchemy/mtx-1/init.c                   |    2 +-
 arch/mips/alchemy/xxs1500/board_setup.c          |   11 +-
 arch/mips/alchemy/xxs1500/init.c                 |    2 +-
 arch/mips/boot/compressed/uart-alchemy.c         |    2 +-
 arch/mips/include/asm/mach-au1x00/au1000.h       |  334 +++++----------------
 arch/mips/include/asm/mach-au1x00/au1000_dma.h   |    4 -
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |    8 -
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h  |  122 +++++++--
 drivers/watchdog/mtx-1_wdt.c                     |   21 +-
 21 files changed, 615 insertions(+), 690 deletions(-)

-- 
1.7.5.rc3
