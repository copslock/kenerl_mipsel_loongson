Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2012 00:55:16 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:33038 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831642Ab2LDXzOf6xjP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Dec 2012 00:55:14 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id qB4Nsn3d014708;
        Tue, 4 Dec 2012 15:54:54 -0800
X-WSS-ID: 0MEJ6FB-01-0OY-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2F0A1364674;
        Tue,  4 Dec 2012 15:54:46 -0800 (PST)
Received: from fun-lab.mips.com (192.168.52.61) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Tue, 4 Dec 2012
 15:54:45 -0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>, <macro@linux-mips.org>, <john@phrozen.org>
CC:     <dczhu@mips.com>
Subject: [PATCH v3 0/5] MIPS: enable APRP (APSP) and add features - v3
Date:   Tue, 4 Dec 2012 15:54:27 -0800
Message-ID: <1354665272-22759-1-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: 2FKDBYOVYDJsx4RzA450JA==
X-archive-position: 35178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
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
CodeSourcery tools instead of the old SDE tools were used to build the
example.

Changes:
v3 - v2:
o Split CMP/MT flavors into different files -cmp/-mt.
o Put Malta needed changes into a separate patch.
o Code style adjustments in rtlx/vpe files.
o Remove kspd.h which might have been left out in Ralf's kspd removal.
v2 - v1:
o Rebase the patches to the latest kernel, and fix a bunch of warnings and
  errors reported by the current scripts/checkpatch.pl.
o Add MIPS_MALTA dependency to Kconfig since modifications of Malta files
  are needed. But it should be easy to port changes to other platforms.

Deng-Cheng Zhu (5):
  MIPS: APRP (APSP): fix/enrich functionality
  MIPS: APRP (APSP): split vpe-loader and rtlx into cmp/mt flavors
  MIPS: APRP (APSP): remove kspd.h
  MIPS: let amon_cpu_start() report results
  MIPS: APRP (APSP): malta board support

 arch/mips/Kconfig                                  |    9 +
 arch/mips/include/asm/amon.h                       |    2 +-
 arch/mips/include/asm/kspd.h                       |   32 -
 .../include/asm/mach-malta/cpu-feature-overrides.h |    3 +
 arch/mips/include/asm/rtlx.h                       |   45 +-
 arch/mips/include/asm/vpe.h                        |  118 +++-
 arch/mips/kernel/Makefile                          |    9 +-
 arch/mips/kernel/rtlx-cmp.c                        |  125 +++
 arch/mips/kernel/rtlx-mt.c                         |  160 ++++
 arch/mips/kernel/rtlx.c                            |  205 +----
 arch/mips/kernel/vpe-cmp.c                         |  202 +++++
 arch/mips/kernel/vpe-mt.c                          |  534 +++++++++++++
 arch/mips/kernel/vpe.c                             |  815 +++-----------------
 arch/mips/mti-malta/malta-amon.c                   |    8 +-
 arch/mips/mti-malta/malta-int.c                    |   22 +-
 15 files changed, 1351 insertions(+), 938 deletions(-)
 delete mode 100644 arch/mips/include/asm/kspd.h
 create mode 100644 arch/mips/kernel/rtlx-cmp.c
 create mode 100644 arch/mips/kernel/rtlx-mt.c
 create mode 100644 arch/mips/kernel/vpe-cmp.c
 create mode 100644 arch/mips/kernel/vpe-mt.c
