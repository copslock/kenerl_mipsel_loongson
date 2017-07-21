Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 16:11:09 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:54501 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992974AbdGUOLCgI3NG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 16:11:02 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 733331A49F7;
        Fri, 21 Jul 2017 16:10:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 1D7DE1A49EE;
        Fri, 21 Jul 2017 16:10:55 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 00/16] MIPS: Miscellaneous fixes related to Android Mips emulator
Date:   Fri, 21 Jul 2017 16:08:58 +0200
Message-Id: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

v2->v3:

    - added a patch that fixes clobber lists in vdso fallback cases
    - added 6 patches related to MIN/MINA/MAX/MAXA issues
    - added 6 patches related to MADDF/MSUBDF issues
    - enhanced logic and comments in patch on multitouch
    - fixed a number of minor spelling and format mistakes in code
        comments and commit messages
    - several patches removed since they got integrated into the tree
    - order of patches changed to better reflect similarity
    - rebased to the latest kernel code

v1->v2:

    - the patch on PREF usage in memcpy dropped as not needed
    - updated recipient lists using get_maintainer.pl
    - rebased to the latest kernel code

This series contains an assortment of changes necessary for proper
operation of Android emulator for Mips. However, we think that wider
kernel community may benefit from them too.

Aleksandar Markovic (10):
  MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix quiet NaN propagation
  MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix cases of both inputs
    zero
  MIPS: math-emu: <MAX|MIN>.<D|S>: Fix cases of both inputs negative
  MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases of input values with
    opposite signs
  MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases of both infinite inputs
  MIPS: math-emu: MINA.<D|S>: Fix some cases of infinity and zero inputs
  MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix NaN propagation
  MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some cases of infinite inputs
  MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some cases of zero inputs
  MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Clean up maddf_flags enumeration

Douglas Leung (2):
  MIPS: math-emu: <MADDF|MSUBF>.S: Fix accuracy (32-bit case)
  MIPS: math-emu: <MADDF|MSUBF>.D: Fix accuracy (64-bit case)

Goran Ferenc (1):
  MIPS: VDSO: Fix clobber lists in fallback code paths

Lingfeng Yang (1):
  input: goldfish: Fix multitouch event handling

Miodrag Dinic (2):
  tty: goldfish: Use streaming DMA for r/w operations on Ranchu
    platforms
  tty: goldfish: Implement support for kernel 'earlycon' parameter

 arch/mips/math-emu/dp_fmax.c             |  61 +++++---
 arch/mips/math-emu/dp_fmin.c             |  63 +++++---
 arch/mips/math-emu/dp_maddf.c            | 237 +++++++++++++++++++------------
 arch/mips/math-emu/ieee754int.h          |   4 +
 arch/mips/math-emu/ieee754sp.h           |   4 +
 arch/mips/math-emu/sp_fmax.c             |  61 +++++---
 arch/mips/math-emu/sp_fmin.c             |  62 +++++---
 arch/mips/math-emu/sp_maddf.c            | 221 +++++++++++++---------------
 arch/mips/vdso/gettimeofday.c            |   6 +-
 drivers/input/keyboard/goldfish_events.c |  35 ++++-
 drivers/tty/Kconfig                      |   3 +
 drivers/tty/goldfish.c                   | 145 +++++++++++++++++--
 12 files changed, 596 insertions(+), 306 deletions(-)

-- 
2.7.4
