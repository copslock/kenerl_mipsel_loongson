Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 00:13:38 +0200 (CEST)
Received: from mail-bl2lp0204.outbound.protection.outlook.com ([207.46.163.204]:24324
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854783AbaE1WLBwLwl3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 00:11:01 +0200
Received: from alberich.caveonetworks.com (31.213.222.82) by
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 28 May 2014 21:54:35 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 11/13] MIPS: paravirt: Add pci controller for virtio
Date:   Wed, 28 May 2014 23:52:14 +0200
Message-ID: <1401313936-11867-12-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [31.213.222.82]
X-ClientProxiedBy: AMSPR01CA013.eurprd01.prod.exchangelabs.com
 (10.255.167.158) To BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22)
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(22564002)(69596002)(99396002)(76482001)(46102001)(77156001)(50466002)(85852003)(50226001)(89996001)(83072002)(53416003)(102836001)(104166001)(101416001)(80022001)(92566001)(64706001)(92726001)(79102001)(19580395003)(83322001)(19580405001)(31966008)(74502001)(74662001)(36756003)(33646001)(86362001)(66066001)(21056001)(81342001)(87286001)(93916002)(62966002)(4396001)(77982001)(48376002)(50986999)(76176999)(87976001)(20776003)(81542001)(42186004)(81156002)(88136002)(47776003);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB386;H:alberich.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40313
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

From: David Daney <david.daney@cavium.com>


Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/Kconfig                |    1 +
 arch/mips/paravirt/Kconfig       |    6 ++
 arch/mips/pci/Makefile           |    2 +-
 arch/mips/pci/pci-virtio-guest.c |  131 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/paravirt/Kconfig
 create mode 100644 arch/mips/pci/pci-virtio-guest.c

[andreas.herrmann:
  * Make use of __BITFIELD_FIELD macro
  * Calculate IO address for in[lwb] and out[lwb] depending on size]

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d540945..1f836d8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -823,6 +823,7 @@ source "arch/mips/cavium-octeon/Kconfig"
 source "arch/mips/loongson/Kconfig"
 source "arch/mips/loongson1/Kconfig"
 source "arch/mips/netlogic/Kconfig"
+source "arch/mips/paravirt/Kconfig"
 
 endmenu
 
diff --git a/arch/mips/paravirt/Kconfig b/arch/mips/paravirt/Kconfig
new file mode 100644
index 0000000..ecae586
--- /dev/null
+++ b/arch/mips/paravirt/Kconfig
@@ -0,0 +1,6 @@
+if MIPS_PARAVIRT
+
+config MIPS_PCI_VIRTIO
+	def_bool y
+
+endif #  MIPS_PARAVIRT
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index d61138a..ff8a553 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
 obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
 obj-$(CONFIG_SOC_AR71XX)	+= pci-ar71xx.o
 obj-$(CONFIG_PCI_AR724X)	+= pci-ar724x.o
-
+obj-$(CONFIG_MIPS_PCI_VIRTIO)	+= pci-virtio-guest.o
 #
 # These are still pretty much in the old state, watch, go blind.
 #
diff --git a/arch/mips/pci/pci-virtio-guest.c b/arch/mips/pci/pci-virtio-guest.c
new file mode 100644
index 0000000..40a078b
--- /dev/null
+++ b/arch/mips/pci/pci-virtio-guest.c
@@ -0,0 +1,131 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Cavium, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+
+#include <uapi/asm/bitfield.h>
+#include <asm/byteorder.h>
+#include <asm/io.h>
+
+#define PCI_CONFIG_ADDRESS	0xcf8
+#define PCI_CONFIG_DATA		0xcfc
+
+union pci_config_address {
+	struct {
+		__BITFIELD_FIELD(unsigned enable_bit	  : 1,	/* 31       */
+		__BITFIELD_FIELD(unsigned reserved	  : 7,	/* 30 .. 24 */
+		__BITFIELD_FIELD(unsigned bus_number	  : 8,	/* 23 .. 16 */
+		__BITFIELD_FIELD(unsigned devfn_number	  : 8,	/* 15 .. 8  */
+		__BITFIELD_FIELD(unsigned register_number : 8,	/* 7  .. 0  */
+		)))));
+	};
+	u32 w;
+};
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return ((pin + slot) % 4)+ MIPS_IRQ_PCIA;
+}
+
+static void pci_virtio_guest_write_config_addr(struct pci_bus *bus,
+					unsigned int devfn, int reg)
+{
+	union pci_config_address pca = { .w = 0 };
+
+	pca.register_number = reg;
+	pca.devfn_number = devfn;
+	pca.bus_number = bus->number;
+	pca.enable_bit = 1;
+
+	outl(pca.w, PCI_CONFIG_ADDRESS);
+}
+
+static int pci_virtio_guest_write_config(struct pci_bus *bus,
+		unsigned int devfn, int reg, int size, u32 val)
+{
+	pci_virtio_guest_write_config_addr(bus, devfn, reg);
+
+	switch (size) {
+	case 1:
+		outb(val, PCI_CONFIG_DATA + (reg & 3));
+		break;
+	case 2:
+		outw(val, PCI_CONFIG_DATA + (reg & 2));
+		break;
+	case 4:
+		outl(val, PCI_CONFIG_DATA);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int pci_virtio_guest_read_config(struct pci_bus *bus, unsigned int devfn,
+					int reg, int size, u32 *val)
+{
+	pci_virtio_guest_write_config_addr(bus, devfn, reg);
+
+	switch (size) {
+	case 1:
+		*val = inb(PCI_CONFIG_DATA + (reg & 3));
+		break;
+	case 2:
+		*val = inw(PCI_CONFIG_DATA + (reg & 2));
+		break;
+	case 4:
+		*val = inl(PCI_CONFIG_DATA);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops pci_virtio_guest_ops = {
+	.read  = pci_virtio_guest_read_config,
+	.write = pci_virtio_guest_write_config,
+};
+
+static struct resource pci_virtio_guest_mem_resource = {
+	.name = "Virtio MEM",
+	.flags = IORESOURCE_MEM,
+	.start	= 0x10000000,
+	.end	= 0x1dffffff
+};
+
+static struct resource pci_virtio_guest_io_resource = {
+	.name = "Virtio IO",
+	.flags = IORESOURCE_IO,
+	.start	= 0,
+	.end	= 0xffff
+};
+
+static struct pci_controller pci_virtio_guest_controller = {
+	.pci_ops = &pci_virtio_guest_ops,
+	.mem_resource = &pci_virtio_guest_mem_resource,
+	.io_resource = &pci_virtio_guest_io_resource,
+};
+
+static int __init pci_virtio_guest_setup(void)
+{
+	pr_err("pci_virtio_guest_setup\n");
+
+	/* Virtio comes pre-assigned */
+	pci_set_flags(PCI_PROBE_ONLY);
+
+	pci_virtio_guest_controller.io_map_base = mips_io_port_base;
+	register_pci_controller(&pci_virtio_guest_controller);
+	return 0;
+}
+arch_initcall(pci_virtio_guest_setup);
-- 
1.7.9.5
