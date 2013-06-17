Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 16:01:38 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:32336 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818472Ab3FQOBcfpjyz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jun 2013 16:01:32 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/7] MIPS: sibyte build fixes
Date:   Mon, 17 Jun 2013 15:00:34 +0100
Message-ID: <1371477641-7989-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_17_15_01_27
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The following patches aim to fix multiple build problems on 
sibyte. These patches should be applied to the
upstream-sfr/mips-for-linux-next tree.

Markos Chandras (7):
  MIPS: sibyte: Fix build for SIBYTE_BW_TRACE
  MIPS: sibyte: Declare the cfe_write() buffer as constant
  MIPS: sibyte: Add missing sched.h header
  MIPS: sibyte: Amend dependencies for SIBYTE_BUS_WATCHER
  drivers: watchdog: sb_wdog: Fix 32bit linking problems
  drivers: ssb: Kconfig: Amend SSB_EMBEDDED dependencies
  MIPS: sibyte: Remove unused variable.

 arch/mips/fw/cfe/cfe_api.c             | 4 ++--
 arch/mips/include/asm/fw/cfe/cfe_api.h | 4 ++--
 arch/mips/mm/cerr-sb1.c                | 2 +-
 arch/mips/sibyte/Kconfig               | 3 ++-
 arch/mips/sibyte/common/sb_tbprof.c    | 1 +
 arch/mips/sibyte/sb1250/bus_watcher.c  | 3 ---
 drivers/ssb/Kconfig                    | 2 +-
 drivers/watchdog/sb_wdog.c             | 5 ++++-
 8 files changed, 13 insertions(+), 11 deletions(-)

-- 
1.8.2.1
