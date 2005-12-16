Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2005 21:35:56 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:55557 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133557AbVLPVfj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Dec 2005 21:35:39 +0000
Received: from 10.10.64.121 by mms1.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Fri, 16 Dec 2005 13:19:52 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Fri, 16 Dec 2005 13:19:50 -0800
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CIZ43338; Fri, 16 Dec 2005 13:19:49 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 23CA820501 for <linux-mips@linux-mips.org>; Fri, 16 Dec 2005 13:19:49
 -0800 (PST)
Received: from [127.0.0.1] ([10.240.253.7]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Fri, 16 Dec 2005 13:19:48 -0800
Message-ID: <43A32F75.2050704@broadcom.com>
Date:	Fri, 16 Dec 2005 13:19:49 -0800
From:	"Mark Mason" <mason@broadcom.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Patch for 1125 PCI support
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=E9620E57; url=
X-OriginalArrivalTime: 16 Dec 2005 21:19:48.0819 (UTC)
 FILETIME=[72012A30:01C60286]
X-WSS-ID: 6FBDF0F24P458023-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello all,

Here's a little patch to re-enable PCI support on 1125 devices.

Thanks,
Mark

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_PMC_YOSEMITE)    += fixup-yose
 obj-$(CONFIG_SGI_IP27)         += pci-ip27.o
 obj-$(CONFIG_SGI_IP32)         += fixup-ip32.o ops-mace.o pci-ip32.o
 obj-$(CONFIG_SIBYTE_SB1250)    += fixup-sb1250.o pci-sb1250.o
+obj-$(CONFIG_SIBYTE_BCM112X)   += fixup-sb1250.o pci-sb1250.o
 obj-$(CONFIG_SIBYTE_BCM1x80)   += pci-bcm1480.o pci-bcm1480ht.o
 obj-$(CONFIG_SNI_RM200_PCI)    += fixup-sni.o ops-sni.o
 obj-$(CONFIG_TANBAC_TB0219)    += fixup-tb0219.o
