Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2014 15:09:52 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:53073 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859979AbaFJNJaDbJq3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Jun 2014 15:09:30 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5AD9LGv003416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jun 2014 09:09:22 -0400
Received: from dhcp-26-207.brq.redhat.com (dhcp-26-119.brq.redhat.com [10.34.26.119])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5AD9Ita017601;
        Tue, 10 Jun 2014 09:09:19 -0400
From:   Alexander Gordeev <agordeev@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@redhat.com>, linux-doc@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/3] Add pci_enable_msi_partial() to conserve MSI-related resources
Date:   Tue, 10 Jun 2014 15:10:29 +0200
Message-Id: <cover.1402405331.git.agordeev@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agordeev@redhat.com
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

Add new pci_enable_msi_partial() interface and use it to
conserve on othewise wasted interrupt resources.

AHCI driver is the first user which would conserve on
10 out of 16 unused MSI vectors on some Intel chipsets.

Cc: linux-doc@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-ide@vger.kernel.org
Cc: linux-pci@vger.kernel.org

Alexander Gordeev (3):
  PCI/MSI: Add pci_enable_msi_partial()
  PCI/MSI/x86: Support pci_enable_msi_partial()
  AHCI: Use pci_enable_msi_partial() to conserve on 10/16 MSIs

 Documentation/PCI/MSI-HOWTO.txt |   36 ++++++++++++++--
 arch/mips/pci/msi-octeon.c      |    2 +-
 arch/powerpc/kernel/msi.c       |    4 +-
 arch/s390/pci/pci.c             |    2 +-
 arch/x86/include/asm/pci.h      |    3 +-
 arch/x86/include/asm/x86_init.h |    3 +-
 arch/x86/kernel/apic/io_apic.c  |    2 +-
 arch/x86/kernel/x86_init.c      |    4 +-
 arch/x86/pci/xen.c              |    9 +++-
 drivers/ata/ahci.c              |    4 +-
 drivers/iommu/irq_remapping.c   |   10 ++--
 drivers/pci/msi.c               |   83 ++++++++++++++++++++++++++++++++++-----
 include/linux/msi.h             |    5 +-
 include/linux/pci.h             |    3 +
 14 files changed, 134 insertions(+), 36 deletions(-)

-- 
1.7.7.6
