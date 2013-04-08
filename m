Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Apr 2013 18:53:21 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:1381 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822429Ab3DHQxQOMoP3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Apr 2013 18:53:16 +0200
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>, <macro@linux-mips.org>, <john@phrozen.org>
CC:     <Steven.Hill@imgtec.com>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v4 0/5] MIPS: enable APRP (APSP) and add features - v4
Date:   Mon, 8 Apr 2013 09:52:57 -0700
Message-ID: <1365439982-4117-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01181__2013_04_08_17_53_10
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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
v4 - v3:
o Rebase onto HEAD of master (3.9-rc6 as of now).
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
 arch/mips/include/asm/rtlx.h                       |   47 +-
 arch/mips/include/asm/vpe.h                        |  117 +++-
 arch/mips/kernel/Makefile                          |    9 +-
 arch/mips/kernel/rtlx-cmp.c                        |  126 ++++
 arch/mips/kernel/rtlx-mt.c                         |  161 +++++
 arch/mips/kernel/rtlx.c                            |  203 ++-----
 arch/mips/kernel/vpe-cmp.c                         |  203 ++++++
 arch/mips/kernel/vpe-mt.c                          |  526 ++++++++++++++
 arch/mips/kernel/vpe.c                             |  732 ++------------------
 arch/mips/mti-malta/malta-amon.c                   |    8 +-
 arch/mips/mti-malta/malta-int.c                    |   21 +
 15 files changed, 1307 insertions(+), 892 deletions(-)
 delete mode 100644 arch/mips/include/asm/kspd.h
 create mode 100644 arch/mips/kernel/rtlx-cmp.c
 create mode 100644 arch/mips/kernel/rtlx-mt.c
 create mode 100644 arch/mips/kernel/vpe-cmp.c
 create mode 100644 arch/mips/kernel/vpe-mt.c
