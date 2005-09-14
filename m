Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 19:41:53 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.201]:9593 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8224982AbVINSlf>;
	Wed, 14 Sep 2005 19:41:35 +0100
Received: by zproxy.gmail.com with SMTP id 34so10648nzf
        for <linux-mips@linux-mips.org>; Wed, 14 Sep 2005 11:41:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=XpM2YT5Qt5vXVn6uDn1GlSq9MhW5Op14opW910fxRzW+CewWDjA0oMwmwQJZ4cZIJiAYEWd4AWdAS1xMer83mwzLlAJMx5VXIHa3tGwY40Dd5kN5bFOKy+mG06R2oT18mRYU3CEHI/cCj3gqWly0hUcrsZQhZWT/1our2OzwIxY=
Received: by 10.36.3.20 with SMTP id 20mr909033nzc;
        Wed, 14 Sep 2005 11:41:26 -0700 (PDT)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id 37sm70593nzf.2005.09.14.11.41.20;
        Wed, 14 Sep 2005 11:41:24 -0700 (PDT)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Wed, 14 Sep 2005 22:51:41 +0400 (MSD)
Date:	Wed, 14 Sep 2005 22:51:37 +0400
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Scott Feldman <sfeldma@pobox.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: [PATCH] gt96100: stop using pci_find_device()
Message-ID: <20050914185136.GE19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

From: Scott Feldman <sfeldma@pobox.com>

Replace pci_find_device with pci_get_device/pci_dev_put to plug race
with pci_find_device.

Signed-off-by: Scott Feldman <sfeldma@pobox.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/net/gt96100eth.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/gt96100eth.c
+++ b/drivers/net/gt96100eth.c
@@ -615,9 +615,9 @@ static int gt96100_init_module(void)
 	/*
 	 * Stupid probe because this really isn't a PCI device
 	 */
-	if (!(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
+	if (!(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
 	                            PCI_DEVICE_ID_MARVELL_GT96100, NULL)) &&
-	    !(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
+	    !(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
 		                    PCI_DEVICE_ID_MARVELL_GT96100A, NULL))) {
 		printk(KERN_ERR __FILE__ ": GT96100 not found!\n");
 		return -ENODEV;
@@ -627,12 +627,14 @@ static int gt96100_init_module(void)
 	if (cpuConfig & (1<<12)) {
 		printk(KERN_ERR __FILE__
 		       ": must be in Big Endian mode!\n");
+		pci_dev_put(pci);
 		return -ENODEV;
 	}
 
 	for (i=0; i < NUM_INTERFACES; i++)
 		retval |= gt96100_probe1(pci, i);
 
+	pci_dev_put(pci);
 	return retval;
 }
 
