Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 08:54:57 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:47370 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903693Ab2FFGyw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jun 2012 08:54:52 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 05 Jun 2012 23:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="scan'208";a="175368209"
Received: from debian.sh.intel.com ([10.239.13.3])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jun 2012 23:54:39 -0700
From:   Alex Shi <alex.shi@intel.com>
To:     a.p.zijlstra@chello.nl
Cc:     anton@samba.org, benh@kernel.crashing.org, cmetcalf@tilera.com,
        dhowells@redhat.com, davem@davemloft.net, fenghua.yu@intel.com,
        hpa@zytor.com, ink@jurassic.park.msu.ru,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        mattst88@gmail.com, paulus@samba.org, lethal@linux-sh.org,
        ralf@linux-mips.org, rth@twiddle.net, sparclinux@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, sivanich@sgi.com,
        greg.pearson@hp.com, kamezawa.hiroyu@jp.fujitsu.com,
        bob.picco@oracle.com, chris.mason@oracle.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mingo@kernel.org, pjt@google.com, tglx@linutronix.de,
        seto.hidetoshi@jp.fujitsu.com, ak@linux.intel.com,
        arjan.van.de.ven@intel.com
Subject: [RFC PATCH] sched/numa: do load balance between remote nodes
Date:   Wed,  6 Jun 2012 14:52:51 +0800
Message-Id: <1338965571-9812-1-git-send-email-alex.shi@intel.com>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 33561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.shi@intel.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

commit cb83b629b remove the NODE sched domain and check if the node
distance in SLIT table is farther than REMOTE_DISTANCE, if so, it will
lose the load balance chance at exec/fork/wake_affine points.

But actually, even the node distance is farther than REMOTE_DISTANCE,
Modern CPUs also has QPI like connections, that make memory access is
not too slow between nodes. So above losing on NUMA machine make a
huge performance regression on benchmark: hackbench, tbench, netperf
and oltp etc.

This patch will recover the scheduler behavior to old mode on all my
Intel platforms: NHM EP/EX, WSM EP, SNB EP/EP4S, and so remove the
perfromance regressions. (all of them just has 2 kinds distance, 10 21)

Signed-off-by: Alex Shi <alex.shi@intel.com>
---
 kernel/sched/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 39eb601..b2ee41a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6286,7 +6286,7 @@ static int sched_domains_curr_level;
 
 static inline int sd_local_flags(int level)
 {
-	if (sched_domains_numa_distance[level] > REMOTE_DISTANCE)
+	if (sched_domains_numa_distance[level] > RECLAIM_DISTANCE)
 		return 0;
 
 	return SD_BALANCE_EXEC | SD_BALANCE_FORK | SD_WAKE_AFFINE;
-- 
1.7.5.4
