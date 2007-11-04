Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 12:03:25 +0000 (GMT)
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:43214 "EHLO
	smtp-out3.tiscali.nl") by ftp.linux-mips.org with ESMTP
	id S20024033AbXKDMDQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Nov 2007 12:03:16 +0000
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out3.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1Ioe99-0007uf-Cx
	for <linux-mips@linux-mips.org>; Sun, 04 Nov 2007 13:00:07 +0100
Message-ID: <472DB446.3020804@tiscali.nl>
Date:	Sun, 04 Nov 2007 13:00:06 +0100
From:	Roel Kluin <12o3l@tiscali.nl>
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] iounmap if in vr41xx_pciu_init() pci clock is over 33MHz
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <12o3l@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 12o3l@tiscali.nl
Precedence: bulk
X-list: linux-mips

iounmap if pci clock is over 33MHz

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/mips/pci/pci-vr41xx.c b/arch/mips/pci/pci-vr41xx.c
index 240df9e..33c4f68 100644
--- a/arch/mips/pci/pci-vr41xx.c
+++ b/arch/mips/pci/pci-vr41xx.c
@@ -154,6 +154,7 @@ static int __init vr41xx_pciu_init(void)
 		pciu_write(PCICLKSELREG, QUARTER_VTCLOCK);
 	else {
 		printk(KERN_ERR "PCI Clock is over 33MHz.\n");
+		iounmap(pciu_base);
 		return -EINVAL;
 	}
 
