Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2012 00:11:12 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43478 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903565Ab2E3WLH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2012 00:11:07 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SZr6b-00012l-27; Wed, 30 May 2012 17:11:01 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 0/5] Add explicit support YAMON firmware.
Date:   Wed, 30 May 2012 17:10:50 -0500
Message-Id: <1338415855-11401-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

YAMON support was implemented differently across a number of
platforms. This change removes duplicated code and moves all
of the YAMON firmware support into a single library.

Steven J. Hill (5):
  MIPS: Add initial support for YAMON firmware.
  MIPS: Clean up YAMON support for Alchemy platforms.
  MIPS: Clean up YAMON support for PowerTV platform.
  MIPS: Clean up YAMON support for PMC Sierra platforms.
  MIPS: Clean up YAMON support for MIPS Malta and SEAD-3 platforms.

 arch/mips/Kconfig                                  |    8 ++
 arch/mips/Makefile                                 |    1 +
 arch/mips/alchemy/board-gpr.c                      |    2 +-
 arch/mips/alchemy/board-mtx1.c                     |    2 +-
 arch/mips/alchemy/board-xxs1500.c                  |    2 +-
 arch/mips/alchemy/common/prom.c                    |   39 ----------
 arch/mips/alchemy/devboards/prom.c                 |    2 +-
 arch/mips/fw/yamon/Makefile                        |    5 ++
 arch/mips/fw/yamon/cmdline.c                       |   68 ++++++++++++++++
 arch/mips/include/asm/fw/yamon/yamon.h             |   53 +++++++++++++
 arch/mips/include/asm/mach-au1x00/prom.h           |   12 ---
 arch/mips/include/asm/mips-boards/generic.h        |   41 ++++------
 arch/mips/include/asm/mips-boards/prom.h           |   47 -----------
 arch/mips/include/asm/mipsprom.h                   |    2 -
 .../mips/include/asm/pmc-sierra/msp71xx/msp_prom.h |   26 -------
 arch/mips/mti-malta/Makefile                       |    2 +-
 arch/mips/mti-malta/malta-cmdline.c                |   59 --------------
 arch/mips/mti-malta/malta-display.c                |    2 +-
 arch/mips/mti-malta/malta-init.c                   |   82 +-------------------
 arch/mips/mti-malta/malta-memory.c                 |   10 +--
 arch/mips/mti-malta/malta-setup.c                  |   16 ++--
 arch/mips/mti-malta/malta-time.c                   |    3 +-
 arch/mips/pmc-sierra/msp71xx/msp_prom.c            |   76 +-----------------
 arch/mips/pmc-sierra/msp71xx/msp_setup.c           |    2 +-
 arch/mips/powertv/init.c                           |   37 ---------
 25 files changed, 174 insertions(+), 425 deletions(-)
 create mode 100644 arch/mips/fw/yamon/Makefile
 create mode 100644 arch/mips/fw/yamon/cmdline.c
 create mode 100644 arch/mips/include/asm/fw/yamon/yamon.h
 delete mode 100644 arch/mips/include/asm/mach-au1x00/prom.h
 delete mode 100644 arch/mips/include/asm/mips-boards/prom.h
 delete mode 100644 arch/mips/mti-malta/malta-cmdline.c

-- 
1.7.10
