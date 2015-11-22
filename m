Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 16:50:13 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49804 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011492AbbKVPuIP7j4P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 16:50:08 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tAMFo78f019497;
        Sun, 22 Nov 2015 16:50:07 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tAMFo6It019496;
        Sun, 22 Nov 2015 16:50:06 +0100
Date:   Sun, 22 Nov 2015 16:50:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mips@linux-mips.org
Subject: MIPS: Pull request
Message-ID: <20151122155006.GA19323@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50049
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

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.linux-mips.org/pub/scm/ralf/upstream-linus.git upstream

for you to fetch changes up to 55f1d5988c52d481dc489e29ee5e8905b18ff859:

  MIPS: ath79: Add a machine entry for booting OF machines (2015-11-20 15:44:57 +0100)

MIPS fixes for 4.1:

 - Fix a flood of annoying build warnings
 - A number of fixes for Atheros 79xx platforms

Please consider pulling,

  Ralf

----------------------------------------------------------------
As usual this has sat in linux-next and survived Imagination's automated
build and test system.

Alban Bedel (3):
      MIPS: ath79: Fix the DDR control initialization on ar71xx and ar934x
      MIPS: ath79: Fix the size of the MISC INTC registers in ar9132.dtsi
      MIPS: ath79: Add a machine entry for booting OF machines

Ralf Baechle (1):
      MIPS: Fix flood of warnings about comparsion being always true.

 arch/mips/ath79/setup.c            | 7 ++++++-
 arch/mips/boot/dts/qca/ar9132.dtsi | 2 +-
 arch/mips/include/asm/page.h       | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)
