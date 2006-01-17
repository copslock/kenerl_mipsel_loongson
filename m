Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 19:53:20 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:48390 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S3468145AbWAQTxC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 19:53:02 +0000
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 17 Jan 2006 11:56:31 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 0C43667420; Tue, 17 Jan 2006 11:56:30 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id A33C167423 for
 <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 11:56:30 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CSK38786; Tue, 17 Jan 2006 11:56:29 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 8515F20501 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 11:56:29
 -0800 (PST)
Received: from localhost.localdomain ([10.9.253.119]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 17 Jan 2006 11:56:29 -0800
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k0HJtwC4019581
 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 11:56:05 -0800
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k0HJtq4D019579 for linux-mips@linux-mips.org;
 Tue, 17 Jan 2006 11:55:52 -0800
Date:	Tue, 17 Jan 2006 11:55:52 -0800
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [patch] bcm1125 pci fixes
Message-ID: <20060117195552.GA19531@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 17 Jan 2006 19:56:29.0358 (UTC)
 FILETIME=[1B4FF4E0:01C61BA0]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006011707; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230312E34334344344143352E303031462D412D;
 ENG=IBF; TS=20060117195632; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006011707_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FD3946510G1751834-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

The following patch allows BCM1125 targets to link again.

/Mark


diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_PMC_YOSEMITE)	+= fixup-yose
 obj-$(CONFIG_SGI_IP27)		+= pci-ip27.o
 obj-$(CONFIG_SGI_IP32)		+= fixup-ip32.o ops-mace.o pci-ip32.o
 obj-$(CONFIG_SIBYTE_SB1250)	+= fixup-sb1250.o pci-sb1250.o
+obj-$(CONFIG_SIBYTE_BCM112X)	+= fixup-sb1250.o pci-sb1250.o
 obj-$(CONFIG_SIBYTE_BCM1x80)	+= pci-bcm1480.o pci-bcm1480ht.o
 obj-$(CONFIG_SNI_RM200_PCI)	+= fixup-sni.o ops-sni.o
 obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
