Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 00:48:30 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:57060 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011633AbbD0Ws21PppX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 00:48:28 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t3RMmJf7027493
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 27 Apr 2015 15:48:19 -0700 (PDT)
Received: from yow-lpgnfs-02.corp.ad.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.224.2; Mon, 27 Apr 2015 15:48:19 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 00/11] Delete new __cpuinit users and then delete stubs
Date:   Mon, 27 Apr 2015 18:47:49 -0400
Message-ID: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

We removed the __cpuinit stuff in 3.11-rc1 with commit 
22f0a27367742f65130c0fb25ef00f7297e032c1 ("init.h: remove __cpuinit
sections from the kernel") but we left some no-op stubs as
a courtesy to unmerged code.

Here we get rid of the stubs as well, since (as can be seen in these
changes) they are enabling use cases to sneak back in, primarily from
older BSP code that has been living out of tree for some time prior
to getting mainlined.  So we get rid of these "new" users 1st and
then get rid of the stubs.

Obviously, getting rid of the stubs can't happen until all the users
are gone, so this might as well stay together as a series.  I'll feed
it into linux-next once I've sent out some other pending cleanups that
need to get coverage there as well.

Paul.

---

Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org

Paul Gortmaker (11):
  sched/core: remove __cpuinit section tag that crept back in.
  arm/mach-keystone: remove legacy __cpuinit sections that crept in
  arm/mach-mvebu: remove legacy __cpuinit sections that crept in
  arm/mach-rockchip: remove legacy __cpuinit section that crept in
  arm/mach-hisi: remove legacy __CPUINIT section that crept in
  mips/ath25: remove legacy __cpuinit section that crept in
  mips/bcm77xx: remove legacy __cpuinit sections that crept in
  mips/c-r4k: remove legacy __cpuinit section that crept in
  kernel/cpu.c: remove new instance of __cpuinit that crept back in
  mips/mm/tlbex: remove new instance of __cpuinit that crept back in
  init: delete the __cpuinit related stubs

 arch/arm/mach-hisi/headsmp.S       |  3 ---
 arch/arm/mach-keystone/platsmp.c   |  4 ++--
 arch/arm/mach-mvebu/headsmp-a9.S   |  3 ---
 arch/arm/mach-mvebu/platsmp-a9.c   |  2 +-
 arch/arm/mach-rockchip/platsmp.c   |  3 +--
 arch/mips/ath25/board.c            |  2 +-
 arch/mips/bcm47xx/prom.c           |  2 +-
 arch/mips/include/asm/pgtable-32.h |  2 +-
 arch/mips/mm/c-r4k.c               |  2 +-
 arch/mips/mm/tlb-r4k.c             |  2 +-
 arch/mips/mm/tlbex.c               |  2 +-
 include/linux/init.h               | 11 -----------
 kernel/cpu.c                       |  2 +-
 kernel/sched/core.c                |  2 +-
 scripts/tags.sh                    |  2 +-
 15 files changed, 13 insertions(+), 31 deletions(-)

-- 
2.2.1
