Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2011 23:31:59 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:48264 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491043Ab1EJVby (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2011 23:31:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 382108ACC;
        Tue, 10 May 2011 23:31:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aMCYqQXyZAaC; Tue, 10 May 2011 23:31:49 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-255-123.ewe-ip-backbone.de [91.97.255.123])
        by hauke-m.de (Postfix) with ESMTPSA id 1902B87E4;
        Tue, 10 May 2011 23:31:49 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 0/5] MIPS: BCM47xx: Enhancements in Parsing the NVRAM data
Date:   Tue, 10 May 2011 23:31:29 +0200
Message-Id: <1305063094-26656-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

The first 3 patches add the ability to provide an fallback sprom from 
the nvram when a card connected to the pci bus using a ssb bus itself 
has no own sprom. Then the ssb code now asks the architecture code for 
the data. In the bcm47xx architecture the sprom data is stored in the 
nvram for recent devices and they do not have an own sprom.
Patch #4 looks for some more values in the sprom. Boradcom changed the 
names of some attributes with sprom revision 4.
The last patch fixes the parsing of mac addresses on some devices.

There are still some checkpatch warnings about not using kstrto*. 
  WARNING: consider using kstrto* in preference to simple_strtoul
I will fix this in a later patch as there are many usages of simple_strtoul
in arch/mips/bcm47xx/setup.c.
    
v2: * fix some checkpatch errors and warnings
    * fix spelling issues    

Hauke Mehrtens (5):
  ssb: Change fallback sprom to callback mechanism.
  MIPS: BCM47xx: extend bcm47xx_fill_sprom with prefix.
  MIPS: BCM47xx: register ssb fallback sprom callback
  MIPS: BCM47xx: extend the filling of sprom from nvram
  MIPS: BCM47xx: Fix mac address parsing.

 arch/mips/bcm47xx/nvram.c                  |    3 +-
 arch/mips/bcm47xx/setup.c                  |  130 +++++++++++++++++++++++-----
 arch/mips/bcm63xx/boards/board_bcm963xx.c  |   16 +++-
 arch/mips/include/asm/mach-bcm47xx/nvram.h |   12 ++-
 drivers/ssb/pci.c                          |   16 +++-
 drivers/ssb/sprom.c                        |   43 ++++++----
 drivers/ssb/ssb_private.h                  |    3 +-
 include/linux/ssb/ssb.h                    |    4 +-
 8 files changed, 175 insertions(+), 52 deletions(-)

-- 
1.7.4.1
