Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2012 14:18:21 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:59878 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823115Ab2J1NSUnby0y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Oct 2012 14:18:20 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so1441542bkw.36
        for <multiple recipients>; Sun, 28 Oct 2012 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wuKQcNTt4wzZhcmcYl3vXObouf6DUy8fxoxLnXJs6Ko=;
        b=ubt8N8D8KRBsGBVQGyZyTQcAk1ud0xHZ4mUn41903wbQBC0dOZsvf+MQyFttH/Y+Ew
         zLKueU3ayvj0Au+sncMgGoR2269dH4eYqS+wUDYcwk91Vmsk10pwZ+Cz94IfauGPe+pP
         4RqgYglhFMQlCT9hHyFWTY90vQgtrYRGiKDxkQc4r//uRWAyW3LagLijXbMOhOKPNM1s
         9exjW2EaqTbC3lKelgJVb27ryfNSYbBeTYEVTpbNFKPzPqmfISlaxW8j8dbFGVYpIZtV
         h6nDQp1VBLKPBflVgQ/T/UxskUF956pvjbdrV8HsWaIUNkVSwedJ0ns4WD6m67vCTM3k
         R65Q==
Received: by 10.204.11.79 with SMTP id s15mr6216175bks.136.1351430295296;
        Sun, 28 Oct 2012 06:18:15 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id j24sm2575695bkv.0.2012.10.28.06.18.13
        (version=SSLv3 cipher=OTHER);
        Sun, 28 Oct 2012 06:18:14 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 0/3] add a reset helper for resetting cores
Date:   Sun, 28 Oct 2012 14:17:52 +0100
Message-Id: <1351430275-14509-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 34783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patchset adds a reset helper to abstract out resetting the
different cores found on BCM63XX SoCs and adds proper locking to prevent
concurrent access to the softreset register.

This patchset technically depends on the pcie clock patch, but git am -3
manages to merge it automatically and correctly if it isn't applied.
There is no real dependency on the other patch.

Jonas Gorski (3):
  MIPS: BCM63XX: add softreset register description for BCM6358
  MIPS: BCM63XX: add core reset helper
  MIPS: BCM63XX: use the new reset helper

 arch/mips/bcm63xx/Makefile                         |    6 +-
 arch/mips/bcm63xx/clk.c                            |   19 +--
 arch/mips/bcm63xx/reset.c                          |  223 ++++++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |   10 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_reset.h |   21 ++
 arch/mips/pci/pci-bcm63xx.c                        |   19 +--
 6 files changed, 268 insertions(+), 30 deletions(-)
 create mode 100644 arch/mips/bcm63xx/reset.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_reset.h

-- 
1.7.2.5
