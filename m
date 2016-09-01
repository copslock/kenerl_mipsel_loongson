Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 22:44:16 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:42590 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992257AbcIAUoKFv4BN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 22:44:10 +0200
Received: from localhost.localdomain (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 46C0D40EA;
        Thu,  1 Sep 2016 23:44:09 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/6] MIPS: OCTEON: clean up platform phy code
Date:   Thu,  1 Sep 2016 23:43:54 +0300
Message-Id: <20160901204400.16562-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

Some phy/mdio code can be deleted from platform code. Let's do it.

Aaro Koskinen (6):
  MIPS: OCTEON: delete legacy hack for broken bootloaders
  MIPS: OCTEON: don't try to maintain link state in early init
  MIPS: OCTEON: delete cvmx_override_board_link_get
  MIPS: OCTEON: delete cvmx_helper_board_link_set_phy
  MIPS: OCTEON: delete legacy code for PHY access
  MIPS: OCTEON: delete unused cvmx-mdio.h

 .../cavium-octeon/executive/cvmx-helper-board.c    | 337 +-------------
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |   5 +-
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   1 -
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |   2 -
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |  10 -
 arch/mips/include/asm/octeon/cvmx-helper-board.h   |  30 --
 arch/mips/include/asm/octeon/cvmx-mdio.h           | 506 ---------------------
 7 files changed, 5 insertions(+), 886 deletions(-)
 delete mode 100644 arch/mips/include/asm/octeon/cvmx-mdio.h

-- 
2.9.2
