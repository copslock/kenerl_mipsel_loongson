Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 15:27:24 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:53703 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012336AbbHMNZBM4UdC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 15:25:01 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7DDOdDZ009680
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Aug 2015 13:24:40 GMT
Received: from localhost.localdomain ([10.144.34.184])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t7DDObQJ030804;
        Thu, 13 Aug 2015 15:24:38 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Janne Huttunen <janne.huttunen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 00/14] MIPS/staging: OCTEON: enable ethernet/xaui on CN68XX
Date:   Thu, 13 Aug 2015 16:21:32 +0300
Message-Id: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 2264
X-purgate-ID: 151667::1439472280-0000676C-E2CA2B35/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

Currently mainline Linux is unusable on OCTEON II CN68XX SOCs due to
issues in Ethernet driver initialization. Some boards are hanging during
init, and all the needed register differences compared to the older SOCs
are not taken into account to make interrupts and packet delivery to work.

This patch set provides a minimal support to get octeon-ethernet going
on CN68XX. Tested on top of 4.2-rc6 with Cavium EBB6800 and Kontron
S1901 boards by sending traffic over XAUI interface with busybox.

A.

Aaro Koskinen (2):
  MIPS/staging: OCTEON: properly enable/disable SSO WQE interrupts
  MIPS/staging: OCTEON: set SSO group mask properly on CN68XX

Janne Huttunen (12):
  MIPS: OCTEON: fix CN6880 hang on XAUI init
  MIPS: OCTEON: support additional interfaces on CN68XX
  MIPS: OCTEON: support all PIP input ports on CN68XX
  MIPS: OCTEON: configure XAUI pkinds
  MIPS: OCTEON: configure minimum PKO packet sizes on CN68XX
  MIPS: OCTEON: add definitions for setting up SSO
  MIPS/staging: OCTEON: increase output command buffers
  MIPS/staging: OCTEON: support CN68XX style WQE
  MIPS: OCTEON: initialize CN68XX PKO
  MIPS: OCTEON: set up 1:1 mapping between CN68XX PKO queues and ports
  MIPS: OCTEON: support interfaces 4 and 5
  MIPS/staging: OCTEON: use common helpers for determining interface and
    port

 .../cavium-octeon/executive/cvmx-helper-util.c     |  20 +-
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |  14 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |  17 ++
 arch/mips/cavium-octeon/executive/cvmx-pko.c       | 149 +++++++++-
 arch/mips/include/asm/octeon/cvmx-pip.h            |   2 +-
 arch/mips/include/asm/octeon/cvmx-pko.h            |   3 +
 arch/mips/include/asm/octeon/cvmx-pow-defs.h       |  29 ++
 arch/mips/include/asm/octeon/cvmx-pow.h            |   9 +-
 arch/mips/include/asm/octeon/cvmx-wqe.h            | 308 +++++++++++++++++----
 drivers/staging/octeon/ethernet-rx.c               | 133 ++++++---
 drivers/staging/octeon/ethernet-tx.c               |  19 +-
 drivers/staging/octeon/ethernet-util.h             |  22 +-
 drivers/staging/octeon/ethernet.c                  |   7 +-
 13 files changed, 595 insertions(+), 137 deletions(-)

-- 
2.4.3
