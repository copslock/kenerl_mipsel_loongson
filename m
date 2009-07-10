Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 10:58:53 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:46642 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491963AbZGJI63 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 10:58:29 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A8wMtK024261
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 01:58:22 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 01:58:21 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A8wL8Q021830;
	Fri, 10 Jul 2009 01:58:21 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 1/2] [MTI] Enable PIIX4 PCI2.1 compliancy on Malta
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 01:58:15 -0700
Message-ID: <20090710085815.26049.39237.stgit@linux-raghu>
In-Reply-To: <20090710085759.26049.52144.stgit@linux-raghu>
References: <20090710085759.26049.52144.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 08:58:22.0040 (UTC) FILETIME=[93A7E580:01CA013C]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/mti-malta/malta-setup.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index dc78b89..69f5f9c 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -223,3 +223,14 @@ void __init plat_mem_setup(void)
 	board_be_init = malta_be_init;
 	board_be_handler = malta_be_handler;
 }
+/* Enable PCI 2.1 compatibility in PIIX4 */
+static void __init quirk_dlcsetup(struct pci_dev *dev)
+{
+	u8 odlc, ndlc;
+	(void) pci_read_config_byte(dev, 0x82, &odlc);
+	/* Enable passive releases and delayed transaction */
+	ndlc = odlc | 7;
+	(void) pci_write_config_byte(dev, 0x82, ndlc);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
+		quirk_dlcsetup);
