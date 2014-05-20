Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 16:48:44 +0200 (CEST)
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:38185
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854988AbaETOsbj9A8a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 May 2014 16:48:31 +0200
Received: from localhost.localdomain (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Tue, 20 May 2014 14:47:59 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>
Subject: [PATCH 00/15] MIPS: Add mips_paravirt
Date:   Tue, 20 May 2014 16:47:01 +0200
Message-ID: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM3PR01CA004.eurprd01.prod.exchangelabs.com
 (10.242.240.14) To DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 02176E2458
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(979002)(6069001)(6009001)(428001)(164054003)(199002)(189002)(79102001)(36756003)(48376002)(66066001)(77982001)(92726001)(50466002)(74502001)(46102001)(64706001)(47776003)(80022001)(20776003)(50226001)(33646001)(101416001)(50986999)(76482001)(77156001)(89996001)(42186004)(81542001)(92566001)(62966002)(81342001)(87976001)(93916002)(87286001)(4396001)(83072002)(88136002)(85852003)(21056001)(83322001)(31966008)(74662001)(86362001)(99396002)(102836001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:localhost.localdomain;FPR:;MLV:ovrnspm;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

Following patches add support for paravirtualized guest on mips
(mips_paravirt). Some of the patches add basic support to run it on
octeon3.

The core of mips_paravirt is David's work.
I rebased his code, rearranged it somewhat (e.g. split it into the
current patches) and added some minor modifications.

I've run it using lkvm on a host with KVM MIPS-VZ support (on
octeon3). I've tested guest kernels built for CPU_MIPS64_R2 and
CPU_MIPS32_R2.

When the guest kernel is built for CPU_CAVIUM_OCTEON it requires an
additional patch to avoid usage of octeon_send_ipi_single in
octeon_flush_icache_all_cores. Latest patch for this is not yet
included as it caused a regression and needs some rework.

To built a mips_paravirt guest kernel it's easiest to start with
mips_paravirt_defconfig, check/modify CPU selection (defconfig has
CPU_MIPS64_R2), and kick off kernel built.

Patches are against v3.15-rc5. Diffstat is

 arch/mips/Kbuild.platforms                         |    1 +
 arch/mips/Kconfig                                  |   30 +-
 arch/mips/cavium-octeon/Kconfig                    |   30 +-
 arch/mips/configs/mips_paravirt_defconfig          | 1521 ++++++++++++++++++++
 arch/mips/include/asm/cpu-features.h               |    9 +-
 arch/mips/include/asm/cpu-type.h                   |    1 +
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    1 -
 .../asm/mach-paravirt/cpu-feature-overrides.h      |   36 +
 arch/mips/include/asm/mach-paravirt/irq.h          |   19 +
 .../include/asm/mach-paravirt/kernel-entry-init.h  |   49 +
 arch/mips/include/asm/mach-paravirt/war.h          |   25 +
 arch/mips/include/asm/mipsregs.h                   |   72 +
 arch/mips/include/asm/r4kcache.h                   |    2 +
 arch/mips/kernel/Makefile                          |    2 +-
 arch/mips/kernel/branch.c                          |    6 +-
 arch/mips/kernel/octeon_switch.S                   |   84 +-
 arch/mips/kernel/r4k_switch.S                      |    3 +
 arch/mips/math-emu/cp1emu.c                        |   12 +-
 arch/mips/mm/c-r4k.c                               |   32 +
 arch/mips/mm/tlbex.c                               |    8 +-
 arch/mips/paravirt/Kconfig                         |    6 +
 arch/mips/paravirt/Makefile                        |   14 +
 arch/mips/paravirt/Platform                        |    9 +
 arch/mips/paravirt/paravirt-irq.c                  |  388 +++++
 arch/mips/paravirt/paravirt-smp.c                  |  149 ++
 arch/mips/paravirt/serial.c                        |   38 +
 arch/mips/paravirt/setup.c                         |   67 +
 arch/mips/pci/Makefile                             |    2 +-
 arch/mips/pci/pci-virtio-guest.c                   |  140 ++
 29 files changed, 2709 insertions(+), 47 deletions(-)


Comments are welcome.


Thanks,

Andreas
