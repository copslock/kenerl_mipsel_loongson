Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 21:10:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59414 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007238AbbCRUKURUm53 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2015 21:10:20 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CEC98B4EF421F;
        Wed, 18 Mar 2015 20:10:10 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 18 Mar 2015 20:10:14 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.138) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 18 Mar 2015 20:10:14 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <netdev@vger.kernel.org>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Don Fry <pcnet32@frontier.com>
Subject: [PATCH] net: ethernet: pcnet32: Setup the SRAM and NOUFLO on Am79C97{3,5}
Date:   Wed, 18 Mar 2015 20:10:07 +0000
Message-ID: <1426709407-16033-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.138]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

On a MIPS Malta board, tons of fifo underflow errors have been observed
when using u-boot as bootloader instead of YAMON. The reason for that
is that YAMON used to set the pcnet device to SRAM mode but u-boot does
not. As a result, the default Tx threshold (64 bytes) is now too small to
keep the fifo relatively used and it can result to Tx fifo underflow errors.
As a result of which, it's best to setup the SRAM on supported controllers
so we can always use the NOUFLO bit.

Cc: <netdev@vger.kernel.org>
Cc: <stable@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Don Fry <pcnet32@frontier.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 drivers/net/ethernet/amd/pcnet32.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 11d6e6561df1..7fb099f0c631 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -1543,7 +1543,7 @@ pcnet32_probe1(unsigned long ioaddr, int shared, struct pci_dev *pdev)
 {
 	struct pcnet32_private *lp;
 	int i, media;
-	int fdx, mii, fset, dxsuflo;
+	int fdx, mii, fset, dxsuflo, sram;
 	int chip_version;
 	char *chipname;
 	struct net_device *dev;
@@ -1580,7 +1580,7 @@ pcnet32_probe1(unsigned long ioaddr, int shared, struct pci_dev *pdev)
 	}
 
 	/* initialize variables */
-	fdx = mii = fset = dxsuflo = 0;
+	fdx = mii = fset = dxsuflo = sram = 0;
 	chip_version = (chip_version >> 12) & 0xffff;
 
 	switch (chip_version) {
@@ -1613,6 +1613,7 @@ pcnet32_probe1(unsigned long ioaddr, int shared, struct pci_dev *pdev)
 		chipname = "PCnet/FAST III 79C973";	/* PCI */
 		fdx = 1;
 		mii = 1;
+		sram = 1;
 		break;
 	case 0x2626:
 		chipname = "PCnet/Home 79C978";	/* PCI */
@@ -1636,6 +1637,7 @@ pcnet32_probe1(unsigned long ioaddr, int shared, struct pci_dev *pdev)
 		chipname = "PCnet/FAST III 79C975";	/* PCI */
 		fdx = 1;
 		mii = 1;
+		sram = 1;
 		break;
 	case 0x2628:
 		chipname = "PCnet/PRO 79C976";
@@ -1664,6 +1666,31 @@ pcnet32_probe1(unsigned long ioaddr, int shared, struct pci_dev *pdev)
 		dxsuflo = 1;
 	}
 
+	/*
+	 * The Am79C973/Am79C975 controllers come with 12K of SRAM
+	 * which we can use for the Tx/Rx buffers but most importantly,
+	 * the use of SRAM allow us to use the BCR18:NOUFLO bit to avoid
+	 * Tx fifo underflows.
+	 */
+	if (sram) {
+		/*
+		 * The SRAM is being configured in two steps. First we
+		 * set the SRAM size in the BCR25:SRAM_SIZE bits. According
+		 * to the datasheet, each bit corresponds to a 512-byte
+		 * page so we can have at most 24 pages. The SRAM_SIZE
+		 * corresponds holds the value of the upper 8 bits of
+		 * the 16-bit SRAM size. The low 8-bits start at 0x00
+		 * and end at 0xff. So the address range is from 0x0000
+		 * up to 0x17ff. Therefore, the SRAM_SIZE is set to 0x17.
+		 * The next step is to set the BCR24:SRAM_BND midway through
+		 * so the Tx and Rx buffers can share the SRAM equally.
+		 */
+		a->write_bcr(ioaddr, 25, 0x17);
+		a->write_bcr(ioaddr, 26, 0xc);
+		/* And finally enable the NOUFLO bit */
+		a->write_bcr(ioaddr, 18, a->read_bcr(ioaddr, 18) | (1 << 11));
+	}
+
 	dev = alloc_etherdev(sizeof(*lp));
 	if (!dev) {
 		ret = -ENOMEM;
-- 
2.3.3
