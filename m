Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 10:51:48 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:53429 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903636Ab2EQIvm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 May 2012 10:51:42 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4H8pYsA011012;
        Thu, 17 May 2012 01:51:34 -0700
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Thu, 17 May 2012
 01:51:29 -0700
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>
CC:     <dczhu@mips.com>
Subject: [PATCH v2 0/2] MIPS: enable APRP (APSP) and add features - v2
Date:   Thu, 17 May 2012 16:51:18 +0800
Message-ID: <1337244680-29968-1-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: kcEr5tH91B7H6nUerQJh0A==
X-archive-position: 33338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The APRP model makes it possible that one or more CPUs run the Linux
kernel whereas a dedicated CPU runs special real-time or signal processing
program.

This patchset adds the following to the current APRP support:
1. Several bug fixes;
2. Running floating point heavy jobs on the RP side;
3. Waking up RP side read by interrupt;
4. CPS multicore APRP support.

A mp3 player program was ported to run in the APRP (APSP exactly) model.
Considerable performance benefits were observed on the player program.

Changes:
v2 - v1:
o Rebase the patches to the latest kernel, and fix a bunch of warnings and
  errors reported by the current scripts/checkpatch.pl.
o Add MIPS_MALTA dependency to Kconfig since modifications of Malta files
  are needed. But it should be easy to port changes to other platforms.

Deng-Cheng Zhu (2):
  MIPS: fix/enrich 34K APRP (APSP) functionalities
  MIPS: enable CPS multicore APRP (APSP)

 arch/mips/Kconfig                                  |   10 +-
 .../include/asm/mach-malta/cpu-feature-overrides.h |    3 +
 arch/mips/include/asm/rtlx.h                       |    5 +
 arch/mips/kernel/kspd.c                            |   26 ++-
 arch/mips/kernel/rtlx.c                            |  183 ++++++++++++--
 arch/mips/kernel/vpe.c                             |  255 ++++++++++++++++++--
 arch/mips/mti-malta/malta-int.c                    |   29 +++-
 7 files changed, 453 insertions(+), 58 deletions(-)
