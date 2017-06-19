Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:56:38 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58908 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993898AbdFSPuY45LSH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:50:24 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 8A63E1A45D1;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 6AB5F1A2452;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 0/8] MIPS: Miscellaneous fixes related to Android Mips emulator
Date:   Mon, 19 Jun 2017 17:50:07 +0200
Message-Id: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58626
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

This series contains an assortment of changes necessary for proper
operation of Android emulator for Mips. However, we think that wider
kernel community may benefit from them too.

Aleksandar Markovic (1):
  MIPS: math-emu: Handle zero accumulator case in MADDF and MSUBF
    separately

Leonid Yegoshin (1):
  MIPS: R6: Fix PREF instruction usage by memcpy for MIPS R6

Lingfeng Yang (1):
  input: goldfish: Fix multitouch event handling

Miodrag Dinic (5):
  MIPS: cmdline: Add support for 'memmap' parameter
  MIPS: build: Fix "-modd-spreg" switch usage when compiling for
    mips32r6
  MIPS: unaligned: Add DSP lwx & lhx missaligned access support
  tty: goldfish: Use streaming DMA for r/w operations on Ranchu
    platforms
  tty: goldfish: Implement support for kernel 'earlycon' parameter

 arch/mips/Makefile                       |   2 +-
 arch/mips/include/uapi/asm/inst.h        |  11 ++
 arch/mips/kernel/setup.c                 |  40 +++++++
 arch/mips/kernel/unaligned.c             | 174 ++++++++++++++++++-------------
 arch/mips/lib/memcpy.S                   |   3 +
 arch/mips/math-emu/dp_maddf.c            |   5 +-
 arch/mips/math-emu/sp_maddf.c            |   5 +-
 drivers/input/keyboard/goldfish_events.c |  33 +++++-
 drivers/tty/Kconfig                      |   3 +
 drivers/tty/goldfish.c                   | 145 ++++++++++++++++++++++++--
 10 files changed, 332 insertions(+), 89 deletions(-)

-- 
2.7.4
