Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 12:19:39 +0200 (CEST)
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:35817 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6835169Ab3DPKTQABIMU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Apr 2013 12:19:16 +0200
Received: from localhost.localdomain (e106165-lin.cambridge.arm.com [10.1.197.23])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id r3GAIh89000318;
        Tue, 16 Apr 2013 11:18:44 +0100
From:   Andrew Murray <Andrew.Murray@arm.com>
To:     linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Cc:     rob.herring@calxeda.com, jgunthorpe@obsidianresearch.com,
        linux@arm.linux.org.uk, siva.kallam@samsung.com,
        linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        jg1.han@samsung.com, Liviu.Dudau@arm.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kgene.kim@samsung.com, bhelgaas@google.com,
        suren.reddy@samsung.com, linux-arm-kernel@lists.infradead.org,
        monstr@monstr.eu, benh@kernel.crashing.org, paulus@samba.org,
        grant.likely@secretlab.ca, thomas.petazzoni@free-electrons.com,
        thierry.reding@avionic-design.de, thomas.abraham@linaro.org,
        arnd@arndb.de, linus.walleij@linaro.org,
        Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH v7 0/3] of/pci: Provide common support for PCI DT parsing
Date:   Tue, 16 Apr 2013 11:18:25 +0100
Message-Id: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <Andrew.Murray@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrew.Murray@arm.com
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

This patchset factors out duplicated code associated with parsing PCI
DT "ranges" properties across the architectures and introduces a
"ranges" parser. This parser "of_pci_range_parser" can be used directly
by ARM host bridge drivers enabling them to obtain ranges from device
trees.

I've included the Reviewed-by and Tested-by's received from v5/v6 in this
patchset, earlier versions of this patchset (v3) have been tested-by:

Thierry Reding <thierry.reding@avionic-design.de>
Jingoo Han <jg1.han@samsung.com>

I've tested that this patchset builds and runs on ARM and that it builds on
PowerPC and x86_64.

Compared to the v6 sent by Andrew Murray, the following changes have
been made in response to build errors/warnings:

 * Inclusion of linux/of_address.h in of_pci.c as suggested by Michal
   Simek to prevent compilation failures on Microblaze (and others) and his
   ack.

 * Use of externs, static inlines and a typo in linux/of_address.h in response
   to linker errors (multiple defination) on x86_64 as spotted by a kbuild test
   robot on (jcooper/linux.git mvebu/drivers)

 * Add EXPORT_SYMBOL_GPL to of_pci_range_parser function to be consistent
   with of_pci_process_ranges function

Compared to the v5 sent by Andrew Murray, the following changes have
been made:

 * Use of CONFIG_64BIT instead of CONFIG_[a32bitarch] as suggested by
   Rob Herring in drivers/of/of_pci.c

 * Added forward declaration of struct pci_controller in linux/of_pci.h
   to prevent compiler warning as suggested by Thomas Petazzoni

 * Improved error checking (!range check), removal of unnecessary be32_to_cpup
   call, improved formatting of struct of_pci_range_parser layout and
   replacement of macro with a static inline. All suggested by Rob Herring.

Compared to the v4 (incorrectly labelled v3) sent by Andrew Murray,
the following changes have been made:

 * Split the patch as suggested by Rob Herring

Compared to the v3 sent by Andrew Murray, the following changes have
been made:

 * Unify and move duplicate pci_process_bridge_OF_ranges functions to
   drivers/of/of_pci.c as suggested by Rob Herring

 * Fix potential build errors with Microblaze/MIPS

Compared to "[PATCH v5 01/17] of/pci: Provide support for parsing PCI DT
ranges property", the following changes have been made:

 * Correct use of IORESOURCE_* as suggested by Russell King

 * Improved interface and naming as suggested by Thierry Reding

Compared to the v2 sent by Andrew Murray, Thomas Petazzoni did:

 * Add a memset() on the struct of_pci_range_iter when starting the
   for loop in for_each_pci_range(). Otherwise, with an uninitialized
   of_pci_range_iter, of_pci_process_ranges() may crash.

 * Add parenthesis around 'res', 'np' and 'iter' in the
   for_each_of_pci_range macro definitions. Otherwise, passing
   something like &foobar as 'res' didn't work.

 * Rebased on top of 3.9-rc2, which required fixing a few conflicts in
   the Microblaze code.

v2:
  This follows on from suggestions made by Grant Likely
  (marc.info/?l=linux-kernel&m=136079602806328)

Andrew Murray (3):
  of/pci: Unify pci_process_bridge_OF_ranges from Microblaze and
    PowerPC
  of/pci: Provide support for parsing PCI DT ranges property
  of/pci: mips: convert to common of_pci_range_parser

 arch/microblaze/include/asm/pci-bridge.h |    5 +-
 arch/microblaze/pci/pci-common.c         |  192 ------------------------------
 arch/mips/pci/pci.c                      |   50 +++------
 arch/powerpc/include/asm/pci-bridge.h    |    5 +-
 arch/powerpc/kernel/pci-common.c         |  192 ------------------------------
 drivers/of/address.c                     |   67 +++++++++++
 drivers/of/of_pci.c                      |  169 ++++++++++++++++++++++++++
 include/linux/of_address.h               |   46 +++++++
 include/linux/of_pci.h                   |    4 +
 9 files changed, 304 insertions(+), 426 deletions(-)
