Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2014 17:55:04 +0200 (CEST)
Received: from mail-by2lp0241.outbound.protection.outlook.com ([207.46.163.241]:46013
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6837587AbaEFPwxwAFuY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 May 2014 17:52:53 +0200
Received: from CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) by
 CO1PR07MB284.namprd07.prod.outlook.com (10.141.69.148) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:46 +0000
Received: from alberich.caveonetworks.com (2.171.87.122) by
 CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:44 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 08/11] kvm tools: Handle virtio/pci I/O space as little endian.
Date:   Tue, 6 May 2014 17:51:28 +0200
Message-ID: <1399391491-5021-9-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2.171.87.122]
X-ClientProxiedBy: DBXPR07CA010.eurprd07.prod.outlook.com (10.255.191.168)
 To CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19)
X-Forefront-PRVS: 0203C93D51
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(77982001)(83072002)(85852003)(89996001)(92566001)(31966008)(77156001)(99396002)(20776003)(47776003)(83322001)(19580405001)(74662001)(74502001)(19580395003)(92726001)(80022001)(33646001)(53416003)(66066001)(2009001)(4396001)(36756003)(88136002)(81542001)(101416001)(50226001)(42186004)(575784001)(93916002)(86362001)(81342001)(46102001)(79102001)(62966002)(50466002)(76482001)(87976001)(87286001)(50986999)(48376002)(76176999);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR07MB396;H:alberich.caveonetworks.com;FPR:FCECF767.EF965528.67FDAB7A.8009F6D9.202C8;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40032
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
index c2da152..e4857b9 100644
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
index 665d492..f0ae8d4 100644
--- a/tools/kvm/virtio/pci.c
+++ b/tools/kvm/virtio/pci.c
@@ -376,9 +376,9 @@ int virtio_pci__init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
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
