Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Feb 2013 23:52:18 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:49917 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823690Ab3BEWwRlwsWj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Feb 2013 23:52:17 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1U2rN2-0008Ky-3q; Tue, 05 Feb 2013 16:52:08 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org,
        cernekee@gmail.com, kevink@paralogos.com, ddaney.cavm@gmail.com
Subject: [PATCH 0/4] Add support for microMIPS instructions
Date:   Tue,  5 Feb 2013 16:51:59 -0600
Message-Id: <1360104723-29529-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35708
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

These patches add support for the microMIPS ISA. The kernel can
simultaneously support classic and microMIPS instructions using
the micro assembler. All microMIPS instructions for the micro
assembler have the 'MM_' prefix.

Steven J. Hill (4):
  MIPS: microMIPS: Add instruction formats.
  MIPS: microMIPS: uasm: Split 'uasm.c' into two files.
  MIPS: microMIPS: uasm: Add microMIPS micro assembler support.
  MIPS: microMIPS: Add instruction utility macros.

 arch/mips/Kconfig                 |    4 +
 arch/mips/include/asm/mipsregs.h  |   18 ++
 arch/mips/include/asm/uasm.h      |   66 ++++--
 arch/mips/include/uapi/asm/inst.h |  449 +++++++++++++++++++++++++++++++++++++
 arch/mips/mm/Makefile             |    4 +-
 arch/mips/mm/uasm-micromips.c     |  220 ++++++++++++++++++
 arch/mips/mm/uasm-mips.c          |  196 ++++++++++++++++
 arch/mips/mm/uasm.c               |  326 +++++++--------------------
 8 files changed, 1010 insertions(+), 273 deletions(-)
 create mode 100644 arch/mips/mm/uasm-micromips.c
 create mode 100644 arch/mips/mm/uasm-mips.c

-- 
1.7.9.5
