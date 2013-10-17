Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2013 04:14:47 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:52408 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817906Ab3JQCOpcEEl5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Oct 2013 04:14:45 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VWd6j-00047p-N9; Wed, 16 Oct 2013 21:14:37 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH 0/6] MIPS: APRP: Enable APRP for platforms with a CM.
Date:   Wed, 16 Oct 2013 21:14:24 -0500
Message-Id: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

The APRP model makes it possible that one or more CPUs to run the
Linux kernel and a dedicated CPU runs a special real-time or signal
processing program.

This patchset adds the following to the current APRP support:
1. Add CM and multicore APRP support.
2. Several bug fixes.
3. Running floating point heavy jobs on the RP side.
4. Waking up the RP side read by interrupt.

Deng-Cheng Zhu (5):
  MIPS: APRP: Split VPE loader into separate files.
  MIPS: APRP: Add VPE loader support for CMP platforms.
  MIPS: APRP: Split RTLX support into separate files.
  MIPS: APRP: Add RTLX API support for CMP platforms.
  MIPS: APRP: Malta Add support for Malta CMP platform.

Steven J. Hill (1):
  MIPS: APRP: Code formatting clean-ups.

 arch/mips/include/asm/amon.h     |   15 +-
 arch/mips/include/asm/rtlx.h     |   49 ++-
 arch/mips/include/asm/vpe.h      |  136 +++++-
 arch/mips/kernel/Makefile        |    4 +-
 arch/mips/kernel/rtlx-cmp.c      |  120 +++++
 arch/mips/kernel/rtlx-mt.c       |  152 +++++++
 arch/mips/kernel/rtlx.c          |  275 +++---------
 arch/mips/kernel/vpe-cmp.c       |  184 ++++++++
 arch/mips/kernel/vpe-mt.c        |  527 ++++++++++++++++++++++
 arch/mips/kernel/vpe.c           |  893 ++++++--------------------------------
 arch/mips/mti-malta/malta-amon.c |   48 +-
 arch/mips/mti-malta/malta-int.c  |  127 +++---
 12 files changed, 1435 insertions(+), 1095 deletions(-)
 create mode 100644 arch/mips/kernel/rtlx-cmp.c
 create mode 100644 arch/mips/kernel/rtlx-mt.c
 create mode 100644 arch/mips/kernel/vpe-cmp.c
 create mode 100644 arch/mips/kernel/vpe-mt.c

-- 
1.7.9.5
