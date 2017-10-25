Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Oct 2017 01:39:11 +0200 (CEST)
Received: from 5pmail.ess.barracuda.com ([64.235.154.203]:53295 "EHLO
        5pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990901AbdJYXiHGxHyS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Oct 2017 01:38:07 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 25 Oct 2017 23:37:41 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Wed, 25 Oct 2017
 16:36:20 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 0/8] irqchip: mips-gic: Cleanups, fixes, prep for multi-cluster
Date:   Wed, 25 Oct 2017 16:37:22 -0700
Message-ID: <20171025233730.22225-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1508974659-321459-28741-58358-7
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186295
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

This series continues cleaning & fixing up the MIPS GIC irqchip driver
whilst laying groundwork to support multi-cluster systems.

Patch 1 refactors in order to reduce some duplication and prepare us for
the following patches.

Patches 2-4 move per-CPU GIC configuration away from being performed all
at once when the driver is probed or when interrupts are masked &
unmasked, instead performing configuration as CPUs are brought online.
This allows us to support reconfiguring after clusters are powered down
& back up, generally cleans up and fixes bugs in the process.

Patch 5 makes use of num_possible_cpus() to reserve IPIs, rather than
the gic_vpes variable. This prepares us for multi-cluster in which
gic_vpes is mostly meaningless since it only reflects the local cluster,
and it generally makes more sense to use the more standard
num_possible_cpus().

Patch 6 removes the now unused gic_vpes variable.

Patch 7 is a general clean up but also prepares us for later patches as
described in its commit message.

Patch 8 is a general clean up marking some variables static.

This series by itself continues along the path towards supporting
multi-cluster systems such as the MIPS I6500, but does not yet get us
the whole way there. If you wish to see my current work in progress
which builds out multi-cluster support atop these patches then that can
be found in the multicluster branch of:

  git://git.linux-mips.org/pub/scm/paul/linux.git

Or browsed at:

  https://git.linux-mips.org/cgit/paul/linux.git/log/?h=multicluster

This series applies cleanly atop v4.14-rc6.


Paul Burton (8):
  irqchip: mips-gic: Inline gic_local_irq_domain_map()
  irqchip: mips-gic: Use irq_cpu_online to (un)mask all-VP(E) IRQs
  irqchip: mips-gic: Mask local interrupts when CPUs come online
  irqchip: mips-gic: Configure EIC when CPUs come online
  irqchip: mips-gic: Use num_possible_cpus() to reserve IPIs
  irqchip: mips-gic: Remove gic_vpes variable
  irqchip: mips-gic: Share register writes in gic_set_type()
  irqchip: mips-gic: Make IPI bitmaps static

 drivers/irqchip/irq-mips-gic.c | 213 ++++++++++++++++++++++-------------------
 1 file changed, 114 insertions(+), 99 deletions(-)

-- 
2.14.3
