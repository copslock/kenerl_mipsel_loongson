Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2012 13:17:36 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:27958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903685Ab2A3MQu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jan 2012 13:16:50 +0100
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0UCGjJ8032637
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 30 Jan 2012 07:16:45 -0500
Received: from redhat.com (vpn-203-146.tlv.redhat.com [10.35.203.146])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id q0UCGbiT001738;
        Mon, 30 Jan 2012 07:16:38 -0500
Date:   Mon, 30 Jan 2012 14:19:05 +0200
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
Subject: [PATCH 3/3] sh: use the the PCI channels's io_map_base
Message-ID: <60def7835613710ecae4878ae5742c45b05791df.1327877053.git.mst@redhat.com>
References: <cover.1327877053.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1327877053.git.mst@redhat.com>
X-Mutt-Fcc: =sent
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
X-archive-position: 32325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

commit 43db595e8b5d78ce5ad2feab719814a76e3ad2e5
failed to take into account the PCI channels's
io_map_base for mapping IO BARs.
This also caused a new warning on sh.

Fix this, without re-introducing code duplication,
by setting NO_GENERIC_PCI_IOPORT_MAP
and supplying a sh-specific __pci_ioport_map.

Reported-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sh/Kconfig           |    1 +
 arch/sh/drivers/pci/pci.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 3c8db65..713fb58 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -859,6 +859,7 @@ config PCI
 	depends on SYS_SUPPORTS_PCI
 	select PCI_DOMAINS
 	select GENERIC_PCI_IOMAP
+	select NO_GENERIC_PCI_IOPORT_MAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 8f18dd0..1e7b0e2 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -356,8 +356,8 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 
 #ifndef CONFIG_GENERIC_IOMAP
 
-static void __iomem *ioport_map_pci(struct pci_dev *dev,
-				    unsigned long port, unsigned int nr)
+void __iomem *__pci_ioport_map(struct pci_dev *dev,
+			       unsigned long port, unsigned int nr)
 {
 	struct pci_channel *chan = dev->sysdata;
 
-- 
1.7.8.2.325.g247f9
