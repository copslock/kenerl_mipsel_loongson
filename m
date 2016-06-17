Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 22:11:53 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:45002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27041967AbcFQULwcXA8F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 22:11:52 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 114D8201BC;
        Fri, 17 Jun 2016 20:11:50 +0000 (UTC)
Received: from localhost (unknown [69.71.1.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 329DB2017E;
        Fri, 17 Jun 2016 20:11:49 +0000 (UTC)
Subject: [PATCH v1 0/4] PCI: pci_resource_to_user() cleanups
To:     Michal Simek <monstr@monstr.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yinghai Lu <yinghai@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     sparclinux@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Fri, 17 Jun 2016 15:11:47 -0500
Message-ID: <20160617195835.11714.18657.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

The /sys/devices/pci.../.../resource and /proc/bus/pci/devices files
contain PCI BAR addresses.  On most architectures these addresses are
"resource" values, e.g., CPU physical memory addresses or Linux I/O port
numbers.  These may be offset from the raw PCI values if there are multiple
PCI host bridges.

On others (microblaze, mips, powerpc, sparc) they are raw PCI values as
they would appear on the PCI bus.  pci_resource_to_user() converts from the
struct resource to whatever the arch wants to expose.  It's a no-op on
most arches.

The PCI core provides a pcibios_resource_to_bus() function that converts
from struct resource values to raw PCI bus values.  These patches use that
when possible instead of the arch-specific hand-coded equivalent.

These shouldn't fix or break anything unless I've made a mistake.

---

Bjorn Helgaas (4):
      PCI: Unify pci_resource_to_user() declarations
      microblaze/PCI: Implement pci_resource_to_user() with pcibios_resource_to_bus()
      powerpc/pci: Implement pci_resource_to_user() with pcibios_resource_to_bus()
      sparc/PCI: Implement pci_resource_to_user() with pcibios_resource_to_bus()


 arch/microblaze/include/asm/pci.h |    3 ---
 arch/microblaze/pci/pci-common.c  |   42 ++++++++++++-------------------------
 arch/mips/include/asm/pci.h       |   10 ---------
 arch/mips/pci/pci.c               |   10 +++++++++
 arch/powerpc/include/asm/pci.h    |    3 ---
 arch/powerpc/kernel/pci-common.c  |   42 ++++++++++++-------------------------
 arch/sparc/include/asm/pci_64.h   |    3 ---
 arch/sparc/kernel/pci.c           |   20 ++++++++++--------
 include/linux/pci.h               |    6 ++++-
 9 files changed, 54 insertions(+), 85 deletions(-)
