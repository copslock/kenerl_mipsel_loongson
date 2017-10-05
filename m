Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 22:38:46 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:58974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993608AbdJEUijd9cAf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Oct 2017 22:38:39 +0200
Received: from localhost (unknown [64.22.228.164])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F0421907;
        Thu,  5 Oct 2017 20:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F0421907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH 0/4] PCI: Cleanup unused stuff
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-am33-list@redhat.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-xtensa@linux-xtensa.org, Mikael Starvik <starvik@axis.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
        linux-parisc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Date:   Thu, 05 Oct 2017 15:38:23 -0500
Message-ID: <20171005201939.18300.25690.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60284
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

Sorry for the long cc list.  These are pretty trivial; they just remove
some unnecessary declarations across several arches.

---

Bjorn Helgaas (4):
      PCI: Remove redundant pcibios_set_master() declarations
      PCI: Remove redundant pci_dev, pci_bus, resource declarations
      PCI: Remove unused declarations
      alpha/PCI: Make pdev_save_srm_config() static


 arch/alpha/include/asm/pci.h            |    5 -----
 arch/alpha/kernel/pci.c                 |   11 ++++++++++-
 arch/alpha/kernel/pci_impl.h            |    8 --------
 arch/cris/include/asm/pci.h             |    9 ---------
 arch/frv/include/asm/pci.h              |    4 ----
 arch/ia64/include/asm/pci.h             |    4 ----
 arch/mips/include/asm/pci.h             |    4 ----
 arch/mn10300/include/asm/pci.h          |    4 ----
 arch/mn10300/unit-asb2305/pci-asb2305.h |    3 ---
 arch/parisc/include/asm/pci.h           |    8 --------
 arch/powerpc/include/asm/pci.h          |    2 --
 arch/sh/include/asm/pci.h               |    4 ----
 arch/sparc/include/asm/pci_32.h         |    2 --
 arch/x86/include/asm/pci.h              |    2 --
 arch/xtensa/include/asm/pci.h           |    2 --
 15 files changed, 10 insertions(+), 62 deletions(-)
