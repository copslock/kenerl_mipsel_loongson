Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 19:59:49 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:29961 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133470AbWAQT7b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 19:59:31 +0000
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 17 Jan 2006 12:02:58 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 4806A67422; Tue, 17 Jan 2006 12:02:58 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id D2C0667421 for
 <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:02:57 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CSK41361; Tue, 17 Jan 2006 12:02:55 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 0002F20501 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:02:54
 -0800 (PST)
Received: from localhost.localdomain ([10.9.253.119]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 17 Jan 2006 12:02:54 -0800
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k0HK2OG1019667
 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:02:30 -0800
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k0HK2HYU019664 for linux-mips@linux-mips.org;
 Tue, 17 Jan 2006 12:02:17 -0800
Date:	Tue, 17 Jan 2006 12:02:17 -0800
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [patch] bcm1480 PCI clean-ups
Message-ID: <20060117200217.GB19531@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 17 Jan 2006 20:02:54.0751 (UTC)
 FILETIME=[010642F0:01C61BA1]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006011707; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230332E34334344344334362E303033302D412D;
 ENG=IBF; TS=20060117200259; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006011707_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FD392F810G1753467-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

The following patch cleans up some debug code left behind in the
bcm1480 PCI driver.

Please apply - thanks.

/Mark


diff --git a/arch/mips/pci/pci-bcm1480.c b/arch/mips/pci/pci-bcm1480.c
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -234,11 +234,9 @@ static int __init bcm1480_pcibios_init(v
 
 	/* turn on ExpMemEn */
 	cmdreg = READCFG32(CFGOFFSET(0, PCI_DEVFN(PCI_BRIDGE_DEVICE, 0), 0x40));
-	printk("PCIFeatureCtrl = %x\n", cmdreg);
 	WRITECFG32(CFGOFFSET(0, PCI_DEVFN(PCI_BRIDGE_DEVICE, 0), 0x40),
 			cmdreg | 0x10);
 	cmdreg = READCFG32(CFGOFFSET(0, PCI_DEVFN(PCI_BRIDGE_DEVICE, 0), 0x40));
-	printk("PCIFeatureCtrl = %x\n", cmdreg);
 
 	/*
 	 * Establish mappings in KSEG2 (kernel virtual) to PCI I/O
