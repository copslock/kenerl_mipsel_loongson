Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2002 11:58:17 +0200 (CEST)
Received: from r-bu.iij4u.or.jp ([210.130.0.89]:39900 "EHLO r-bu.iij4u.or.jp")
	by linux-mips.org with ESMTP id <S1122961AbSILJ6Q>;
	Thu, 12 Sep 2002 11:58:16 +0200
Received: from pudding ([202.216.29.50])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id g8C9w3G20090;
	Thu, 12 Sep 2002 18:58:04 +0900 (JST)
Date: Thu, 12 Sep 2002 18:56:12 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: patch for pci.c
Message-Id: <20020912185612.56743fd7.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

The argument of pcibios_enable_device is changed.

In include/linux/pci.h:
int pcibios_enable_device(struct pci_dev *, int mask);

The following patch is required for the cvs tree of linux_2_4 tag.

--- ./arch/mips/kernel/pci.c.orig	Wed May 29 12:03:16 2002
+++ ./arch/mips/kernel/pci.c	Thu Sep 12 18:22:14 2002
@@ -100,7 +100,7 @@
 	pcibios_fixup_irqs();
 }
 
-int pcibios_enable_device(struct pci_dev *dev)
+int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	/* pciauto_assign_resources() will enable all devices found */
 	return 0;

-- 
Yoichi Yuasa
Montavista Software Japan, Inc.
