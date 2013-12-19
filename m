Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2013 22:11:46 +0100 (CET)
Received: from seketeli.net ([91.121.166.71]:40845 "EHLO ms.seketeli.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867278Ab3LSVLoOtKxg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Dec 2013 22:11:44 +0100
Received: from localhost (176-26-190-109.dsl.ovh.fr [109.190.26.176])
        by ms.seketeli.net (Postfix) with ESMTP id 2A7C5EA075;
        Thu, 19 Dec 2013 22:46:45 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
        id 17AD4A405B1; Thu, 19 Dec 2013 22:11:43 +0100 (CET)
From:   Apelete Seketeli <apelete@seketeli.net>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] Update platform data for JZ4740 usb device controller
Date:   Thu, 19 Dec 2013 22:11:42 +0100
Message-Id: <1387487503-26161-1-git-send-email-apelete@seketeli.net>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <apelete@seketeli.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apelete@seketeli.net
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

Hello,

Following a few patches sent to the linux-usb mailing list to add USB
support for the Ingenic JZ4740 MIPS SoC found in the Ben Nanonote,
here is a patch that updates platform data for JZ4740 usb device
controller.

The patch that comes as a follow-up of this message was originally
part of the patch set sent to linux-usb but was split out to separate
arch/ from drivers/ files.

Changes were rebased on top of Ralf Baechle's Linux MIPS master
branch, built and tested on device successfully.

The following changes since commit a9b7663:

  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux

are available in the git repository at:

  git://seketeli.fr/~apelete/linux-mips.git update-jz4740-arch

Apelete Seketeli (1):
  arch: mips: update platform data for JZ4740 usb device controller

 arch/mips/include/asm/mach-jz4740/platform.h |    1 +
 arch/mips/jz4740/board-qi_lb60.c             |    1 +
 arch/mips/jz4740/platform.c                  |   40 +++++++++++++++-----------
 3 files changed, 26 insertions(+), 16 deletions(-)

-- 
1.7.10.4
