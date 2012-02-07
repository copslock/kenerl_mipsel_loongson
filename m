Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2012 07:59:44 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:9162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903684Ab2BGG7d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Feb 2012 07:59:33 +0100
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q176xNKV004556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 7 Feb 2012 01:59:24 -0500
Received: from redhat.com (vpn-203-175.tlv.redhat.com [10.35.203.175])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id q176xF17030728;
        Tue, 7 Feb 2012 01:59:16 -0500
Date:   Tue, 7 Feb 2012 08:59:18 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Myron Stowe <myron.stowe@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Dmitry Kasatkin <dmitry.kasatkin@intel.com>,
        James Morris <jmorris@namei.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        Michael Witten <mfwitten@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [GIT PULL] fixups for generic pci_iomap
Message-ID: <20120207065917.GA24577@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
X-archive-position: 32410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The following changes since commit 0a9626575400879d1d5e6bc8768188b938d7c501:

  Merge tag 'driver-core-3.3-rc1-bugfixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2012-01-28 18:20:48 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git for-linus

for you to fetch changes up to 1e05b62ae4bd4c1209229de367b0989b39644f88:

  sh: use the the PCI channels's io_map_base (2012-01-31 23:21:19 +0200)

These changes have been on linux-next for a couple of weeks,
I have also tested them on x86 and built on sh and mips.

----------------------------------------------------------------
arch: fix ioport mapping on mips,sh

Kevin Cernekee reported that recent cleanup
that replaced pci_iomap with a generic function
failed to take into account the differences
in io port handling on mips and sh architectures.

Rather than revert the changes reintroducing the
code duplication, this patchset fixes this
by adding ability for architectures to override
ioport mapping for pci devices.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (3):
      lib: add NO_GENERIC_PCI_IOPORT_MAP
      mips: use the the PCI controller's io_map_base
      sh: use the the PCI channels's io_map_base

 arch/mips/Kconfig               |    1 +
 arch/mips/lib/iomap-pci.c       |    4 ++--
 arch/sh/Kconfig                 |    1 +
 arch/sh/drivers/pci/pci.c       |    4 ++--
 include/asm-generic/pci_iomap.h |   10 ++++++++++
 lib/Kconfig                     |    3 +++
 lib/pci_iomap.c                 |    2 +-
 7 files changed, 20 insertions(+), 5 deletions(-)
-- 
MST
