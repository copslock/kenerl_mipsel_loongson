Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2015 13:13:31 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:36879 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010894AbbJLLN3gKsna (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Oct 2015 13:13:29 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 9F37128A675;
        Mon, 12 Oct 2015 13:11:49 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-016-160.088.073.pools.vodafone-ip.de [88.73.16.160])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A3946281070;
        Mon, 12 Oct 2015 13:11:33 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>
Subject: [PATCH V2 0/3]  MIPS: allow keeping the dtb command line
Date:   Mon, 12 Oct 2015 13:13:00 +0200
Message-Id: <1444648383-22518-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Currently MIPS kernel code overwrites any bootargs from devicetree
unconditionally with the arcscmdline. Several targets work around this
by copying the devicetree bootargs into the arcscmdline after parsing
the device tree.

This patchset adds a new kernel option for keeping the devicetree
bootargs, then removes the workarounds and lets the targets instead make
use of that option.

Since some targets use OF but don't make use of the devicetree bootargs,
treat them like non-OF enabled targets and only use the prom commandline.

Changes v1 -> v2:
 * Fix ATh79 -> ATH79

Jonas Gorski (3):
  MIPS: use USE_OF as the guard for appended dtb
  MIPS: make the kernel arguments from dtb available
  MIPS: make MIPS_CMDLINE_DTB default

 arch/mips/Kconfig           | 21 ++++++++++++++++++++-
 arch/mips/bmips/setup.c     |  1 -
 arch/mips/kernel/setup.c    | 24 +++++++++++++++++-------
 arch/mips/lantiq/prom.c     |  2 --
 arch/mips/netlogic/xlp/dt.c |  1 -
 arch/mips/pistachio/init.c  |  1 -
 arch/mips/ralink/of.c       |  2 --
 7 files changed, 37 insertions(+), 15 deletions(-)

-- 
2.1.4
