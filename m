Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:21:03 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60391 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823707Ab2LGFVB4QUQA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:21:01 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TgqMp-0007Pp-6G; Thu, 06 Dec 2012 23:20:55 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 0/4] Add environment variable processing to firmware library.
Date:   Thu,  6 Dec 2012 23:20:45 -0600
Message-Id: <1354857649-29224-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35229
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

Update firmware library functionality to do environment variable
processing. Updates the Malta and SEAD-3 platforms to use the new
functionality.

Steven J. Hill (4):
  MIPS: FW: Add environment variable processing.
  MIPS: sead3: Use new common FW library variable processing.
  MIPS: malta: Use new common FW library variable processing.
  MIPS: malta: Code clean-ups.

 arch/mips/fw/lib/Makefile                   |    2 +
 arch/mips/fw/lib/cmdline.c                  |  101 ++++++++++++++++++
 arch/mips/include/asm/fw/fw.h               |   47 ++++++++
 arch/mips/include/asm/mips-boards/generic.h |    1 +
 arch/mips/include/asm/mips-boards/prom.h    |   49 ---------
 arch/mips/mti-malta/Makefile                |    5 +-
 arch/mips/mti-malta/malta-cmdline.c         |   59 -----------
 arch/mips/mti-malta/malta-display.c         |   40 +++----
 arch/mips/mti-malta/malta-init.c            |  153 ++++++---------------------
 arch/mips/mti-malta/malta-memory.c          |  104 ++++++------------
 arch/mips/mti-malta/malta-setup.c           |   24 ++---
 arch/mips/mti-malta/malta-time.c            |    1 -
 arch/mips/mti-sead3/Makefile                |    8 +-
 arch/mips/mti-sead3/sead3-cmdline.c         |   46 --------
 arch/mips/mti-sead3/sead3-console.c         |    2 +-
 arch/mips/mti-sead3/sead3-display.c         |    1 -
 arch/mips/mti-sead3/sead3-init.c            |   82 +++++++-------
 arch/mips/mti-sead3/sead3-time.c            |    1 -
 18 files changed, 296 insertions(+), 430 deletions(-)
 create mode 100644 arch/mips/fw/lib/cmdline.c
 create mode 100644 arch/mips/include/asm/fw/fw.h
 delete mode 100644 arch/mips/include/asm/mips-boards/prom.h
 delete mode 100644 arch/mips/mti-malta/malta-cmdline.c
 delete mode 100644 arch/mips/mti-sead3/sead3-cmdline.c

-- 
1.7.9.5
