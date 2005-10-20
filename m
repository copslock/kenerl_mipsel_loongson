Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 08:05:41 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:42252 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S3465582AbVJTHAF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 08:00:05 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 19 Oct 2005 23:59:48 -0700
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:59:46 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CAW11227; Wed, 19 Oct 2005 23:59:47 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA28445 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:59:47
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j9K6xkov008749 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005
 23:59:46 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j9K6xkM24044 for linux-mips@linux-mips.org; Wed, 19 Oct 2005
 23:59:46 -0700
Date:	Wed, 19 Oct 2005 23:59:46 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 12/12] pci-expmem-hack
Message-ID: <20051020065946.GL23899@broadcom.com>
References: <20051020065320.GA23857@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20051020065320.GA23857@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F499FEE4NK4416932-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

CFE 1.2.5 and earlier fails to turn on the ExpMemEn bit in the
PCIFeatureControl register, which means that DMA does not work
beyond physical address 01_0000_0000, ergo to DRAM beyond 1GB.

With ExpMemEn turned on, 01_0000_0000-0f_ffff_ffff is mapped,
so DMA works for up to 61 GB of DRAM.

Will be fixed in CFE 1.2.6 (yet to be released).

Signed-Off-By: Andy Isaacson <adi@broadcom.com>

 arch/mips/pci/pci-bcm1480.c |    8 ++++++++
 1 files changed, 8 insertions(+)

Index: lmo/arch/mips/pci/pci-bcm1480.c
===================================================================
--- lmo.orig/arch/mips/pci/pci-bcm1480.c	2005-10-19 22:34:13.000000000 -0700
+++ lmo/arch/mips/pci/pci-bcm1480.c	2005-10-19 22:34:13.000000000 -0700
@@ -232,6 +232,14 @@
 		bcm1480_bus_status |= PCI_BUS_ENABLED;
 	}
 
+	/* turn on ExpMemEn */
+	cmdreg = READCFG32(CFGOFFSET(0, PCI_DEVFN(PCI_BRIDGE_DEVICE, 0), 0x40));
+	printk("PCIFeatureCtrl = %x\n", cmdreg);
+	WRITECFG32(CFGOFFSET(0, PCI_DEVFN(PCI_BRIDGE_DEVICE, 0), 0x40),
+			cmdreg | 0x10);
+	cmdreg = READCFG32(CFGOFFSET(0, PCI_DEVFN(PCI_BRIDGE_DEVICE, 0), 0x40));
+	printk("PCIFeatureCtrl = %x\n", cmdreg);
+
 	/*
 	 * Establish mappings in KSEG2 (kernel virtual) to PCI I/O
 	 * space.  Use "match bytes" policy to make everything look
