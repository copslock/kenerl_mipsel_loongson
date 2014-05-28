Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2014 22:31:02 +0200 (CEST)
Received: from mail-bn1lp0139.outbound.protection.outlook.com ([207.46.163.139]:46254
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854794AbaE1UaDCfcqn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 May 2014 22:30:03 +0200
Received: from localhost.localdomain (31.213.222.82) by
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 28 May 2014 20:29:55 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v3 09/12] kvm tools: Handle virtio/pci I/O space as little endian
Date:   Wed, 28 May 2014 22:28:03 +0200
Message-ID: <1401308886-17394-9-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [31.213.222.82]
X-ClientProxiedBy: DB3PR07CA008.eurprd07.prod.outlook.com (10.242.134.48) To
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15)
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(74662001)(76176999)(50986999)(83072002)(74502001)(21056001)(66066001)(99396002)(85852003)(64706001)(33646001)(50466002)(80022001)(47776003)(104166001)(89996001)(88136002)(20776003)(77156001)(50226001)(79102001)(4396001)(77982001)(92566001)(46102001)(92726001)(42186004)(76482001)(81342001)(62966002)(102836001)(81542001)(86362001)(93916002)(87286001)(19580395003)(36756003)(83322001)(48376002)(19580405001)(87976001)(31966008)(101416001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB397;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40299
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

It doesn't work on big endian hosts as is.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/pci.c        |   16 +++++++++++++---
 tools/kvm/virtio/pci.c |    6 +++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/kvm/pci.c b/tools/kvm/pci.c
index 5d60585..eac718f 100644
--- a/tools/kvm/pci.c
+++ b/tools/kvm/pci.c
@@ -10,7 +10,7 @@
 
 #define PCI_BAR_OFFSET(b)		(offsetof(struct pci_device_header, bar[b]))
 
-static union pci_config_address		pci_config_address;
+static u32 pci_config_address_bits;
 
 /* This is within our PCI gap - in an unused area.
  * Note this is a PCI *bus address*, is used to assign BARs etc.!
@@ -49,7 +49,7 @@ static void *pci_config_address_ptr(u16 port)
 	void *base;
 
 	offset	= port - PCI_CONFIG_ADDRESS;
-	base	= &pci_config_address;
+	base	= &pci_config_address_bits;
 
 	return base + offset;
 }
@@ -79,6 +79,10 @@ static struct ioport_operations pci_config_address_ops = {
 
 static bool pci_device_exists(u8 bus_number, u8 device_number, u8 function_number)
 {
+	union pci_config_address pci_config_address;
+
+	pci_config_address.w = ioport__read32(&pci_config_address_bits);
+
 	if (pci_config_address.bus_number != bus_number)
 		return false;
 
@@ -90,6 +94,9 @@ static bool pci_device_exists(u8 bus_number, u8 device_number, u8 function_numbe
 
 static bool pci_config_data_out(struct ioport *ioport, struct kvm *kvm, u16 port, void *data, int size)
 {
+	union pci_config_address pci_config_address;
+
+	pci_config_address.w = ioport__read32(&pci_config_address_bits);
 	/*
 	 * If someone accesses PCI configuration space offsets that are not
 	 * aligned to 4 bytes, it uses ioports to signify that.
@@ -103,6 +110,9 @@ static bool pci_config_data_out(struct ioport *ioport, struct kvm *kvm, u16 port
 
 static bool pci_config_data_in(struct ioport *ioport, struct kvm *kvm, u16 port, void *data, int size)
 {
+	union pci_config_address pci_config_address;
+
+	pci_config_address.w = ioport__read32(&pci_config_address_bits);
 	/*
 	 * If someone accesses PCI configuration space offsets that are not
 	 * aligned to 4 bytes, it uses ioports to signify that.
@@ -133,7 +143,7 @@ void pci__config_wr(struct kvm *kvm, union pci_config_address addr, void *data,
 			void *p = device__find_dev(DEVICE_BUS_PCI, dev_num)->data;
 			struct pci_device_header *hdr = p;
 			u8 bar = (offset - PCI_BAR_OFFSET(0)) / (sizeof(u32));
-			u32 sz = PCI_IO_SIZE;
+			u32 sz = cpu_to_le32(PCI_IO_SIZE);
 
 			if (bar < 6 && hdr->bar_size[bar])
 				sz = hdr->bar_size[bar];
diff --git a/tools/kvm/virtio/pci.c b/tools/kvm/virtio/pci.c
index 57ccde6..b8122b0 100644
--- a/tools/kvm/virtio/pci.c
+++ b/tools/kvm/virtio/pci.c
@@ -378,9 +378,9 @@ int virtio_pci__init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 							| PCI_BASE_ADDRESS_SPACE_MEMORY),
 		.status			= cpu_to_le16(PCI_STATUS_CAP_LIST),
 		.capabilities		= (void *)&vpci->pci_hdr.msix - (void *)&vpci->pci_hdr,
-		.bar_size[0]		= IOPORT_SIZE,
-		.bar_size[1]		= IOPORT_SIZE,
-		.bar_size[2]		= PCI_IO_SIZE * 2,
+		.bar_size[0]		= cpu_to_le32(IOPORT_SIZE),
+		.bar_size[1]		= cpu_to_le32(IOPORT_SIZE),
+		.bar_size[2]		= cpu_to_le32(PCI_IO_SIZE*2),
 	};
 
 	vpci->dev_hdr = (struct device_header) {
-- 
1.7.9.5
