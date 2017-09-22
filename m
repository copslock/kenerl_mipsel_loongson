Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2017 16:05:03 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:45184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990405AbdIVOExE22f2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Sep 2017 16:04:53 +0200
Received: from localhost (unknown [69.55.156.165])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C278922A72;
        Fri, 22 Sep 2017 14:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C278922A72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date:   Fri, 22 Sep 2017 09:04:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steve French <smfrench@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org
Subject: [GIT PULL] PCI fixes for v4.14
Message-ID: <20170922140449.GA15970@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helgaas@kernel.org
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

PCI fixes:

  - fix endpoint "end of test" interrupt issue (introduced in v4.14-rc1)
    (John Keeping)

  - fix MIPS use-after-free map_irq() issue (introduced in v4.14-rc1)
    (Lorenzo Pieralisi)


N.B.  The MIPS tree contains 8eba3651f1da ("MIPS: PCI: fix pcibios_map_irq
section mismatch"), a subset of the MIPS fix here.  I'm sending you this
one because (a) it's a little more comprehensive and (b) the problem was
with 04c81c7293df ("MIPS: PCI: Replace pci_fixup_irqs() call with host
bridge IRQ mapping hooks"), which was merged via the PCI tree.


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.14-fixes-2

for you to fetch changes up to 749aaf3372b8b56b8743c3e27700d64c8bd06921:

  PCI: endpoint: Use correct "end of test" interrupt (2017-09-20 13:56:06 -0500)

----------------------------------------------------------------
pci-v4.14-fixes-2

----------------------------------------------------------------
John Keeping (1):
      PCI: endpoint: Use correct "end of test" interrupt

Lorenzo Pieralisi (1):
      MIPS: PCI: Move map_irq() hooks out of initdata

 arch/mips/ath79/pci.c                         | 12 ++++++------
 arch/mips/pci/fixup-capcella.c                |  4 ++--
 arch/mips/pci/fixup-cobalt.c                  |  8 ++++----
 arch/mips/pci/fixup-emma2rh.c                 |  4 ++--
 arch/mips/pci/fixup-fuloong2e.c               |  2 +-
 arch/mips/pci/fixup-ip32.c                    |  4 ++--
 arch/mips/pci/fixup-jmr3927.c                 |  2 +-
 arch/mips/pci/fixup-lantiq.c                  |  2 +-
 arch/mips/pci/fixup-lemote2f.c                |  4 ++--
 arch/mips/pci/fixup-loongson3.c               |  2 +-
 arch/mips/pci/fixup-malta.c                   |  4 ++--
 arch/mips/pci/fixup-mpc30x.c                  |  6 +++---
 arch/mips/pci/fixup-pmcmsp.c                  |  8 ++++----
 arch/mips/pci/fixup-rbtx4927.c                |  2 +-
 arch/mips/pci/fixup-rbtx4938.c                |  2 +-
 arch/mips/pci/fixup-sni.c                     | 12 ++++++------
 arch/mips/pci/fixup-tb0219.c                  |  2 +-
 arch/mips/pci/fixup-tb0226.c                  |  2 +-
 arch/mips/pci/fixup-tb0287.c                  |  2 +-
 arch/mips/pci/pci-alchemy.c                   |  2 +-
 arch/mips/pci/pci-bcm47xx.c                   |  2 +-
 arch/mips/pci/pci-lasat.c                     |  2 +-
 arch/mips/pci/pci-mt7620.c                    |  2 +-
 arch/mips/pci/pci-octeon.c                    |  5 ++---
 arch/mips/pci/pci-rt2880.c                    |  2 +-
 arch/mips/pci/pci-rt3883.c                    |  2 +-
 arch/mips/pci/pci-tx4938.c                    |  2 +-
 arch/mips/pci/pci-tx4939.c                    |  4 ++--
 arch/mips/pci/pci-xlp.c                       |  2 +-
 arch/mips/pci/pci-xlr.c                       |  2 +-
 arch/mips/pci/pcie-octeon.c                   |  3 +--
 arch/mips/txx9/generic/pci.c                  |  8 ++++++--
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++-------
 33 files changed, 68 insertions(+), 67 deletions(-)
