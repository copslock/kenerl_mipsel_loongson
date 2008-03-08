Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Mar 2008 16:56:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:52943 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28645914AbYCHQ4f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Mar 2008 16:56:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m28GuYtX008613;
	Sat, 8 Mar 2008 16:56:34 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m28GuXUl008612;
	Sat, 8 Mar 2008 16:56:33 GMT
Date:	Sat, 8 Mar 2008 16:56:33 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	jgarik@linux-mips.org, Andrew Morton <akpm@linux-foundation.org>,
	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: [IOC3] Fix section missmatch
Message-ID: <20080308165633.GA13996@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

  LD      drivers/net/built-in.o
WARNING: drivers/net/built-in.o(.text+0x3468): Section mismatch in reference fro
m the function ioc3_probe() to the function .devinit.text:ioc3_serial_probe()
The function ioc3_probe() references
the function __devinit ioc3_serial_probe().
This is often because ioc3_probe lacks a __devinit 
annotation or the annotation of ioc3_serial_probe is wrong.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/net/ioc3-eth.c b/drivers/net/ioc3-eth.c
index 373f72c..1f25263 100644
--- a/drivers/net/ioc3-eth.c
+++ b/drivers/net/ioc3-eth.c
@@ -1221,7 +1221,8 @@ static void __devinit ioc3_serial_probe(struct pci_dev *pdev, struct ioc3 *ioc3)
 }
 #endif
 
-static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit ioc3_probe(struct pci_dev *pdev,
+	const struct pci_device_id *ent)
 {
 	unsigned int sw_physid1, sw_physid2;
 	struct net_device *dev = NULL;
