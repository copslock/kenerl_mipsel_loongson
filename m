Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2012 13:16:24 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:41863 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901169Ab2A3MQT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jan 2012 13:16:19 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0UCG7rg015830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 30 Jan 2012 07:16:07 -0500
Received: from redhat.com (vpn-203-146.tlv.redhat.com [10.35.203.146])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id q0UCFvSg016862;
        Mon, 30 Jan 2012 07:15:58 -0500
Date:   Mon, 30 Jan 2012 14:18:25 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
Subject: [PATCH 0/3] arch: fix ioport mapping on mips,sh
Message-ID: <cover.1327877053.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-archive-position: 32322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Kevin Cernekee reported that recent cleanup
that replaced pci_iomap with a generic function
failed to take into account the differences
in io port handling on mips and sh architectures.

Rather than revert the changes reintroducing the
code duplication, this patchset fixes this
by adding ability for architectures to override
ioport mapping for pci devices.

I put this in my tree that feeds into linux-next
and intend to ask Linus to pull this fix if this
doesn't cause any issues and there are no objections.

The patches were tested on x86 and compiled on mips and sh.
Would appreciate reviews/acks/testing reports.

Michael S. Tsirkin (3):
  lib: add NO_GENERIC_PCI_IOPORT_MAP
  mips: use the the PCI controller's io_map_base
  sh: use the the PCI channels's io_map_base

 arch/mips/Kconfig               |    1 +
 arch/mips/lib/iomap-pci.c       |    4 ++--
 arch/sh/Kconfig                 |    1 +
 arch/sh/drivers/pci/pci.c       |    4 ++--
 include/asm-generic/pci_iomap.h |    5 +++++
 lib/Kconfig                     |    3 +++
 lib/pci_iomap.c                 |   12 +++++++++++-
 7 files changed, 25 insertions(+), 5 deletions(-)

-- 
1.7.8.2.325.g247f9
