Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Mar 2016 17:49:05 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60290 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008301AbcCMQtCtOpnL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Mar 2016 17:49:02 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2DGn1im021204;
        Sun, 13 Mar 2016 17:49:01 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2DGn1OO021203;
        Sun, 13 Mar 2016 17:49:01 +0100
Date:   Sun, 13 Mar 2016 17:49:01 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mips@linux-mips.org
Subject: MIPS: Pull request
Message-ID: <20160313164900.GA21200@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52573
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

The following changes since commit f6cede5b49e822ebc41a099fe41ab4989f64e2cb:

  Linux 4.5-rc7 (2016-03-06 14:48:03 -0800)

are available in the git repository at:

  git://git.linux-mips.org/pub/scm/ralf/upstream-linus.git upstream

for you to fetch changes up to d825c06bfe8b885b797f917ad47365d0e9c21fbb:

  MIPS: smp.c: Fix uninitialised temp_foreign_map (2016-03-13 10:59:19 +0100)

Another round of MIPS fixes for 4.5:

 - Fix JZ4780 build with DEBUG_ZBOOT and MACH_JZ4780
 - Fix build with DEBUG_ZBOOT and MACH_JZ4780
 - Fix issue with uninitialised temp_foreign_map
 - Fix awk regex compile failure with certain versions of awk.  At this
   time, the sole user, ld-ifversion, is only used on MIPS.

Please consider pulling.

  Ralf

----------------------------------------------------------------

As usual these patches have survived individual testing and Imagination's
automated test farm and they're also sitting on my queue for linux-next.

Aaro Koskinen (1):
      MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4780

Hauke Mehrtens (1):
      MIPS: Fix build error when SMP is used without GIC

James Hogan (2):
      ld-version: Fix awk regex compile failure
      MIPS: smp.c: Fix uninitialised temp_foreign_map

 arch/mips/Kconfig                      | 7 ++++---
 arch/mips/boot/compressed/uart-16550.c | 2 +-
 arch/mips/kernel/smp.c                 | 1 +
 scripts/ld-version.sh                  | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)
