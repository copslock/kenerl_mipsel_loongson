Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 01:31:18 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:40175 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8224941AbUKWBbE>; Tue, 23 Nov 2004 01:31:04 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iAN1V2dh020646;
	Mon, 22 Nov 2004 17:31:02 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iAN1V28F020644;
	Mon, 22 Nov 2004 17:31:02 -0800
Date: Mon, 22 Nov 2004 17:31:02 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] PCMCIA Subsystem of Toshiba TX4927
Message-ID: <20041123013102.GA20638@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf

Attached patch gets the PCMCIA to work for the Toshiba TX4927. This has been
tested with a Linksys PCMCIA ethernet controller. Please review ...

Thanks
Manish Lachwani


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-tx4927-pcmcia

--- include/asm-mips/pci.h.orig	2004-11-22 17:37:59.000000000 -0800
+++ include/asm-mips/pci.h	2004-11-22 17:37:08.000000000 -0800
@@ -23,6 +23,11 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+#ifdef CONFIG_TOSHIBA_RBTX4927
+#undef PCIBIOS_MIN_MEM
+#define PCIBIOS_MIN_MEM		0x1000000
+#endif
+
 
 extern void pcibios_set_master(struct pci_dev *dev);
 

--zhXaljGHf11kAtnf--
