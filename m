Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2016 10:52:56 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40066 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006822AbcCFJwywWfzB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 Mar 2016 10:52:54 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u269qs3i024016;
        Sun, 6 Mar 2016 10:52:54 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u269qrII024015;
        Sun, 6 Mar 2016 10:52:53 +0100
Date:   Sun, 6 Mar 2016 10:52:53 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mips@linux-mips.org
Subject: MIPS: Pull request
Message-ID: <20160306095253.GA24012@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52474
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

The following changes since commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

  Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)

are available in the git repository at:

  git://git.linux-mips.org/pub/scm/ralf/upstream-linus.git upstream

for you to fetch changes up to e723e3f7f9591b79e8c56b3d7c5a204a9c571b55:

  MIPS: traps: Fix SIGFPE information leak from `do_ov' and `do_trap_or_bp' (2016-03-04 22:52:32 +0100)

Another round of fixes for 4.5:

 - Fix the use of an undocumented syntactial variant of the .type pseudo
   op which is not supported by the LLVM assembler.
 - Fix invalid initialization on S-cache-less systems.
 - Fix possible information leak from the kernel stack for SIGFPE.
 - Fix handling of copy_{from,to}_user() return value in KVM
 - Fix the last instance of irq_to_gpio() which now was causing build
   errors.

Please consider pulling,

  Ralf

----------------------------------------------------------------

This has been sitting in linux-next for a few days and also survived
Imagination's test farm.

Daniel Sanders (1):
      MIPS: Avoid variant of .type unsupported by LLVM Assembler

Govindraj Raja (1):
      MIPS: scache: Fix scache init with invalid line size.

Maciej W. Rozycki (1):
      MIPS: traps: Fix SIGFPE information leak from `do_ov' and `do_trap_or_bp'

Michael S. Tsirkin (1):
      MIPS: kvm: Fix ioctl error handling.

Ralf Baechle (1):
      MIPS: jz4740: Fix surviving instance of irq_to_gpio()

 arch/mips/jz4740/gpio.c      |  2 +-
 arch/mips/kernel/r2300_fpu.S |  2 +-
 arch/mips/kernel/r4k_fpu.S   |  2 +-
 arch/mips/kernel/traps.c     | 13 ++++++-------
 arch/mips/kvm/mips.c         |  4 ++--
 arch/mips/mm/sc-mips.c       | 13 +++++++++----
 6 files changed, 20 insertions(+), 16 deletions(-)
