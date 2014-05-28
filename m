Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2014 22:10:07 +0200 (CEST)
Received: from mail-bl2lp0203.outbound.protection.outlook.com ([207.46.163.203]:1940
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854780AbaE1UJ5OdIvo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 May 2014 22:09:57 +0200
Received: from localhost.localdomain (31.213.222.82) by
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 28 May 2014 20:09:31 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v3 00/12] kvm tools: Misc patches (mips support)
Date:   Wed, 28 May 2014 22:08:43 +0200
Message-ID: <1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [31.213.222.82]
X-ClientProxiedBy: AM3PR02CA004.eurprd02.prod.outlook.com (10.242.240.24) To
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15)
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(199002)(189002)(164054003)(62966002)(81342001)(102836001)(86362001)(81542001)(92726001)(46102001)(92566001)(77982001)(76482001)(42186004)(31966008)(101416001)(87286001)(19580395003)(93916002)(87976001)(83322001)(36756003)(19580405001)(48376002)(15975445006)(21056001)(74502001)(15395725003)(74662001)(50986999)(83072002)(15202345003)(88136002)(89996001)(20776003)(104166001)(80022001)(47776003)(50226001)(4396001)(79102001)(77156001)(99396002)(66066001)(64706001)(50466002)(33646001)(85852003)(6606295002);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB397;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40290
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

This is v3 of my patch set to run lkvm on MIPS.

It's rebased on v3.13-rc1-1436-g1fc83c5 of
git://github.com/penberg/linux-kvm.git

Diffstat is:

 tools/kvm/Makefile                           |    9 +-
 tools/kvm/arm/fdt.c                          |    7 -
 tools/kvm/arm/include/arm-common/kvm-arch.h  |    2 +
 tools/kvm/builtin-run.c                      |   12 +-
 tools/kvm/builtin-stat.c                     |    2 +-
 tools/kvm/disk/core.c                        |    4 +-
 tools/kvm/hw/pci-shmem.c                     |    5 +-
 tools/kvm/include/kvm/kvm.h                  |    1 +
 tools/kvm/include/kvm/term.h                 |    2 +
 tools/kvm/kvm.c                              |   20 +-
 tools/kvm/mips/include/kvm/barrier.h         |   20 ++
 tools/kvm/mips/include/kvm/kvm-arch.h        |   38 +++
 tools/kvm/mips/include/kvm/kvm-config-arch.h |    7 +
 tools/kvm/mips/include/kvm/kvm-cpu-arch.h    |   42 ++++
 tools/kvm/mips/irq.c                         |   10 +
 tools/kvm/mips/kvm-cpu.c                     |  219 +++++++++++++++++
 tools/kvm/mips/kvm.c                         |  328 ++++++++++++++++++++++++++
 tools/kvm/mmio.c                             |    5 +-
 tools/kvm/pci.c                              |   16 +-
 tools/kvm/powerpc/include/kvm/kvm-arch.h     |    2 +
 tools/kvm/powerpc/kvm.c                      |    7 -
 tools/kvm/term.c                             |   10 +-
 tools/kvm/util/util.c                        |    4 +-
 tools/kvm/virtio/pci.c                       |    6 +-
 tools/kvm/x86/include/kvm/kvm-arch.h         |    2 +
 25 files changed, 742 insertions(+), 38 deletions(-)

Changelog:
v3:
 - Rebased to v3.13-rc1-1436-g1fc83c5
 - Moved patch "kvm tools: Provide per arch macro to specify type for
   KVM_CREATE_VM" before patch "kvm tools, mips: Enable build of mips
   support" to avoid broken built.
 - Added macro for hypercall number (KVM_HC_MIPS_CONSOLE_OUTPUT)
   (Once mips-paravirt is upstream and its changes merged into your
   tree this should be replaced by including the appropriate kernel
   header file.)
v2:
 - http://marc.info/?i=1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com
v1:
 - http://marc.info/?i=1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com


Please apply.


Thanks,

Andreas
