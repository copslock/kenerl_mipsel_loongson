Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 20:22:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38185 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014030AbaKSTWSYeB8w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Nov 2014 20:22:18 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAJJMFmh018059;
        Wed, 19 Nov 2014 20:22:15 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAJJMEqG018058;
        Wed, 19 Nov 2014 20:22:14 +0100
Date:   Wed, 19 Nov 2014 20:22:14 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mips@linux-mips.org
Subject: MIPS: Pull request
Message-ID: <20141119192214.GH8625@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Hi Linus,

The following changes since commit 206c5f60a3d902bc4b56dab2de3e88de5eb06108:

  Linux 3.18-rc4 (2014-11-09 14:55:29 -0800)

are available in the git repository at:

  git://git.linux-mips.org/pub/scm/ralf/upstream-linus.git upstream

for you to fetch changes up to 935c2dbec4d6d3163ee8e7409996904a734ad89a:

  MIPS: jump_label.c: Handle the microMIPS J instruction encoding (2014-11-19 18:22:09 +0100)

More 3.18 fixes for MIPS:

 - Backtraces were not quite working on on 64-bit kernels
 - Loongson needs a different cache coherency setting
 - Loongson 3 is a MIPS64 R2 version but due to erratum we treat is an
   older architecture revision.
 - Fix build errors due to undefined references to __node_distances for
   certain configurations.
 - Fix instruction decodig in the jump label code.
 - For certain configurations copy_{from,to}_user destroy the content
   of $3 so that register needs to be marked as clobbed by the calling
   code.
 - Hardware Table Walker fixes.
 - Fill the delay slot of the last instruction of memcpy otherwise
   whatever ends up there randomly might have undesirable effects.
 - Ensure get_user/__get_user always zero the variable to be read even
   in case of an error.

Please consider pulling,

  Ralf

----------------------------------------------------------------
This has survived the usual torture by Imagination's build farm and
sat in -next.


Aaro Koskinen (1):
      MIPS: oprofile: Fix backtrace on 64-bit kernel

Huacai Chen (2):
      MIPS: Loongson: Fix the write-combine CCA value setting
      MIPS: Loongson: Set Loongson-3's ISA level to MIPS64R1

James Cowgill (2):
      MIPS: Loongson3: Fix __node_distances undefined error
      MIPS: IP27: Fix __node_distances undefined error

Maciej W. Rozycki (2):
      MIPS: jump_label.c: Correct the span of the J instruction
      MIPS: jump_label.c: Handle the microMIPS J instruction encoding

Markos Chandras (3):
      MIPS: asm: uaccess: Add v1 register to clobber list on EVA
      MIPS: tlb-r4k: Add missing HTW stop/start sequences
      MIPS: lib: memcpy: Restore NOP on delay slot before returning to caller

Ralf Baechle (1):
      MIPS: Zero variable read by get_user / __get_user in case of an error.

 arch/mips/include/asm/jump_label.h                 |  8 ++++-
 .../asm/mach-loongson/cpu-feature-overrides.h      |  2 --
 arch/mips/include/asm/uaccess.h                    | 12 ++++---
 arch/mips/kernel/cpu-probe.c                       |  7 ++--
 arch/mips/kernel/jump_label.c                      | 42 ++++++++++++++++------
 arch/mips/lib/memcpy.S                             |  1 +
 arch/mips/loongson/loongson-3/numa.c               |  1 +
 arch/mips/mm/tlb-r4k.c                             |  4 +++
 arch/mips/oprofile/backtrace.c                     |  2 +-
 arch/mips/sgi-ip27/ip27-memory.c                   |  1 +
 10 files changed, 60 insertions(+), 20 deletions(-)
