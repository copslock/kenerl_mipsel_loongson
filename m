Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 15:32:17 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:54080 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133507AbWBWPa5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 15:30:57 +0000
Received: from 192.168.1.104 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k1NFcBt16403
	for <linux-mips@linux-mips.org>; Thu, 23 Feb 2006 19:38:11 +0400
Subject: NEC VR5701 support
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-lnwk6VPPHfzRQvFpjqDZ"
Organization: MontaVista
Date:	Thu, 23 Feb 2006 18:38:12 +0300
Message-Id: <1140709092.5741.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-lnwk6VPPHfzRQvFpjqDZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-lnwk6VPPHfzRQvFpjqDZ
Content-Disposition: attachment; filename=pro_mips_nec_vr5701_errata.patch
Content-Type: text/x-patch; name=pro_mips_nec_vr5701_errata.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Source: MontaVista Software, Inc. Sergey Podstavin <spodstavin@ru.mvista.com>
MR: 17133
Type: Enhancement
Disposition:  needs submitting to linuxmips-embedded mailing list
Signed-off-by: Sergey Podstavin <spodstavin@ru.mvista.com>
Description:
    NEC Vr5701 workaround. Basically,it gives the following workaround:
	Restriction no.1:
	Please set the value 1 in DISCTIM field of the IPCI_CTRL-L
	register of IPCIC (or the EPCI_CTRL-L register of EPCIC).
	Restriction no.2:
	Please clear SERREN bit of the PCICMD register of IDEC.
	Restriction no.6:
	Please clear PREFETCHABLE bit of the IP_BAR_MEM01 register 
	of IPCIC (or the EP_BAR_MEM01 register of EPCIC).

Index: linux-2.6.10/arch/mips/vr5701/vr5701_sg2/setup.c
===================================================================
--- linux-2.6.10.orig/arch/mips/vr5701/vr5701_sg2/setup.c
+++ linux-2.6.10/arch/mips/vr5701/vr5701_sg2/setup.c
@@ -98,7 +98,7 @@ static void __init vr5701_sg2_board_init
 	/* ------------ reset PCI bus and BARs ----------------- */
 	ddb_pci_reset_bus();
 	/* Ext. PCI memory space */
-	ddb_out32(PCI_BAR_MEM01, 0x00000008);
+	ddb_out32(PCI_BAR_MEM01, 0x00000000); /* workaround - Restriction no.6 */
 	ddb_out8(PCI_MLTIM, 0x40);
 
 	ddb_out32(PCI_BAR_LCS0, 0xffffffff);
@@ -114,6 +114,8 @@ static void __init vr5701_sg2_board_init
 	ddb_out32(IPCI_BAR_LCS3, 0xffffffff);
 	ddb_out32(IPCI_BAR_IREG, 0xffffffff);
 
+	ddb_out32(IPCI_CTRLL, 0x01000000); /* workaround - Restriction no.1 */
+	ddb_out32(EPCI_CTRLL, 0x01000000); /* workaround - Restriction no.1 */
 	/*
 	 * We use pci master register 0  for memory space / config space
 	 * And we use register 1 for IO space.
Index: linux-2.6.10/drivers/ide/pci/nec_vr5701_sg2.c
===================================================================
--- linux-2.6.10.orig/drivers/ide/pci/nec_vr5701_sg2.c
+++ linux-2.6.10/drivers/ide/pci/nec_vr5701_sg2.c
@@ -184,6 +184,7 @@ static int __devinit nec_vr5701_init_one
 		return 1;
 	}
 	ide_setup_pci_device(dev, d);
+	pci_write_config_byte(dev, 0x52, 0x00); /* workaround - Restriction no.2 */
 	return 0;
 }
 
Index: linux-2.6.10/include/asm-mips/vr5701/vr5701.h
===================================================================
--- linux-2.6.10.orig/include/asm-mips/vr5701/vr5701.h
+++ linux-2.6.10/include/asm-mips/vr5701/vr5701.h
@@ -40,6 +40,7 @@
 #define LOCAL_CST0	0x400
 #define LOCAL_CFG	0x440
 /* EPCI registers */
+#define EPCI_CTRLL	0x600
 #define EPCI_CTRLH	0x604
 #define EPCI_INIT0	0x610
 #define EPCI_INIT1	0x618
@@ -77,6 +78,7 @@
 #define CSI1_INT	0xBC8
 
 /* IPCI registers*/
+#define IPCI_CTRLL	0xE00
 #define IPCI_CTRLH	0xE04
 #define IPCI_INIT0	0xE10
 #define IPCI_INIT1	0xE18

--=-lnwk6VPPHfzRQvFpjqDZ--
